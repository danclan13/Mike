// lmr project arduino crane & arms - old bootlogger

#define EI_ARDUINO_INTERRUPTED_PIN

#include <FastPID.h>
#include <EnableInterrupt.h>
#include <Wire.h>
#include <Servo.h>

int motor[5];
volatile boolean rFlag = false;
volatile byte i2cdata[256];
uint8_t writeBufferIndex;
uint8_t readBufferIndex;

unsigned long i2ctimeout = 300000;
unsigned long i2ct = 0;

//Define Variables we'll be connecting to
int Input1, Output1, Input2, Output2;
int Setpoint1 = 0;
int Setpoint2 = 0;
int sign1 = 1;
int sign2 = 1;
int rcount1, rcount2;
int dpos1, dpos2;
int cpos1, cpos2;
int dspeed1, dspeed2;

int lift_state[8];

boolean swFlag = false;
boolean refFlag = false;

Servo lServo;
Servo rServo;

int lSpos, rSpos;


//Specify the links and initial tuning parameters
//float Kp = 10.8, Ki = 2.6, Kd = 0.56, Hz = 100;
float Kp = 5.0, Ki = 0.8, Kd = 0.2, Hz = 100;
FastPID PID1(Kp, Ki, Kd, Hz, 9, true);          // PID regulator for the hoist motor
FastPID PID2(Kp, Ki, Kd, Hz, 9, true);          // Extension gear motor PID

#define INTEG_MAX    250
#define INTEG_MIN    -250


//Sensor
const int hall_11 = 8; // flipped for the hoist motor
const int hall_12 = 2; // flipped for the hoist motor
const int hall_21 = 4;
const int hall_22 = 12;
unsigned long t1, t1_updated, t2, t2_updated;
unsigned long dt1, dt2;
unsigned long braketime = 300000;
unsigned rpm1, rpm2;


//Micro switch
const int mc_sw = 7;

//Driver
const int pwm_11 = 11; // flipped for the hoist motor
const int pwm_12 = 10; // flipped for the hoist motor
const int pwm_21 = 6;
const int pwm_22 = 9;
const int servo_1 = 3;
const int servo_2 = 5;
int in_11;
int in_12;
int in_21;
int in_22;


void setup()
{
  Wire.begin(81);                // join i2c bus with address #81
  delay(100);
  Wire.onReceive(receiveEvent);

  if (PID1.err()) {
    Serial.println("There is a configuration error!");
    for (;;) {}
  }
  if (PID2.err()) {
    Serial.println("There is a configuration error!");
    for (;;) {}
  }
  PID1.setOutputRange(-255, 255);
  PID2.setOutputRange(-255, 255);

  Serial.begin(115200);

  pinMode(pwm_11, OUTPUT);
  pinMode(pwm_12, OUTPUT);
  pinMode(pwm_21, OUTPUT);
  pinMode(pwm_22, OUTPUT);

  TCCR0B = TCCR0B & B11111000 | B00000011;
  TCCR1B = TCCR1B & B11111000 | B00000011;
  TCCR2B = TCCR2B & B11111000 | B00000011;


  pinMode(hall_12, INPUT);
  pinMode(hall_22, INPUT);
  pinMode(hall_11, INPUT);
  pinMode(hall_21, INPUT);


  enableInterrupt(hall_11, interruptFunction1, RISING);
  enableInterrupt(hall_21, interruptFunction2, RISING);

  pinMode(mc_sw, INPUT_PULLUP);
  enableInterrupt(mc_sw, interruptFunction3, FALLING);

  lServo.attach(servo_1);
  rServo.attach(servo_2);

  writeBufferIndex = 0;
  readBufferIndex = 0;

  rcount1 = 0;
  rcount2 = 0;
  cpos1 = 0;
  cpos2 = 0;
  dpos1 = 0;
  dpos2 = 0;

}

void loop()
{
  /****************************************************************
       begin I2C read and timeout funcitons
   ****************************************************************/

  if (rFlag == true)  // when data is availabe -> read it
  {
    LoadBytes();

    rFlag = false;
    i2ct = micros();
    Serial.print(motor[0]);
    Serial.print(",");
    Serial.print(motor[1]);
    Serial.print(",");
    Serial.print(motor[2]);
    Serial.print(",");
    Serial.print(motor[3]);
    Serial.print(",");
    Serial.print(motor[4]);
    Serial.print(",");
    Serial.println(motor[5]);
  }

  if ((micros() - i2ct) > i2ctimeout) // timeout for i2c signal
  {
    //Serial.println("i2c communication failed");
    motor[1] = 0;   //zero the hoist speed if the bus is failed
    motor[3] = 0;   //zero the jib speed if the bus is failed
    i2ct = micros();
  }

  /****************************************************************
       end I2C read and timeout funcitons
   ****************************************************************/


  /****************************************************************
       begin update crane positions
   ****************************************************************/

  if (abs(rcount1) > 18)
  { cpos1 = cpos1 + rcount1 / 18;
    rcount1 = rcount1 -  (floor(rcount1 / 18)) * 18;
  }

  if (abs(rcount2) > 18)
  { cpos2 = cpos2 + rcount2 / 18;
    rcount2 = rcount2 -  (floor(rcount2 / 18)) * 18;
  }

  /****************************************************************
     end update crane positions
  ****************************************************************/

  /****************************************************************
      begin referencing the crane jib if not yet referenced
  ****************************************************************/

  if (refFlag == false) {
    if (swFlag == false && digitalRead(mc_sw) == HIGH) {
      Setpoint2 = -20;
    }
    if (swFlag == true || digitalRead(mc_sw) == LOW) {
      Setpoint2 = 0;
      cpos2 = 0;
      refFlag = true;
      swFlag = false;
      //Serial.println("Crane retraction is now calibrated");
    }
  }

  /****************************************************************
     end referencing the crane jib if not yet referenced
  ****************************************************************/

  /****************************************************************
     begin changing motor setpoints for reaching crane and arms positions
  ****************************************************************/
  if (refFlag == true)
  {
    dpos1 = motor[0];
    dspeed1 = motor[1];
    dpos2 = motor[2];
    dspeed2 = motor[3];
    lSpos = motor[4];
    rSpos = motor[5];
    

    if (cpos1 < dpos1) {
      Setpoint1 = dspeed1;
    }
    if (cpos1 > dpos1) {
      Setpoint1 = -dspeed1;
    }
    if (cpos1 == dpos1)
    { Setpoint1 = 0;/*
    if (dpos1 > 29)     // comment out after testing
      dpos1 = 2;
    else dpos1 = 30; */
    }

    if (cpos2 < dpos2) {
      Setpoint2 = dspeed2;
    }
    if (cpos2 > dpos2) {
      Setpoint2 = -dspeed2;
    }
    if (cpos2 == dpos2)
    { Setpoint2 = 0;/*
    if (dpos2 > 29)     // comment out remove after testing
      dpos2 = 20;
    else dpos2 = 30; */
    }



  }

  /****************************************************************
     end changing motor setpoints for reaching crane positions
  ****************************************************************/



  /****************************************************************
       begin RPM and PID calculations
   ****************************************************************/
  // calculate revolutions per minute

  dt1 = t1_updated - t1;
  if (dt1 > braketime || (micros() - t1_updated) > braketime)
  {
    rpm1 = 0;
  }
  else
  {
    rpm1 = (60000000.0 / (dt1 * 700)) * sign1;
  }

  dt2 = t2_updated - t2;
  if (dt2 > braketime || (micros() - t2_updated) > braketime)
  {
    rpm2 = 0;
  }
  else
  {
    rpm2 = (60000000.0 / (dt2 * 700)) * sign2;
  }


  Input1 = rpm1;
  Input2 = rpm2;

  // get output values from PID loop

  int16_t Output1 = PID1.step(Setpoint1, Input1);
  int16_t Output2 = PID2.step(Setpoint2, Input2);

  motor_write(Output1, Output2);

}

/****************************************************************
     Write to motors
 ****************************************************************/



void motor_write(int16_t Output1, int16_t Output2) {
  // reorder output pins depending on PID loop output

  if (Output1 < 0)
  { Output1 = -Output1;
    in_11 = pwm_12;
    in_12 = pwm_11;
  }
  else
  { in_11 = pwm_11;
    in_12 = pwm_12;
  }

  if (Output2 < 0)
  { Output2 = -Output2;
    in_21 = pwm_22;
    in_22 = pwm_21;
  }
  else
  { in_21 = pwm_21;
    in_22 = pwm_22;
  }

  // write to motors

  analogWrite(in_11, Output1);
  analogWrite(in_12, 0);


  analogWrite(in_21, Output2);
  analogWrite(in_22, 0);

  lServo.write(lSpos);
  rServo.write(rSpos);

}

/****************************************************************
     begin interrupts and functions
 ****************************************************************/

char lastbyte;
char lastbyte2;
void LoadBytes(void) {
  while (writeBufferIndex != readBufferIndex)
  {
    if (i2cdata[readBufferIndex] == 241)
    {
      readBufferIndex++;
      motor[0] = i2cdata[readBufferIndex];
    }
    else if (i2cdata[readBufferIndex] == 242)
    {
      readBufferIndex++;
      motor[1] = i2cdata[readBufferIndex] - 80;
    }
    else if (i2cdata[readBufferIndex] == 243)
    {
      readBufferIndex++;
      motor[2] = i2cdata[readBufferIndex];
    }
    else if (i2cdata[readBufferIndex] == 244)
    {
      readBufferIndex++;
      motor[3] = i2cdata[readBufferIndex] - 80;
    }
    else if (i2cdata[readBufferIndex] == 245)
    {
      readBufferIndex++;
      motor[4] = i2cdata[readBufferIndex];
    }
    else if (i2cdata[readBufferIndex] == 246)
    {
      readBufferIndex++;
      motor[5] = i2cdata[readBufferIndex];
    }
    readBufferIndex++;
  }
}

void receiveEvent(int howMany) {
  while (howMany > 0)
  {
    howMany--;
    i2cdata[writeBufferIndex] = Wire.read(); // receive byte as a character
    lastbyte2 = lastbyte;
    lastbyte = i2cdata[writeBufferIndex];
    writeBufferIndex++;

    if (lastbyte2 == '\n' && lastbyte == '\r' ) {
      rFlag = true;
      break;
    }
  }
}

void interruptFunction1() {
  t1 = t1_updated;
  t1_updated = micros();
  sign1 = 1 - (digitalRead(hall_12)) * 2;
  rcount1 = rcount1 + sign1;
}

void interruptFunction2() {
  t2 = t2_updated;
  t2_updated = micros();
  sign2 = 1 - (digitalRead(hall_22)) * 2;
  rcount2 = rcount2 + sign2;
}

void interruptFunction3() {
  swFlag = true;
}

/****************************************************************
     end interrupts
 ****************************************************************/

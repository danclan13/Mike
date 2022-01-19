// lmr project arduino crane & arms - old bootlogger

#define EI_ARDUINO_INTERRUPTED_PIN

#include <FastPID.h>
#include <EnableInterrupt.h>
#include <Wire.h>

int motor[6];
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




//Specify the links and initial tuning parameters
//float Kp = 10.8, Ki = 2.6, Kd = 0.56, Hz = 100;
float Kp = 5.0, Ki = 1.0, Kd = 0.2, Hz = 100;
FastPID PID1(Kp, Ki, Kd, Hz, 9, true);
FastPID PID2(Kp, Ki, Kd, Hz, 9, true);

#define INTEG_MAX    250
#define INTEG_MIN    -250

//Sensor
const int hall_11 = 8; // flipped
const int hall_12 = 2; // flipped
const int hall_21 = 4;
const int hall_22 = 12;
unsigned long t1, t1_updated, t2, t2_updated;
unsigned long dt1, dt2;
unsigned long braketime = 300000;
unsigned rpm1, rpm2;

//Driver
const int pwm_11 = 11; // flipped
const int pwm_12 = 10; // flipped
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

  writeBufferIndex = 0;
  readBufferIndex = 0;

  rcount1 = 0;
  rcount2 = 0;
  cpos1 = 0;
  cpos2 = 0;
  dpos1 = 30;
  dpos2 = 30;

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
    Serial.println(motor[1]);
  }

  if ((micros() - i2ct) > i2ctimeout) // timeout for i2c signal
  {
    //Serial.println("i2c communication failed");
    for (int i = 0; i < 3; i++) {
      motor[i] = 0;
    }
    i2ct = micros();
  }

  /****************************************************************

       end I2C read and timeout funcitons

   ****************************************************************/


  /****************************************************************

       begin changing motor setpoints

   ****************************************************************/

  if (abs(rcount1) > 18)
  { cpos1 = cpos1 + rcount1 / 18;
    rcount1 = rcount1 -  (floor(rcount1 / 18)) * 18;
  }

  if (abs(rcount2) > 18)
  { cpos2 = cpos2 + rcount2 / 18;
    rcount2 = rcount2 -  (floor(rcount2 / 18)) * 18;
    
  }

  Serial.print(cpos1);
  Serial.print(",");
  Serial.print(rcount1);
  Serial.print(",");
  Serial.println(rpm1);
  if (cpos1 < dpos1) {
    Setpoint1 = 15;
  }
  if (cpos1 > dpos1) {
    Setpoint1 = -15;
  }
  if (cpos1 == dpos1)
  { Setpoint1 = 0;
    if (dpos1 > 29)     // remove after testing
      dpos1 = 2;         // remove after testing
    else dpos1 = 30;    // remove after testing
  }

  if (cpos2 < dpos2) {
    Setpoint2 = 15;
  }
  if (cpos2 > dpos2) {
    Setpoint2 = -15;
  }
  if (cpos2 == dpos2)
  { Setpoint2 = 0;
    if (dpos2 > 29)     // remove after testing
      dpos2 = 20;         // remove after testing
    else dpos2 = 30;    // remove after testing
  }



  //Setpoint1 = motor[0];
  //Setpoint2 = motor[1];


  /****************************************************************

       end changing motor setpoints

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

}

/****************************************************************

     begin interrupts

 ****************************************************************/

char lastbyte;
char lastbyte2;
void LoadBytes(void) {
  while (writeBufferIndex != readBufferIndex)
  {
    if (i2cdata[readBufferIndex] == 251)
    {
      readBufferIndex++;
      motor[0] = i2cdata[readBufferIndex] - 80;
    }
    else if (i2cdata[readBufferIndex] == 252)
    {
      readBufferIndex++;
      motor[1] = i2cdata[readBufferIndex] - 80;
    }
    else if (i2cdata[readBufferIndex] == 253)
    {
      readBufferIndex++;
      motor[2] = i2cdata[readBufferIndex] - 80;
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

/****************************************************************

     end interrupts

 ****************************************************************/

// lmr project arduino crane & arms - old bootlogger

#define EI_ARDUINO_INTERRUPTED_PIN

#include <FastPID.h>
#include <EnableInterrupt.h>
#include <Wire.h>
#include <Servo.h>

int crane[3];
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

boolean swFlag = false;
boolean refFlag = false;

Servo lServo;
Servo rServo;

int lSpos, rSpos;


//Specify the links and initial tuning parameters
//float Kp = 10.8, Ki = 2.6, Kd = 0.56, Hz = 100;
float Kp = 7.0, Ki = 1.2, Kd = 0.4, Hz = 100;
FastPID PID1(Kp, Ki, Kd, Hz, 9, true);          // PID regulator for the hoist motor
FastPID PID2(Kp, Ki, Kd, Hz, 9, true);          // Extension gear motor PID

#define INTEG_MAX    250
#define INTEG_MIN    -250


//Sensor
const int hall_11 = 2; // flipped for the hoist motor
const int hall_12 = 8; // flipped for the hoist motor
const int hall_21 = 4;
const int hall_22 = 12;
unsigned long t1, t1_updated, t2, t2_updated;
unsigned long dt1, dt2;
unsigned long strugt1, strugt2;
volatile boolean strugFlag1 = 0;
volatile boolean strugFlag2 = 0;
unsigned long braketime = 300000;
unsigned rpm1, rpm2;


//Micro switch
const int mc_sw = 7;

///////////////////////////////////////////////////////////////////////  Crane variables
volatile boolean liftdone = 1;
volatile boolean liftreport = 0;
unsigned stepdone = 0;
unsigned long cranetimer = 0;
unsigned long cranetimeout = 500; // in milliseconds
unsigned long craneout = 162;  //going to the hole forward in mm    ~ sort of calibrated
unsigned long hookdown = 528;  // going to the hole down in mm?    ~ sort of calibrated
unsigned long hookbitup = 60;  // hooking up the hole in mm?
unsigned long cranetohole = 75; // retracting the jib while lifting to this position in mm
unsigned long hooktohole = 115; // lifting the hook while retracting to this position in mm?
unsigned long hookfinish = 66; // finishing lifting the bridge to this position in mm?


//Driver
const int pwm_11 = 10; // flipped for the hoist motor
const int pwm_12 = 11; // flipped for the hoist motor
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
  Wire.onRequest(requestEvent);

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
  crane[0] = 1;

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
    Serial.print(stepdone);
    Serial.print(",");
    Serial.print(crane[0]);
    Serial.print(",");
    Serial.print(crane[1]);
    Serial.print(",");
    Serial.println(crane[2]);
  }

  if ((micros() - i2ct) > i2ctimeout) // timeout for i2c signal
  {
    //Serial.println("i2c communication failed");
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


  craneReferencing(); // reference if not referenced

  /****************************************************************
     end referencing the crane jib if not yet referenced
  ****************************************************************/

  /****************************************************************
     begin changing motor setpoints for reaching crane and arms positions
  ****************************************************************/
  if (refFlag == true)
  {
    liftdone = crane[0];
    lSpos = crane[1];
    rSpos = 180 - crane[2];

    bridgeLifting();    // execute the bridge lifting


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

  /* if input << setpoint, check if its struggling
     (not reaching setpoint in 1 sec)
     then rest for 2 sec
  */


  Input1 = rpm1;
  int16_t Output1 = PID1.step(Setpoint1, Input1);


  if (abs(rpm1) < ((abs(Setpoint1)) * 0.1)) {
    if (strugFlag1 == 0) {
      strugt1 = micros();
      strugFlag1 = 1;
    }
    if ((micros() - strugt1) > 1000000 &&  strugFlag1 == 1) {
      int16_t Output1 = 0;      
      PID1.clear();
    }
    if ((micros() - strugt1) > 3000000 &&  strugFlag1 == 1) {
      strugFlag1 = 0;      
      PID1.clear();
    }
  }
  else {
    strugFlag1 = 0;
  }



  Input2 = rpm2;
  int16_t Output2 = PID2.step(Setpoint2, Input2);


  if (abs(rpm2) < ((abs(Setpoint2)) * 0.1)) {
    if (strugFlag2 == 0) {
      strugt2 = micros();
      strugFlag2 = 1;
    }
    if ((micros() - strugt2) > 1000000 &&  strugFlag2 == 1) {
      int16_t Output2 = 0;
      PID2.clear();
    }
    if ((micros() - strugt2) > 3000000 &&  strugFlag2 == 1) {
      strugFlag2 = 0;
      PID2.clear();
    }
  }
  else {
    strugFlag2 = 0;
  }




  // get output values from PID loop




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
      crane[0] = i2cdata[readBufferIndex];
    }
    else if (i2cdata[readBufferIndex] == 242)
    {
      readBufferIndex++;
      crane[1] = i2cdata[readBufferIndex];
    }
    else if (i2cdata[readBufferIndex] == 243)
    {
      readBufferIndex++;
      crane[2] = i2cdata[readBufferIndex];
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


void requestEvent() {
  Wire.write(0x01);
  Wire.write("p");
  Wire.write(liftreport);
  Wire.write("\r");
  Wire.write("\n");
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


void craneReferencing() {
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
}


void bridgeLifting() {
  if (liftdone != 1) {          // check if lifting required
    if (stepdone == 0) {
      dpos2 = craneout;         // on step 1 extend the crane
      dspeed2 = 55;
      if (cpos2 == dpos2) {
        stepdone = 1;
      }          // when step 1 is done set stepdone to '1'
    }
    else if (stepdone == 1) {
      dpos1 = hookdown;         // on step 2 lower the hook
      dspeed1 = 54;
      if (cpos1 == dpos1) {
        cranetimer = micros();  // when step 2 is done, start the pause timer and set stepdone to '2'
        stepdone = 2;
      }
    }
    else if (stepdone == 2) {
      if ((cranetimer + 1000 * cranetimeout) < micros()) {  // on step 3 wait for the timer
        stepdone = 3;
      }                                      // when step 3 is done, set stepdone to '3'
    }
    else if (stepdone == 3) {
      dpos1 = hookdown - hookbitup;         // on step 4 hook up the bridge a bit
      dspeed1 = 16;
      if (cpos1 == dpos1) {
        stepdone = 4;
      }                      // when step 4 is done, set stepdone to '4'
    }
    else if (stepdone == 4) {
      dpos2 = cranetohole;         // on step 5 lift the bridge to a certain point and retract the jib
      dpos1 = hooktohole;
      dspeed2 = 18;
      dspeed1 = 38;
      if ((cpos2 == dpos2) && (cpos1 == dpos1)) {
        stepdone = 5;
      }            // when step 5 is done, set stepdone to '5'
    }
    else if (stepdone == 5) {
      dpos1 = hookfinish;         // on step 6 lift the bridge to the end
      dspeed1 = 20;
      if (cpos1 == dpos1) {
        stepdone = 6;
      }            // when step 6 is done, set stepdone to '6'
    }
    else if (stepdone == 6) {
      dpos1 = hooktohole;         // on step 7 release the hook
      dspeed1 = 30;
      if (cpos1 == dpos1) {
        stepdone = 7;
      }            // when step 7 is done, set stepdone to '7'
    }
    else if (stepdone == 7) {
      dpos1 = 10;                    // on step 8 turn back the hook and the jib
      dspeed1 = 35;
      dpos2 = 0;
      dspeed2 = 50;
      if ((cpos2 == dpos2) && (cpos1 == dpos1)) {
        stepdone = 8;
      }
    }
    else if (stepdone == 8) {
      liftreport = 1;
    }
  }
  else if ((liftdone == 1) && (stepdone == 8)) {
    stepdone = 0;
    liftreport = 0;
  }
}



/****************************************************************
     end interrupts
 ****************************************************************/

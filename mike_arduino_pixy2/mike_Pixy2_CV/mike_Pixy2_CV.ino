//
// begin license header
//
// This file is part of Pixy CMUcam5 or "Pixy" for short
//
// All Pixy source code is provided under the terms of the
// GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
// Those wishing to use Pixy source code, software and/or
// technologies under different licensing terms should contact us at
// cmucam@cs.cmu.edu. Such licensing terms are available for
// all portions of the Pixy codebase presented here.
//
// end license header
//


//
// Last modyfied by Hermann Karl Björnsson
// 20/12/2021 06:58
bool Go_For_bridge_and_hill = false;

#include <Pixy2.h>
#include <avr/pgmspace.h>
#include <EEPROM.h>
Pixy2 pixy;

// function prototypes
void setMode(int sm);

// EEPROM address list
#define ADDR_P_DEF 0x00
#define ADDR_T_DEF 0x02
#define ADDR_P_LIN 0x04
#define ADDR_T_LIN 0x06
#define ADDR_P_TRA 0x08
#define ADDR_T_TRA 0x0a
#define ADDR_P_ROU 0x0c
#define ADDR_T_ROU 0x0e
#define ADDR_P_BUT 0x10
#define ADDR_T_BUT 0x12
#define ADDR_BRIDGE_N_HILL 0x14
#define ADDR_SPD_FST 0x16
#define ADDR_SPD_SLO 0x18


int mode = 0;


// needs to be adjusted - updated by EEPROM
uint16_t Pan_Default = 370;
uint16_t Tilt_Default = 250;
uint16_t Pan_Linemode = 370;
uint16_t Tilt_Linemode = 485;
uint16_t Pan_Trafficlight = 250;
uint16_t Tilt_Trafficlight = 250;
uint16_t Pan_Roundabout = 125;
uint16_t Tilt_Roundabout = 125;
uint16_t Pan_RedButton = 250;
uint16_t Tilt_RedButton = 250;
uint8_t speed_fast = 100;
uint8_t speed_slow = 20;


// needs to be adjusted on competition day

// serial varibles
char buf[256];
char ringbuff[256];
uint8_t readpos = 0;
uint8_t writepos = 0;
char read[256];
bool lineavailable = false;


bool greenNotFound = true;
const char helpmenu1[] PROGMEM = "\n\tsetmode - set current mode\n\tgetmode - get current mode\nEEPROM settings\n\tP_def\n\tT_def\n\tP_lin\n\tT_lin\n\tP_tra\n\tT_tra\n\tP_rou\n\tT_rou\n\tP_but\n\tT_but\n\tspd_fst\n\tspd_slo\n\tbridge_and_hill - t/f\n";
const char helpmenu2[] PROGMEM = "modes:\n\t0: Stop/Reset all\n\t1: Drive until intersection is between 40 and 45 on y axis\n\t";
const char helpmenu3[] PROGMEM = "2: Drive sideways to hit button\n\t3: Drive sideways to find intersection again\n\t4: Wait for traffic light to turn green\n\t";
const char helpmenu4[] PROGMEM = "5:Find intersection and turn right\n\t6: Follow line to bridge\n\t7: Deploy arm to retreive bridge\n\t8: Retrieve bridge\n\t";
const char helpmenu5[] PROGMEM = "9: Drive sideways to verify bridge is up - if not jump to 17 at end\n\t10: Drive forward to junction turn right - If intention is to get both the bridge and the hill, jump to 17 at end\n\t";
const char helpmenu6[] PROGMEM = "11: Follow path until button can be seen\n\t12: Rotate to face roundabout center, take IMU reading\n\t13: Track roundabout center\n\t14: Wait for IMU to take reading within 90° of original\n\t";
const char helpmenu7[] PROGMEM = "15: Follow line towards button\n\t16: Press button -- End of program -> jump to 0\n\t17: Rotate 180° and follow line to junction\n\t18: take right at junction\n\t";
const char helpmenu8[] PROGMEM = "19: If needed, rotate 180° to climb hill\n\t20: Take imu reading of angle to keep track of incline\n\t21: follow ine up hill, if rotated 180° drive backwards\n\t";
const char helpmenu9[] PROGMEM = "22: Take IMU reading to know if on top of hill, if needed turn 180°\n\t23: Take IMU reading to know if on bottom of hill, rotate 180° if needed\n\t24: Jump to 11\n\t101: debug linemode\n\t102: debug ccc mode";
const char *const helpmenu[] PROGMEM = {helpmenu1, helpmenu2, helpmenu3, helpmenu4, helpmenu5, helpmenu6, helpmenu7, helpmenu8, helpmenu9};
const char string_curmode[] PROGMEM = "Current mode is: %d\n";
const char string_WaitForLight[] PROGMEM = "Waiting for light\n";
const char string_RED[] PROGMEM = "RED\n";
const char string_YELLOW[] PROGMEM = "YELLOW\n";
const char string_GREEN[] PROGMEM = "GREEN\n";

const char string_setmode[] PROGMEM = "setmode"; 


#define FILTER_UPDATE_RATE_HZ 10
uint32_t timestamp;
int8_t i;
//    
void setup()
{
  Serial.begin(115200);
  timestamp = millis();
//  Serial.print("Starting...\n");

  // we need to initialize the pixy object
  pixy.init();
  // Change to line tracking program
  pixy.changeProg("line");
  pixy.line.setDefaultTurn(0);
  pixy.setCameraBrightness(85); // set brightness to default
}

void loop()
{
  if (Serial.available()) {
    ringbuff[writepos] = Serial.read();
    if (ringbuff[writepos] == '\n')
      lineavailable = true;
    writepos++;
  }
  if (lineavailable) {
    lineavailable = false;
    serial_parse();
  }
  
if ((millis() - timestamp) < (1000 / FILTER_UPDATE_RATE_HZ)) {
    return;
  }
  timestamp = millis();
  
  pixy.line.getAllFeatures();
  if(pixy.line.barcodes[0].m_code == 14){
    mode = 0;
  }
  switch (mode) {
    case 0:        // Stop, wait for button input, reset all parameters
      // do nothing
      // change camera tilt to line following setpoint
      pixy.setServos(Pan_Default, Tilt_Default);
      
      for (i = 0; i < pixy.line.numBarcodes; i++)
      {
//        sprintf(buf, "barcode %d: ", i);
//        Serial.print(buf);
//        pixy.line.barcodes[i].print();
        if(pixy.line.barcodes[i].m_code==0){
          mode = 1;
          pixy.setServos(Pan_Default, Tilt_Linemode);
      }
    }
      
      greenNotFound = true;
      break;


    case 1:        // Drive until intersection is between 40 and 45 on y axis
      // drive forward until intersection is between y=40 and y=45
      if(waitForIntersection()){
        
          pixy.setServos(Pan_Default, 460);
        waitForIntersection_lower_center();
        
        setMode(2);
      }
      
      break;


    case 2:        // Drive sideways to hit button
      // keep track of stop line to ensure hiting button
      break;


    case 3:        // Drive sideways to find intersection again
      waitForIntersection();
      // keep track of stop line/intersection and wait for intersection to be between x= 34 and x=44

      pixy.line.setDefaultTurn(0);
      break;


    case 4:        // Wait for traffic light to turn green
      // switch camera modes to identify opbjects
      // change camera tilt to traffic light setpoint
      // look for red or green light
      // on green light, move forward
      waitForGreen();
      if (greenNotFound == false)
        setMode(5);
      break;


    case 5:        // Find intersection and turn right
      pixy.line.setDefaultTurn(-90);
      // follow line until intersection is available
      // take right turn on intersection
      break;


    case 6:        // Follow line to bridge
      // follow line until vector ends on aprox y=25 +/- 5
      break;


    case 7:        // Deploy arm to retreive bridge
      // possibly change modes to identify hole and arm
      // if CV used to find hole, code goes here
      break;


    case 8:        // Retrieve bridge
      // do nothing
      break;


    case 9:        // Drive sideways to verify bridge is up - if not jump to 17 at end
      // move sideways so vector is on x~=65
      // identify if vectors are aproxomately aligned or if they are misaligned
      // if vectors are misaligned jump to 17
      break;


    case 10:       // Drive forward to junction turn right - If intention is to get both the bridge and the hill, jump to 17 at end
      waitForIntersection();      // identify intersection
      if (Go_For_bridge_and_hill) // if wanted to get hill, jump to 17 at end
        setMode(17);
      break;


    case 11:       // Follow path until button can be seen
      // switch between line mode and ccc mode repeatedly until button is identified
      break;


    case 12:       // Rotate to face roundabout center, take IMU reading
      // switch to ccc mode
      // keep roundabout centered
      break;


    case 13:       // Track roundabout center
      // track roundabout center
      // issue turn commands when roundabout center has moved 25% of frame width
      break;


    case 14:       // Wait for IMU to take reading within 90° of original
      // same as cases 13
      break;


    case 15:       // Follow line towards button
      // rotate 90° and find vector to follow towards button
      break;


    case 16:       // Press button -- End of program -> jump to 0
      // identfy end of line
      // move until end of line is aprox Y=45
      setMode(0);
      break;


    case 17:       // Rotate 180° and follow line to junction
      // wait for rotation to complete
      // find line to follow
      // find intersection
      break;


    case 18:       // take right at junction
      // take right at itersection
      break;


    case 19:       // If needed, rotate 180° to climb hill
      // do nothing
      break;


    case 20:       // Take imu reading of angle to keep track of incline
      // aquire lock on line, fix rotation if needed
      break;


    case 21:       // follow ine up hill, if rotated 180° drive backwards
      // track line
      break;


    case 22:       // Take IMU reading to know if on top of hill, if needed turn 180°
      // do nothing
      break;


    case 23:       // Take IMU reading to know if on bottom of hill, rotate 180° if needed
      // follow line
      break;


    case 24:       // Jump to 11
      break;

    case 101:      // debug line mode
      debug_line();
      break;

    case 102:      // debug line mode
      break;


    case 111:      // debug line mode
      follow_line(0);
      break;
    case 112:      // debug line mode
      follow_line(1);
      break;

    default:
      break;
  }
}

/*
  Wait functions
*/

// Halts the program until intersection has been found
bool waitForIntersection() {
  pixy.line.getAllFeatures();
  bool found = false;
  /*while (pixy.line.numIntersections == 0) {
    if (Serial.available()) break;
    pixy.line.getAllFeatures();
    if(pixy.line.barcodes[0].m_code == 14){
      mode = 0;
      break;
    }
  }*/
  if(pixy.line.numIntersections>0)
    found=true;

  return found;
}
void waitForIntersection_lower_center() {
  while (pixy.line.intersections[0].m_x < 34 || pixy.line.intersections[0].m_x > 44 || pixy.line.intersections[0].m_y < 43 || pixy.line.intersections[0].m_y > 47 ) {
    if (Serial.available()) break;
    pixy.line.getAllFeatures(); 
    if(pixy.line.barcodes[0].m_code == 14){
      mode = 0;
      break;
    }
    if (pixy.line.intersections[0].m_x < 34 || pixy.line.intersections[0].m_x > 44 ) { // if x value is not in range
      if (pixy.line.intersections[0].m_x < 34) {
        drive(90, speed_slow);
      }
      else
      {
        drive(-90, speed_slow);
      }
    }
    else
    {
      if (pixy.line.intersections[0].m_y < 43) {
        drive(0, speed_slow);
      }
      else
      {
        drive(180, speed_slow);
      }
    }

  }
}

// Halts the program until green is detected (signature id 3)
void waitForGreen() {
  setCameraMode(1); // set the camera to ccc mode and reduce brightness
  while (greenNotFound) {
    if (Serial.available()) break;
    pixy.ccc.getBlocks();
    for (i = 0; i < pixy.ccc.numBlocks; i++)
    {
      // for debugging only
      //sprintf(buf, "Block signature %d: ", i);
      //Serial.print(buf);
      //pixy.ccc.blocks[i].print();
      if (pixy.ccc.blocks[i].m_signature == 1){
        Serial.print("R");
      }
      if (pixy.ccc.blocks[i].m_signature == 2){
        Serial.print("Y");
      }
      if (pixy.ccc.blocks[i].m_signature == 3) {
        greenNotFound = false;
        Serial.print("G");
      }
      
    }
  if(pixy.line.barcodes[0].m_code == 14){
    mode = 0;
      break;
  }
  }
  setBrightness(0); // set brightness to default
}

/**********************************

  Sets modes for pixy

***********************************/

// sets image brightness
void setBrightness(int br_mode) {
  if (br_mode == 0)
    pixy.setCameraBrightness(85); // set brightness to default
  else if (br_mode == 1)
    pixy.setCameraBrightness(20); // set brightness to detect lights
  else
    pixy.setCameraBrightness(85); // set brightness to default
}

/*
  Camera modes
  0: Line follow
  1: Traffic light spotting
  2: Roundabout spotting
*/
void setCameraMode(int px_mode) {
  if (px_mode == 0) {      // line follow
    setBrightness(0);
    pixy.changeProg("line");
  }
  else if (px_mode == 1) { // ccc mode reduced brightness
    setBrightness(1);
    pixy.changeProg("ccc");
  }
  else if (px_mode == 2) { // ccc mode normal brightness
    setBrightness(0);
    pixy.changeProg("ccc");
  }
  else {
    setBrightness(0);
    pixy.changeProg("line");
  }
}


/**********************************

  Sets what mode the controller is in

***********************************/

void setMode(int sm) {
  Send_setmode(sm);
  mode = sm;
//  sprintf(buf, "Set to mode %dp\r\n", mode);
//  Serial.print(buf);
}

void serial_parse() {
  uint8_t j = 0;
  while (readpos != writepos) {
    read[j] = ringbuff[readpos];
    j++;
    readpos++;
  }
  read[j] = '\n';
  if(strstr(read,"c\r\n")!= NULL){
    char num[3];
    int16_t val;
    uint16_t readval;
    if (strstr(read, "setmode") != NULL | strstr(read, "Setmode") != NULL | strstr(read, "SetMode") != NULL | strstr(read, "setMode") != NULL) {
      i = 0;
      while (read[i] != ' ') i++;
      i++;
      for (j = 0; j < 3; j++) {
        if (read[i] >= '0' && read[i] <= '9')
          num[j] = read[i];
        else
          num[j] = 0;
        i++;
      }
      setMode(atoi(num));
    }
    else if (strstr(read, "getmode") != NULL | strstr(read, "Getmode") != NULL | strstr(read, "GetMode") != NULL | strstr(read, "getMode") != NULL) {
      sprintf(buf, (char *)pgm_read_word(&string_curmode), mode);
      Serial.print(buf);
    }
    else if (strstr(read, "help") != NULL | strstr(read, "Help") != NULL | strstr(read, "HELP") != NULL) {
      sprintf(buf, (char *)pgm_read_word(&(string_curmode)), mode);
      Serial.print(buf);
      for (int i = 0; i < 9; i++) {
        strcpy_P(buf, (char *)pgm_read_word(&(helpmenu[i])));  // Necessary casts and dereferencing, just copy.
        Serial.print(buf);
      }
    }
    // commands to change settings in EEPROM
    else if (strstr(read, "P_") != NULL) {
      i = 0;
      while (read[i] != ' ') i++;
      i++;
      for (j = 0; j < 3; j++) {
        if (read[i] >= '0' && read[i] <= '9')
          num[j] = read[i];
        else
          num[j] = 0;
        i++;
      }
      val = atoi(num);
      if (strstr(read, "def") != NULL) {
        readval = eeprom_write16(ADDR_P_DEF, val);
      }
      else if (strstr(read, "lin") != NULL) {
        readval = eeprom_write16(ADDR_P_LIN, val);
      }
      else if (strstr(read, "tra") != NULL) {
        readval = eeprom_write16(ADDR_P_TRA, val);
      }
      else if (strstr(read, "rou") != NULL) {
        readval = eeprom_write16(ADDR_P_ROU, val);
      }
      else if (strstr(read, "but") != NULL) {
        readval = eeprom_write16(ADDR_P_BUT, val);
      }
    }
    else if (strstr(read, "T_") != NULL) {
      if (strstr(read, "def") != NULL) {
        readval = eeprom_write16(ADDR_T_DEF, val);
      }
      else if (strstr(read, "lin") != NULL) {
        readval = eeprom_write16(ADDR_T_LIN, val);
      }
      else if (strstr(read, "tra") != NULL) {
        readval = eeprom_write16(ADDR_T_TRA, val);
      }
      else if (strstr(read, "rou") != NULL) {
        readval = eeprom_write16(ADDR_T_ROU, val);
      }
      else if (strstr(read, "but") != NULL) {
        readval = eeprom_write16(ADDR_T_BUT, val);
      }
    }
    else if (strstr(read, "spd_fst") != NULL) {
  
      i = 0;
      while (read[i] != ' ') i++;
      i++;
      for (j = 0; j < 3; j++) {
        if (read[i] >= '0' && read[i] <= '9')
          num[j] = read[i];
        else
          num[j] = 0;
        i++;
      }
      val = atoi(num);
      readval = eeprom_write16(ADDR_SPD_FST, val);
    }
    else if (strstr(read, "spd_slo") != NULL) {
  
      i = 0;
      while (read[i] != ' ') i++;
      i++;
      for (j = 0; j < 3; j++) {
        if (read[i] >= '0' && read[i] <= '9')
          num[j] = read[i];
        else
          num[j] = 0;
        i++;
      }
      val = atoi(num);
      readval = eeprom_write16(ADDR_SPD_SLO, val);
    }
  }
  else /*if(strstr(read,"p\r\n")!= NULL||strstr(read,"i\r\n")!= NULL)*/{
    Serial.print(read);
  }

}

// writes 16 bits to eeprom and reads them back - 100ms delay
uint16_t eeprom_write16(uint16_t addr, uint16_t val) {
  EEPROM.write(addr , val >> 8 & 0xff);
  EEPROM.write(addr + 1 , val & 0xff);
  uint16_t readval = (EEPROM.read(addr) << 8) + EEPROM.read(addr + 1);
//  sprintf(buf,"wrote %d to EEPROM address %d\n",val,addr);
//  Serial.print(buf);
  return readval;
}

//
void drive(int16_t deg, int spd) {
  deg = deg*10;
  buf[0] = 'D';
  buf[1] = 'R';
  buf[2] = (deg >> 8 & 0xff) +1;
  buf[3] = (deg & 0xff)+1;
  buf[4] = spd+1;
  if(deg>=0){
    buf[5] = '+';
  }
  else{
    buf[5] = '-';
  }
  buf[6] = 'p';
  buf[7] = '\r';
  buf[8] = '\n';
  buf[9] = '\0';
  Serial.write(buf,9);
  delay(50);
//  sprintf(buf, "Driving to %d° at %d speed\n", deg, spd);
//  Serial.print(buf);
}

void rotate(uint16_t deg, int spd) {
  buf[0] = 'R';
  buf[1] = 'O';
  buf[2] = deg >> 8 & 0xff;
  buf[3] = deg & 0xff;
  buf[4] = spd;
  buf[5] = 'p';
  buf[6] = '\r';
  buf[7] = '\n';
  buf[8] = '\0';
  Serial.write(buf,8);
  delay(50);
//  sprintf(buf, "Driving to %d° at %d speed\n", deg, spd);
//  Serial.print(buf);
}

// 0: horizontal
// 1: vertical
void follow_line(uint8_t dir) {
  
          pixy.setServos(Pan_Default, 480);
  uint8_t bestfit = 0;
  int8_t dx;
  int8_t dy;
  int8_t dirLocal[20];
  int8_t x1[20];
  uint8_t DeltaDirLocal[20];
  uint8_t lowestval = 45;
  pixy.line.getAllFeatures();
  for (i = 0; i < pixy.line.numVectors; i++)
  {
    if(i<=19){
      dx = pixy.line.vectors[i].m_x0 - pixy.line.vectors[i].m_x1; // get difference between x coordinates
      dy = pixy.line.vectors[i].m_y0 - pixy.line.vectors[i].m_y1; // get difference between y coordinates
      if(dy<0){
        x1[i] = pixy.line.vectors[i].m_x1;
      }
      else{
        x1[i] = pixy.line.vectors[i].m_x0;
      }
      double vLength = sqrt(pow(dx, 2) + pow(dy, 2));
      dirLocal[i] = (int8_t)(180 / 3.141592) * acos(-dx / vLength) - 90;
//      sprintf(buf, "angle %d: %d %d %d\n", i, (int)dirLocal[i], dx, dy);
//      Serial.print(buf);
      if (dir == 0) {
        DeltaDirLocal[i] = 90 - abs(dirLocal[i]);
        if (lowestval > (int) DeltaDirLocal[i]) {
          bestfit = i;
        }
      }
      else {
        DeltaDirLocal[i] = abs(dirLocal[i]);
        if (lowestval > (int) DeltaDirLocal[i]) {
          bestfit = i;
        }
      }
    }
//    sprintf(buf, "The best value is %d\n", (int) dirLocal[bestfit]);
//    Serial.print(buf);

    // drive towards center
    if(x1[bestfit] > 42){
      drive(-90,20);
    }
    else if(x1[bestfit] < 36){
      drive(90,20);
    }
    else{
      if(abs(dirLocal[bestfit])>2){
        rotate(dirLocal[bestfit],20);
      }
      drive(dirLocal[bestfit],30);
    }
  }
}

void Send_setmode(uint8_t modevar) {
  buf[0] = 'S';
  buf[1] = 'M';
  buf[2] = modevar+1;
  buf[3] = 'p';
  buf[4] = '\r';
  buf[5] = '\n';
  buf[6] = '\0';
  Serial.print(buf);
}
void Send_getmode() {
  Serial.write("GMp\n\r");
}
// debugging code
void debug_line() {
  // print all vectors
  for (i = 0; i < pixy.line.numVectors; i++)
  {
    sprintf(buf, "line %d: ", i);
    Serial.print(buf);
    pixy.line.vectors[i].print();
  }

  // print all intersections
  for (i = 0; i < pixy.line.numIntersections; i++)
  {
    sprintf(buf, "intersection %d: ", i);
    Serial.print(buf);
    pixy.line.intersections[i].print();
  }

  // print all barcodes
  for (i = 0; i < pixy.line.numBarcodes; i++)
  {
    sprintf(buf, "barcode %d: ", i);
    Serial.print(buf);
    pixy.line.barcodes[i].print();
  }
}

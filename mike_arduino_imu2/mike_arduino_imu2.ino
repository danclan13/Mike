
#define FILTER_UPDATE_RATE_HZ 1000
#define PRINT_EVERY_N_UPDATES 100

// serial varibles
char buf[256];
char ringbuff[256];
uint8_t readpos = 0;
uint8_t writepos = 0;
char read[256];
bool lineavailable = false;
uint8_t sendLines = 0;


uint32_t timestamp;

void setup() {
  Serial.begin(115200);

  timestamp = millis();
}
int distance = 0;
int threshold_distance = 600;


void loop() {

  static uint8_t counter = 0;
  if (Serial.available()) {
    while(Serial.available()){
      ringbuff[writepos] = Serial.read();
      if (ringbuff[writepos] == 0x0A)
        lineavailable = true;
      writepos++;
    }
  }
  if (lineavailable) {
    lineavailable = false;
    serial_parse();
  }
  distance = analogRead(A0);
  if ((millis() - timestamp) < (1000 / FILTER_UPDATE_RATE_HZ)) {
    return;
  }
  timestamp = millis();
  //for debugging only start
  if(distance<threshold_distance){
  Serial.print("DS");
  Serial.write(distance>>2);
  Serial.print("p\r\n");
  
  //Serial.print(distance); 
  }
  // for debugging only end
  
 


  // only print the calculated output once in a while
  if (counter++ <= PRINT_EVERY_N_UPDATES) {
    return;
  }
  // reset the counter
  counter = 0;

}


void serial_parse() {
  uint8_t j = 0;
  while (readpos != writepos) {
    read[j] = ringbuff[readpos];
    j++;
    readpos++;
  }
  read[j] = '\0';
  if(strstr(read,"i\r\n")!= NULL){
    char num[3];
    int16_t val;
    uint16_t readval;
    if (strstr(read, "read") != NULL){
      sendLines = read[4];
    }
    if (strstr(read, "distance") != NULL){
      Serial.print("DS");
      Serial.write(distance>>2);
      Serial.print("p\r\n");
    }
  }
  else{
    Serial.print(read);
  }

}

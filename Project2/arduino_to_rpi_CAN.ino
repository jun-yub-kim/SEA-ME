//code by joe in 42 wolfsburg @https://github.com/jun-yub-kim
#define lo8(x) ((int)(x)&0xFF)
#define hi8(x) ((int)(x)>>8)
//↓for temperature sensor --------------------------------------------------
#include "DHT.h"
#define DHTPIN 3     // Digital pin connected to the DHT sensor
#define DHTTYPE DHT11   // DHT 22  (AM2302), AM2321
DHT dht(DHTPIN, DHTTYPE);
float h;
float t;


//↓for speed sensor ---------------------------------------------------------
int speed_sensor_input = 0;
int speed_count_change = 0;
unsigned long cur_time = 0;


//↓for can communication ----------------------------------------------------
#include <mcp_can.h>
#include <SPI.h>
const int SPI_CS_PIN = 10;
MCP_CAN CAN(SPI_CS_PIN);



void setup() {
  Serial.begin(9600);
  dht.begin();
  pinMode(2, INPUT); //Input data from arduino uno board pin 2
  while (CAN_OK != CAN.begin(CAN_500KBPS))              // init can bus : baudrate = 500k
    {
        Serial.println("CAN BUS Shield init fail");
        Serial.println(" Init CAN BUS Shield again");
        delay(100);
    }
    Serial.println("CAN BUS Shield init ok!");
  


}

static void speed_sensor()
{
  static int switch_state = 1;
  
  speed_sensor_input = digitalRead(2); //read data from input
  if (speed_sensor_input == HIGH && switch_state){
    //Serial.write("on ");
    switch_state = 0;
    speed_count_change++;
  }
  else if (speed_sensor_input == LOW && !switch_state){    
    //Serial.write("off ");
    switch_state = 1;
    speed_count_change++;
  }
}

void temperature_sensor()
{
  h = dht.readHumidity();
  t = dht.readTemperature();
  
}
unsigned long testcount = 0;
unsigned long testMillis = millis();
void loop()
{
  testcount++;
  
  if(testcount > 1000){
    testcount = 0;
    Serial.println(millis() - testMillis);
    testMillis = millis();
   }
  cur_time = millis();
  speed_sensor();

  if (cur_time % 10 == 0){ //if the number behind gets greater, cycle is reduced
    // the speed sensor has 20 holes, so if the count_change gets 40, It means motor rotated once.
    // so, In one second RPM = count_change * 60 / 40
    temperature_sensor();

    long int donkey_engine_change = speed_count_change * 2.5 / 40;
    long int donkey_speed = donkey_engine_change / 5 * 2*3.14*47; // unit : mm
    long int rpm = speed_count_change * 3.75;
    unsigned char stmp[4] = {h, t, hi8(rpm), lo8(rpm)};
    CAN.sendMsgBuf(0x00, 0, 4, stmp);
    h = 0;
    t = 0;    
    speed_count_change = 0;
  }
}

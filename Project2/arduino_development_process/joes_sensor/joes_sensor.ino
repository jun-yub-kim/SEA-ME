//code by joe in 42 wolfsburg @https://github.com/jun-yub-kim
int input = 0;
int count_change = 0;
unsigned long cur_time = 0;

// detect_rotor_change()
// count_speed()
// count_speed(detect_rotor_change());

void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT); // Input data from arduino uno board pin 2
}

static void detect_rotary_change()
{
  static int switch_state = 1;
  
  input = digitalRead(2); //read data from input
  if (input == HIGH && switch_state){
    //Serial.write("on ");
    switch_state = 0;
    count_change++;
  }
  else if (input == LOW && !switch_state){    
    //Serial.write("off ");
    switch_state = 1;
    count_change++;
  }
}

void loop()
{
  cur_time = millis();
  detect_rotary_change();

  if (cur_time % 1000 == 0){ //if the number behind gets greater, cycle is reduced
    // the speed sensor has 20 holes, so if the count_change gets 40, It means motor rotated once.
    // so, In one second RPM = count_change * 60 / 40
    float rpm = count_change * 1.5;
    Serial.println(rpm);
    count_change = 0;
  }
}

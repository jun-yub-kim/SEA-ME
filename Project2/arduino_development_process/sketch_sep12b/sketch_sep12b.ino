int input = 0;

void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT);

}

static void print_rotary_change()
{
  static int switch_state = 1;
  
  input = digitalRead(2);
  if (input == HIGH && switch_state){
    Serial.write("on ");
    switch_state = 0;
  }
  else if (input == LOW && !switch_state){    
    Serial.write("off ");
    switch_state = 1;
  } 
}

void loop() {
  print_rotary_change();
}

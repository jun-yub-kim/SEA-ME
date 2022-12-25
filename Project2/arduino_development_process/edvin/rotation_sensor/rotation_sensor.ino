#define FACTOR 1

int input = 0;

void setup() {
  Serial.begin(9600);
  pinMode(2, INPUT); //핀2를 입력값으로 받는다.
}

static int count_rotary_change()
{
  static int  switch_state = 1;
  
  input = digitalRead(2); //입력으로 설정한 INPUT값(핀2)을 읽어낸다.
  if (input == HIGH && switch_state){
    switch_state = 0;
    return (1);
  }
  else if (input == LOW && !switch_state){    
    switch_state = 1;
    return (0);
  }
  return (0);
}

static int rpm()
{
   static int  count = 0;
    
  count += count_rotary_change();
  if (millis() % 1000 == 0){
    
    Serial.println(count * FACTOR);    
  }
}

void loop()
{ 
  rpm();
}

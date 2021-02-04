//include AP_Sync Library
#include <AP_Sync.h>

//Create an AP_Sync Object
AP_Sync streamer(Serial);

//declare pins where the motors are wired
//D1 and S1 are for rear pushing motor
//D2 and S2 are for direction motor
int D1 = 4;
int S1 = 5;
int D2 = 6;
int S2 = 7;

//setup()
//Open serial communication
//Set pins to outputs
void setup() {
  Serial.begin(9600);
  pinMode(D1, OUTPUT);
  pinMode(S1, OUTPUT);
  pinMode(D2, OUTPUT);
  pinMode(S2, OUTPUT);
  
}

//loop()
//if serial available read string command and perform...
void loop() {
  
  if (Serial.available()) {
    
    String command = Serial.readString();

    //if "go" set motor 1 to go forwards and at a speed of 200
    if (command == "go") {
      digitalWrite(D1, LOW);
      analogWrite(S1, 200);
      delay(10);
    }

    //if "faster" change motor's 1 speed to 244
    if (command == "faster"){
        digitalWrite(D1, LOW);
        analogWrite(S1, 240);   //PWM Speed Control
        delay(10);
      }

    //if "slower"change motor' 1 speed to 129
    if (command == "slower"){
        digitalWrite(D1, LOW);
        analogWrite(S1, 129);   //PWM Speed Control
        delay(10);
      }

    //if "stop" set all motors to stop spinning 
    if (command == "stop") {
      digitalWrite(D1, LOW);
      analogWrite(S1,0);
      digitalWrite(D2, LOW);
      digitalWrite(S2,LOW);
      
    }
    
    //if "reverse" change motor 1 direction and reverse speed
    if (command == "reverse"){
      digitalWrite(D1,HIGH);
      analogWrite(S1, 20);
    }

    //if "right" activate motor 2 right direction for a second and then continue straight
    if (command == "right"){
      digitalWrite(D2,HIGH);
      digitalWrite(S2,LOW);
      delay(1000);
      digitalWrite(D2,LOW);
      digitalWrite(S2,LOW);
      
    }

    //if "left" activate motor 2 left direction for a second and then continue straight
    if (command == "left"){
      digitalWrite(D2,LOW);
      digitalWrite(S2,HIGH);
      delay(1000);
      digitalWrite(D2,LOW);
      digitalWrite(S2,LOW);
    }
  }

    

  }

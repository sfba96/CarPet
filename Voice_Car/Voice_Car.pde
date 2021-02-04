//Speech Controlled  RC Car - CarPet
//CARPET IS STILL A PROTOTYPE. A LIVE DEMONSTRATION IS NEEDED TO SEE THE CAR WORKING. IF REPLICATION IS WANTED THEN FOLLOW THESE:
// 1. Download all the files from the folder. 
// 2. Open a SimpleHTTPServer from the terminal on the same location as the html file in order to get a host server.
// 3. Load the arduino sketch to the arduino microcontroller and make sure all connections are done properly (including the bluetooth pairing)
// 4. Open the processing file and run it
// 5. Open the webpage were the html file is located
// 6. Talk to the device and have fun.

//CarPet is a speech radio-controlled car. It uses the natural language from the person talking to it and reacts depending on the command that is being said.
//The car can understand more than english. However, I played with the ambiguity of the language in the code. Basically, the car can understand only english and some 
//really different words from spanish. Nonetheless, I used the recognition patterns that I saw on the speech API and use them to fool the code. For example, if anyone says allez
//the car will still understand but only because it interprets it as ally and that word is built in the code.


//Code Final_Prototype

//import necessary libraries
import apsync.*; //for arduino
import websockets.*; //for websocket connections
import processing.serial.*; //for processing serial communications

//import apsync and websocket objects 
AP_Sync streamer;
WebsocketServer socket;

//Movement Strings
String[] moveForward = {"move forward", "avanza", "forward", "go", "curry", "and", "end", "morality", "Ally", "and daddy"};
String[] moveFaster = {"faster", "more", "move faster", "go faster", "rapido", "trapeze", "repeat", "veloce", "feet"};
String[] moveSlower = {"slower","less", "move slower", "go slower", "lento", "mas lento", "westmont", "my splint", "mental"};
String[] moveBackwards = {"move backwards", "go backwards", "backwards", "reverse", "trivets", "perimeter", "address", "embarrassing"};
String[] stop = {"stop", "wait", "detente", "spirit"};
String[] turnRight = {"turn right", "go right", "right", "barrage", "diestra", "Vista" ,"Fiesta"};
String[] turnLeft = {"turn left", "left", "go left", "izquierda", "izquierdo", "scared", "gosh", "sinister"};
String[] comeBack = {"come back", "Craiglist", "Progressive", "drag racing", "return", "preview"};

//Empty String that receives chrome input
String speechText =" ";

//booleans that will check only once
//this will allow processing to send the message to arduino only once
boolean caseGo = false;
boolean caseFaster = false;
boolean caseSlower = false;
boolean caseStop = false;
boolean caseTurnRight = false;
boolean caseTurnLeft = false;
boolean caseComeBack = false;



void setup() {
  size(100, 100);
  
  //initialize apsync object
  streamer = new AP_Sync(this,"/dev/cu.bamse-SPP", 9600);
  
  
  //initialize socket
  socket = new WebsocketServer(this, 1337, "/voiceCar");
}

void draw() {
  
  background(255);
  
  //if forward command then turn any other cases false (to allow the reusage) and send message to arduino IDE to go forwards
  if (speechText.equals(moveForward[0])||speechText.equals(moveForward[1])|| speechText.equals(moveForward[2])||speechText.equals(moveForward[3])||
  speechText.equals(moveForward[4])||speechText.equals(moveForward[5])|| speechText.equals(moveForward[6])||speechText.equals(moveForward[7]) ||
  speechText.equals(moveForward[8])||speechText.equals(moveForward[9])){
      
      caseStop = false;
      caseFaster = false;
      caseSlower = false;
      caseTurnLeft= false;
      caseTurnRight = false;
      caseComeBack = false;
      
      if (!caseGo){
        streamer.send("go");
        caseGo = true;
      }
   
  //if faster command then turn any other cases false (to allow the reusage) and send message to arduino IDE to go faster
  } else if (speechText.equals(moveFaster[0])||speechText.equals(moveFaster[1])||speechText.equals(moveFaster[2])||speechText.equals(moveFaster[3])|| 
    speechText.equals(moveFaster[4])||speechText.equals(moveFaster[5])||speechText.equals(moveFaster[6])||speechText.equals(moveFaster[7])||
    speechText.equals(moveFaster[8])) {
      
      caseStop = false;
      caseGo = false;
      caseSlower = false;
      caseTurnLeft= false;
      caseTurnRight = false;
      caseComeBack = false;
      
      if (!caseFaster){
        streamer.send("faster");
        caseFaster = true;
      }
    
  //if slower command then turn any other cases false (to allow the reusage) and send message to arduino IDE to go slower
  } else if (speechText.equals(moveSlower[0])||speechText.equals(moveSlower[1])||speechText.equals(moveSlower[2])||speechText.equals(moveSlower[3])|| 
    speechText.equals(moveSlower[4])||speechText.equals(moveSlower[5])||speechText.equals(moveSlower[6])||speechText.equals(moveSlower[7])||
    speechText.equals(moveSlower[8])) {
    
    caseStop = false;
    caseGo = false;
    caseFaster = false;
    caseTurnLeft= false;
    caseTurnRight = false;
    caseComeBack = false;
    
    if (!caseSlower){
      streamer.send("slower");
      caseSlower = true;
    }
   
  //if stop command then turn any other cases false (to allow the reusage) and send message to arduino IDE to stop
  } else if (speechText.equals(stop[0])||speechText.equals(stop[1])||speechText.equals(stop[2])||speechText.equals(stop[3])) {
    
    caseGo = false;
    caseFaster = false;
    caseSlower = false;
    caseTurnLeft= false;
    caseTurnRight = false;
    caseComeBack = false;
    
    if (!caseStop){
        streamer.send("stop");
        caseStop = true;
    }
    
  //if backwards command then turn any other cases false (to allow the reusage) and send message to arduino IDE to go backwards
  } else if (speechText.equals(moveBackwards[0])||speechText.equals(moveBackwards[1])||speechText.equals(moveBackwards[2])||speechText.equals(moveBackwards[3])|| 
    speechText.equals(moveBackwards[4])||speechText.equals(moveBackwards[5])||speechText.equals(moveBackwards[6])||speechText.equals(moveBackwards[7])) {
    
    caseStop = false;
    caseFaster = false;
    caseSlower = false;
    caseTurnLeft= false;
    caseTurnRight = false;
    caseComeBack = false;
    
      
    if (!caseGo){
        streamer.send("reverse");
        caseGo = true;
    }
  
  //if turn right command then turn any other cases false (to allow the reusage) and send message to arduino IDE to turn the car right
  } else if (speechText.equals(turnRight[0])||speechText.equals(turnRight[1])||speechText.equals(turnRight[2])||speechText.equals(turnRight[3])|| 
    speechText.equals(turnRight[4])||speechText.equals(turnRight[5])||speechText.equals(turnRight[6])) {
    
    caseStop = false;
    caseFaster = false;
    caseSlower = false;
    caseGo = false;
    caseTurnLeft= false;
    caseComeBack = false;
    
    if (!caseTurnRight){
      streamer.send("right");
      caseTurnRight = true;
    
    }
  //if turn left command then turn any other cases false (to allow the reusage) and send message to arduino IDE to turn the car left
  }  else if (speechText.equals(turnLeft[0])||speechText.equals(turnLeft[1])||speechText.equals(turnLeft[2])||speechText.equals(turnLeft[3])|| 
    speechText.equals(turnLeft[4])||speechText.equals(turnLeft[5])||speechText.equals(turnLeft[6])||speechText.equals(turnLeft[7])) {
    
    caseStop = false;
    caseFaster = false;
    caseSlower = false;
    caseGo = false;
    caseTurnRight = false;
    caseComeBack = false;
    
    if (!caseTurnLeft){
      streamer.send("left");
      caseTurnLeft = true;
    
    }
  //if come back command then turn any other cases false (to allow the reusage) and send message to arduino IDE to turn the car around
  } else if (speechText.equals(comeBack[0])||speechText.equals(comeBack[1])||speechText.equals(comeBack[2])||speechText.equals(comeBack[3])||
  speechText.equals(comeBack[4])||speechText.equals(comeBack[5])){
    
    caseStop = false;
    caseFaster = false;
    caseSlower = false;
    caseGo = false;
    caseTurnRight = false;
    caseTurnLeft = false;
    
    if (!caseComeBack){
      streamer.send("back");
      caseComeBack = true;
    
    }
  }
  
}
  
  


void webSocketServerEvent(String msg) {
  println(msg.trim());

  speechText = msg.trim();
}
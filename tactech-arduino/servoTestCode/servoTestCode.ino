// Developer: Beatrice Villanueva
// Project: tactech
// Last Update: November 2019

// 0,1,1,1,1,0;1,0,0,0,1,0 == [[0, 1, 1, 1, 1, 0], [1, 0, 0, 0, 1, 0]] TEST RECEIPT

//LIBRARIES
#include <Servo.h>  // Servo library

//VARIABLES
// --- Servos
Servo peg1;
Servo peg2;
Servo peg3;
Servo peg4;
Servo peg5;
Servo peg6;

// --- Variables for processString(String tempString)
int pos = 0;

// --- Variables for recvAsString()
String readString;
String tempString = "";


//METHODS
// --- Setup the Board
void setup() {
    // Match baud
    Serial.begin(115200);

    // Attach servos
    peg1.attach(A1);
    peg2.attach(A2);
    peg3.attach(A3);
    peg4.attach(A4);
    peg5.attach(A5);
    peg6.attach(6);
    peg1.write(0);  
    peg2.write(0);  
    peg3.write(0);
    peg4.write(100);  
    peg5.write(100);  
    peg6.write(100);  
    
    Serial.println("<Arduino is ready>");
}

// --- Arduino loop
void loop() {
  
    // Receive data as STRING
    recvAsString();
}

// --- Process the string and convert into data for servos
void processString(String tempString) {
  delay(10);
  
  if (tempString.substring(0,1) == "1"){
    for(pos = 0; pos <= 100; pos += 1) {
      peg1.write(pos);
      delay(10);
    }
  }
  if (tempString.substring(2,3) == "1"){
    for (pos = 0; pos <= 100; pos += 1) {
      peg2.write(pos);
      delay(10);
    }
  }
  if (tempString.substring(4,5) == "1"){
    for (pos = 0; pos <= 100; pos += 1) {
      peg3.write(pos);
      delay(10);
    }
  }
  if (tempString.substring(6,7) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) {
      peg4.write(pos);
      delay(10);
    }
  }
  if (tempString.substring(8,9) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) {
      peg5.write(pos);
      delay(10);
    }
  }
  if (tempString.substring(10,11) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) {
      peg6.write(pos);
      delay(10);
    }
  }

  delay(20);

  // Reset pegs
  if (tempString.substring(0,1) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) {
      peg1.write(pos);
      delay(10);
    }
  }
  if (tempString.substring(2,3) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) {
      peg2.write(pos);
      delay(10);
    }
  }
  if (tempString.substring(4,5) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) {
      peg3.write(pos);
      delay(10);
    }
  }
  if (tempString.substring(6,7) == "1"){
    for (pos = 0; pos <= 100; pos += 1) {
      peg4.write(pos);
      delay(10);
    }
  }
  if (tempString.substring(8,9) == "1"){
    for (pos = 0; pos <= 100; pos += 1) {
      peg5.write(pos);
      delay(10);
    }
  }
  if (tempString.substring(10,11) == "1"){
    for (pos = 0; pos <= 100; pos += 1) {
      peg6.write(pos);
      delay(10);
    }
  }
}


// Receive data as string from the Serial Monitor
// 0,1,1,1,1,0;1,0,0,0,1,0;1,1,1,0,0,0; == [[0, 1, 1, 1, 1, 0], [1, 0, 0, 0, 1, 0], [1, 1, 1, 0, 0, 0]]
void recvAsString() {
    if (Serial.available())  {
      char c = Serial.read();        //gets one byte from serial buffer
      
      //Parse for first cell
      if (c == ';') {
        //do stuff
        tempString = readString;
        Serial.println(tempString);
        processString(tempString);
        readString = "";             //clears variable for new input
        
        Serial.println(tempString.substring(0,1));
        Serial.println(tempString.substring(2,3));
        Serial.println(tempString.substring(4,5));
        Serial.println(tempString.substring(6,7));
        Serial.println(tempString.substring(8,9));
        Serial.println(tempString.substring(10,11));
        tempString = "";
      }
      else {     
        readString += c; //makes the string readString
      }
  }   
 }

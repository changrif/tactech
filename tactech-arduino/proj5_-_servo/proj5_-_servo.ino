// [[0, 1, 1, 1, 1, 0], [1, 0, 0, 0, 1, 0], [0, 1, 1, 1, 0, 0], [0, 1, 1, 1, 1, 0]] REAL RECEIPT
// [0, 1, 1, 1, 1, 0] # = 18 characters TEST RECEIPT

// 0,1,1,1,1,0;1,0,0,0,1,0 == [[0, 1, 1, 1, 1, 0], [1, 0, 0, 0, 1, 0]]

//LIBRARIES
#include <Servo.h>  // Servo library
#include "Arduino.h"

//VARIABLES
// --- Servos
Servo peg1;
Servo peg2;
Servo peg3;
Servo peg4;
Servo peg5;
Servo peg6;
int pos = 0;

// --- Variables for recvAsString()
String readString;
String tempString = "";

// --- Variables for recvAsArray()
int brailleArray[6] = {1, 1, 1, 1, 1, 1}; // Braille peg array for something


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
    peg4.write(0);  
    peg5.write(100);  
    peg6.write(100);  
    
    Serial.println("<Arduino is ready>");
}

// --- Arduino loop
void loop() {
  
    // Receive data as STRING
    recvAsString();
    
    // Receive data as ARRAY
    //recvAsArray();
}

// --- Receive data as ARRAY
// --- [0, 1, 1, 1, 1, 0] # = 18 characters TEST RECEIPT
void processString(String tempString) {
  delay(10);
  
  if (tempString.substring(0,1) == "1"){
    for(pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg1.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (tempString.substring(2,3) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg2.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (tempString.substring(4,5) == "1"){
    for (pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg3.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (tempString.substring(6,7) == "1"){
    for (pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg4.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (tempString.substring(8,9) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg5.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (tempString.substring(10,11) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg6.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }

  delay(20);

  // Reset pegs
  
  if (tempString.substring(0,1) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg1.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (tempString.substring(2,3) == "1"){
    for (pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg2.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (tempString.substring(4,5) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg3.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (tempString.substring(6,7) == "1"){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg4.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);  
    }
  }
  if (tempString.substring(8,9) == "1"){
    for (pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg5.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (tempString.substring(10,11) == "1"){
    for (pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg6.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
}


// Receive data as STRING
// 0,1,1,1,1,0;1,0,0,0,1,0;1,1,1,0,0,0; == [[0, 1, 1, 1, 1, 0], [1, 0, 0, 0, 1, 0], [1, 1, 1, 0, 0, 0]]
void recvAsString() {
    if (Serial.available())  {
      char c = Serial.read();        //gets one byte from serial buffer
      
      //Parse for first cell
      if (c == ';') {
        //do stuff
        tempString = readString;
        Serial.println(tempString);  //prints string to serial port out
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

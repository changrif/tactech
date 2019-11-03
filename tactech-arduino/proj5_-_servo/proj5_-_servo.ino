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
String serialResponse = "";
char sz[] = "Here; is some; sample;100;data;1.414;1020";
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
void recvAsArray() {
  delay(10);
  
  if (brailleArray[0] == 1){
    for(pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg1.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (brailleArray[1] == 1){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg2.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (brailleArray[2] == 1){
    for (pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg3.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (brailleArray[3] == 1){
    for (pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg4.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (brailleArray[4] == 1){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg5.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (brailleArray[5] == 1){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg6.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }

  delay(20);

  // Reset pegs
  
  if (brailleArray[0] == 1){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg1.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (brailleArray[1] == 1){
    for (pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg2.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (brailleArray[2] == 1){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg3.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (brailleArray[3] == 1){
    for (pos = 100; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      peg4.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);  
    }
  }
  if (brailleArray[4] == 1){
    for (pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg5.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }
  if (brailleArray[5] == 1){
    for (pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
      peg6.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(10);                         // waits 15ms for the servo to reach the position
    }
  }

  //Exit
  brailleArray[0] = 0;
  brailleArray[1] = 0;
  brailleArray[2] = 0;
  brailleArray[3] = 0;
  brailleArray[4] = 0;
  brailleArray[5] = 0;
}


// Receive data as STRING
// 0,1,1,1,1,0;1,0,0,0,1,0;1,1,1,0,0,0 == [[0, 1, 1, 1, 1, 0], [1, 0, 0, 0, 1, 0], [1, 1, 1, 0, 0, 0]]
void recvAsString() {
    if ( Serial.available()) {
    serialResponse = Serial.readStringUntil('\r\n');

    // Convert from String Object to String.
    char buf[sizeof(sz)];
    serialResponse.toCharArray(buf, sizeof(buf));
    char *p = buf;
    char *str;
    while ((str = strtok_r(p, ";", &p)) != NULL) // delimiter is the semicolon
      // 0,1,1,1,1,0;
      //tempString = str;
      /*
      delay(10);
      
      if(str[0] = '1'){
        for(pos = 0; pos <= 100; pos += 1) { // goes from 180 degrees to 0 degrees
          peg1.write(pos);                   // tell servo to go to position in variable 'pos'
          delay(10);                         // waits 15ms for the servo to reach the position
        }
      }*/
      //Serial.println(tempString.substring(0,1));
      //Serial.println(tempString);
      Serial.println(str);
      Serial.println("Test");
      
  }
  
}

// Reset pegs
void resetPegs() {
  for (pos = 180; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
    peg2.write(pos);                    // tell servo to go to position in variable 'pos'
    delay(15);                          // waits 15ms for the servo to reach the position
  }
}

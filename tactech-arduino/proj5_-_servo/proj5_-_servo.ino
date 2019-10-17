// [[0, 1, 1, 1, 1, 0], [1, 0, 0, 0, 1, 0], [0, 1, 1, 1, 0, 0], [0, 1, 1, 1, 1, 0]] REAL RECEIPT
// [0, 1, 1, 1, 1, 0] # = 18 characters TEST RECEIPT

//LIBRARIES
#include <Servo.h>  // Servo library

//VARIABLES
// --- Servos
Servo peg1;
Servo peg2;
// --- Variables for recvAsString()
const byte numChars = 32; // random number
char receivedChars[numChars]; // an array to store the received data
boolean newData = false;

// --- Variables for recvAsArray()
int brailleArray[6] = {0, 1, 1, 1, 1, 0}; // Braille peg array for 't'

int pos = 0;

//METHODS
// --- Setup the Board
void setup() {
    // Match baud
    Serial.begin(9600);

    // Attach servos
    peg1.attach(A0);
    peg2.attach(A1);
    
    Serial.println("<Arduino is ready>");
}

// --- Arduino loop
void loop() {
  
    // Receive data as STRING
    //recvAsString();
    //showNewData();
    
    // Receive data as ARRAY
    recvAsArray();
    exit(0);

}

// --- Receive data as ARRAY
// --- [0, 1, 1, 1, 1, 0] # = 18 characters TEST RECEIPT
void recvAsArray() {
  // Reset pegs
  peg1.write(0);
  peg2.write(0);

  delay(30);
  
  if (brailleArray[0] == 1){
    for (pos = 0; pos <= 90; pos += 1) { // goes from 180 degrees to 0 degrees
      peg1.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(15);                         // waits 15ms for the servo to reach the position
    }
  }
  if (brailleArray[1] == 1){
    for (pos = 0; pos <= 90; pos += 1) { // goes from 180 degrees to 0 degrees
      peg2.write(pos);                   // tell servo to go to position in variable 'pos'
      delay(15);                         // waits 15ms for the servo to reach the position
    }
  }

  delay(30);

  // Reset pegs
  peg1.write(0);
  peg2.write(0);
}


// Receive data as STRING
// [0, 1, 1, 1, 1, 0] # = 18 characters TEST RECEIPT
void recvAsString() {
    static byte ndx = 0;
    char endMarker = '\n';
    char rc;
   
    while (Serial.available() > 0 && newData == false) {
        rc = Serial.read();

        if (rc != endMarker) {
            receivedChars[ndx] = rc;
            ndx++;
            if (ndx >= numChars) {
                ndx = numChars - 1;
            }
        }
        else {
            receivedChars[ndx] = '\0'; // terminate the string
            ndx = 0;
            newData = true;
        }
    }
}

// Reset pegs
void resetPegs() {
  for (pos = 180; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
    peg2.write(pos);                    // tell servo to go to position in variable 'pos'
    delay(15);                          // waits 15ms for the servo to reach the position
  }
}

// Display data in Serial Monitor
void showNewData() {
    if (newData == true) {
        Serial.print("This just in ... ");
        Serial.println(receivedChars);
        newData = false;
    }
}

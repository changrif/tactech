// [[0, 1, 1, 1, 1, 0], [1, 0, 0, 0, 1, 0], [0, 1, 1, 1, 0, 0], [0, 1, 1, 1, 1, 0]]
// [0, 1, 1, 1, 1, 0] # = 18
/*
NOTE: Maps and moves servo to a potentiometer
#include <Servo.h>

Servo myServo;

int const potPin = A0;
int potVal;
int angle;

void setup(){
  myServo.attach(9);

  Serial.begin(9600);
}

void loop(){
  potVal = analogRead(potPin);
  Serial.print("potVal: ");
  Serial.print(potVal);
  angle = map(potVal, 0, 1023, 0, 179);
  Serial.print(", angle: ");
  Serial.println(angle);
  myServo.write(angle);
  delay(15);
}
*/
// -------------
/*
void setup() {
  Serial.begin(9600); // Initialize the serial connection at 9600 bits per second
}

char rx_byte = 0;

void loop() {
  if (Serial.available() > 0) {    // is a character available?
    rx_byte = Serial.read();       // get the character
  
    // check if a number was received
    if ((rx_byte >= '0') && (rx_byte <= '9')) {
      Serial.print("Number received: ");
      Serial.println(rx_byte);
    }
    else {
      Serial.println("Not a number.");
    }
  } // end: if (Serial.available() > 0)
}*/

// Example 2 - Receive with an end-marker

const byte numChars = 19;       //
char receivedChars[numChars];   // an array to store the received data

boolean newData = false;

void setup() {
    Serial.begin(9600);
    Serial.println("<Arduino is ready>");
}

void loop() {
    recvWithEndMarker();
    showNewData();
}

void recvWithEndMarker() {
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

void showNewData() {
    if (newData == true) {
        Serial.print("This just in ... ");
        Serial.println(receivedChars);
        newData = false;
    }
}

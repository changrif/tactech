# tactech-arduino
##### tactech-arduino houses all of our code that controls our project's hardware. The two folders are divided into **bleuart_cmdmode** and **servoTestCode**.


### bleuart_cmdmode
bleuart_cmdmode is our main, working hardware code.

* setup() sets up and factory resets our Adafruit Bluefruit module

* loop() loops through our Adafruit Bluefruit's buffer and pushes it into recvAsString()

* recvAsString() parses through the buffer's contents using our programmed delimiters (, and ;) for our Braille "code" for a String (i.e. 1,1,1,1,1,1;0,0,0,0,0,0;)

* convertToString() converts char* buffer into String

* recvAsString() parses through each Braille cell (i.e. 1,1,1,1,1,1;), attaches each servo, and pulls up the respective servo motor

* getUserInput() checks for user input


### servoTestCode
servoTestCode is our testing environment for our servos that separates it from the Adafruit Bluefruit

* setup() sets up our servos and attaches them

* processString() parses through each Braille cell (i.e. 1,1,1,1,1,1;), attaches each servo, and pulls up the respective servo motor

* recvAsString() parses through user input to send into processString()

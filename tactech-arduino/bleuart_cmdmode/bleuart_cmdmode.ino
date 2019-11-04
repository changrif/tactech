/*********************************************************************
 This is an example for our nRF51822 based Bluefruit LE modules

 Pick one up today in the adafruit shop!

 Adafruit invests time and resources providing this open source code,
 please support Adafruit and open-source hardware by purchasing
 products from Adafruit!

 MIT license, check LICENSE for more information
 All text above, and the splash screen below must be included in
 any redistribution
*********************************************************************/

//LIBRARIES
#include <SPI.h>
#include "Adafruit_BLE.h"
#include "Adafruit_BluefruitLE_SPI.h"
#include "Adafruit_BluefruitLE_UART.h"
#include "BluefruitConfig.h"
#include <Servo.h>

#if SOFTWARE_SERIAL_AVAILABLE
  #include <SoftwareSerial.h>
#endif

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


/*=========================================================================
    APPLICATION SETTINGS

    FACTORYRESET_ENABLE       Perform a factory reset when running this sketch
   
                              Enabling this will put your Bluefruit LE module
                              in a 'known good' state and clear any config
                              data set in previous sketches or projects, so
                              running this at least once is a good idea.
   
                              When deploying your project, however, you will
                              want to disable factory reset by setting this
                              value to 0.  If you are making changes to your
                              Bluefruit LE device via AT commands, and those
                              changes aren't persisting across resets, this
                              is the reason why.  Factory reset will erase
                              the non-volatile memory where config data is
                              stored, setting it back to factory default
                              values.
       
                              Some sketches that require you to bond to a
                              central device (HID mouse, keyboard, etc.)
                              won't work at all with this feature enabled
                              since the factory reset will clear all of the
                              bonding data stored on the chip, meaning the
                              central device won't be able to reconnect.
    MINIMUM_FIRMWARE_VERSION  Minimum firmware version to have some new features
    MODE_LED_BEHAVIOUR        LED activity, valid options are
                              "DISABLE" or "MODE" or "BLEUART" or
                              "HWUART"  or "SPI"  or "MANUAL"
    -----------------------------------------------------------------------*/
    #define FACTORYRESET_ENABLE         1
    #define MINIMUM_FIRMWARE_VERSION    "0.6.6"
    #define MODE_LED_BEHAVIOUR          "MODE"
/*=========================================================================*/

// Create the bluefruit object, either software serial...uncomment these lines

SoftwareSerial bluefruitSS = SoftwareSerial(BLUEFRUIT_SWUART_TXD_PIN, BLUEFRUIT_SWUART_RXD_PIN);

Adafruit_BluefruitLE_UART ble(bluefruitSS, BLUEFRUIT_UART_MODE_PIN,
                      BLUEFRUIT_UART_CTS_PIN, BLUEFRUIT_UART_RTS_PIN);

// A small helper
void error(const __FlashStringHelper*err) {
  Serial.println(err);
  while (1);
}

/**************************************************************************/
/*!
    @brief  Sets up the HW an the BLE module (this function is called
            automatically on startup)
*/
/**************************************************************************/

void setup(void)
{
  // Match baud
  Serial.begin(115200);
  
  Serial.println(F("Adafruit Bluefruit Command Mode Example"));
  Serial.println(F("---------------------------------------"));

  /* Initialise the module */
  Serial.print(F("Initialising the Bluefruit LE module: "));

  if ( !ble.begin(VERBOSE_MODE) )
  {
    error(F("Couldn't find Bluefruit, make sure it's in CoMmanD mode & check wiring?"));
  }
  Serial.println( F("OK!") );

  if ( FACTORYRESET_ENABLE )
  {
    /* Perform a factory reset to make sure everything is in a known state */
    Serial.println(F("Performing a factory reset: "));
    if ( ! ble.factoryReset() ){
      error(F("Couldn't factory reset"));
    }
  }

  /* Disable command echo from Bluefruit */
  ble.echo(false);

  Serial.println("Requesting Bluefruit info:");
  /* Print Bluefruit information */
  ble.info();

  Serial.println(F("Please use Adafruit Bluefruit LE app to connect in UART mode"));
  Serial.println(F("Then Enter characters to send to Bluefruit"));
  Serial.println();

  ble.verbose(false);  // debug info is a little annoying after this point!

  /* Wait for connection */
  while (! ble.isConnected()) {
      delay(500);
  }

  // LED Activity command is only supported from 0.6.6
  if ( ble.isVersionAtLeast(MINIMUM_FIRMWARE_VERSION) )
  {
    // Change Mode LED Activity
    Serial.println(F("******************************"));
    Serial.println(F("Change LED activity to " MODE_LED_BEHAVIOUR));
    ble.sendCommandCheckOK("AT+HWModeLED=" MODE_LED_BEHAVIOUR);
    Serial.println(F("******************************"));
  }

  // Connects to Bluetooth
  Serial.println("<Arduino is ready>");
}

/**************************************************************************/
/*!
    @brief  Constantly poll for new command or response data
*/
/**************************************************************************/
void loop(void)
{ 
  // Check for user input
  char inputs[BUFSIZE+1];

  if ( getUserInput(inputs, BUFSIZE) )
  {
    // Send characters to Bluefruit
    Serial.print("[Send] ");
    Serial.println(inputs);

    ble.print("AT+BLEUARTTX=");
    ble.println(inputs);

    // check response stastus
    if (! ble.waitForOK() ) {
      Serial.println(F("Failed to send?"));
    }
  }

  // Check for incoming characters from Bluefruit
  ble.println("AT+BLEUARTRX");
  ble.readline();
  if (strcmp(ble.buffer, "OK") == 0) {
    // no data
    return;
  }
  // Some data was found, its in the buffer
  Serial.print(F("[Recv] ")); char* c = ble.buffer;
  Serial.println(c);
  recvAsString(c);
  ble.waitForOK();
}

int cellNum = 0;

void recvAsString(String c){
  // Attach servos
  peg1.attach(A1);
  peg2.attach(A2);
  peg3.attach(A3);
  peg4.attach(A4);
  peg5.attach(A5);
  peg6.attach(A0);
  peg1.write(0);
  peg2.write(0);
  peg3.write(0);
  peg4.write(100);
  peg5.write(100);
  peg6.write(100);
  
  //1,0,0,0,0,1; - ONE CELL AT A TIME
  for(int i = 0; i <= c.length(); i++){
    if(c.substring(i, i+1) == ';'){
      tempString = c.substring(0,i);
      Serial.println(tempString);
      processString(tempString);
      tempString = "";
    }
  }
}

// --- Process the string and convert into data for servos
void processString(String tempString) {
  delay(10);
  Serial.println(tempString.substring(0,1));
  Serial.println(tempString.substring(2,3));
  Serial.println(tempString.substring(4,5));
  Serial.println(tempString.substring(6,7));
  Serial.println(tempString.substring(8,9));
  Serial.println(tempString.substring(10,11));
  
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

  //Detach
  peg1.detach();
  peg2.detach();
  peg3.detach();
  peg4.detach();
  peg5.detach();
  peg6.detach();
}
/**************************************************************************/
/*!
    @brief  Checks for user input (via the Serial Monitor)
*/
/**************************************************************************/
bool getUserInput(char buffer[], uint8_t maxSize)
{
  // timeout in 100 milliseconds
  TimeoutTimer timeout(100);

  memset(buffer, 0, maxSize);
  while( (!Serial.available()) && !timeout.expired() ) {
    delay(1); 
    peg1.write(0);
    peg2.write(0);
    peg3.write(0);
    peg4.write(100);
    peg5.write(100);
    peg6.write(100);
   }

  if ( timeout.expired() ) return false;

  delay(2);
  uint8_t count=0;
  
  do
  {
    count += Serial.readBytes(buffer+count, maxSize);
    delay(2);
    peg1.write(0);
    peg2.write(0);
    peg3.write(0);
    peg4.write(100);
    peg5.write(100);
    peg6.write(100);
  } while( (count < maxSize) && (Serial.available()) );

  return true;
}

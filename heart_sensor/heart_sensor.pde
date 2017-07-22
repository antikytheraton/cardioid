// based on http://openprocessing.org/sketch/215656
//
// Heart function:
// x = 16*sin(t)^3
// y = 13*cos(t) - 5*cos(2*t) - 2*cos(3*t) - cos(4*t)
//
// Colors: https://color.adobe.com/ru/Cherry-Bomb-color-theme-1197172/

import processing.serial.*;

Serial arduino;  // serial port to arduino
int serialVal = 1;  // this variable saves serial reading
float inByte = 0;

void setup() {

  arduino = new Serial(this, Serial.list()[0], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  arduino.bufferUntil('\n');

  size(640, 640);
  noStroke();
  fill(#f60a20, 200);
}

void draw() {
  background(#262526);
  translate(width/2, height/2);
  for (float angle = -90; angle < 90; angle += 0.5) {
    for (float q = 1; q < 2; q += 0.2) {
      float a = q*180;
      float t = angle+frameCount*1.5+a;
      float x = 16*pow(sin(radians(t)), 3);
      float y = -13*cos(radians(t)) + 5*cos(radians(2*t)) + 2*cos(radians(3*t)) + cos(radians(4*t));
      float s = cos(radians(angle))*q*7;
      ellipse(x*q*8, y*q*8, s * inByte, s);
    }
  }
}

void serialEvent (Serial arduino) {
  // get the ASCII string:
  String inString = arduino.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    inByte = float(inString);
    println(inByte);
    inByte = map(inByte, 0, 1023, 1, 10);
  }
}
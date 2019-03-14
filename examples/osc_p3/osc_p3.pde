/* osc_p3 _ OSC sketch for Processing 3.x
 * OSC workshop
 * NYU ITP - Spring 2019
 * by nicolás escarpentier */

// packages to import -- REMEMBER TO INSTALL THEM!
import netP5.*;
import oscP5.*;

// OSC variables
int PORT = 9000;
String IP_ADDRESS = "127.0.0.1";
OscP5 oscP5;
NetAddress net_location;

// sketch variables
float r, g, b, a;

void setup(){
  size(400, 200);
  
  // initialize OSC connection
  oscP5 = new OscP5(this, PORT);
  net_location = new NetAddress(IP_ADDRESS, PORT);
  
  // variables initialization
  r = 0.;
  g = 0.;
  b = 0.;
  a = 1.;
}

void draw(){
  color c = color(r,g,b,a);
  background(c);
}

// function to send an OSC message
void sendOsc(String route, String value){
  OscMessage msg = new OscMessage(route); // "/mouse"
  msg.add(value);
  oscP5.send(msg, net_location);
}

// function to receive an OSC message
void oscEvent(OscMessage msg){
  if(msg.checkAddrPattern("/sliders") == true){
    // you can check for the type of the messages;
    //if(msg.checkTypetag("ifs")){}
    r = msg.get(0).floatValue() * 255;
    g = msg.get(1).floatValue() * 255;
    b = msg.get(2).floatValue() * 255;
    a = msg.get(3).floatValue() * 255;
  }
}
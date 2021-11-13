/*
Voice Commands:
 "next" to cycle through images
 "go up" to pan up on the image
 "go down" to pan down on the image
 "go left" to pan left on the image
 "go right" to pan right on the image
 */

int x, y = 0;
boolean image1 = true, image2 = false;
PImage img1, img2, img3;
String message;
import websockets.*;

WebsocketServer socket;
void setup() {
  socket = new WebsocketServer(this, 1337, "/p5websocket");
  size(960, 540);
  img1 = loadImage("img1.jpg");
  img2 = loadImage("img2.jpg");
  img3 = loadImage("img3.jpg");
}

void draw() {
  background(0);
  if (image1) {
    image(img1, x, y);
  } else if (image2) {
    image(img2, x, y);
  } else {
    image(img3, x, y);
  }
}

void webSocketServerEvent(String msg) {
  println(msg);
  message = msg;
  if (trim(message).equals("next")) {
    x = 0;
    y = 0;
    if (image1) {
      image1 = false;
      image2 = true;
    } else if (image2) {
      image2 = false;
    } else {
      image1 = true;
    }
  }
  if (trim(message).equals("go right")) {
    x = -960;
  } else if (trim(message).equals("go left")) {
    x = 0;
  }
  if (trim(message).equals("go up")) {
    y = 0;
  } else if (trim(message).equals("go down")) {
    y = -540;
  }
}

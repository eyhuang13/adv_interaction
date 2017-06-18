import processing.serial.*;

PImage lotus;
PImage sprout;
PImage poster;
PImage poster2;
boolean has_motion = false;
ArrayList<Particle> particles = new ArrayList<Particle>();
//Serial sensorPort;
String val = "";

void setup(){
  //fullScreen(2);

  size(1100, 1684);
  imageMode(CENTER);
  lotus = loadImage("lotus.png");
  sprout = loadImage("sprout.png");
  poster = loadImage("finalnolotuslong.jpg");
  poster2 = loadImage("postersproutlong.jpg");
  
  for(int i=0; i<60; i++){
    Particle p_temp = new Particle(random(width), 612);
    particles.add(p_temp);
  }
  //println(Serial.list()[0]);
  //String portName = Serial.list()[0];
  //sensorPort = new Serial(this, portName, 19200);
}


int wave = 10; //for controlling particles
int ct = 0;
void draw(){
  /*if(sensorPort.available() > 0){
    val = sensorPort.readStringUntil('\n');  
  }*/
  //println(val);

  if(has_motion){
    poster2.resize(width, height);
    background(poster2);
    fade(sprout);
  }
  else{
    poster.resize(width, height);
    background(poster);
    fade(lotus);
  }
  
  //draw particles
  for(int i=0; i<wave; i++){
    particles.get(i).create();  
  }  
  if(wave < 60){
    wave += 10; 
  }
  delay(25);
  
  ct++;
  if(ct == 220){
    has_motion ^= true;
    ct = 0;
  }
}


//fade icon in and out
int alpha = 1, delta = 4;
void fade(PImage icon){
  alpha += delta;
  if (alpha == 1 || alpha == 161) delta *= -1;
  tint(255, alpha);
  image(icon, width/2, (height/2)-(height/7.3), width/1.39, width/1.39);
}


//floating particle effect
class Particle{
  float xval;
  float yval;
  
  Particle(float tempXval, float tempYval){
    xval = tempXval;
    yval = tempYval;
  }
  
  void create(){
    noStroke();
    fill(255, 255, 255, alpha);
    ellipse(xval, yval, 4, 4);
    //filter(BLUR, 4);
    xval += random(-3, 3);
    yval -= random(40);
    if(yval <= 0) yval = height;
  }
}
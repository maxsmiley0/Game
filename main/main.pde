import java.util.Stack;

PFont font;

PImage friskRestLeft;
PImage friskRestRight;
PImage friskRestForward;

Animation friskWalkLeft;
Animation friskWalkRight;
Animation friskWalkForward;

Animation hP;

ButtonList bl;

Player p;

void setup()
{
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  size(800, 600);
  
  font = createFont("data/fonts/pusab.ttf", 30);
  textFont(font);
  
  friskRestLeft = loadImage("data/images/friskRestLeft.png");
  friskRestRight = loadImage("data/images/friskRestRight.png");
  friskRestForward = loadImage("data/images/friskRestForward.png");
  
  friskWalkLeft = new Animation("friskWalkLeft", 2, 2);
  friskWalkRight = new Animation("friskWalkRight", 2, 2);
  friskWalkForward = new Animation("friskWalkForward", 4, 1);
  
  hP = new Animation("hP", 8, .5);
  
  String buttons[] = {"One", "Two", "Three"};
  bl = new ButtonList(buttons, true, new PVector(100, 100), new PVector (100, 50), 3, 80, false);
  
  p = new Player(new PVector(-300, 400));
  p.setStill(friskRestForward);
  
  Struct s = new Struct("data/images/wall.png", new PVector(0, 0), new PVector(200, 200), true);
  Struct s1 = new Struct("data/images/wall.png", new PVector(-600, 400), new PVector(100, 200), true);
  Struct s2 = new Struct("data/images/wall.png", new PVector(-100, 700), new PVector(200, 100), true);
  Struct s3 = new Struct("data/images/wall.png", new PVector(200, -300), new PVector(300, 100), true);
  Struct s4 = new Struct("data/images/wall.png", new PVector(100, -900), new PVector(100, 300), true);
  Struct s5 = new Struct("data/images/wall.png", new PVector(700, 200), new PVector(400, 400), true);
  Struct s6 = new Struct("data/images/wall.png", new PVector(-600, 1600), new PVector(100, 100), true);
  
  Room r = new Room(new PVector(0, 0), new PVector(2000, 2000));
  r.addStruct(s);
  r.addStruct(s1);
  r.addStruct(s2);
  r.addStruct(s3);
  r.addStruct(s4);
  r.addStruct(s5);
  r.addStruct(s6);
  
  p.setRoom(r);
  //p.getBlStack().push(bl);
}

float x = 0;
int endSize = 100;
Text t = new Text();
void draw()
{
  pushMatrix();
  
  translate(width/2, height/2);
  
  background(#CCCCCC);
  
  p.implementArrowKeys();
  
  p.displayRoom();
  p.display();
  
  popMatrix();
  if (mousePressed)
  {
    if (mouseButton ==LEFT)
    {
      x = 0; 
      t.reset();
    }
  }
  //Some kind of system that auto newlines words
  fill(#FFFFFF);
  noStroke();
  rect(mouseX, mouseY, 2*x, x);
  fill(#000000);
  textSize(x/5);
  t.display("Hello, my name \nis Frisk. What is\nyours?\n\n\nd", new PVector(mouseX, mouseY), 3);
  if (x < (endSize * .99))
  {
    x += (endSize/20)*(1 - x/endSize);
  }
  else
  {
    x = endSize;
  }
  
  println(x);
  
  
  //bl.display();
}

/*
Before we implement NPCs, we have to
Figure out speech mechanics
Room transitions?
Room spawnpoints?
*/

import java.util.Stack;

PFont font;

PImage friskRestLeft;
PImage friskRestRight;
PImage friskRestForward;

Animation friskWalkLeft;
Animation friskWalkRight;
Animation friskWalkForward;

ButtonList bl;

Player p;

void setup()
{
  rectMode(CENTER);
  textAlign(CENTER);
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
  
  String buttons[] = {"One", "Two", "Three"};
  bl = new ButtonList(buttons, true, new PVector(100, 100), new PVector (100, 50), 3, 80, false);
  
  p = new Player(new PVector(-300, 400));
  p.setStill(friskRestForward);
  
  Struct s = new Struct("data/images/wall.png", new PVector(0, 0), new PVector(200, 200), false);
  Struct s1 = new Struct("data/images/wall.png", new PVector(200, 300), new PVector(100, 100), true);
  
  Room r = new Room(new PVector(0, 0), new PVector(2000, 2000));
  r.addStruct(s);
  r.addStruct(s1);
  
  p.setRoom(r);
  //p.getBlStack().push(bl);
}


void draw()
{
  translate(width/2, height/2);
  
  background(#FFFFFF);
  
  p.implementArrowKeys();
  
  p.displayRoom();
  p.display();
  
  //bl.display();
  println("reinke");
}

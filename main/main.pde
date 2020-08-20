import java.util.Stack;

PFont font;

PImage friskRestLeft;
PImage friskRestRight;
PImage friskRestForward;

PImage hPStill;

Animation friskWalkLeft;
Animation friskWalkRight;
Animation friskWalkForward;

Animation hP;

ButtonList bl;
NPC npc;

Bubble b;
String strs[] = {"Hello, my name is\nFrisk. What is\nyours?", "Nice to meet you!"};
int displayPeriods[] = {3, 1};


Player p;

void setup()
{
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  size(800, 600);
  
  font = createFont("data/fonts/pusab.ttf", 30);
  textFont(font);
  
  hPStill = loadImage("data/images/hP.png");
  friskRestLeft = loadImage("data/images/friskRestLeft.png");
  friskRestRight = loadImage("data/images/friskRestRight.png");
  friskRestForward = loadImage("data/images/friskRestForward.png");
  
  friskWalkLeft = new Animation("friskWalkLeft", 2, 2);
  friskWalkRight = new Animation("friskWalkRight", 2, 2);
  friskWalkForward = new Animation("friskWalkForward", 4, 1);
  
  hP = new Animation("hP", 8, .5);
  
  b = new Bubble(strs, displayPeriods, new PVector(200, 200), new PVector(200, 150), 2);
  npc = new NPC(new PVector(100, 100), hPStill);
  npc.addQuest(b);
  
  String buttons[] = {"One", "Two", "Three"};
  bl = new ButtonList(buttons, true, new PVector(100, 100), new PVector (100, 50), 3, 80, false);
  
  p = new Player(new PVector(-300, 400));
  p.setStill(friskRestForward);
  //Big structs lag?
  Struct s = new Struct("data/images/wall.png", new PVector(0, 0), new PVector(200, 200), false);
  Struct s1 = new Struct("data/images/wall.png", new PVector(-600, 400), new PVector(100, 200), false);
  Struct s2 = new Struct("data/images/wall.png", new PVector(-100, 700), new PVector(200, 100), false);
  Struct s3 = new Struct("data/images/wall.png", new PVector(200, -300), new PVector(300, 100), false);
  Struct s4 = new Struct("data/images/wall.png", new PVector(100, -900), new PVector(100, 300), false);
  Struct s5 = new Struct("data/images/wall.png", new PVector(700, 200), new PVector(100, 100), false);
  Struct s6 = new Struct("data/images/wall.png", new PVector(-600, 1600), new PVector(100, 100), false);
  
  Room r = new Room(new PVector(0, 0), new PVector(2000, 2000));
  r.addStruct(s);
  r.addStruct(s1);
  r.addStruct(s2);
  r.addStruct(s3);
  r.addStruct(s4);
  r.addStruct(s5);
  r.addStruct(s6);
  r.addNpc(npc);
  
  p.setRoom(r);
  //p.getBlStack().push(bl);

}

float x = 0;
float endSize = 1;
Text t = new Text();
void draw()
{
  pushMatrix();
  
  translate(width/2, height/2);
  
  background(#CCCCCC);
  
  p.implementArrowKeys();
  
  p.displayRoom();
  p.display();
  //b.display();
  
  popMatrix();
  
  if (p.getInteractor() != null)
  {
    text(p.getInteractor().toString(), mouseX, mouseY);
  }
  else 
  {
    text("null", mouseX, mouseY);
  }
}

/*
Before we implement NPCs, we have to
Figure out speech mechanics
Room transitions?

boolean method in Text, true if rolling effect is done

Room spawnpoints?
make a text file explaining how to use each class
*/

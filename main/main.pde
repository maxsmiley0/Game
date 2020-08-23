import java.util.Stack;

enum shopInterface {DEFAULT, BUY, SELL, TALK};

PFont font;
PFont font0;

PImage friskRestLeft;
PImage friskRestRight;
PImage friskRestForward;

PImage shopBackground;

PImage hPStill;

Animation friskWalkLeft;
Animation friskWalkRight;
Animation friskWalkForward;

Object o1;
Object o2;
Object o3;

Animation hP;
Shop shop;

Text text;
ButtonList bl;
NPC npc;
NPC npc0;

Bubble b;
Bubble b0;
String strs[] = {"Alex Hadidi\nis a gentleman\nand a scholar", "Nice to meet you!"};
int displayPeriods[] = {3, 1};


Player p;
String buttons[] = {"One", "Two", "Three"};

void setup()
{
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  size(1100, 700);
  text = new Text();
  font0 = createFont("data/fonts/8bitoperator.ttf", 30);
  font = createFont("data/fonts/pusab.ttf", 30);
  textFont(font);
  
  hPStill = loadImage("data/images/hP.png");
  friskRestLeft = loadImage("data/images/friskRestLeft.png");
  friskRestRight = loadImage("data/images/friskRestRight.png");
  friskRestForward = loadImage("data/images/friskRestForward.png");
  shopBackground = loadImage("data/images/shopBackground.png");
  
  friskWalkLeft = new Animation("friskWalkLeft", 2, 2);
  friskWalkRight = new Animation("friskWalkRight", 2, 2);
  friskWalkForward = new Animation("friskWalkForward", 4, 1);
  
  shop = new Shop();
  
  hP = new Animation("hP", 8, .5);
  
  b = new Bubble(strs, displayPeriods, new PVector(100, -50), new PVector(200, 100), 2);
  b0 = new Bubble(strs, displayPeriods, new PVector(400, 250), new PVector(200, 100), 2);
  npc = new NPC(new PVector(100, 100), hPStill);
  npc0 = new NPC(new PVector(400, 400), hPStill);
  npc.setBubble(b);
  npc0.setBubble(b0);
  
  bl = new ButtonList(buttons, true, new PVector(0, 0), new PVector (0, 0), 3, 80, false);
  
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
  npc.setShopkeeper(true);
  Room r = new Room(new PVector(0, 0), new PVector(2000, 2000));
  r.addStruct(s);
  r.addStruct(s1);
  r.addStruct(s2);
  r.addStruct(s3);
  r.addStruct(s4);
  r.addStruct(s5);
  r.addStruct(s6);
  r.addNpc(npc);
  r.addNpc(npc0);
  
  //Definitely need to be able to adjust text size!
  o1 = new Object("Frog Peasent Sword", "Before sunrise, the Frog\nPeasents roam the grounds,\nslashing and stabbing at\nany unwelcome visitors.", 100);
  o2 = new Object("Frog Peasent Lederhosen", "Blocks or something idk", 80);
  o3 = new Object("Potion", "*gurgles*", 25);
  
  ArrayList<Object> inventory = new ArrayList<Object>();
  
  inventory.add(o1);
  inventory.add(o2);
  inventory.add(o3);
  
  shop.setInventory(inventory);
  
  p.setRoom(r);
}

void draw()
{
  pushMatrix();
  
  translate(width/2, height/2);
  background(#CCCCCC);
  
  if (!p.isInShop())
  {
    p.implementArrowKeys();
    p.displayRoom();
    p.display();
  }
  else 
  {
    shop.display();
  }
  
  popMatrix();
  text(shop.getShopInterface(), mouseX, mouseY);
}

void displayShop()
{   
  if (p.getBlStack().size() == 1)
  {
    //fill(#FFFFFF);
    //text.display("What can I do for you today?", new PVector(-200, 120), 2);
  }
    
  
}

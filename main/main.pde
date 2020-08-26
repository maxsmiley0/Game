import java.util.Stack;
import ddf.minim.*;

Minim minim;

AudioPlayer talk;
AudioPlayer song;

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
int displayCps[] = {12, 12};


Player p;
String buttons[] = {"One", "Two", "Three"};

void setup()
{
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  size(1100, 700);
  
  minim = new Minim(this);
  talk = minim.loadFile("data/sounds/generic.mp3");
  song = minim.loadFile("data/sounds/shopSong.mp3");
  talk.setGain(100);
  song.setGain(-5);
  
  String[][] shopDialogue = {
  {"Introduction","Hi, my name is Torvald.","Nice to meet you!"},
  {"Beans vs Fruit","I have strong opinions on this subject.\nMaybe one day I'll tell you them."},
  {"Where are we?","We're in my shop of course!","Some smart-asses would say we live\nin a simulation.","Or a computer game.","What idiots!"},
  {"Favorite zodiac sign","For me, it's a big toss up between\nTaurus and Capricorn.","I give Taurus a slight edge though."}
  };
  
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
  shop.setDialogue(shopDialogue);
  shop.setBackgroundSong(song);
  
  hP = new Animation("hP", 8, .5);
  
  b = new Bubble(strs, displayCps, new PVector(100, -50), new PVector(200, 100), 2);
  b.getText().setSound(talk);
  b0 = new Bubble(strs, displayCps, new PVector(400, 250), new PVector(200, 100), 2);
  npc = new NPC(new PVector(100, 100), hPStill);
  npc0 = new NPC(new PVector(400, 400), hPStill);
  shop.getText().setSound(talk);
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
  npc0.setShopkeeper(true);
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
  o1 = new Object("Frog Peasant Sword", "Before sunrise, the Frog\nPeasants roam the grounds,\nslashing and stabbing at\nany unwelcome visitors.", 100);
  o2 = new Object("Frog Peasant Lederhosen", "Blocks or something idk", 80);
  o3 = new Object("Potion", "*gurgles*", 25);
  
  ArrayList<Object> inventory = new ArrayList<Object>();
  
  inventory.add(o1);
  inventory.add(o2);
  inventory.add(o3);
  
  shop.setInventory(inventory);
  p.getInventory().add(o1);
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
}

void loop(AudioPlayer a, int offset) {          //loops a sound effect as long as loop() is in a draw function
  a.play();
  if (a.position() >= a.length() - offset) {     //offset = number of miliseconds the soundbyte will cut off. used for soundbytes with extra silence after
    a.rewind();                                //rewinds the soundbyte
  }
}

/*
TODO:
Audioplayer - incorporate w/ shop and displayText
Give shop member functions to support artwork change
Limit player inventory space, same with shop
Make room spawnpoint useful
Figure out how to change rooms / cool transition effect (darkening)

~Battle mechanics
  -
  -
  -
~Inventory / weapons / armor actually affect battle
  -
  -
  -
*/

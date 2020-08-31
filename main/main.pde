import java.util.Stack;
import ddf.minim.*;

Minim minim;

AudioPlayer talk;
AudioPlayer song;

PFont font;
PFont font0;

Room friskRoom;

PImage friskRestLeft;
PImage friskRestRight;
PImage friskRestForward;

PImage shopBackground;

PImage hPStill;

PImage wall;

Animation friskWalkLeft;
Animation friskWalkRight;
Animation friskWalkForward;

Object o1;
Object o2;
Object o3;

Animation hP;

PImage friskRImg;

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
  
  wall = loadImage("data/images/wall.png");
  
  hPStill = loadImage("data/images/hP.png");
  friskRestLeft = loadImage("data/images/friskRestLeft.png");
  friskRestRight = loadImage("data/images/friskRestRight.png");
  friskRestForward = loadImage("data/images/friskRestForward.png");
  shopBackground = loadImage("data/images/shopBackground.png");
  
  friskWalkLeft = new Animation("friskWalkLeft", 2, 2);
  friskWalkRight = new Animation("friskWalkRight", 2, 2);
  friskWalkForward = new Animation("friskWalkForward", 4, 1);
  
  p = new Player(new PVector(-300, 400));
  
  p.getShop().setDialogue(shopDialogue);
  p.getShop().setBackgroundSong(song);
  p.getShop().getText().setSound(talk);
  
  hP = new Animation("hP", 8, .5);
  
  b = new Bubble(strs, displayCps, new PVector(100, -50), new PVector(200, 100), 2);
  
  String sw[] = {"This is a cool bed.\nMaybe I should sleep\non it.", "Sike"};
  Bubble bedB = new Bubble(sw, displayCps, new PVector(100, 50), new PVector(250, 100), 2);
  bedB.getText().setSound(talk);
  
  b.getText().setSound(talk);
  b0 = new Bubble(strs, displayCps, new PVector(400, 250), new PVector(200, 100), 2);
  npc = new NPC(hPStill, new PVector(100, 100), true);
  npc0 = new NPC(hPStill, new PVector(400, 400), true);
  
  npc.setEnemy(true);
  npc.setBubble(b);
  npc0.setBubble(b0);
  
  bl = new ButtonList(buttons, true, new PVector(0, 0), new PVector (0, 0), 3, 80, false);
  
  p.setImage(friskRestForward);
  //Big structs lag?
  Struct s = new Struct(wall, new PVector(0, 0), new PVector(200, 200), false, false);
  Struct s1 = new Struct(wall, new PVector(-600, 400), new PVector(100, 200), false, false);
  Struct s2 = new Struct(wall, new PVector(-100, 700), new PVector(200, 100), false, false);
  Struct s3 = new Struct(wall, new PVector(200, -300), new PVector(300, 100), false, false);
  Struct s4 = new Struct(wall, new PVector(100, -900), new PVector(100, 300), false, false);
  Struct s5 = new Struct(wall, new PVector(700, 200), new PVector(100, 100), false, false);
  Struct s6 = new Struct(wall, new PVector(-600, 1600), new PVector(100, 100), false, false);
  npc0.setShopkeeper(true);
  Room r = new Room(new PVector(0, 0), new PVector(2000, 2000));
  Room r0 = new Room(new PVector(-300, -250), new PVector(800, 700));
  
  Portal portal = new Portal(friskRestLeft, new PVector(-300, -400), new PVector(150, 150), r0);
  friskRImg = loadImage("data/images/friskRoom.png");
  friskRoom = new Room(new PVector(0, 0), new PVector(800, 650));
  Struct roomImg = new Struct(friskRImg, new PVector(0, 0), new PVector(800, 650), false, false);
  
  Struct desk = new Struct(null, new PVector(292 - width/2, 141 - height/2), new PVector(282, 220), true, true);
  Struct bed = new Struct(null, new PVector(819 - width/2, 383 - height/2), new PVector(270, 328), true, true);
  bed.setBubble(bedB);
  desk.setBubble(b);
  
  friskRoom.addGameObject(roomImg);
  friskRoom.addGameObject(desk);
  friskRoom.addGameObject(new Struct(null, new PVector(685 - width/2, 110 - height/2), new PVector(528, 174), false, true));
  
  
  friskRoom.addGameObject(bed);
  //Bedside Desk
  friskRoom.addGameObject(new Struct(null, new PVector(643 - width/2, 495 - height/2), new PVector(100, 100), false, true));
  friskRoom.addGameObject(new Struct(null, new PVector(624 - width/2, 619 - height/2), new PVector(644, 147), false, true));
  friskRoom.addGameObject(new Struct(null, new PVector(128 - width/2, 601 - height/2), new PVector(100, 121), false, true));
  friskRoom.addGameObject(new Portal(null, new PVector(240 - width/2, 723 - height/2), new PVector(126, 100), r));
  
  r.addGameObject(s);
  r.addGameObject(s1);
  r.addGameObject(s2);
  r.addGameObject(s3);
  r.addGameObject(s4);
  r.addGameObject(s5);
  r.addGameObject(s6);
  r.addGameObject(npc);
  r.addGameObject(npc0);
  r.addGameObject(portal);
  
  //Definitely need to be able to adjust text size!
  o1 = new Object("Frog Peasant Sword", "Before sunrise, the Frog\nPeasants roam the grounds,\nslashing and stabbing at\nany unwelcome visitors.", 100);
  o2 = new Object("Frog Peasant Lederhosen", "Blocks or something idk", 80);
  o3 = new Object("Potion", "*gurgles*", 25);
  
  ArrayList<Object> inventory = new ArrayList<Object>();
  
  inventory.add(o1);
  inventory.add(o2);
  inventory.add(o3);
  
  p.getShop().setInventory(inventory);
  p.setRoom(friskRoom);
  p.getOverview().getText().setSound(talk);
}

int w = 100;
int h = 100;

void draw()
{
  pushMatrix();
  
  translate(width/2, height/2);
  background(#CCCCCC);
  
  if (p.isInShop())
  {
    p.getShop().display();
  }
  else if (p.isInBattle())
  {
    p.getBattle().display();
  }
  else
  {
    p.implementArrowKeys();
    p.displayRoom();
    p.display();
    p.getCamera().display();
    
    fill(#FFFFFF);
    noStroke();
    rect(mouseX - width/2, mouseY - height/2, w, h);
    fill(#000000);
    text("x: " + (mouseX - width/2), mouseX - width/2, mouseY - height/2);
    text("y: " + (mouseY - height/2), mouseX - width/2, mouseY + 20 - height/2);
    text("w: " + w, mouseX - width/2, mouseY + 40 - height/2);
    text("h: " + h, mouseX - width/2, mouseY + 60 - height/2);
    
    if (mousePressed)
    {
      if (mouseButton == LEFT)
      {
        w++;
      }
      else 
      {
        h++;
      }
    }
  }
  
  popMatrix();
  
  if (p.getInteractor() == null)
  {
    text("null", mouseX, mouseY);
  }
  else 
  {
    text(p.getInteractor().toString(), mouseX, mouseY);
  }
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
  Portal can be an interactor too... find out how to work interactor into GameObject
*/

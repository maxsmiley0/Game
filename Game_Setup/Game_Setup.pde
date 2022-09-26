/*
TO DO:
//Change GameObject image to animation and refactor animation class
//Separate player from GameObject and make clearer global variable
//Bubble text should have an auto skip keyword

//Make concept of "state" - shop, transition, battle, walk, overview etc... make "Camera" responsible for that. Too little modularity...
//Take out fields from GameObject and push as much as possible into the derived classes

//Get rid of all notion of p.get... we need to decouple. Design game class to handle this
//De spaghettify Shop and key classes

//Maybe like a sound countroller too..? SoundSystem?

import java.util.Stack;
import ddf.minim.*;

Minim minim;

PImage friskRImg;
Room r;


int w = 100;
int h = 100;

AudioPlayer talk;
AudioPlayer song;

PFont font;
PFont font0;

Room friskRoom;
Room forestArea;

PImage friskRestLeft;
PImage friskRestRight;
PImage friskRestForward;
PImage battleBackground;
PImage shop;

PImage shopBackground;
PImage pillar;

PImage hPStill;

PImage wall;

Animation friskWalkLeft;
Animation friskWalkRight;
Animation friskWalkForward;

Object o1;
Object o2;
Object o3;

Animation hP;



Text text;
ButtonList bl;
NPC npc;
NPC npc0;

Bubble b;
Bubble b0;
String strs[] = {"ABCDEFGHIJKLMNOPQRSTUVWXYZ", "Nice to meet you!"};
int displayCps = 12;


Player p;
String buttons[] = {"One", "Two", "Three"};

void setup()
{
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  size(1100, 700);
  surface.setResizable(true);
  
  //SaveFile save = new SaveFile();
  //save.load();
  
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
  pillar = loadImage("data/images/pillar.png");
  battleBackground = loadImage("data/images/battleBackground.png");
  shop = loadImage("data/images/shop.png");
  
  hPStill = loadImage("data/images/hP.png");
  friskRestLeft = loadImage("data/images/friskRestLeft.png");
  friskRestRight = loadImage("data/images/friskRestRight.png");
  friskRestForward = loadImage("data/images/friskRestForward.png");
  shopBackground = loadImage("data/images/shopBackground.png");
  
  friskWalkLeft = new Animation("friskWalkLeft", 2, 2);
  friskWalkRight = new Animation("friskWalkRight", 2, 2);
  friskWalkForward = new Animation("friskWalkForward", 4, 1);
  
  hP = new Animation("hP", 8, .5);
  
  p = new Player(new PVector(-300, 400));
  
  friskRoom = new Room(new PVector(0, 0), new PVector(800, 650));
  
  //Forest Area right outside of Frisk's Room
  
  PImage grassTile = loadImage("data/images/grass_tile.png");
  PImage walkway = loadImage("data/images/walkway.png");
  PImage friskHouse = loadImage("data/images/friskHouse.png");
  
  AudioPlayer forestSound = minim.loadFile("data/sounds/birds.mp3");
  AudioPlayer homeSound = minim.loadFile("data/sounds/home.mp3");
  
  forestArea = new Room(new PVector(-180, -1090), new PVector(900, 3000));  //Defining spawnpoint and dimensions
  
  forestArea.setSound(forestSound);
  friskRoom.setSound(homeSound);
  
  forestArea.addGameObject(new Struct(grassTile, new PVector(225, -1250), new PVector(450, 500), false));
  forestArea.addGameObject(new Struct(grassTile, new PVector(-225, -1250), new PVector(450, 500), false));
  forestArea.addGameObject(new Struct(grassTile, new PVector(225, -750), new PVector(450, 500), false));
  forestArea.addGameObject(new Struct(grassTile, new PVector(-225, -750), new PVector(450, 500), false));
  forestArea.addGameObject(new Struct(grassTile, new PVector(225, -250), new PVector(450, 500), false));
  forestArea.addGameObject(new Struct(grassTile, new PVector(-225, -250), new PVector(450, 500), false));
  forestArea.addGameObject(new Struct(grassTile, new PVector(225, 250), new PVector(450, 500), false));
  forestArea.addGameObject(new Struct(grassTile, new PVector(-225, 250), new PVector(450, 500), false));
  forestArea.addGameObject(new Struct(grassTile, new PVector(225, 750), new PVector(450, 500), false));
  forestArea.addGameObject(new Struct(grassTile, new PVector(-225, 750), new PVector(450, 500), false));
  forestArea.addGameObject(new Struct(grassTile, new PVector(225, 1250), new PVector(450, 500), false));
  forestArea.addGameObject(new Struct(grassTile, new PVector(-225, 1250), new PVector(450, 500), false));
  
  Bubble houseBubble = new Bubble(new String[]{"This is the house I've grown up in over the years","Good 'ol Relief Inn!"}, displayCps);
  houseBubble.getText().setSound(talk);
  Struct friskHouseStruct = new Struct(friskHouse, new PVector(-252, -1350), new PVector(400, 400), true);
  friskHouseStruct.setBubble(houseBubble);
  forestArea.addGameObject(friskHouseStruct);
  
  
  
  forestArea.addGameObject(new Struct(walkway, new PVector(-180, -1090), new PVector(100, 100), false));
  forestArea.addGameObject(new Struct(walkway, new PVector(-180, -990), new PVector(100, 100), false));
  forestArea.addGameObject(new Struct(walkway, new PVector(-180, -890), new PVector(100, 100), false));
  forestArea.addGameObject(new Struct(walkway, new PVector(-180, -790), new PVector(100, 100), false));
  forestArea.addGameObject(new Struct(walkway, new PVector(-180, -690), new PVector(100, 100), false));
  forestArea.addGameObject(new Struct(walkway, new PVector(-180, -590), new PVector(100, 100), false));
  forestArea.addGameObject(new Struct(walkway, new PVector(-180, -490), new PVector(100, 100), false));
  forestArea.addGameObject(new Struct(walkway, new PVector(-80, -590), new PVector(100, 100), false));
  
  PImage frogPic = loadImage("data/images/frog.png");
  NPC frog = new NPC(frogPic, new PVector(150, -800));
  Bubble frogBubble = new Bubble(new String[]{"Hi! I am just a frog.","I am thrilled to meet you :)"}, displayCps);
  frogBubble.getText().setSound(talk);
  frog.setBubble(frogBubble);
  
  forestArea.addGameObject(frog);
  
  
  p.getShop().setDialogue(shopDialogue);
  p.getShop().setBackgroundSong(song);
  p.getShop().getText().setSound(talk);
  
  Room r1 = new Room(new PVector(0, 0), new PVector(200, 100));
  r1.addGameObject(new Struct(battleBackground, new PVector(0, 0), new PVector(1100, 700), false));
  r1.addGameObject(new Struct(pillar, new PVector(300, 150), new PVector(210, 500), false));
  r1.addGameObject(new Struct(pillar, new PVector(-300, 400), new PVector(210, 500), false));
    
  Fighter enemy = new Fighter(hP);
  p.setBattle(new Battle(r1, enemy));
  
  b = new Bubble(strs, displayCps);
  //new PVector(100, -50)
  
  String sw[] = {"My name is Max Smiley and my amazing gf is Isabella Edrada :)", "it's true"};
  Bubble bedB = new Bubble(sw, displayCps);
  bedB.getText().setSound(talk);
  
  b.getText().setSound(talk);
  b0 = new Bubble(strs, displayCps);
  npc = new NPC(hPStill, new PVector(100, 100));
  npc0 = new NPC(shop, new PVector(400, 400));
  
  npc.setEnemy(true);
  npc.setBubble(b);
  npc0.setBubble(b0);
  
  bl = new ButtonList(buttons, true, new PVector(0, 0), new PVector (0, 0), 80, false);
  
  p.setImage(friskRestForward);
  //Big structs lag?
  Struct s = new Struct(wall, new PVector(0, 0), new PVector(200, 200), false);
  Struct s1 = new Struct(wall, new PVector(-600, 400), new PVector(100, 200), false);
  Struct s2 = new Struct(wall, new PVector(-100, 700), new PVector(200, 100), false);
  Struct s3 = new Struct(wall, new PVector(200, -300), new PVector(300, 100), false);
  Struct s4 = new Struct(wall, new PVector(100, -900), new PVector(100, 300), false);
  Struct s5 = new Struct(wall, new PVector(700, 200), new PVector(100, 100), false);
  Struct s6 = new Struct(wall, new PVector(-600, 1600), new PVector(100, 100), false);
  npc0.setShopkeeper(true);
  r = new Room(new PVector(0, 0), new PVector(2000, 2000));
  //Room r0 = new Room(new PVector(-300, -250), new PVector(800, 700));
  
  //Portal portal = new Portal(friskRestLeft, new PVector(-300, -400), new PVector(150, 150), r0);
  friskRImg = loadImage("data/images/friskRoom.png");
  Struct roomImg = new Struct(friskRImg, new PVector(0, 0), new PVector(800, 650), false);
  
  Struct desk = new Struct(null, new PVector(292 - width/2, 141 - height/2), new PVector(282, 220), true);
  Struct bed = new Struct(null, new PVector(819 - width/2, 383 - height/2), new PVector(270, 328), true);
  bed.setBubble(bedB);
  desk.setBubble(b);
  
  friskRoom.addGameObject(roomImg);
  friskRoom.addGameObject(desk);
  friskRoom.addGameObject(new Struct(null, new PVector(685 - width/2, 110 - height/2), new PVector(528, 174), true));
  
  
  friskRoom.addGameObject(bed);
  //Bedside Desk
  friskRoom.addGameObject(new Struct(null, new PVector(643 - width/2, 495 - height/2), new PVector(100, 100), true));
  friskRoom.addGameObject(new Struct(null, new PVector(624 - width/2, 619 - height/2), new PVector(644, 147), true));
  friskRoom.addGameObject(new Struct(null, new PVector(128 - width/2, 601 - height/2), new PVector(100, 121), true));
  friskRoom.addGameObject(new Portal(null, new PVector(240 - width/2, 723 - height/2), new PVector(126, 100), forestArea, 'u'));
  
  r.addGameObject(s);
  r.addGameObject(s1);
  r.addGameObject(s2);
  r.addGameObject(s3);
  r.addGameObject(s4);
  r.addGameObject(s5);
  r.addGameObject(s6);
  r.addGameObject(npc);
  r.addGameObject(npc0);
  r.addGameObject(new Portal(null, new PVector(-100, -100), new PVector(0, 0), friskRoom, 'd'));
  //r.addGameObject(portal);
  
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
  
  forestArea.addGameObject(new Portal(null, new PVector(-180, -1190), new PVector(100, 100), r, 'd'));
  /*
  HashMap<String, Room> mm = new HashMap<String, Room>();
  mm.put("forestArea", forestArea);
  mm.get("forestArea");
  */
}

//player could actually be displayed before npcs?

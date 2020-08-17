PFont font;

PImage friskRestLeft;
PImage friskRestRight;
PImage friskRestForward;

Animation friskWalkLeft;
Animation friskWalkRight;
Animation friskWalkForward;

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
  
  p = new Player(new PVector(-300, 400));
  p.setStill(friskRestForward);
  
  Struct s = new Struct("data/images/wall.png", new PVector(0, 0), new PVector(200, 200), false);
  Struct s1 = new Struct("data/images/wall.png", new PVector(200, 300), new PVector(100, 100), false);
  
  Room r = new Room(new PVector(0, 0), new PVector(2000, 2000));
  r.addStruct(s);
  r.addStruct(s1);
  
  p.setRoom(r);
}


void draw()
{
  translate(width/2, height/2);
  
  background(#FFFFFF);
  
  p.displayRoom();

  if (keyPressed)
  {
    p.isMoving = true;
    if (keyCode == LEFT)
    {
      p.setAnimation(friskWalkLeft);
      p.move(new PVector(-8, 0));
    }
    else if (keyCode == RIGHT)
    {
      p.setAnimation(friskWalkRight);
      p.move(new PVector(8, 0));
    }
    else if (keyCode == UP)
    {
      p.setAnimation(friskWalkForward);
      p.move(new PVector(0, -8));
    }
    else if (keyCode == DOWN)
    {
      p.setAnimation(friskWalkForward);
      p.move(new PVector(0, 8));
    }
  }
}

void keyReleased()
{
  p.isMoving = false;
  if (keyCode == LEFT)
    {
      p.setStill(friskRestLeft);
      p.move(new PVector(-8, 0));
    }
    else if (keyCode == RIGHT)
    {
      p.setStill(friskRestRight);
      p.move(new PVector(8, 0));
    }
    else if (keyCode == UP)
    {
      p.move(new PVector(0, -8));
    }
    else if (keyCode == DOWN)
    {
      p.setStill(friskRestForward);
      p.move(new PVector(0, 8));
    }
}

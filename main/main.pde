PFont font;
Player p;

void setup()
{
  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);
  size(800, 600);
  
  font = createFont("data/fonts/pusab.ttf", 30);
  textFont(font);
  
  p = new Player(new PVector(0, 0));
  
  Struct s = new Struct("data/images/wall.png", new PVector(0, 0), new PVector(200, 200), false);
  Struct s1 = new Struct("data/images/wall.png", new PVector(200, 300), new PVector(100, 100), false);
  
  Room r = new Room(new PVector(0, 0), new PVector(1000, 900));
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
    if (keyCode == LEFT)
    {
      p.move(new PVector(-8, 0));
    }
    else if (keyCode == RIGHT)
    {
      p.move(new PVector(8, 0));
    }
    else if (keyCode == UP)
    {
      p.move(new PVector(0, -8));
    }
    else if (keyCode == DOWN)
    {
      p.move(new PVector(0, 8));
    }
  }
}

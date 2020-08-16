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
  
  Room r = new Room(new PVector(0, 0), new PVector(1500, 500));
  r.addStruct(s);
  
  p.setRoom(r);
}


void draw()
{
  translate(width/2, height/2);
  
  background(#FFFFFF);
  
  p.displayRoom();
  if (mousePressed)
  {
    if (mouseButton == LEFT)
    {
      p.move(new PVector(8, 0));
    }
    else 
    {
      p.move(new PVector(-8, 0));
    }
  }
}

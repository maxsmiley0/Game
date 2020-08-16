PFont font;

void setup()
{
  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);
  size(800, 600);
  
  font = createFont("data/fonts/pusab.ttf", 30);
  textFont(font);
}

String[] names = {"One", "Two", "Tree", "Four", "Five"};
ButtonList bl = new ButtonList(names, true, new PVector(100, 100), new PVector(120, 80), 5, 200, true);
Entity e = new Player(new PVector(100, 100));

void draw()
{
  background(#FFFFFF);
  
  if (mousePressed)
  {
    bl.changeButton(true);
    e.move(new PVector(1, 1));
  }
  
  bl.display();
  e.display();
  
  Struct s = new Struct("data/images/wall.png", new PVector(300, 300), new PVector(100, 200), false);
  s.display();
  /*
  //pushMatrix();
  translate(100, 0);
  //popMatrix();
  rect(100, 100, 100, 100);
  */                      
}

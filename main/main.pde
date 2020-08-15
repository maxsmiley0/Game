PFont font;

void setup()
{
  rectMode(CENTER);
  textAlign(CENTER);
  size(800, 600);
  
  font = createFont("data/pusab.ttf", 30);
  textFont(font);
}

String[] names = {"One", "Two", "Tree", "Four", "Five"};
ButtonList bl = new ButtonList(names, true, new PVector(100, 100), new PVector(120, 80), 5, 200, true);

void draw()
{
  background(#FFFFFF);
  
  if (mousePressed)
  {
    bl.changeButton(true);
  }
  
  bl.display();
}

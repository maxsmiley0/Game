public abstract class GameObject
{
  private PImage img;        //Image, to be displayed in DerivedClass::display(). A null img means nothing will be displayed
  
  private PVector position;  //Position of GameObject (x-pos, y-pos)
  private PVector dimensions;//Dimensions of GameObject (width, height)
  
  public GameObject(PImage img, PVector position, PVector dimensions)
  {
    this.img = img;
    
    this.position = position;
    this.dimensions = dimensions;
  }
  
  //Accessors
  
  public PImage getImage()
  {
    return img;
  }
  
  public PVector getPosition()
  {
   return position; 
  }
  
  public PVector getDimensions()
  {
    return dimensions;
  }
  
  //Mutators
  
  public void setPosition(PVector position)
  {
    this.position = position;
  }
  
  public void setImage(PImage img)
  {
    this.img = img;
  }
  
  public void move(PVector p)
  {
    position.add(p);
  }
  
  //Abstract functions
  public abstract void display();
}

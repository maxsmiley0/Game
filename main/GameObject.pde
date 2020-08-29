public abstract class GameObject
{
  private PImage img;        //Image, to be displayed in DerivedClass::display(). A null img means nothing will be displayed
  
  private PVector position;  //Position of GameObject (x-pos, y-pos)
  private PVector dimensions;//Dimensions of GameObject (width, height)
  
  private boolean isInteractor;        //True if Player can interact with it
  
  private boolean inInteractionRange;  //True if Player is sufficiently close
  private boolean isInteracting;       //True if Player interacts with NPC
  
  private Bubble bubble;
  
  public GameObject(PImage img, PVector position, PVector dimensions, boolean isInteractor)
  {
    this.img = img;
    
    this.position = position;
    this.dimensions = dimensions;
    this.isInteractor = isInteractor;
    
    inInteractionRange = false;
    isInteracting = false;
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
  
  public boolean getInteract()
  {
    return isInteracting;
  }
  
  public boolean inInteractionRange()
  {
    return inInteractionRange;
  }
  
  public boolean isInteractor()
  {
    return isInteractor;
  }
  
  public Bubble getBubble()
  {
    return bubble;
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
  
  public void setInteract(boolean b)
  {
   isInteracting = b;
  }
  
  public void setInteractionRange(boolean b)
  {
    inInteractionRange = b;
  }
  
  public void setBubble(Bubble bubble)
  {
    if (isInteractor)
    {
      this.bubble = bubble;
    }
    else 
    {
      println("Attempting to give a non-interactor " + toString() + " a bubble in GameObject.pde");
      exit();
    }
  }
  
  //Abstract functions
  public abstract void display();
}

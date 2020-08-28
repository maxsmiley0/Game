public class NPC extends GameObject
{
  private Bubble bubble;               //Speech bubble
  
  private boolean inInteractionRange;  //True if Player is sufficiently close
  private boolean isInteracting;       //True if Player interacts with NPC
  private boolean isShopkeeper;        //True if interacting will result in the shop interface, rather than a bubble
  
  public NPC(PImage currentStill, PVector position)
  {
    super(currentStill, position, new PVector(currentStill.width, currentStill.height));
    
    inInteractionRange = false;
    isInteracting = false;
    isShopkeeper = false;
  }
  
  //Accessors
  
  public Bubble getBubble()
  {
    return bubble;
  }
  
  public boolean getInteract()
  {
    return isInteracting;
  }
  
  public boolean isShopkeeper()
  {
    return isShopkeeper;
  }
  
  //Mutators
  
  public void setBubble(Bubble bubble)
  {
    this.bubble = bubble;
  }
  
  public void setShopkeeper(boolean b)
  {
    isShopkeeper = b;
  }

  public void setInteract(boolean b)
  {
    isInteracting = b;
  }
    
  //Implementing abstract function
  
  public void display()
  {
    image(getImage(), getPosition().x, getPosition().y);  //All NPCs must have an image, so null checking is unneccessary
    
    //Automatic rigidBody applied to NPCs
    int leftBorder = (int)(getPosition().x - (getDimensions().x/2) - (p.getDimensions().x / 2));
    int rightBorder = (int)(getPosition().x + (getDimensions().x/2) + (p.getDimensions().x / 2));
    int topBorder = (int)(getPosition().y - (getDimensions().y/2) - (p.getDimensions().y/2));
    int bottomBorder = (int)(getPosition().y + (getDimensions().y/2) + (p.getDimensions().y/2));
    /*
    This parameter defines how thick the rigid border will be. Note that it must have a nontrivial length, as if 
    it is slower than the player's speed, since this program runs frame by frame, the player will pass through the rigid
    portion and the computer won't apply a normal force
    */
    int offset = 10;     //Player's speed is tentatively 6, so 10 is okay
      
    //Applying an fixed impulse
    if (p.getPosition().x > leftBorder && p.getPosition().x < leftBorder + offset && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)
    {
      p.move(new PVector(-6, 0));
      inInteractionRange = true;
    }
    if (p.getPosition().x > rightBorder - offset && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)    
    {
      p.move(new PVector(6, 0));
      inInteractionRange = true;
    }
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < topBorder + offset)
    {
      p.move(new PVector(0, -6));
      inInteractionRange = true;
    }
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > bottomBorder - offset && p.getPosition().y < bottomBorder)
    {
      p.move(new PVector(0, 6));
      inInteractionRange = true;
    }
    
    if (p.getPosition().x < leftBorder - offset || p.getPosition().x > rightBorder + offset || p.getPosition().y < topBorder - offset || p.getPosition().y > bottomBorder + offset)
    {
      inInteractionRange = false;
    }
    //Temporary box so we know player is by NPC
    if (inInteractionRange)
    {
      rect(p.getPosition().x, p.getPosition().y, 55, 126);
      //Setting Player's interactor to this object
      p.setInteractor(this);
    }
    else
    {
      if (p.getInteractor() == this)
      {
        //The reason we don't always want to setInteractor to null if not in range is because it could be in range of other NPCs
        p.setInteractor(null);
      }
    }
  
    if (isInteracting)   //Player is interacting with the NPC
    {
      if (isShopkeeper)  //If shopkeeper, enter shop
      {
        p.enterShop();
      }
      else               //Else enter dialogue
      {
        bubble.display();
        if (p.getBlStack().empty())
        {
          p.getBlStack().add(bubble.getBl());
          p.stopMoving();
        }
      }
    }
  }
}

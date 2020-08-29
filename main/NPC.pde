public class NPC extends GameObject
{
  private boolean isShopkeeper;        //True if interacting will result in the shop interface, rather than a bubble
  
  public NPC(PImage currentStill, PVector position, boolean isInteractor)
  {
    super(currentStill, position, new PVector(currentStill.width, currentStill.height), isInteractor);
    
    isShopkeeper = false;
  }
  
  public boolean isShopkeeper()        //Accessor
  {
    return isShopkeeper;
  }
  
  public void setShopkeeper(boolean b) //Mutator
  {
    isShopkeeper = b;
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
      if (isInteractor())
      {
        setInteractionRange(true);
      }
    }
    if (p.getPosition().x > rightBorder - offset && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)    
    {
      p.move(new PVector(6, 0));
      if (isInteractor())
      {
        setInteractionRange(true);
      }
    }
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < topBorder + offset)
    {
      p.move(new PVector(0, -6));
      if (isInteractor())
      {
        setInteractionRange(true);
      }
    }
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > bottomBorder - offset && p.getPosition().y < bottomBorder)
    {
      p.move(new PVector(0, 6));
      if (isInteractor())
      {
        setInteractionRange(true);
      }
    }
    
    //Case if the NPC is an interactor
    if (isInteractor())
    {
      //If Player is out of NPC interaction range, set "in interaction range" to false
      if (p.getPosition().x < leftBorder - offset || p.getPosition().x > rightBorder + offset || p.getPosition().y < topBorder - offset || p.getPosition().y > bottomBorder + offset)
      {
        setInteractionRange(false);
      }
      //If in interaction range, set interactor to this
      if (inInteractionRange())
      {
        p.setInteractor(this);
      }
      else
      {
        //The reason we don't always want to setInteractor to null if not in range is because it could be in range of other NPCs
        if (p.getInteractor() == this)
        {
          p.setInteractor(null);
        }
      }  
      //Player is interacting with the NPC (and ostensibley in range)
      if (getInteract())   
      {
        if (isShopkeeper)  //If shopkeeper, enter shop
        {
          p.enterShop();
        }
        else               //Else enter dialogue
        {
          getBubble().display();
          if (p.getBlStack().empty())
          {
            p.getBlStack().add(getBubble().getBl());
            p.stopMoving();
          }
        }
      }
    }
  }
}

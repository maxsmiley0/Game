public class Struct extends GameObject            //Structure: To be implemented inside of Rooms
{
  private boolean rigidBody;   //If true, then entities collide with it
  
  public Struct(PImage img, PVector position, PVector dimensions, boolean isInteractor, boolean rigidBody)
  {
    super(img, position, dimensions, isInteractor);
    
    this.rigidBody = rigidBody;
  }
  
  //Note: rigidBody boundries will be enforced with display
  public void display()
  {
    //Displays the image associated with the structure
    if (getImage() != null)
    {
      image(getImage(), getPosition().x, getPosition().y, getDimensions().x, getDimensions().y);
    }
    
    /*
    Defining the borders of the rigidBody, with an extra term in relation to the player's dimensions
    This is so a player won't be stopped right at the border of the structure, i.e. half of the player's
    sprite won't be inside the rigidBody
    */
    
    int leftBorder = (int)(getPosition().x - (getDimensions().x/2) - (p.getDimensions().x / 2));
    int rightBorder = (int)(getPosition().x + (getDimensions().x/2) + (p.getDimensions().x / 2));
    int topBorder = (int)(getPosition().y - (getDimensions().y/2) - (p.getDimensions().y/2));
    int bottomBorder = (int)(getPosition().y + (getDimensions().y/2) + (p.getDimensions().y/2));
    
    int offset = 10;     //Player's speed is tentatively 6, so 10 is okay
    
    if (p.getPosition().x > leftBorder && p.getPosition().x < leftBorder + offset && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)
    {
      if (rigidBody)
      {
        p.move(new PVector(-6, 0));  //Applying an fixed impulse
      }
      if (isInteractor())
      {
        setInteractionRange(true);
      }
    }
    
    if (p.getPosition().x > rightBorder - offset && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)
    {
      if (rigidBody)
      {
        p.move(new PVector(6, 0));  //Applying an fixed impulse
      }
      if (isInteractor())
      {
        setInteractionRange(true);
      }
    }
    
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < topBorder + offset)
    {
      if (rigidBody)
      {
        p.move(new PVector(0, -6));
      }
      if (isInteractor())
      {
        setInteractionRange(true);
      }
    }
    
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > bottomBorder - offset && p.getPosition().y < bottomBorder)
    {
      if (rigidBody)
      {
        p.move(new PVector(0, 6));
      }
      if (isInteractor())
      {
        setInteractionRange(true);
      }
    }
    
    if (isInteractor())
    {
      if (p.getPosition().x < leftBorder - offset || p.getPosition().x > rightBorder + offset || p.getPosition().y < topBorder - offset || p.getPosition().y > bottomBorder + offset)
      {  
        setInteractionRange(false);
      }
    
      if (inInteractionRange())
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
  
      if (getInteract())   //Player is interacting with the NPC
      {
        getBubble().setPosition(new PVector(p.getPosition().x, p.getPosition().y - getBubble().getDimensions().y/2 - p.getDimensions().y/2));
        getBubble().display();
        if (p.getBlStack().empty())
        {
          p.getBlStack().add(getBubble().getBl());
          p.stopMoving();
        }
      }
    }
  }
    
  //Simple accessor
  public boolean isRigidBody()
  {
    return rigidBody;
  }
}

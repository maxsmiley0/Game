public class NPC extends GameObject
{
  private boolean isShopkeeper;        //True if interacting will result in the shop interface, rather than a bubble
  private boolean isEnemy;             //True if interacting will result in the battle interface, rather than a bubble
  
  public NPC(PImage currentStill, PVector position, boolean isInteractor)
  {
    super(currentStill, position, new PVector(currentStill.width, currentStill.height), isInteractor);
    
    isShopkeeper = false;
    isEnemy = false;
  }
  
  public boolean isShopkeeper()        //Accessor
  {
    return isShopkeeper;
  }
  
  public boolean isEnemy()
  {
    return isEnemy;
  }
  
  public void setShopkeeper(boolean b) //Mutator
  {
    isShopkeeper = b;
  }
  
  public void setEnemy(boolean b)  
  {
    isEnemy = b;
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
    }
    if (p.getPosition().x > rightBorder - offset && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)    
    {
      p.move(new PVector(6, 0));
    }
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < topBorder + offset)
    {
      p.move(new PVector(0, -6));
    }
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > bottomBorder - offset && p.getPosition().y < bottomBorder)
    {
      p.move(new PVector(0, 6));
    }
    
    if (displayNPCs)
    {
      stroke(0);
      strokeWeight(5);
      noFill();
      rect(getPosition().x, getPosition().y, getDimensions().x, getDimensions().y);
      fill(#ffffff);
      text("NPC", getPosition().x, getPosition().y - 30);
      text("Shopkeeper: " + isShopkeeper, getPosition().x, getPosition().y - 10);
      text("Enemy: " + isEnemy, getPosition().x, getPosition().y + 10);
    }
  }
}

public class NPC extends GameObject
{
  private boolean isShopkeeper;        //True if interacting will result in the shop interface, rather than a bubble
  private boolean isEnemy;             //True if interacting will result in the battle interface, rather than a bubble
  
  public NPC(PImage currentStill, PVector position)
  {
    super(currentStill, position, new PVector(currentStill.width, currentStill.height));
    
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

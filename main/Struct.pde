public class Struct extends GameObject            //Structure: To be implemented inside of Rooms
{
  private boolean rigidBody;   //If true, then entities collide with it
  
  public Struct(PImage img, PVector position, PVector dimensions, boolean rigidBody)
  {
    super(img, position, dimensions);
    
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
    
    if (rigidBody)
    {
      /*
      Defining the borders of the rigidBody, with an extra term in relation to the player's dimensions
      This is so a player won't be stopped right at the border of the structure, i.e. half of the player's
      sprite won't be inside the rigidBody
      */
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
    }
  }
  
  //Simple accessor
  public boolean isRigidBody()
  {
    return rigidBody;
  }
}

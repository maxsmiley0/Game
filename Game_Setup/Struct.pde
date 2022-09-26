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
    
    if (displayStructs)
    {
      stroke(0);
      strokeWeight(5);
      noFill();
      rect(getPosition().x, getPosition().y, getDimensions().x, getDimensions().y);
      fill(#ffffff);
      text("Struct", getPosition().x, getPosition().y - 15);
      text("Rigidbody: " + rigidBody, getPosition().x, getPosition().y);
    }
  }
    
  //Simple accessor
  public boolean hasRigidBody()
  {
    return rigidBody;
  }
}

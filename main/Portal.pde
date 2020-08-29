public class Portal extends GameObject
{
  private Room room;   //this stores which room the portal will take the player to
  
  public Portal (PImage img, PVector position, PVector dimensions, Room room)
  {
    super(img, position, dimensions, false);
    this.room = room;
  }
  
  public void display()
  {
    //Displays the image associated with the portal, if it exists
    if (getImage() != null)
    {
      image(getImage(), getPosition().x, getPosition().y, getDimensions().x, getDimensions().y);
    }
    
    //Same code as rigidbody, detects when Player enters portal
    int leftBorder = (int)(getPosition().x - (getDimensions().x/2) - (p.getDimensions().x / 2));
    int rightBorder = (int)(getPosition().x + (getDimensions().x/2) + (p.getDimensions().x / 2));
    int topBorder = (int)(getPosition().y - (getDimensions().y/2) - (p.getDimensions().y/2));
    int bottomBorder = (int)(getPosition().y + (getDimensions().y/2) + (p.getDimensions().y/2));
    
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)
    {
      p.getCamera().panTo(room);  //fades out, switches rooms to room spawnpoint, fades in
    }
  }
}

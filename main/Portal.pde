public class Portal
{
  private PImage img;  //stores what the portal will look like, null means no image
  
  private PVector position;    //position and dimensions
  private PVector dimensions;
  
  private Room room;   //this stores which room the portal will take the player to
  
  public Portal (PImage img, PVector position, PVector dimensions, Room room)
  {
    this.img = img;
    this.position = position;
    this.dimensions = dimensions;
    this.room = room;
  }
  
  public void display()
  {
    //Displays the image associated with the portal, if it exists
    if (img != null)
    {
      image(img, position.x, position.y, dimensions.x, dimensions.y);
    }
    
    //Same code as rigidbody, detects when Player enters portal
    int leftBorder = (int)(position.x - (dimensions.x/2) - (p.getDimensions().x / 2));
    int rightBorder = (int)(position.x + (dimensions.x/2) + (p.getDimensions().x / 2));
    int topBorder = (int)(position.y - (dimensions.y/2) - (p.getDimensions().y/2));
    int bottomBorder = (int)(position.y + (dimensions.y/2) + (p.getDimensions().y/2));
    
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)
    {
      p.getCamera().panTo(room);  //fades out, switches rooms to room spawnpoint, fades in
    }
  }
}

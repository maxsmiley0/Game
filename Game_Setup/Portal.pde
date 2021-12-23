public class Portal extends GameObject
{
  private Room room;   //this stores which room the portal will take the player to
  private char spawn;  //u, l, d, or r. E.g.: if the char is 'u', the player will spawn just above this portal when they re-enter the room
  
  public Portal (PImage img, PVector position, PVector dimensions, Room room, char spawn)
  {
    super(img, position, dimensions, false);
    
    if (spawn != 'u' && spawn != 'd' && spawn != 'l' && spawn != 'r')
    {
      println("Setting spawn char to an invalid expression in Portal constructor");
      exit();
    }
    
    this.room = room;
    this.spawn = spawn;
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
      switch (spawn)
      {
        case 'u':
          p.getRoom().setSpawnpoint(new PVector(getPosition().x, getPosition().y - getDimensions().y / 2 - p.getImage().height / 2 - 10));
          break;
        case 'd':
          p.getRoom().setSpawnpoint(new PVector(getPosition().x, getPosition().y + getDimensions().y / 2 + p.getImage().height / 2 + 10));
          break;
        case 'l':
          p.getRoom().setSpawnpoint(new PVector(getPosition().x - getDimensions().x / 2 - p.getImage().width / 2 - 10, getPosition().y));
          break;
        case 'r':
          p.getRoom().setSpawnpoint(new PVector(getPosition().x + getDimensions().x / 2 + p.getImage().width / 2 + 10, getPosition().y));
          break;
      }
      
      p.getCamera().panTo(room);  //fades out, switches rooms to room spawnpoint, fades in
      if (displayPortals)
      {
        stroke(0);
        strokeWeight(5);
        noFill();
        rect(getPosition().x, getPosition().y, getDimensions().x, getDimensions().y);
        fill(#ffffff);
        text("Portal", getPosition().x, getPosition().y);
      }
    }
  }
}
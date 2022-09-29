public class Portal extends GameObject
{
  private Room room;   //this stores which room the portal will take the player to
  private char spawn;  //u, l, d, or r. E.g.: if the char is 'u', the player will spawn just above this portal when they re-enter the room
  
  public Portal (PImage img, PVector position, PVector dimensions, Room room, char spawn)
  {
    super(img, position, dimensions);
    
    if (spawn != 'u' && spawn != 'd' && spawn != 'l' && spawn != 'r')
    {
      println("Setting spawn char to an invalid expression in Portal constructor");
      exit();
    }
    
    this.room = room;
    this.spawn = spawn;
  }
  
  public char getSpawn() {
    return spawn; 
  }
  
  public Room getRoom() {
    return room;
  }
  
  public void display()
  {
    //Displays the image associated with the portal, if it exists
    if (getImage() != null)
    {
      image(getImage(), getPosition().x, getPosition().y, getDimensions().x, getDimensions().y);
    }
    
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

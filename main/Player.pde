public class Player extends Entity
{
  private Room currentRoom;      //The room the player is currently in
  private Camera camera;         //Camera to keep display and center the player and room
  
  public Player(PVector position)
  {
    super(position);             //Passing position vector to Entity superclass
    camera = new Camera();       //Instantiating a new camera
  }
  
  public void display()          //Placeholder sprite
  {
    fill(0, 0, 0);
    rect(getPosition().x, getPosition().y, 10, 10);
  }
  
  public void setRoom(Room room)
  {
    currentRoom = room;
  }
  
  public Room getRoom()
  {
    return currentRoom;
  }
  
  public void displayRoom()
  { 
    pushMatrix();
    
    camera.center(getPosition(), currentRoom);
    fill(#000000);
    
    rectMode(CORNER);
    rect(currentRoom.getDimensions().x / 2, -currentRoom.getDimensions().y, currentRoom.getDimensions().x, 2*currentRoom.getDimensions().y);
    rect(-currentRoom.getDimensions().x / 2, -currentRoom.getDimensions().y, -currentRoom.getDimensions().x, 2*currentRoom.getDimensions().y);
    rect(-currentRoom.getDimensions().x, currentRoom.getDimensions().y / 2, 2*currentRoom.getDimensions().x, currentRoom.getDimensions().y);
    rect(-currentRoom.getDimensions().x, -currentRoom.getDimensions().y / 2, 2*currentRoom.getDimensions().x, -currentRoom.getDimensions().y);
    rectMode(CENTER);
    
    currentRoom.display();
    display();
    popMatrix();
  }
}

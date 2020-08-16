public class Player extends Entity
{
  private Room currentRoom;
  private Camera camera;
  
  public Player(PVector position)
  {
    super(position);
    camera = new Camera();
  }
  
  public void display()
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
    camera.refresh(getPosition(), currentRoom);
    camera.printInfo();
    
    pushMatrix();
    fill(#000000);
    
    //maybe combine refresh and center for camera?
    
    camera.center(getPosition(), currentRoom);
    display();
    rectMode(CORNER);
    rect(currentRoom.getDimensions().x / 2, -currentRoom.getDimensions().y, currentRoom.getDimensions().x, 2*currentRoom.getDimensions().y);
    rect(-currentRoom.getDimensions().x / 2, -currentRoom.getDimensions().y, -currentRoom.getDimensions().x, 2*currentRoom.getDimensions().y);
    rect(-currentRoom.getDimensions().x, currentRoom.getDimensions().y / 2, 2*currentRoom.getDimensions().x, currentRoom.getDimensions().y);
    rect(-currentRoom.getDimensions().x, -currentRoom.getDimensions().y / 2, 2*currentRoom.getDimensions().x, -currentRoom.getDimensions().y);
    rectMode(CENTER);
    
    currentRoom.display();
    popMatrix();
    
    
  }
}

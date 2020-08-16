public class Player extends Entity
{
  private Room currentRoom;
  
  public Player(PVector position)
  {
    super(position);
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
}

public class Player extends Entity
{
  private Room currentRoom;      //The room the player is currently in
  private Camera camera;         //Camera to keep display and center the player and room
  private Animation currentAnimation;   //Animation to be displayed when moving
  private PImage currentStill;          //Image to be displayed when still
  public boolean isMoving;
  
  public Player(PVector position)
  {
    super(position);             //Passing position vector to Entity superclass
    camera = new Camera();       //Instantiating a new camera
    isMoving = false;
  }
  
  public void display()          //Placeholder sprite
  {
    if (isMoving)    //Displays still image if not moving
    {
      currentAnimation.display(getPosition());
    }
    else             //Displays animation if moving
    {
      image(currentStill, getPosition().x, getPosition().y);
    }
  }
  
  public void setAnimation(Animation a)
  {
    currentAnimation = a;
  }
  
  public void setStill(PImage i)
  {
    currentStill = i;
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

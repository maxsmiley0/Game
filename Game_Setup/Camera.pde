public class Camera
{
  private int roomBorderUp;    //These members keep track of how far away a certain border is from the player
  private int roomBorderDown;
  private int roomBorderLeft;
  private int roomBorderRight;
  
  private int alpha;           //This stores the transparency of the screen, which will change if we fade in / out
  private boolean isFadingIn;     //Stores if camera is fading in or out, respectively
  private boolean isFadingOut;
  private boolean inCycle;        //When this is set to "true", the fading cycle begins
  private int fadeSpeed = 7;          //Speed at which the fade transition operates
  
  private Room isPanningTo;       //Stores which room the camera will pan to
  
  public Camera()        
  {
    alpha = 0;
    isFadingIn = false;
    isFadingOut = false;
    inCycle = false;
  }
  
  /*
  This method translates a Room "r" so an object at PVector position, usually the player, can be properly displayed
  Conventions:
  If the room's dimensions do not exceed the screen resolution:
    The room is centered in the middle of the screen
    The "out of bounds area" is blacked out
    The camera does not follow the PVector, it is assumed the PVector cannot leave the screen due to the dimensions of the room
  If the room's dimensions exceed the screen resolution about one, or both axis:
    Provided the PVector is not near the end of the room, the room shifts to center the PVector
    Once the edge of the room is in the frame, the camera will stop following the PVector
  */
  public void center(PVector position, Room r)
  {
    PVector offset = new PVector(0, 0);  //Initial offset
    boolean centeredHorizontal = false;
    boolean centeredVertical = false;
    
    roomBorderUp = (int)(r.getDimensions().y/2 + position.y);    //Updating where the room borders are
    roomBorderDown = (int)(r.getDimensions().y/2 - position.y);
    roomBorderLeft = (int)(r.getDimensions().x/2 + position.x);
    roomBorderRight = (int)(r.getDimensions().x/2 - position.x);
    
    if (r.getDimensions().x > width)  //If the dimensions exceed the screen about the horizontal axis
    {
      if (roomBorderLeft >= width/2)  //PVector is not sufficiently close to the left edge of the room
      {
        offset.x = -position.x;       //Offsets by PVector, so it appears that PVector is still in the middle of the screen
      }
      else                            //PVector is close to the left edge of the room
      {
        //PVector will still move, but the left room border will stay fixed
        offset.x = -position.x - (width/2) + roomBorderLeft;
        //This is so the computer won't overwrite this translation
        centeredHorizontal = true;
      }
      
      if (!centeredHorizontal)
      {
        //Same code, but now for the case that PVector is on the right side of the room
        if (roomBorderRight >= width/2) //PVector is not sufficiently close to the right edge of the room
        {
          offset.x = -position.x;       //Offsets by PVector, so it appears that PVector is still in the middle of the screen
        }
        else                            //PVector is close to the left edge of the room
        {
          //PVector will still move, but the right room border will stay fixed
          offset.x = -position.x + (width/2) - roomBorderRight;
        }
      }
    }
    
    if (r.getDimensions().y > height)  //If the dimensions exceed the screen about the vertical axis
    {
      if (roomBorderUp >= height/2)    //PVector is not sufficiently close to the upper edge of the room
        {
          offset.y = -position.y;      //Offsets by PVector, so it appears that PVector is still in the middle of the screen
        }
        else                           //PVector is close to the upper edge of the room
        {
          //PVector will still move, but the upper room border will stay fixed
          offset.y = -position.y - (height/2) + roomBorderUp;
          //This is so the computer won't overwrite this translation
          centeredVertical = true;
        }
      
        if (!centeredVertical)
        {
          //Same code, but now for the case that PVector is on the right side of the room
          if (roomBorderDown >= height/2)  //PVector is not sufficiently close to the lower edge of the room
          {
            offset.y = -position.y;        //Offsets by PVector, so it appears that PVector is still in the middle of the screen
          }
          else                             //PVector is close to the lower edge of the room
          {
            //PVector will still move, but the lower room border will stay fixed
            offset.y = -position.y + (height/2) - roomBorderDown;
          }
       }
    }
    
    //Translating by the offset
    translate(offset.x, offset.y);
  }
  
  public void display()
  { 
    //The following code executes if the camera pans to a new room, called in Portal::display()
    Player player = gameController.getPlayer();
    if (inCycle)
    {
      fill(#000000, alpha);
      rect(0, 0, gameController.getRoom().getDimensions().x, gameController.getRoom().getDimensions().y);
      
      AudioPlayer previousSound = gameController.getRoom().getSound();
      
      if (isFadingOut)
      {
        
        alpha += fadeSpeed;
        if (alpha >= 255)
        {
          alpha = 255;
          isFadingOut = false;
          isFadingIn = true;
          
          if (gameController.getRoom().getSound() != null && isPanningTo.getSound() != null && isPanningTo.getSound() != gameController.getRoom().getSound())  //Before changing rooms, song is paused and rewound
          {
            gameController.getRoom().getSound().pause();
            gameController.getRoom().getSound().rewind();
          }
          
          
          gameController.setRoom(isPanningTo);
          player.setPosition(isPanningTo.getSpawnpoint());
          player.getBlStack().pop();      //Lets player move again
          player.resetKeys();             //This is so the keys the player was pressing in the previous room doesn't affect anything in the new room
          
          if (gameController.getRoom().getSound() != null && gameController.getRoom().getSound() != previousSound) //After changing rooms, the new song fades in
          {
            gameController.getRoom().getSound().shiftGain(-10, 0, 1500);
          }
        }
      }
      else if (isFadingIn)
      {
        alpha -= fadeSpeed;
        if (alpha <= 0)
        {
          alpha = 0;
          isFadingIn = false;
          inCycle = false;
        }
       if (gameController.getRoom().getSound() != null && gameController.getRoom().getSound() != previousSound) //After changing rooms, the new song fades in
        {
          gameController.getRoom().getSound().shiftGain(0, 10, 1500);
        }
      }
    }
    //'x' if approaches interactor
    if (player.getInteractor() != null)
    {
     // rect(-100, -100, 100, 100); 
    }
  }
  
  public boolean inTransition() {
    return isFadingIn || isFadingOut;
  }
  
  //Pans to a room "room"

  public void displayGrid()
  {
    pushMatrix();
    Player player = gameController.getPlayer();
    center(player.getPosition(), gameController.getRoom());
    noFill();
    stroke(#000000);
    strokeWeight(1);
    //Displays a grid every 100px in a 10k x 10k area centered at the origin
    for (int i = -100; i < 100; i++)
    {
      rect(i * 50, 0, 1, 10000);
      rect(0, i * 50, 10000, 1);
    }
    strokeWeight(10);
    int idealX = floor(player.getPosition().x / 50) * 50;
    int idealY = floor(player.getPosition().y / 50) * 50;
    rect(idealX, idealY, 50, 50);
    textSize(25);
    fill(#ffffff);
    text("X: " + idealX, idealX, idealY - 20);
    text("Y: " + idealY, idealX, idealY + 20);
    popMatrix();
  }
  
  public void panTo(Room room)
  {
    inCycle = true;
    isFadingOut = true;
    isPanningTo = room;
    Player player = gameController.getPlayer();
    
    if (player.getBlStack().empty())  //only want to push one BL
    {
      //If Room has a song, we want it to fade out
      if (gameController.getRoom().getSound() != null && isPanningTo.getSound() != gameController.getRoom().getSound())
      {
        gameController.getRoom().getSound().shiftGain(0, -50, 1500);
      }
      player.getBlStack().add(new ButtonList());  //"Empty BL"
    }
    
    player.stopMoving();
  }
}

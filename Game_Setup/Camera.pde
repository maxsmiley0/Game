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
    if (inCycle)
    {
      fill(#000000, alpha);
      rect(0, 0, p.getRoom().getDimensions().x, p.getRoom().getDimensions().y);
      
      if (isFadingOut)
      {
        AudioPlayer previousSound = p.getRoom().getSound();
        
        alpha += fadeSpeed;
        if (alpha >= 255)
        {
          alpha = 255;
          isFadingOut = false;
          isFadingIn = true;
          
          if (p.getRoom().getSound() != null && isPanningTo.getSound() != null && isPanningTo.getSound() != p.getRoom().getSound())  //Before changing rooms, song is paused and rewound
          {
            p.getRoom().getSound().pause();
            p.getRoom().getSound().rewind();
          }
          
          
          p.setRoom(isPanningTo);
          p.setPosition(isPanningTo.getSpawnpoint());
          p.getBlStack().pop();      //Lets player move again
          p.resetKeys();             //This is so the keys the player was pressing in the previous room doesn't affect anything in the new room
          
          if (p.getRoom().getSound() != null && p.getRoom().getSound() != previousSound) //After changing rooms, the new song fades in
          {
            p.getRoom().getSound().shiftGain(-10, 0, 1500);
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
      }
    }
  }
  
  //Pans to a room "room"
  
  public void panTo(Room room)
  {
    inCycle = true;
    isFadingOut = true;
    isPanningTo = room;
    
    if (p.getBlStack().empty())  //only want to push one BL
    {
      //If Room has a song, we want it to fade out
      if (p.getRoom().getSound() != null && isPanningTo.getSound() != null && isPanningTo.getSound() != p.getRoom().getSound())
      {
        p.getRoom().getSound().shiftGain(0, -50, 1500);
      }
      p.getBlStack().add(new ButtonList());  //"Empty BL"
    }
    
    p.stopMoving();
  }
}

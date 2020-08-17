public class Camera
{
  private int roomBorderUp;    //These members keep track of how far away a certain border is from the player
  private int roomBorderDown;
  private int roomBorderLeft;
  private int roomBorderRight;
  
  public Camera()        
  {
    
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
}

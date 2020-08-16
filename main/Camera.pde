public class Camera
{
  private int roomBorderUp;
  private int roomBorderDown;
  private int roomBorderLeft;
  private int roomBorderRight;
  
  public Camera()        
  {
    
  }
  
  public void refresh(PVector position, Room r)
  {
    
    //roomBorderLeft -= -position.x - width/4;
    //roomBorderRight += -position.x - width/4;
    //these are important detectors! make sure they work properly. if we have a problem it probably stems from this
    roomBorderUp = (int)(r.getDimensions().y/2 + position.y);
    roomBorderDown = (int)(r.getDimensions().y/2 - position.y);
    roomBorderLeft = (int)(r.getDimensions().x/2 + position.x);
    roomBorderRight = (int)(r.getDimensions().x/2 - position.x);
  }
  
  public void center(PVector position, Room r)
  {
    if (r.getDimensions().x > width)
    {
      if (position.x < -width/4)
      {
        println(1);
        if (roomBorderLeft >= width/4) //we have enough space to fully shift
        {
          translate(-position.x - width/4, 0);
        }
        else                           //case we CANNOT fully shift
        {
          translate(-position.x - roomBorderLeft, 0);
          println(2);
        }
      }
      else if (position.x > width/4)
      {
        println(3);
        if (roomBorderRight >= width/4) //we have enough space to fully shift
        {
          translate(-position.x + width/4, 0);
        }
        else                           //case we CANNOT fully shift
        {
          translate(-position.x + roomBorderRight, 0);
          println(4);
        }
      }
    }
    
    if (r.getDimensions().y > height)
    {
      
    }
    
    //if the width / height border does not exceed the screen threshold, we do nothing
    //otherwise:
    /*
      if the player is outside the mid-center square, AND the border is not already on the edge, we have to shift
    */
  }
  
  public void update(PVector translation)
  {
    
  }
  
  public void printInfo()
  {
   println(roomBorderUp);
   println(roomBorderRight);
   println(roomBorderDown);
   println(roomBorderLeft);
  }
  
  //what does the camera need to know?
  //player and current room
}

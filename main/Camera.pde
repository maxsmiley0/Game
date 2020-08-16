public class Camera
{
  private Room currentRoom;
  //rooms are alwyas square
  //the idea is that a room can be smaller than, equal to, or bigger than the allotted screen (800 x 600)
  //Case Smaller: the room is simply centered in the screen, with the outer edges blacked out
  //Case the same: the room is simply centered in the screen perfectly
  //Case bigger: there will be a certain subwindow within the screen where when you move around, nothing happens. However, outside these bounds, if the end of the room
  //is not yet displayed, the camera will shift towards that direction, until the end wall has been hit
}

public class Struct            //Structure: To be implemented inside of Rooms
{
  private PImage img;          //Has a custom image
  private PVector position;    //Has both a position, and dimensions
  private PVector dimensions;
  
  private boolean rigidBody;   //If true, then entities collide with it
  
  //Constructor for image
  public Struct(String imgFilePath, PVector position, PVector dimensions, boolean rigidBody)
  {
    img = loadImage(imgFilePath);
    
    this.position = position;
    this.dimensions = dimensions;
    this.rigidBody = rigidBody;
  }
  
  public void display()
  {
    //Displays the image associated with the structure
    image(img, position.x, position.y, dimensions.x, dimensions.y);
  }
  
  //Simple accessor
  public boolean isRigidBody()
  {
    return rigidBody;
  }
}

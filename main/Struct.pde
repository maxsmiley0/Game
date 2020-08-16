public class Struct            //Structure: To be implemented inside of Rooms
{
  private PShape shape;        //Has either a shape, or a custom image
  private PImage img;
  private PVector position;    //Has both a position, and dimensions
  private PVector dimensions;
  
  private boolean rigidBody;   //If true, then entities collide with it
  
  //Constructor for shape
  public Struct(PShape shape, PVector position, PVector dimensions, boolean rigidBody)
  {
    this.shape = shape;
    this.position = position;
    this.dimensions = dimensions;
    this.rigidBody = rigidBody;
    //Setting img = to null to signify it only has a shape
    img = null;
  }
  
  //Constructor for image
  public Struct(PImage img, PVector position, PVector dimensions, boolean rigidBody)
  {
    this.img = img;
    this.position = position;
    this.dimensions = dimensions;
    this.rigidBody = rigidBody;
    //Setting shape = to null to signify it only has an image
    shape = null;
  }
  
  public void display()
  {
    //Displays either the image or shape associated with the structure
    if (shape == null)
    {
      image(img, position.x, position.y, dimensions.x, dimensions.y);
    }
    else 
    {
      shape(shape, position.x, position.y, dimensions.x, dimensions.y);
    }
  }
  
  //Simple accessor
  public boolean isRigidBody()
  {
    return rigidBody;
  }
}

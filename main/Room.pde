public class Room
{
  private ArrayList<Struct> li = new ArrayList<Struct>();  //A room is comprised of an arbitrary number of structs
  private PVector spawnpoint;    //where we spawn
  private PVector dimensions;    //dimensions of room
  
  public Room(PVector spawnpoint, PVector dimensions)
  {
    this.spawnpoint = spawnpoint;
    this.dimensions = dimensions;
  }
  
  //Adds a struct to the room
  public void addStruct(Struct s)
  {
    li.add(s);
  }
  
  //Displays the room by displaying each struct of the room
  public void display()
  {
    for (int i = 0; i < li.size(); i++)
    {
      li.get(i).display();
    }
  }
}

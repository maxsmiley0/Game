public class Room
{
  private ArrayList<Struct> li;  //A room is comprised of an arbitrary number of structs
  private ArrayList<NPC> liNpc;  //A room also has NPC's
  
  private PVector spawnpoint;    //spawnpoint of Player
  private PVector dimensions;    //dimensions of room
  
  public Room(PVector spawnpoint, PVector dimensions)
  {
    li = new ArrayList<Struct>();
    liNpc = new ArrayList<NPC>();
    
    this.spawnpoint = spawnpoint;
    this.dimensions = dimensions;
  }
  
  //Adds a struct to the room
  public void addStruct(Struct s)
  {
    li.add(s);
  }
  
  //Adds an NPC to the room
  public void addNpc(NPC npc)
  {
    liNpc.add(npc);
  }
  
  //Displays the room by displaying each struct of the room
  public void display()
  {
    for (int i = 0; i < li.size(); i++)
    {
      li.get(i).display();
    }
    for (int i = 0; i < liNpc.size(); i++)
    {
      liNpc.get(i).display();
    }
  }
  
  //Spawnpoint mutator method - may be called if a Player leaves a room via different doors
  public void setSpawnpoint(PVector spawnpoint)
  {
    this.spawnpoint = spawnpoint;
  }
  
  //Simple spawnpoint accessor
  public PVector getSpawnpoint()
  {
    return spawnpoint;
  }
  
  //Simple dimensions accessor
  public PVector getDimensions()
  {
    return dimensions;
  }
}

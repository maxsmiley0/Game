public class Room
{
  private ArrayList<Struct> liStruct;  //A room is comprised of an arbitrary number of structs
  private ArrayList<NPC> liNpc;        //A room also has NPC's
  private ArrayList<Portal> liPortal;  //A room also has portals
  
  private PVector spawnpoint;    //spawnpoint of Player
  private PVector dimensions;    //dimensions of room
  
  public Room(PVector spawnpoint, PVector dimensions)
  {
    liStruct = new ArrayList<Struct>();
    liNpc = new ArrayList<NPC>();
    liPortal = new ArrayList<Portal>();
    
    this.spawnpoint = spawnpoint;
    this.dimensions = dimensions;
  }
  
  //Adds a struct to the room
  public void addStruct(Struct s)
  {
    liStruct.add(s);
  }
  
  //Adds an NPC to the room
  public void addNpc(NPC npc)
  {
    liNpc.add(npc);
  }
  
  public void addPortal(Portal portal)
  {
    liPortal.add(portal);
  }
  
  //Displays the room by displaying each struct of the room
  public void display()
  {
    for (int i = 0; i < liStruct.size(); i++)
    {
      liStruct.get(i).display();
    }
    for (int i = 0; i < liNpc.size(); i++)
    {
      liNpc.get(i).display();
    }
    for (int i = 0; i < liPortal.size(); i++)
    {
      liPortal.get(i).display();
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

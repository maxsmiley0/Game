public class Room
{
  private ArrayList<GameObject> li;  //A room is comprised of GameObjects
  private AudioPlayer roomSong;      //Ambient song that plays in the background, null if no song
  
  private PVector spawnpoint;    //spawnpoint of Player
  private PVector dimensions;    //dimensions of room
  
  public Room(PVector spawnpoint, PVector dimensions)
  {
    li = new ArrayList<GameObject>();
    
    this.spawnpoint = spawnpoint;
    this.dimensions = dimensions;
    this.roomSong = null;
    
    //Auto-adds rigidbodies for the walls
    li.add(new Struct(null, new PVector(dimensions.x, -dimensions.y / 2), new PVector(dimensions.x, 2*dimensions.y), false, true));
    li.add(new Struct(null, new PVector(-dimensions.x, -dimensions.y / 2), new PVector(dimensions.x, 2*dimensions.y), false, true));
    li.add(new Struct(null, new PVector(0, dimensions.y), new PVector(2*dimensions.x, dimensions.y), false, true));
    li.add(new Struct(null, new PVector(0, -dimensions.y), new PVector(2*dimensions.x, dimensions.y), false, true));
  }
  
  //Adds a GameObject to the room
  public void addGameObject(GameObject g)
  {
    li.add(g);
  }
  
  //Displays the room by displaying each GameObject
  public void display()
  {
    if (roomSong != null)
    {
      loop(roomSong, 1000);
    }
    
    for (int i = 0; i < li.size(); i++)
    {
      li.get(i).display();
    }
  }
  
  //Spawnpoint mutator method - may be called if a Player leaves a room via different doors
  public void setSpawnpoint(PVector spawnpoint)
  {
    this.spawnpoint = spawnpoint;
  }
  
  public void setSound(AudioPlayer roomSong)
  {
    this.roomSong = roomSong;
  }
  
  public AudioPlayer getSound()
  {
    return roomSong;
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

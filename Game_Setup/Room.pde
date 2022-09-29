public class Room
{
  private ArrayList<GameObject> gameObjects;  //A room is comprised of GameObjects
  private AudioPlayer roomSong;      //Ambient song that plays in the background, null if no song
  
  private PVector spawnpoint;    //spawnpoint of Player
  private PVector dimensions;    //dimensions of room
  
  public Room(PVector spawnpoint, PVector dimensions)
  {
    gameObjects = new ArrayList<GameObject>();
    
    this.spawnpoint = spawnpoint;
    this.dimensions = dimensions;
    this.roomSong = null;
    
    //Auto-adds rigidbodies for the walls
    gameObjects.add(new Struct(null, new PVector(dimensions.x, -dimensions.y / 2), new PVector(dimensions.x, 2*dimensions.y), true));
    gameObjects.add(new Struct(null, new PVector(-dimensions.x, -dimensions.y / 2), new PVector(dimensions.x, 2*dimensions.y), true));
    gameObjects.add(new Struct(null, new PVector(0, dimensions.y), new PVector(2*dimensions.x, dimensions.y), true));
    gameObjects.add(new Struct(null, new PVector(0, -dimensions.y), new PVector(2*dimensions.x, dimensions.y), true));
  }
  
  //Adds a GameObject to the room
  public void addGameObject(GameObject gameObject)
  {
    gameObjects.add(gameObject);
  }
  
  public ArrayList<GameObject> getGameObjects() {
    return gameObjects;
  }
  
  //Displays the room by displaying each GameObject
  public void display()
  {
    pushMatrix();
    
    gameController.getCamera().center(gameController.getPlayer().getPosition(), this);
    fill(#000000);
    
    rectMode(CORNER);
    rect(getDimensions().x / 2, -getDimensions().y, getDimensions().x, 2*getDimensions().y);
    rect(-getDimensions().x / 2, -getDimensions().y, -getDimensions().x, 2*getDimensions().y);
    rect(-getDimensions().x, getDimensions().y / 2, 2*getDimensions().x, getDimensions().y);
    rect(-getDimensions().x, -getDimensions().y / 2, 2*getDimensions().x, -getDimensions().y);
    rectMode(CENTER);
    
    if (roomSong != null)
    {
      loop(roomSong, 1000);
    }
    
    for (int i = 0; i < gameObjects.size(); i++)
    {
      gameObjects.get(i).display();
    }
    
    popMatrix();
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

public class Player extends Entity
{
  private Room currentRoom;      //The room the player is currently in
  private Camera camera;         //Camera to keep display and center the player and room
  private Animation currentAnimation;   //Animation to be displayed when moving
  private NPC currentInteractor; //Stores the NPC that the player is currently interacting with
  
  private PImage currentStill;          //Image to be displayed when still
  
  private boolean inShop;               //If true, displays shop instead of room and character
  private boolean isMoving;             //If true, the moving animation will be displayed instead of the still
  
  private ArrayList<Object> inventory;
  //moneYY
  
  /*
  The heiarchy of ButtonLists is implemented as a stack, because if you enter a new interface within a separate interface, we want
  the previous interface to be displayed when we exit out of the new interface (first in  first out). If the stack is empty, e.g.
  no interfaces / buttons to choose from, then the player can freely move
  */
  private Stack<ButtonList> blStack = new Stack<ButtonList>();
  
  /*
  0 is UP, 1 is RIGHT, 2 is DOWN, 3 is LEFT
  If true, then the player moves in that direction
  0 and 2 may never be true concurrently, as is the case with 1 and 3
  However, 01, 03, 21, and 23 may be concurrently true, which corresponds to diagonal movement
  */
  private boolean keys[] = new boolean[4];
  
  public Player(PVector position)
  {
    super(position);             //Passing position vector to Entity superclass
    camera = new Camera();       //Instantiating a new camera
    inventory = new ArrayList<Object>();  //Instantiating a new inventory
    
    isMoving = false; 
    inShop = false;
    
    currentInteractor = null;
    currentStill = friskRestForward;     //Need to have a current still setup as soon as player is instantiated for rigidBody reasons
    currentAnimation = friskWalkForward;
  }
  
  //Sets the Player's current interactor
  public void setInteractor(NPC npc)
  {
    currentInteractor = npc;
  }
  
  public NPC getInteractor()
  {
    return currentInteractor;
  }
  
  public void addItem(Object object)
  {
    inventory.add(object);
  }
  
  public ArrayList<Object> getInventory()
  {
    return inventory;
  }
  
  //Setting the key "keyNum" to boolean b
  public void setKey(int keyNum, boolean b)
  {
    //If the key is out of bounds, we exit
    if (keyNum < 0 || keyNum > 3)
    {
      println("Setting key to an out of bounds parameter in Player.pde");
      exit();
    }
    keys[keyNum] = b;
  }
  
  //Responsible for arrow keys affecting the player / current interface
  public void implementArrowKeys()
  {
    if (blStack.empty())  //Player can freely move, is not in any ButtonList
    {
      PVector velocity = new PVector(0, 0);
      if (keys[0])
      {
        isMoving = true;
        setAnimation(friskWalkForward);
        setStill(friskRestForward);
        velocity.y = -6;
      }
      else if (keys[2])
      {
        isMoving = true;
        setAnimation(friskWalkForward);
        setStill(friskRestForward);
        velocity.y = 6;
      }
      if (keys[1])
      {
        isMoving = true;
        setAnimation(friskWalkRight);
        setStill(friskRestRight);
        velocity.x = 6;
      }
      else if (keys[3])
      {
        isMoving = true;
        setAnimation(friskWalkLeft);
        setStill(friskRestLeft);
        velocity.x = -6;
      }
      
      move(velocity);
    }
    else  //Player cannot move, is in at least on interface
    {
      
    }
  }
  
  //Note: by themselves, these methods do not move the player, but simply display the moving animation
  public void startMoving()
  {
    isMoving = true;
  }
  
  public void stopMoving()
  {
    isMoving = false;
  }
  
  public void setAnimation(Animation a)
  {
    currentAnimation = a;
  }
  
  public void setStill(PImage i)
  {
    currentStill = i;
  }
  
  public void setRoom(Room room)
  {
    currentRoom = room;
  }
  
  //Enters shop, also pushes an interaction onto the blStack
  public void enterShop()
  {
    inShop = true;
    String choices[] = {"Buy","Sell","Talk","Leave"};
    blStack.add(new ButtonList(choices, true, new PVector(350, 130), new PVector(150, 45), 4, 60, true));
  }
  
  //Exits shop, stops interacting with NPC, pops the blStack
  public void exitShop()
  {
    inShop = false;
    currentInteractor.setInteract(false);
    blStack.pop();
  }
  
  public boolean isInShop()
  {
    return inShop;
  }
  
  public PVector getDimensions()
  {
    return new PVector(currentStill.width, currentStill.height);
  }
  
  public Room getRoom()
  {
    return currentRoom;
  }
  
  public Stack getBlStack()
  {
    return blStack;
  }
  
  /*
  Only defining this because we java is too dumb to recognize that we can indeed call member functions on an object from .peek() in a stack 
  So, naturally, instead of writing
  "p.getBlStack().peek().display()"
  we get to write
  "p.getCurrentBl().display()"
  */
  //Undefined if blStack is empty, but will only be called when we know this is not the case
  public ButtonList getCurrentBl()
  {
    return blStack.peek();
  }
  
  public void display()          //Placeholder sprite
  {
    pushMatrix();
    camera.center(getPosition(), currentRoom);
    
    if (isMoving)    //Displays still image if not moving
    {
      currentAnimation.display(getPosition());
    }
    else             //Displays animation if moving
    {
      image(currentStill, getPosition().x, getPosition().y);
    }
    popMatrix();
  }
  
  public void displayRoom()
  { 
    pushMatrix();
    
    camera.center(getPosition(), currentRoom);
    fill(#000000);
    
    rectMode(CORNER);
    rect(currentRoom.getDimensions().x / 2, -currentRoom.getDimensions().y, currentRoom.getDimensions().x, 2*currentRoom.getDimensions().y);
    rect(-currentRoom.getDimensions().x / 2, -currentRoom.getDimensions().y, -currentRoom.getDimensions().x, 2*currentRoom.getDimensions().y);
    rect(-currentRoom.getDimensions().x, currentRoom.getDimensions().y / 2, 2*currentRoom.getDimensions().x, currentRoom.getDimensions().y);
    rect(-currentRoom.getDimensions().x, -currentRoom.getDimensions().y / 2, 2*currentRoom.getDimensions().x, -currentRoom.getDimensions().y);
    rectMode(CENTER);
    
    currentRoom.display();
    popMatrix();
  }
}

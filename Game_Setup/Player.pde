public class Player extends GameObject
{
  private Animation currentAnimation;
  private boolean isMoving;
  
  private ArrayList<Object> inventory;
  private int gold;
  
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
    super(friskRestForward, position, new PVector(friskRestForward.width, friskRestForward.height));
    inventory = new ArrayList<Object>();  //Instantiating a new inventory
    isMoving = false; 
    currentAnimation = friskWalkForward;
    gold = 200;
  }
  
  public int getGold()
  {
    return gold;
  }
  
  public void gainGold(int i)
  {
    gold += i;
  }
  
  public GameObject getInteractor()
  {
    for (GameObject gameObject : gameController.getRoom().getGameObjects()) {
      int offset = 10;     //Player's speed is tentatively 6, so 10 is okay
      
      int leftBorder = (int)(gameObject.getPosition().x - (gameObject.getDimensions().x/2) - (getDimensions().x / 2) - offset);
      int rightBorder = (int)(gameObject.getPosition().x + (gameObject.getDimensions().x/2) + (getDimensions().x / 2) + offset);
      int topBorder = (int)(gameObject.getPosition().y - (gameObject.getDimensions().y/2) - (getDimensions().y/2) - offset);
      int bottomBorder = (int)(gameObject.getPosition().y + (gameObject.getDimensions().y/2) + (getDimensions().y/2) + offset);
      
      if (gameObject.getBubble() != null && getPosition().x >= leftBorder && getPosition().x <= rightBorder && getPosition().y >= topBorder && getPosition().y <= bottomBorder)
      {  
        return gameObject;
      }
    }
    return null;
  }
  
  public Portal getPortal() {
    for (GameObject gameObject : gameController.getRoom().getGameObjects()) {
      if (gameObject instanceof Portal) {
        int offset = 10;     //Player's speed is tentatively 6, so 10 is okay
        
        int leftBorder = (int)(gameObject.getPosition().x - (gameObject.getDimensions().x/2) - (getDimensions().x / 2) - offset);
        int rightBorder = (int)(gameObject.getPosition().x + (gameObject.getDimensions().x/2) + (getDimensions().x / 2) + offset);
        int topBorder = (int)(gameObject.getPosition().y - (gameObject.getDimensions().y/2) - (getDimensions().y/2) - offset);
        int bottomBorder = (int)(gameObject.getPosition().y + (gameObject.getDimensions().y/2) + (getDimensions().y/2) + offset);
        
        if (getPosition().x >= leftBorder && getPosition().x <= rightBorder && getPosition().y >= topBorder && getPosition().y <= bottomBorder)
        {  
          return (Portal)gameObject;
        }
      }
    }
    return null;
  }
  
  public void addObject(Object object)
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
        setImage(friskRestForward);
        velocity.y = -6;
      }
      else if (keys[2])
      {
        isMoving = true;
        setAnimation(friskWalkForward);
        setImage(friskRestForward);
        velocity.y = 6;
      }
      if (keys[1])
      {
        isMoving = true;
        setAnimation(friskWalkRight);
        setImage(friskRestRight);
        velocity.x = 6;
      }
      else if (keys[3])
      {
        isMoving = true;
        setAnimation(friskWalkLeft);
        setImage(friskRestLeft);
        velocity.x = -6;
      }
      
      move(velocity);
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
  
  public void resetKeys()
  {
    keys[0] = false;
    keys[1] = false;
    keys[2] = false;
    keys[3] = false;
  }
  
  public void setAnimation(Animation a)
  {
    currentAnimation = a;
  }
  
  //Enters shop, also pushes an interaction onto the blStack
  public void enterShop()
  {
    blStack.push(new ButtonList(new String[]{"Buy","Sell","Talk","Leave"}, true, new PVector(350, 130), new PVector(150, 45), 60, true));
  }
  
  //Exits shop, stops interacting with NPC, pops the blStack
  public void exitShop()
  {
    blStack.pop();
    gameController.getShop().getText().reset();
  }
  
  public void enterBattle()
  {
    blStack.push(new ButtonList(new String[]{"Attack","Inventory","Talk"}, true, new PVector(-20, -280), new PVector(175, 50), 75, true));
  }
  
  public void exitBattle()
  {
    blStack.pop();
    //text reset?
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
  
  public ButtonList getPreviousBl()  //Returns previous ButtonList
  {
    //Assumes at least two button lists
    return blStack.get(blStack.size() - 2);
  }
  
  public void display()
  {
    if (isMoving)
    {
      currentAnimation.display(getPosition());
    }
    else
    {
      image(getImage(), getPosition().x, getPosition().y);
    }

    if (getBubble() != null) {
      getBubble().display();
    }
  }
}

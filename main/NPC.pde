public class NPC extends Entity
{
  private PImage currentStill;     //might change..? depending on if player interacts from a given side..?
  private ArrayList<Bubble> quests;
  
  private boolean inInteractionRange;
  private boolean displayQuest;
  
  public NPC(PVector position, PImage currentStill)
  {
    super(position);
    this.currentStill = currentStill;
    quests = new ArrayList<Bubble>();
    
    inInteractionRange = false;
    displayQuest = false;
  }
  
  //What will an NPC have?
  //Always: a position, a display
  
  //Sometimes: talk to you
  //questgiving
  //shop
  //For now add bubbles, but later on, maybe have a quest class, and bubbles be a member of that?
  public void addQuest(Bubble quest)
  {
    quests.add(quest);
  }
  
  public Bubble getQuest(int i)
  {
    return quests.get(i);
  }
  
  public void display()
  {
    image(currentStill, getPosition().x, getPosition().y);
    
    //Automatic rigidBody applied to NPCs
    int leftBorder = (int)(getPosition().x - (currentStill.width/2) - (p.getDimensions().x / 2));
    int rightBorder = (int)(getPosition().x + (currentStill.width/2) + (p.getDimensions().x / 2));
    int topBorder = (int)(getPosition().y - (currentStill.height/2) - (p.getDimensions().y/2));
    int bottomBorder = (int)(getPosition().y + (currentStill.height/2) + (p.getDimensions().y/2));
    /*
    This parameter defines how thick the rigid border will be. Note that it must have a nontrivial length, as if 
    it is slower than the player's speed, since this program runs frame by frame, the player will pass through the rigid
    portion and the computer won't apply a normal force
    */
    int offset = 10;     //Player's speed is tentatively 6, so 10 is okay
      
    //Applying an fixed impulse
    if (p.getPosition().x > leftBorder && p.getPosition().x < leftBorder + offset && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)
    {
      p.move(new PVector(-6, 0));
      inInteractionRange = true;
    }
    if (p.getPosition().x > rightBorder - offset && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)    
    {
      p.move(new PVector(6, 0));
      inInteractionRange = true;
    }
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < topBorder + offset)
    {
      p.move(new PVector(0, -6));
      inInteractionRange = true;
    }
    if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > bottomBorder - offset && p.getPosition().y < bottomBorder)
    {
      p.move(new PVector(0, 6));
      inInteractionRange = true;
    }
    
    if (p.getPosition().x < leftBorder - offset || p.getPosition().x > rightBorder + offset || p.getPosition().y < topBorder - offset || p.getPosition().y > bottomBorder + offset)
    {
      inInteractionRange = false;
    }
    //temp tester
  if (inInteractionRange)
  {
    rect(p.getPosition().x, p.getPosition().y, 55, 126);
    p.setInteractor(this);
  }
  else
  {
    if (p.getInteractor() == this)
    {
      p.setInteractor(null);
    }
  }
  
  if (displayQuest)
  {
    getQuest(0).display();
    if (p.getBlStack().empty())
    {
      p.getBlStack().add(getQuest(0).getBl());
      p.stopMoving();
    }
  
  }
  }
  
  public void setDisplayQuest(boolean b)
  {
    displayQuest = b;
  }
}

//scheme for entering different rooms..?
//work out text... is it going to be in a bubble, or a window..?

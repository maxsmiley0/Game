public class NPC extends Entity
{
  private PImage currentStill;     //might change..? depending on if player interacts from a given side..?
  
  public NPC(PVector position, PImage currentStill)
  {
    super(position);
    this.currentStill = currentStill;
  }
  
  //What will an NPC have?
  //Always: a position, a display
  
  //Sometimes: talk to you
  //questgiving
  //shop
  public void display()
  {
    image(currentStill, getPosition().x, getPosition().y);
  }
}

//scheme for entering different rooms..?
//work out text... is it going to be in a bubble, or a window..?

public class Fighter
{
  private Animation currentAnimation;     //if null, no current animation
  private PImage currentStill;
  //arraylist of moves
  private int health;
  //mana etc;
  private String name;
  
  public Fighter(Animation a)
  {
    currentAnimation = a;
  }
  
  public void display(PVector position)
  {
    currentAnimation.display(position);
  }
  
}

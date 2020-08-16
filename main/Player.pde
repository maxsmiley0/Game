public class Player extends Entity
{
  private int speed = 4;
  
  public Player(PVector position)
  {
    super(position);
  }
  
  public void display()
  {
    fill(0, 0, 0);
    rect(getPosition().x, getPosition().y, 10, 10);
  }
  
  public int getSpeed()
  {
    return speed;
  }
  
}

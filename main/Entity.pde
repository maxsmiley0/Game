public abstract class Entity
{
  private PVector position;
  
  public Entity(PVector position)
  {
    this.position = position;
  }
  
  public PVector getPosition()
  {
   return position; 
  }
  
  public void setPosition(PVector position)
  {
    this.position = position;
  }
  
  public void move(PVector p)
  {
    position.add(p);
  }
  
  public abstract void display();
}

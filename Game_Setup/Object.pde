public class Object
{
  private String name;
  private String description;
  private int cost;
  
  public Object(String name, String description, int cost)
  {
    this.name = name;
    this.description = description;
    this.cost = cost;
  }
  
  public String getName()
  {
    return name;
  }
  
  public String getDescription()
  {
    return description;
  }
  
  public int getCost()
  {
    return cost;
  }
  
  //What do they all have?
  //Strings for names
  //Strings for descriptions
  //int for cost? must be divisible by 5
  
  //Are they a weapon / armor / potion - TBI later!
}

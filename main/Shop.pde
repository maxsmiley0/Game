public class Shop
{
  private String[] items;    //Later will be an ArrayList of objects
  
  public Shop(String[] items)
  {
    this.items = items;
  }
  //has items to be added later, for now we'll just have the items as strings
  //-Buy
  //-Sell
  //-Talk
  //-Leave
  
  //When first opening shop, it will have these four options
  
  public void displayShop()
  {
    //assumes at least one BL
    
    //Displays background
    //Displays text interface
    //Displays current BL
    /*
    if p.bl.size = 1
      opening screen
    elif p.bl.size = 2
      buy / sell
    elif p.bl.size = 3
      are you sure? (you want to buy / sell)
    */
  }
}

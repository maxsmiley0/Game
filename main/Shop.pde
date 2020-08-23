public class Shop
{
  private ArrayList<Object> inventory;  //inventory of the shop
  private int shopInterface;   // 0: starting screen | 1: buy screen | 2: sell screen | 3: talk screen |
  private Text text;
  
  public Shop()
  {
    shopInterface = 0;
    text = new Text();
    inventory = new ArrayList<Object>();
  }
  
  public void setInventory(ArrayList<Object> inventory)
  {
    this.inventory = inventory;
  }
  
  public ArrayList<Object> getInventory()
  {
    return inventory;
  }
  
  public Text getText()
  {
    return text;
  }
  
  public void display()
  {
    image(shopBackground, 0, -130);  //Background (shop vender image)
    
    fill(#000000);                   //Lefthand box
    stroke(#FFFFFF);
    strokeWeight(10);
    rect(-200, 220, 700, 260);
    
    fill(#000000);
    stroke(#FFFFFF);                 //Righthand box
    strokeWeight(10);
    rect(350, 220, 400, 260);
    
    switch (shopInterface)
    {
      case 0:
        fill(#FFFFFF);
        text.display("What can I do for you today?", new PVector(-200, 120), 18);
        break;
      case 1:
        fill(#FFFFFF);
        textSize(25);
        if (p.getCurrentBl().getButton() != p.getCurrentBl().getMaxButton() - 1)
        {
          text.display(shop.getInventory().get(p.getCurrentBl().getButton()).getDescription(), new PVector(350, 220), 18);
        }
        break;
      case 2:
        fill(#FFFFFF);
        textSize(25);
        if (p.getCurrentBl().getButton() != p.getCurrentBl().getMaxButton() - 1)
        {
          text.display(shop.getInventory().get(p.getCurrentBl().getButton()).getDescription(), new PVector(350, 220), 18);
        }
        break;
      case 3:
        break;
    }
    
    p.getCurrentBl().display();
  }
  
  public void setShopInterface(int i)
  {
    shopInterface = i;
    text.reset();
  }
  
  public int getShopInterface()
  {
    return shopInterface;
  }
}

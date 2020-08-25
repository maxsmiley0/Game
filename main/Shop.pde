public class Shop
{
  private ArrayList<Object> inventory;  //inventory of the shop
  private String[][] dialogue;     //Stores dialogue of shopkeeper: 1st dimension represents number of dialogues, 2nd represents number of slides per dialogue
                                   //Title of dialogue is stored as first index of each sub-array
  private int textSlide;           //In a given index of the dialogue "catalog" (i.e. an array of strings), stores which "slide" (index) we are on
  
  private int shopInterface;   // 0: starting screen | 1: buy screen | 2: sell screen | 3: talk screen | 4: "are you sure" buy screen | 5: "are you sure" sell screen
  private Text text;
  
  public Shop()
  {
    shopInterface = 0;
    textSlide = 1;
    text = new Text();
  }
  
  public int currentSlide()
  {
    return textSlide;
  }
  
  public void nextSlide()
  {
    textSlide++;
  }
  
  public void resetSlide()
  {
    textSlide = 1;
  }
  
  public String[][] getDialogue()
  {
    return dialogue;
  }
  
  public void setInventory(ArrayList<Object> inventory)
  {
    this.inventory = inventory;
  }
  
  public void setDialogue(String[][] dialogue)
  {
    this.dialogue = dialogue;
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
        textSize(25);
        fill(#C6B323);
        text("Gold: " + p.getGold(), 230, 320);
        fill(#00C7FF);
        text("Buy?", 500, 320);
        fill(#FFFFFF);
        if (p.getCurrentBl().getButton() != p.getCurrentBl().getMaxButton() - 1)
        {
          
          text.display(shop.getInventory().get(p.getCurrentBl().getButton()).getDescription(), new PVector(350, 220), 18);
        }
        break;
      case 2:
        textSize(25);
        fill(#C6B323);
        text("Gold: " + p.getGold(), 230, 320);
        fill(#00C7FF);
        text("Sell?", 495, 320);
        fill(#FFFFFF);
        textSize(25);
        if (p.getCurrentBl().getButton() != p.getCurrentBl().getMaxButton() - 1)
        {
          text.display(p.getInventory().get(p.getCurrentBl().getButton()).getDescription(), new PVector(350, 220), 18);
        }
        break;
      case 3:
        
        break;
      case 4:
        textSize(25);
        fill(#C6B323);
        text("Gold: " + p.getGold(), 230, 320);
        fill(#00C7FF);
        text("Buy?", 500, 320);
        fill(#FFFFFF);
        text("Are you sure you want\nto buy\n\n" + shop.getInventory().get(p.getPreviousBl().getButton()).getName() + "\n\nfor " + shop.getInventory().get(p.getPreviousBl().getButton()).getCost() + "G?", 350, 174);
        p.getPreviousBl().display();
        break;
      case 5:
        textSize(25);
        fill(#C6B323);
        text("Gold: " + p.getGold(), 230, 320);
        fill(#00C7FF);
        text("Sell?", 495, 320);
        fill(#FFFFFF);
        text("Are you sure you want\nto sell\n\n" + p.getInventory().get(p.getPreviousBl().getButton()).getName() + "\n\nfor " + 4 * p.getInventory().get(p.getPreviousBl().getButton()).getCost() / 5 + "G?", 350, 174);
        p.getPreviousBl().display();
        break;
      case 6:
        fill(#FFFFFF);
        text.display(dialogue[p.getPreviousBl().getButton()][textSlide], new PVector(-200, 220), 18);
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

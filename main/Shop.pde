public class Shop
{
  private ArrayList<Object> inventory;  //inventory of the shop
  private String[][] dialogue;     //Stores dialogue of shopkeeper: 1st dimension represents number of dialogues, 2nd represents number of slides per dialogue
                                   //Title of dialogue is stored as first index of each sub-array
  private int textSlide;           //In a given index of the dialogue "catalog" (i.e. an array of strings), stores which "slide" (index) we are on
  
  private AudioPlayer backgroundSong; //This is the song that will be playing in the background
  
  private int shopInterface;   // 0: starting screen | 1: buy screen | 2: sell screen | 3: talk screen | 4: "are you sure" buy screen | 5: "are you sure" sell screen | 6: in a given dialogue with the shopkeeper
  private Text text;
  
  public Shop()
  {
    shopInterface = 0;
    textSlide = 1;      //Text slide starts at 1, because 0 holds the place of the title String
    text = new Text();
    backgroundSong = null;
  }
  
  public void display()
  {
    if (backgroundSong != null)
    {
      loop(backgroundSong, 79);
    }
    
    image(shopBackground, 0, -130);  //Background (shop vender image)
    
    fill(#000000);                   //Lefthand box
    stroke(#FFFFFF);
    strokeWeight(10);
    rect(-200, 220, 700, 260);
    
    fill(#000000);                   //Righthand box
    stroke(#FFFFFF);                 
    strokeWeight(10);
    rect(350, 220, 400, 260);
    
    switch (shopInterface)
    {
      //Default menu screen
      case 0:
        fill(#FFFFFF);
        text.display("What can I do for you today?", new PVector(-200, 120), 18);
        break;
      //"Buy" screen
      case 1:
        textSize(25);
        fill(#C6B323);
        text("Gold: " + p.getGold(), 230, 320);
        fill(#00C7FF);
        text("Buy?", 500, 320);
        fill(#FFFFFF);
        //Object description displayed here
        if (p.getCurrentBl().getButton() != p.getCurrentBl().getMaxButton() - 1)
        {
          text.display(inventory.get(p.getCurrentBl().getButton()).getDescription(), new PVector(350, 220), 18);
        }
        else 
        {
          text.display("", new PVector(350, 220), 18);  //We do this so the AudioPlayer cuts out
        }
        break;
      //"Sell" screen
      case 2:
        textSize(25);
        fill(#C6B323);
        text("Gold: " + p.getGold(), 230, 320);
        fill(#00C7FF);
        text("Sell?", 495, 320);
        fill(#FFFFFF);
        textSize(25);
        //Object description displayed here
        if (p.getCurrentBl().getButton() != p.getCurrentBl().getMaxButton() - 1)
        {
          text.display(p.getInventory().get(p.getCurrentBl().getButton()).getDescription(), new PVector(350, 220), 18);
        }
        else 
        {
          text.display("", new PVector(350, 220), 18);  //We do this so the AudioPlayer cuts out
        }
        break;
      //"Talk" screen
      case 3:
        //Nothing additional to be displayed here, current button list displays everything we would want to be displayed
        text.getSound().pause();  //We do this so the AudioPlayer c
        break;
      //"Buy" screen - Player is choosing between yes or no
      case 4:
        textSize(25);
        fill(#C6B323);
        text("Gold: " + p.getGold(), 230, 320);
        fill(#00C7FF);
        text("Buy?", 500, 320);
        fill(#FFFFFF);
        text("Are you sure you want\nto buy\n\n" + inventory.get(p.getPreviousBl().getButton()).getName() + "\n\nfor " + inventory.get(p.getPreviousBl().getButton()).getCost() + "G?", 350, 174);
        //We want to see the shop inventory (prev BL) in ADDITION to the current BL (yes/no interface)
        p.getPreviousBl().display();
        break;
      //"Sell" screen - Player is choosing between yes or no
      case 5:
        text.getSound().pause();
        
        textSize(25);
        fill(#C6B323);
        text("Gold: " + p.getGold(), 230, 320);
        fill(#00C7FF);
        text("Sell?", 495, 320);
        fill(#FFFFFF);
        text("Are you sure you want\nto sell\n\n" + p.getInventory().get(p.getPreviousBl().getButton()).getName() + "\n\nfor " + 4 * p.getInventory().get(p.getPreviousBl().getButton()).getCost() / 5 + "G?", 350, 174);
        //We want to see the player inventory (prev BL) in ADDITION to the current BL (yes/no interface)
        p.getPreviousBl().display();
        break;
      //Engaging in a dialogue
      case 6:
        fill(#FFFFFF);
        text.display(dialogue[p.getPreviousBl().getButton()][textSlide], new PVector(-200, 220), 18);
        break;
    }
    //Displays the current BL (what you see when you press UP/DOWN)
    p.getCurrentBl().display();
  }
  
  //Acessors
  
  public ArrayList<Object> getInventory()
  {
    return inventory;
  }
  
  public String[][] getDialogue()
  {
    return dialogue;
  }
  
  public int currentSlide()
  {
    return textSlide;
  }
  
  public Text getText()
  {
    return text;
  }
  
  public AudioPlayer getBackgroundSong()
  {
    return backgroundSong;
  }
  
  public int getShopInterface()
  {
    return shopInterface;
  }
  
  //Mutators
  
  public void setInventory(ArrayList<Object> inventory)
  {
    this.inventory = inventory;
  }
  
  public void setBackgroundSong(AudioPlayer a)
  {
    backgroundSong = a;
  }
  
  public void setDialogue(String[][] dialogue)
  {
    this.dialogue = dialogue;
  }
  
  public void nextSlide()
  {
    textSlide++;
  }
  
  public void resetSlide()
  {
    textSlide = 1;
  }
  
  public void setShopInterface(int i)
  {
    shopInterface = i;
    text.reset();
  }
}

public class Overview
{
  //What is an overview?
  
  private Text text;              
  private int overviewInterface;  //0: Starting screen | 1: Stats | 2: Inventory | 3: Map | 4: Quests | 5: "Are you sure you want to exit game?"
  
  public Overview ()
  {
    text = new Text();
    overviewInterface = 0;
  }
  
  public void display()
  {
    //The box at the bottom of the screen
    strokeWeight(10);
    stroke(255);
    fill(0);
    rect(0, 294, 1090, 100);
    noStroke();
    
    switch (overviewInterface)
    {
      //Starting screen
      case 0:
        break;
      //Stats
      case 1:
        break;
      //Inventory
      case 2:
        break;
      //Map
      case 3:
        break;
      //Quests
      case 4:
        break;
      //"Are you sure you want to exit game"
      case 5:
        background(#000000);
        fill(#FF0000);
        text("Are you sure you want to exit the game?\nAny unsaved progress will be lost.", 0, -200);
        break;
    }
    
    p.getCurrentBl().display();
  }
  
  public int getOverviewInterface()
  {
    return overviewInterface;
  }
  
  public void setOverviewInterface(int overviewInterface)
  {
    this.overviewInterface = overviewInterface;
  }
  
  
  //Stats (health, mana, gold, etc)
  //Map
  //Inventory
  //Quests
  //Exit
}

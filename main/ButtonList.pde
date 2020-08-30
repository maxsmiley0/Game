public class ButtonList
{
  private ArrayList<Button> li;
  private int currentButton;
  private int maxButtons;
  private boolean expandVert;
  
  public ButtonList(String[] tags, boolean displayButton,  PVector firstButtonPos, PVector dimensions, int maxButtons, int buttonSpacing, boolean expandVert)        
  {
    //Exits if invalid maxButtons argument
    if (maxButtons < 1)
    {
      println("Invalid maxButtons parameter in ButtonList.pde");
      exit();
    }
    //Exits if invalid tags argument
    else if (tags.length < maxButtons)
    {
      println("Passing a string array of size less than allocated buttons in ButtonList.pde");
      exit();
    }
    
    li = new ArrayList<Button>();
    currentButton = 0;
    this.maxButtons = maxButtons;
    this.expandVert = expandVert;
    
    //Inserting the buttons into the button list
    for (int i = 0; i < maxButtons; i++)
    {
      //If "expandVert" is true, the buttons will be expanded parallel to the Y axis, spaced out a distance "buttonSpacing"
      if (expandVert)
      {
        Button b = new Button(tags[i], displayButton, new PVector(firstButtonPos.x, firstButtonPos.y + i*buttonSpacing), dimensions);
        li.add(b);
      }
      //If "expandVert" is false, the buttons will be expanded parallel to the X axis, spaced out a distance "buttonSpacing"
      else 
      {
        Button b = new Button(tags[i], displayButton, new PVector(firstButtonPos.x + i*buttonSpacing, firstButtonPos.y), dimensions);
        li.add(b);
      }
      //The first button in a button list starts out selected
    }
    li.get(0).press();
  }
  
  public ButtonList()  //"Empty" ButtonList, used as a blocker so Player can't move
  {
    li = new ArrayList<Button>();
    li.add(new Button("", false, new PVector(0, 0), new PVector(0, 0)));
    currentButton = 0;
    maxButtons = 1;
  }
  
  public void display()
  {
    for (int i = 0; i < maxButtons; i++)
    {
      //Simply calls each button in the ButtonList to display
      li.get(i).display();
    }
  }
  
  public void changeButton(boolean next)  //If "next" is true, the button will be changed to the next button, as opposed to the previous
  {
    if (next)
    {
      //Assuming the current selected button is not the last one
      if (currentButton < maxButtons - 1)
      {
        //Deselecting current one and selecting next one
        li.get(currentButton).press();
        currentButton++;
        li.get(currentButton).press();
      }
      //If it is, we simply wrap around back to the front
      else 
      {
        //Deselecting current one and selecting first one
        li.get(currentButton).press();
        currentButton = 0;
        li.get(currentButton).press();
      }
    }
    else 
    {
      //Assuming the current selected button is not the first one
      if (currentButton > 0)
      {
        //Deselecting current one and selecting previous one
        li.get(currentButton).press();
        currentButton--;
        li.get(currentButton).press();
      }
      //If it is, we simply skip towards the end of the list
      else 
      {
        //Deselecting current one and selecting last one
        li.get(currentButton).press();
        currentButton = maxButtons - 1;
        li.get(currentButton).press();
      }
    }
  }
  
  public boolean isExpandedVert()
  {
    return expandVert;
  }
  
  public int getButton()
  {
    return currentButton;
  }
  
  public int getMaxButton()
  {
    return maxButtons;
  }
}

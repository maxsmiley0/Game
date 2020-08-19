public class Text 
{
  private float currentLetter;    //Keeps track of current last letter displayed
    
  public Text () 
  {
    currentLetter = 1;    
  }
  
  //displayPeriod is the total time it will take to display the text
  public void display(String text, PVector position, int displayPeriod)
  {
    //In the stage where we haven't yet displayed the whole text
    if (currentLetter < text.length())
    {
      //Engineered so currentLetter will equal text.length() at the end of displayPeriod seconds running at a certain frameRate
      float displayDifferential = (float)(text.length()) / (displayPeriod*frameRate);
      //Condition is the current letter (-1 since index starts at 0)
      switch(text.charAt((int)currentLetter - 1))
      {
        //Differences in the denominator because we want these characters to be paused upon
        case ',':
          currentLetter += displayDifferential/3;
          break;
        
        case '.':
        case '?':
        case '!':
          currentLetter += displayDifferential/6;
          break;
        
        default:
          currentLetter += displayDifferential;
          break;
      }
      //Displaying the partial string
      text(text.substring(0, (int)currentLetter), position.x, position.y);
    }
    else 
    {
      //If we want to display the whole text, don't bother calculating displayDifferential, simply display the whole string
      text(text, position.x, position.y);
    }
  }
  
  //Needs to be called when saying something new, so currentLetter is set back to 1
  public void reset()
  {
    currentLetter = 1;
  }
}

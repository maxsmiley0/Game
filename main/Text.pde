public class Text 
{
  private float currentLetter;    //Keeps track of current last letter displayed
  private boolean finished;
    
  public Text () 
  {
    currentLetter = 1;    
    finished = false;
  }
  
  //cps is the character per second of the display speed (higher -> faster)
  public void display(String text, PVector position, int cps)
  {
    //In the stage where we haven't yet displayed the whole text
    if (currentLetter < text.length())
    {
      //Engineered so after one second, "cps" characters will be displayed
      float displayDifferential = (float)(cps) / (frameRate);
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
      finished = true;
    }
  }
  
  //Returns true if text has finished "rolling", and is in its end state
  public boolean isFinished()
  {
    return finished;
  }
  
  //Needs to be called when saying something new, so currentLetter is set back to 1
  public void reset()
  {
    currentLetter = 1;
    finished = false;
  }
}

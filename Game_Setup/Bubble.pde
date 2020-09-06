public class Bubble
{
  private Text text;            //Text object, responsible for the "rolling text" effect
  private ButtonList bl;        //Will be pushed into the player buttonlist stack to signify player is interacting with someone/thing
                                //Perhaps later could also signify responses / choices?
  
  private String[] strings;     //Stores the strings to be displayed, will have "numSlides" objects
  private int displayCps;       //Stores the rate at which text will appear in characters per second
  
  private PVector position;     //Stores midpoint of text bubble
  private PVector dimensions;   //Stores dimensions
  
  private int currentSlide;     //Keeps track of which slide we are on
  private float sizeFactor;     //When the bubble first grows, keeps track of the ratio of current size to max size, where "1" represents full size
  
  public Bubble (String[] strings, int displayCps, PVector dimensions)
  {
    String temp[] = {""};
    bl = new ButtonList(temp, false, new PVector(0, 0), new PVector(0, 0), 1, 0, false);
    text = new Text();
    
    this.strings = strings;
    this.displayCps = displayCps;
    this.dimensions = dimensions;
    
    //Initialize to first string in strings
    currentSlide = 0;
    //The bubble starts out small
    sizeFactor = 0;
  }
  
  //Returns true if bubble is on its last slide
  public boolean atEnd()
  {
    return currentSlide == strings.length - 1;
  }
  
  public void display()
  {
    if (currentSlide == 0 && sizeFactor < .99)
    {
      //"Balooning" effect, modeled by a logistic differential equation
      sizeFactor += (1 - sizeFactor) / 20;
    }
    else 
    {
      //At a certain point, cease calculations and just display it as its original size
      sizeFactor = 1;
    }
    
    //Displaying the bubble rectangle
    noStroke();
    fill(#FFFFFF);
    rect(position.x, position.y, sizeFactor*dimensions.x, sizeFactor*dimensions.y);
    
    //Displaying the bubble text
    textSize(sizeFactor*20);
    fill(#000000);
    text.display(strings[currentSlide], position, displayCps);
  }
  
  public void nextSlide()
  {
    //We won't allow the Player to skip dialogue
    if (text.isFinished() && !atEnd())
    {
      text.reset();
      currentSlide++;
    }
  }
  
  public ButtonList getBl()
  {
    return bl;
  }
  
  public void reset()
  {
    //Resets the Bubble
    text.reset();
    sizeFactor = 0;
    currentSlide = 0;
  }
  
  public Text getText()
  {
    return text;
  }
  
  public void setPosition(PVector position)
  {
    this.position = position;
  }
  
  public PVector getDimensions()
  {
    return dimensions;
  }
}

//Other things about buttons:
/*
Know when display text is done so we can move on
Implement in key to swtich bubbles
How will we close out of bubbles? Probably something in NPC or Player
How will we integrate bubble as a current interface? can it act as a button list?
*/

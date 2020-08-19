public class Bubble
{
  private Text text;            //Text object, responsible for the "rolling text" effect
  
  private String[] strings;     //Stores the strings to be displayed, will have "numSlides" objects
  private int[] displayPeriods; //Stores period of each text slide, will have "numSlides" ints
  
  private PVector position;     //Stores midpoint of text bubble
  private PVector dimensions;   //Stores dimensions
  
  private int numSlides;        //Number of text slides
  private int currentSlide;     //Keeps track of which slide we are on
  private float sizeFactor;     //When the bubble first grows, keeps track of the ratio of current size to max size, where "1" represents full size
  
  public Bubble (String[] strings, int[] displayPeriods, PVector position, PVector dimensions, int numSlides)
  {
    //Class invariant: length of array of strings / ints must be specified the same as numSlides
    if (strings.length != numSlides || displayPeriods.length != numSlides)
    {
     println("Passing array of different size than numSlides in Bubble.pde"); 
     exit();
    }
    
    text = new Text();
    
    this.strings = strings;
    this.displayPeriods = displayPeriods;
    this.position = position;
    this.dimensions = dimensions;
    this.numSlides = numSlides;
    
    //Initialize to first string in strings
    currentSlide = 0;
    //The bubble starts out small
    sizeFactor = 0;
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
    text.display(strings[currentSlide], position, displayPeriods[currentSlide]);
  }
  
  public void nextSlide()
  {
    if (currentSlide == numSlides - 1)
    {
      //close out of bubble
    }
    else 
    {
      text.reset();
      currentSlide++;
    }
  }
  
  
  //is it first slide or not?
}

//Other things about buttons:
/*
Know when display text is done so we can move on
Implement in key to swtich bubbles
How will we close out of bubbles? Probably something in NPC or Player
How will we integrate bubble as a current interface? can it act as a button list?
*/

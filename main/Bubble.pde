public class Bubble
{
  private Text text;            //Text object, responsible for the "rolling text" effect
  
  private String[] strings;     //Stores the strings to be displayed, will have "numSlides" objects
  private int[] displayPeriods; //Stores period of each text slide, will have "numSlides" ints
  
  private PVector position;     //Stores midpoint of text bubble
  private PVector dimensions;   //Stores dimensions
  
  private int numSlides;        //Number if text slides
  private int currentSlide;     //Keeps track of which slide we are on
  
  public Bubble (String[] strings, int[] displayPeriods, PVector position, PVector dimensions, int numSlides)
  {
    text = new Text();
    
    this.strings = strings;
    this.displayPeriods = displayPeriods;
    this.position = position;
    this.dimensions = dimensions;
    this.numSlides = numSlides;
    //Initialize to first string in strings
    currentSlide = 0;
  }
  
  public void display()
  {
    if (currentSlide == 0)
    {
      //here we do the cool bubble effect
    }
    else 
    {
      
    }
    text.display(strings[currentSlide], position, displayPeriods[currentSlide]);
  }
  
  public void nextSlide()
  {
    if (true)
    {
      //if close to the end, exit out of the bubble
    }
    else 
    {
      text.reset();
      currentSlide++;
    }
  }
  
  
  //is it first slide or not?
}

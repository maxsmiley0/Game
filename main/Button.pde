public class Button
{
  private boolean selected;    //True or false if the button is selected
  private PVector position;    //Stores x and y coordinate of midpoint of button 
  private PVector dimensions;  //Stores width and height data of dimensions of button
  
  public Button(boolean selected, PVector position, PVector dimensions)
  {
    this.selected = selected;
    this.position = position;
    this.dimensions = dimensions;
  }
  
  public void display()        //To be called when we want to see the buttons
  {
    if (selected)              //If the button is selected, we want it to be shinier
    {
      fill(255, 0, 0);         //Fill golden
      strokeWeight(10);        //Thick edges of selected box
    }
    else                       //Case not selected
    {
      fill(0, 0, 0);           //Dull coloring
      strokeWeight(1);         //Thin edges of deselected box
    }
    
    rect(position.x, position.y, dimensions.x, dimensions.y);
  }
  
  public void press()
  {
    selected = !selected;      //Reverses the "selected" status of the button
  }
  
  public boolean isSelected()
  {
    return selected;           //Simple accessor
  }
}
  

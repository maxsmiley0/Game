public class Button
{
  private boolean displayButton;//True or false if we want the button to display a box around the text
  private boolean selected;     //True or false if the button is selected

  private PVector position;     //Stores x and y coordinate of midpoint of button 
  private PVector dimensions;   //Stores width and height data of dimensions of button

  private String tag;           //Stores what the button will display

  public Button(String tag, boolean displayButton, PVector position, PVector dimensions)
  {
    selected = false;

    this.tag = tag;
    this.displayButton = displayButton;
    this.position = position;
    this.dimensions = dimensions;
  }

  public void display()        //To be called when we want to see the buttons / tags
  { 
    if (displayButton)         //If we want to see the button's "border"
    {
      fill(#000000);           //Drawing the border
      if (selected)            //If the button is selected, we want it to have a golden, thick border
      {
        fill(#C6B323);
        stroke(#FF4500);          
        strokeWeight(5);        
      } 
      else                     //If the button is not selected, we want it to have a black, thin border
      {
        stroke(#FFFFFF);           
        strokeWeight(1);         
      }
      rect(position.x, position.y, dimensions.x, dimensions.y);
      fill(#FFFFFF);
    } 
    else                       //If we don't want to see the button's "border"
    {
      if (selected)            //If the button is selected, we want the text to have a nice purple sheen
      {
        fill(#BC145A);
      } 
      else                     //If the button is not selected, we want the text to be plain white
      {
        fill(#FFFFFF);           
      }
    }

    textSize(30);              //Writing out the text
    text(tag, position.x, position.y);
  }

  public void press()
  {
    selected = !selected;      //Reverses the "selected" status of the button
    
    //not a fundamental part of button - extension
    if (shop.getShopInterface() == 1 || shop.getShopInterface() == 2)  //Resets the description if a player is switching between items in the buy section of shop
    {
      shop.getText().reset();
    }
  }

  public boolean isSelected()
  {
    return selected;           //Simple accessor
  }
}

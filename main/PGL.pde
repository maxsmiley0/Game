/* Processing Graphics Library*/
public class PGL
{
  private PVector pBackground;
  private boolean redUp;
  private boolean greenUp;
  private boolean blueUp;
  
  private int uBound;
  private int lBound;
  
  public PGL () 
  {
    pBackground = new PVector(160, 160, 160);
    
    uBound = 200;
    lBound = 120;
    
    redUp = false;
    greenUp = false;
    blueUp = false;
  }
  
  public void rainbowBackground()
  {
    background(pBackground.x, pBackground.y, pBackground.z);
    
    if (pBackground.x > uBound)
    {
      redUp = false;
    }
    else if (pBackground.x < lBound)
    {
      redUp = true;
    }
    if (pBackground.y > uBound)
    {
      greenUp = false;
    }
    else if (pBackground.y < lBound)
    {
      greenUp = true;
    }
    if (pBackground.z > uBound)
    {
      blueUp = false;
    }
    else if (pBackground.z < lBound)
    {
      blueUp = true;
    }
    
    if (redUp)
    {
      pBackground.x++;
    }
    else 
    {
      pBackground.x--;
    }
    
    if (greenUp)
    {
      pBackground.y += 2;
    }
    else 
    {
      pBackground.y -= 2;
    }
    
    if (blueUp)
    {
      pBackground.z += 3;
    }
    else 
    {
      pBackground.z -= 3;
    }
  }
}

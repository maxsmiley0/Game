public class Quest
{
  private ButtonList bl;
  private Bubble b;
  //a bubble should just have a buttonlist actually...
  public Quest(Bubble b)
  {
    String temp[] = {""};
    
    this.b = b;
    bl = new ButtonList(temp, false, new PVector(0, 0), new PVector(0, 0), 1, 0, false);
  }
}

//A quest will have:
/*
A buttonlist (to be pushed onto player BL so he can't move)
A bubble of text dialogue
*/

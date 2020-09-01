public class Battle
{
  private Room battleRoom;      //Room that the battle takes place in, should have dimensions equal to width x height
  private Fighter enemy;        //Enemy
  private PGL graphics;
  
  int battleInterface;          // 0: Starting screen | 1: Choosing attack | 2: Using item | 3: Talk | 4: Enemy turn 
  
  public Battle(Room battleRoom, Fighter enemy)
  {
    battleInterface = 0;
    
    graphics = new PGL();
    
    this.battleRoom = battleRoom;
    this.enemy = enemy;
  }
  
  public void display()
  {
    graphics.rainbowBackground();
    battleRoom.display();
    
    enemy.display(new PVector(300, -120));
    image(friskRestRight, -300, 160);
    
    fill(#000000);
    stroke(#FFFFFF);
    strokeWeight(10);
    rect(-225, -200, 642, 292);
    
    p.getCurrentBl().display();
  }
}

//What does a Battle have?

/*
Player (don't need to define that)
NPC(s) (don't need to define that)
-Both should have an arraylist of "moves"
-A move has a: 
  Name
  Description
  Damage
  Effect
  Sound
  Animation

Battle has:
  members:
    battleInterface (0 -> starting, 1 -> attacking, etc)
  
  methods:
    display fnct
*/

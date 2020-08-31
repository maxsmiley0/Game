public class Battle
{
  Room room;
  ArrayList<NPC> enemies;
  
  int r, g, b;
  boolean ru, gu, bu;
  
  int ubound = 200;
  int lbound = 120;
  
  public Battle(Room room, ArrayList<NPC> enemies)
  {
    r = 0;
    g = 0;
    b = 0;
    
    ru = true;
    gu = true;
    bu = true;
    
    this.room = room;
    this.enemies = enemies;
  }
  
  public void display()
  {
    room.display();
    
    if (r > ubound)
    {
      ru = false;
    }
    else if (r < lbound)
    {
      ru = true;
    }
    if (g > ubound)
    {
      gu = false;
    }
    else if (g < lbound)
    {
      gu = true;
    }
    if (b > ubound)
    {
      bu = false;
    }
    else if (b < lbound)
    {
      bu = true;
    }
    
    if (ru)
    {
      r++;
    }
    else 
    {
      r--;
    }
    
    if (gu)
    {
      g+=2;
    }
    else 
    {
      g-=2;
    }
    
    if (bu)
    {
      b+=3;
    }
    else 
    {
      b-=3;
    }
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

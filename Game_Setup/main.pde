void draw()
{
  pushMatrix();
  
  translate(width/2, height/2);
  background(#CCCCCC);
  
  if (p.isInShop())
  {
    p.getShop().display();
  }
  else if (p.isInBattle())
  {
    p.getBattle().display();
    
    fill(#000000);
    stroke(#FFFFFF);
    strokeWeight(10);
    //rect(mouseX - width/2, mouseY - height/2, w, h);
    fill(#FFFFFF);
    //text("x: " + (mouseX - width/2), mouseX - width/2, mouseY - height/2);
    //text("y: " + (mouseY - height/2), mouseX - width/2, mouseY + 20 - height/2);
    //text("w: " + w, mouseX - width/2, mouseY + 40 - height/2);
    //text("h: " + h, mouseX - width/2, mouseY + 60 - height/2);
    
    text("x: " + p.getPosition().x, mouseX - width/2, mouseY - height/2);
    text("y: " + p.getPosition().y, mouseX - width/2, mouseY + 20 - height/2);
    text("x spawn: " + friskRoom.getSpawnpoint().x, mouseX - width/2, mouseY + 40 - height/2);
    text("y spawn: " + friskRoom.getSpawnpoint().y, mouseX - width/2, mouseY + 60 - height/2);
    
    if (mousePressed)
    {
      if (mouseButton == LEFT)
      {
        w++;
      }
      else 
      {
        h++;
      }
    }
  }
  else
  {
    p.implementArrowKeys();
    p.displayRoom();
    p.display();
    p.getCamera().display();
    p.getCamera().displayGrid();
    
    fill(#FFFFFF);
    noStroke();
    //rect(mouseX - width/2, mouseY - height/2, w, h);
    fill(#FF0000);
    //text("x: " + p.getPosition().x, mouseX - width/2, mouseY - height/2);
    //text("y: " + p.getPosition().y, mouseX - width/2, mouseY + 20 - height/2);
    //text("x spawn: " + p.getRoom().getSpawnpoint().x, mouseX - width/2, mouseY + 40 - height/2);
    //text("y spawn: " + p.getRoom().getSpawnpoint().y, mouseX - width/2, mouseY + 60 - height/2);
    
    if (mousePressed)
    {
      if (mouseButton == LEFT)
      {
        w++;
      }
      else 
      {
        h++;
      }
    }
  }
  
  popMatrix();
  
  fill(255);
}

void loop(AudioPlayer a, int offset) {          //loops a sound effect as long as loop() is in a draw function
  a.play();
  if (a.position() >= a.length() - offset) {     //offset = number of miliseconds the soundbyte will cut off. used for soundbytes with extra silence after
    a.rewind();                                //rewinds the soundbyte
  }
}

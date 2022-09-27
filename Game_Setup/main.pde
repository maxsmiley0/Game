//Dev Tools
boolean displayGrid = false;
boolean displayNPCs = false;
boolean displayStructs = false;
boolean displayPortals = false;

void draw()
{
  Player player = gameController.getPlayer();
  
  pushMatrix();
  
  translate(width/2, height/2);
  background(#CCCCCC);
  
  if (player.isInShop())
  {
    player.getShop().display();
  }
  else if (player.isInBattle())
  {
    player.getBattle().display();
    
    fill(#000000);
    stroke(#FFFFFF);
    strokeWeight(10);
    //rect(mouseX - width/2, mouseY - height/2, w, h);
    fill(#FFFFFF);
    //text("x: " + (mouseX - width/2), mouseX - width/2, mouseY - height/2);
    //text("y: " + (mouseY - height/2), mouseX - width/2, mouseY + 20 - height/2);
    //text("w: " + w, mouseX - width/2, mouseY + 40 - height/2);
    //text("h: " + h, mouseX - width/2, mouseY + 60 - height/2);
    
    text("x: " + player.getPosition().x, mouseX - width/2, mouseY - height/2);
    text("y: " + player.getPosition().y, mouseX - width/2, mouseY + 20 - height/2);
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
    executeRigidBodyController(player.getRoom());
    player.implementArrowKeys();
    player.displayRoom();
    player.display();
    player.getCamera().display();
    if (displayGrid)
    {
      player.getCamera().displayGrid();
    }
    
    fill(#FFFFFF);
    noStroke();
    //rect(mouseX - width/2, mouseY - height/2, w, h);
    fill(#FF0000);
    //text("x: " + player.getPosition().x, mouseX - width/2, mouseY - height/2);
    //text("y: " + player.getPosition().y, mouseX - width/2, mouseY + 20 - height/2);
    //text("x spawn: " + player.getRoom().getSpawnpoint().x, mouseX - width/2, mouseY + 40 - height/2);
    //text("y spawn: " + player.getRoom().getSpawnpoint().y, mouseX - width/2, mouseY + 60 - height/2);
    
    if (mousePressed)
    {
      println("X: " + mouseX);
      println("Y: " + mouseY);
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

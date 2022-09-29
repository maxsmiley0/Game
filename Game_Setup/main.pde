//Dev Tools
boolean displayGrid = false;
boolean displayNPCs = false;
boolean displayStructs = false;
boolean displayPortals = false;

void draw()
{
  gameController.runGame();
  println(gameController.gameState);
}

void loop(AudioPlayer a, int offset) {          //loops a sound effect as long as loop() is in a draw function
  a.play();
  if (a.position() >= a.length() - offset) {     //offset = number of miliseconds the soundbyte will cut off. used for soundbytes with extra silence after
    a.rewind();                                //rewinds the soundbyte
  }
}

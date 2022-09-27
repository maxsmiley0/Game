//Later add SoundSystem object
enum GameState {idle, moving, interacting, roomTransition, overview, shop, battle};

class GameController {
  private GameState gameState;
  private Camera camera;
  private Player player;
  
  public GameController() {
    gameState = GameState.idle;
    camera = new Camera();
    player = new Player(new PVector(0, 0));
  }
  
  public Player getPlayer() {
    return player; 
  }
  
  public Camera getCamera() {
    return camera;
  }
  
  public void runGame() {
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
};

public void keyPressed()
{ 
  Player player = gameController.getPlayer();
  GameObject interactor = player.getInteractor();
  if (player.getBlStack().empty())  //No interactions
  {
    if (key == 'c')  //Opening up character interface
    {
      player.resetKeys();
      player.stopMoving();
      player.setInOverview(true);
      ButtonList bl = new ButtonList(new String[]{"Stats","Inventory","Map","Quests","Back","Exit Game"}, false, new PVector(-450, 294), new PVector(0, 0), 175, false);
      player.getBlStack().push(bl);
    }
    if (key == 'x' && interactor != null)  //If we have someone to interact with
    {
      player.resetKeys();
      if (interactor instanceof NPC && ((NPC)interactor).isShopkeeper())
      {
        player.enterShop();
        AudioPlayer sound = player.getRoom().getSound();
        if (sound != null)  //kill music on shop enter
        {
          sound.setGain(sound.getGain() - 50);
          sound.pause();
          sound.rewind();
        }
      }
      else if (interactor instanceof NPC && ((NPC)interactor).isEnemy())
      {
        player.enterBattle();
      }
      else {
          Bubble interactorBubble = interactor.getBubble();
          if (interactor instanceof Struct) {
            interactorBubble.setPosition(new PVector(player.getPosition().x, player.getPosition().y - interactorBubble.getDimensions().y / 2 - player.getDimensions().y / 2));
          }
          else if (interactor instanceof NPC) {
            interactorBubble.setPosition(new PVector(interactor.getPosition().x, interactor.getPosition().y - interactorBubble.getDimensions().y/2 - interactor.getDimensions().y/2));
          }
          //interactorBubble.setPosition(new PVector(player.getPosition().x, player.getPosition().y - interactorBubble.getDimensions().y/2 - player.getDimensions().y/2));
          player.setBubble(interactorBubble);
          player.getBlStack().add(interactor.getBubble().getBl());
          player.stopMoving();
      }
    }
    
    if (keyCode == LEFT)
    {
      player.startMoving();     //Display animation
      player.setKey(1, false);  //Move left is true
      player.setKey(3, true);   //Move right is false
    }
    else if (keyCode == RIGHT)
    {
      player.startMoving();     //Display animation
      player.setKey(1, true);   //Move left is false
      player.setKey(3, false);  //Move right is true
    }
    if (keyCode == UP)
    {
      player.startMoving();     //Display animation
      player.setKey(0, true);   //Move up is true
      player.setKey(2, false);  //Move down is false
    }
    else if (keyCode == DOWN)
    {
      player.startMoving();     //Display animation
      player.setKey(0, false);  //Move up is false
      player.setKey(2, true);   //Move down is true
    }
  }
  else 
  {
    if (player.getCurrentBl().isExpandedVert())    //If the button list is expanded vertically
    {
      if (keyCode == UP)                      //Up and down will change the button, while left and right will do nothing
      {
        player.getCurrentBl().changeButton(false);
      }
      else if (keyCode == DOWN)
      {
        player.getCurrentBl().changeButton(true);
      }
    }
    else                                       //Case: horizontal expansion
    {
      if (keyCode == LEFT)                     //Left and right will change the button, while up and down will do nothing
      {
        player.getCurrentBl().changeButton(false);
      }
      else if (keyCode == RIGHT)
      {
        player.getCurrentBl().changeButton(true);
      }
    }
    
    //CASE PLAYER IS IN SHOP
    if (player.isInShop() && key == 'x')
    {
      executeShopController();
    }
    
    //CASE PLAYER IS IN OVERVIEW
    if (player.inOverview() && key == 'x')
    {
      executeOverviewController();
    }
    
    if (player.isInBattle() && key == 'x')
    {
      executeBattleController();
    }
  }
  
  //If not in shop or battle, this progresses the Bubble
  if (key == 'x' && interactor != null)
    {
      if (!interactor.getBubble().atEnd())
      {
        interactor.getBubble().nextSlide();
      }
      else 
      {
        //needs to make sure we are at the end
        if (interactor.getBubble().getText().isFinished())
        {
          //Stops displaying, resets bubble, and pops BL off stack
          player.setBubble(null);
          interactor.getBubble().reset();
          player.getBlStack().pop();
        }
      }
    }
}

public void keyReleased()
{
  Player player = gameController.getPlayer();
  if (player.getBlStack().empty())
  {
    player.stopMoving();       //Display still instead of animation
    if (keyCode == LEFT)
    {
      player.setKey(3, false);
    }
    if (keyCode == RIGHT)
    {
      player.setKey(1, false);
    }
    if (keyCode == UP)
    {
      player.setKey(0, false);
    }
    if (keyCode == DOWN)
    {
      player.setKey(2, false);
    }
  }
}

public void executeBattleController()
{
  Player player = gameController.getPlayer();
  
  switch (player.getBattle().getBattleInterface())
  {
    case 0:
      switch (player.getCurrentBl().getButton())
      {
        case 0:
          player.getBattle().setBattleInterface(1);
          player.getBlStack().push(new ButtonList());
          break;
      }
      break;
  }
}

public void executeOverviewController()
{
  Player player = gameController.getPlayer();
  
  switch (player.getOverview().getOverviewInterface())
  {
    //In default screen
    case 0:
      switch (player.getCurrentBl().getButton())
      {
        //Pressing the "stats" button
        case 0:
          break;
        //Pressing the "inventory" button
        case 1:
          player.getOverview().setOverviewInterface(2);    //Sending to "inventory" interface
          
          //All this does is allocate an extra button to the buttonlist, one for "leave", in addition to the player inventory
          String inventoryInterface[] = new String[player.getInventory().size() + 1];
                
          for (int i = 0; i < player.getInventory().size(); i++)
          {
            inventoryInterface[i] = player.getInventory().get(i).getName();
          }
          inventoryInterface[player.getInventory().size()] = "Back";
          //End
                
          player.getBlStack().push(new ButtonList(inventoryInterface, false, new PVector(-200, 15), new PVector(150, 45), 25, true));
          break;
        //Pressing the "map" button
        case 2:
          break;
        //Pressing the "quests" button
        case 3:
          break;
        //Pressing the "back" button
        case 4:
          player.setInOverview(false);
          player.getBlStack().pop();
          break;
        //Pressing the "exit" button
        case 5:
          player.getOverview().setOverviewInterface(5);  //send to "are you sure you want to exit" interface
          player.getBlStack().push(new ButtonList(new String[]{"Yes","No"}, false, new PVector(0, 0), new PVector(0, 0), 50, true));
          break;
      }
      break;
    //In "stats" overview
    case 1:
      break;
    //In "inventory" overview
    case 2:
      if (player.getCurrentBl().getButton() == player.getInventory().size())  //Only exit if click "back"
      {
        player.getOverview().setOverviewInterface(0);
        player.getBlStack().pop();
      }
      break;
    //In "map" overview
    case 3:
      break;
    //In "quests" overview
    case 4:
      break;
    //In "are you sure you want to exit" overview
    case 5:
      if (player.getCurrentBl().getButton() == 0)  //If press yes, then exit
      {
        exit();
      }
      else 
      {
        player.getOverview().setOverviewInterface(0);  //If press no, send back to other interface
        player.getBlStack().pop();
      }
      break;
  }
}

public void executeShopController()
{
  Player player = gameController.getPlayer();
  
  switch (player.getShop().getShopInterface())
  {
    case 0:
      switch (player.getCurrentBl().getButton())
      {
      //IF IN MENU SCREEN AND PRESS "BUY"
      case 0:
        player.getShop().setShopInterface(1);    //go to buy interface
                
        //All this does is allocate an extra button to the buttonlist, one for "leave", in addition to the shop inventory
        String buyInterface[] = new String[player.getShop().getInventory().size() + 1];
                
        for (int i = 0; i < player.getShop().getInventory().size(); i++)
        {
          buyInterface[i] = player.getShop().getInventory().get(i).getName() + " - " + player.getShop().getInventory().get(i).getCost() + "G";
        }
        buyInterface[player.getShop().getInventory().size()] = "Back";
        //End
                
       player.getBlStack().push(new ButtonList(buyInterface, false, new PVector(-200, 120), new PVector(150, 45), 25, true));
       break;
     //IF IN MENU SCREEN AND PRESS "SELL"
     case 1:
       player.getShop().setShopInterface(2);    //go to sell interface
                
       //All this does is allocate an extra button to the buttonlist, one for "leave", in addition to the player inventory
       String sellInterface[] = new String[player.getInventory().size() + 1];
                
       for (int i = 0; i < player.getInventory().size(); i++)
       {
         sellInterface[i] = player.getInventory().get(i).getName() + " - " + 4 * player.getInventory().get(i).getCost() / 5 + "G";
       }
       sellInterface[player.getInventory().size()] = "Back";
       //End
                
       player.getBlStack().push(new ButtonList(sellInterface, false, new PVector(-200, 120), new PVector(150, 45), 25, true));
       break;
     //IF IN MENU SCREEN AND PRESS "TALK"
     case 2:
       player.getShop().setShopInterface(3);  //go to talk interface
                
       //All this does is allocate an extra button to the buttonlist, one for "leave", in addition to the the shop dialogues
       String shopInterface[] = new String[player.getShop().getDialogue().length + 1];
                
       for (int i = 0; i < player.getShop().getDialogue().length; i++)
       {
         shopInterface[i] = player.getShop().getDialogue()[i][0];
       }
       shopInterface[player.getShop().getDialogue().length] = "Back";
       //End
                
       player.getBlStack().push(new ButtonList(shopInterface, false, new PVector(-200, 120), new PVector(150, 45), 50, true));
       break;
     //IF IN MENY SCREEN AND PRESS "LEAVE"
     case 3:
       player.exitShop();  //leaves shop
       player.getShop().getText().getSound().pause();  //we don't want the shopkeeper to keep rambling on once we exit
       player.getShop().getBackgroundSong().pause();   //rewinding and pausing song when we exit shop
       player.getShop().getBackgroundSong().rewind();
       AudioPlayer sound = player.getRoom().getSound();
       if (sound != null)                         //bring back sound on exit shop
       {
         sound.setGain(sound.getGain() + 50);
         sound.pause();
         sound.rewind();
       }
       break;
     }
     break;
     
   //IN "BUY" SCREEN
   case 1:
     //If presses "leave"
     if (player.getCurrentBl().getButton() == player.getShop().getInventory().size())
     {
       player.getBlStack().pop();      //go back to shop menu
       player.getShop().setShopInterface(0);
     }
     else 
     {
       //CASE actually buy
       //Test for inventory space later on
       if (player.getShop().getInventory().get(player.getCurrentBl().getButton()).getCost() <= player.getGold())  //must have enough gold
       {
         player.getShop().setShopInterface(4);  //go to the "are you sure" buy screen
         player.getBlStack().push(new ButtonList(new String[]{"Yes","No"}, false, new PVector(350, 270), new PVector(150, 45), 25, true));
       }
       else 
       {
         //Error sound or "insufficient funds" message
       }
     }
     break;
   //In "sell" screen
   case 2:
     //If presses leave
     if (player.getCurrentBl().getButton() == player.getInventory().size())
     {
       player.getBlStack().pop();
       player.getShop().setShopInterface(0);
     }
     else 
     {
       //CASE actually sell
       player.getShop().setShopInterface(5);    //go to the "are you sure" sell screen
       player.getBlStack().push(new ButtonList(new String[]{"Yes","No"}, false, new PVector(350, 270), new PVector(150, 45), 25, true));
     }
     break;
   //In "talk" screen
   case 3:
     //If presses leave
     if (player.getCurrentBl().getButton() == player.getShop().getDialogue().length)
     {
       player.getBlStack().pop();
       player.getShop().setShopInterface(0);
     }
     else 
     {
       //CASE actually talk
       player.getShop().setShopInterface(6);    //sends to dialogue interface
       player.getBlStack().push(new ButtonList());
     }
     break;
   //In "are you sure you want to buy" screen
   case 4:
     //If presses yes
     if (player.getCurrentBl().getButton() == 0)
     {
       player.getInventory().add(player.getShop().getInventory().get(player.getPreviousBl().getButton()));      //adds item
       player.gainGold(-1 * player.getShop().getInventory().get(player.getPreviousBl().getButton()).getCost()); //subtracts cost from player balance
     }
     player.getBlStack().pop();
     player.getShop().setShopInterface(1);  //sends back to "buy" screen
     break;
   //In "are you sure you want to sell" screen
   case 5:
     //If presses yes
     if (player.getCurrentBl().getButton() == 0)
     {
       player.gainGold(4 * player.getInventory().get(player.getPreviousBl().getButton()).getCost() / 5);  //add gold to player balance (only 80% of initial worth)
       player.getInventory().remove(player.getInventory().get(player.getPreviousBl().getButton()));       //remove item from player inventory
     }
     player.getBlStack().pop();  //gets out of "are you sure you want to sell" BL, current is "sell choices" BL (associated with shopInterface = 2)
                
     //This reallocates the interface for displaying the player's current inventory, since the player may or may not have one less item than previously from selling it
     player.getBlStack().pop();  
                
     String sellInterface[] = new String[player.getInventory().size() + 1];
                
     for (int i = 0; i < player.getInventory().size(); i++)
     {
       sellInterface[i] = player.getInventory().get(i).getName() + " - " + 4 * player.getInventory().get(i).getCost() / 5 + "G";
     }
     sellInterface[player.getInventory().size()] = "Back";
     //End
                
     player.getBlStack().push(new ButtonList(sellInterface, false, new PVector(-200, 120), new PVector(150, 45), 25, true));
     player.getShop().setShopInterface(2);    //sends back to "sell" interface
     break;
   //Case in dialogue with the shopkeeper
   case 6:
     //Can only do anything if the text is fully displayed
     if (player.getShop().getText().isFinished())
     {
       if (player.getShop().currentSlide() == player.getShop().getDialogue()[player.getPreviousBl().getButton()].length - 1)
       {
         //case last slide
         player.getShop().setShopInterface(3);  //sends back to "talk" interface
         player.getShop().resetSlide();
         player.getShop().getText().reset();
         player.getBlStack().pop();
       }
       else 
       {
         //not last slide
         player.getShop().nextSlide();          //simply displays next slide
         player.getShop().getText().reset();
       }
     }
     break;
   }
}

//Controls Game State
void executeRigidBodyController(Room room) {
  Player player = gameController.getPlayer();
  
  for (GameObject gameObject : room.li) {
    /*
    Defining the borders of the rigidBody, with an extra term in relation to the player's dimensions
    This is so a player won't be stopped right at the border of the structure, i.e. half of the player's
    sprite won't be inside the rigidBody
    */
    if ((gameObject instanceof Struct && ((Struct)gameObject).hasRigidBody()) || gameObject instanceof NPC) {
      
      int leftBorder = (int)(gameObject.getPosition().x - (gameObject.getDimensions().x/2) - (player.getDimensions().x / 2));
      int rightBorder = (int)(gameObject.getPosition().x + (gameObject.getDimensions().x/2) + (player.getDimensions().x / 2));
      int topBorder = (int)(gameObject.getPosition().y - (gameObject.getDimensions().y/2) - (player.getDimensions().y/2));
      int bottomBorder = (int)(gameObject.getPosition().y + (gameObject.getDimensions().y/2) + (player.getDimensions().y/2));
      
      int offset = 10;     //Player's speed is tentatively 6, so 10 is okay
      
      //Applying an fixed impulse
      if (player.getPosition().x > leftBorder && player.getPosition().x < leftBorder + offset && player.getPosition().y > topBorder && player.getPosition().y < bottomBorder)
      {
        player.move(new PVector(-6, 0));  
      }
      
      if (player.getPosition().x > rightBorder - offset && player.getPosition().x < rightBorder && player.getPosition().y > topBorder && player.getPosition().y < bottomBorder)
      {
        player.move(new PVector(6, 0));
      }
      
      if (player.getPosition().x > leftBorder && player.getPosition().x < rightBorder && player.getPosition().y > topBorder && player.getPosition().y < topBorder + offset)
      {
        player.move(new PVector(0, -6));
      }
      
      if (player.getPosition().x > leftBorder && player.getPosition().x < rightBorder && player.getPosition().y > bottomBorder - offset && player.getPosition().y < bottomBorder)
      {
        player.move(new PVector(0, 6));
      }
    }
  }
}

public void executeAudioController() {
  /*
  Panning in and out of scenes
  "Hearing" the text roll out
  Shop / battle audio
  Ambient room noises
  
  States - 
  */
}

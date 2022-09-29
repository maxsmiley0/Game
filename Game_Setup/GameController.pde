//Later add SoundSystem object
enum GameState {vanilla, interacting, transition, overview, shop, battle};

class GameController {
  private GameState gameState;
  private Camera camera;
  private Player player;
  private Room room;
  private Overview overview;
  private Shop shop;
  private Battle battle;
  
  public GameController() {
    gameState = GameState.vanilla;
    camera = new Camera();
    player = new Player(new PVector(0, 0));
    overview = new Overview();
    shop = new Shop();
    //Going to have to manually load in a Room and Battle to access
  }
  
  public Player getPlayer() {
    return player; 
  }
  
  public Camera getCamera() {
    return camera;
  }
  
  public Room getRoom() {
    return room;
  }
  
  public void setRoom(Room room) {
    this.room = room;
    player.setPosition(room.getSpawnpoint());
  }
  
  public Overview getOverview() {
    return overview;
  }
  
  public void setOverview(Overview overview) {
    this.overview = overview;
  }
  
  public Shop getShop() {
    return shop; 
  }
  
  public void setShop(Shop shop) {
    this.shop = shop;
  }
  
  public Battle getBattle() {
    return battle;
  }
  
  public void setBattle(Battle battle) {
    this.battle = battle;
  }
  
  public void runGame() {
    pushMatrix();
  
    translate(width/2, height/2);
    background(#CCCCCC);
    
    //Maybe later have a separate graphicsController / audioController and call graphicsController.displayIdle / audioController.displayIdle / executeIdleStateController
    //Display: handles visuals
    //Controller: specifies state changes
    switch (gameState) {
      case vanilla:
        displayVanilla();
        executeVanillaStateController();
        break;
      case interacting:
        displayInteracting();
        executeInteractingStateController();
        break;
      case transition:
        displayTransition();
        executeTransitionStateController();
        break;
      case overview:
        displayOverview();
        executeOverviewStateController();
        break;
      case shop:
        displayShop();
        executeShopStateController();
        break;
      case battle:
        displayBattle();
        executeBattleStateController();
        break;
    }
    
    popMatrix();
  }
  
  private void displayVanilla() {
    room.display();
    player.display();
  }
  
  private void executeVanillaStateController() {
    executeRigidBodyController(room);
    player.implementArrowKeys();
    if (keyPressed) {
      GameObject interactor = player.getInteractor();
      if (key == 'x') {
        if (interactor != null)  //If we have someone to interact with
        {
          player.resetKeys();
          if (interactor instanceof NPC && ((NPC)interactor).isShopkeeper())
          {
            player.enterShop();
            AudioPlayer sound = room.getSound();
            if (sound != null)  //kill music on shop enter
            {
              sound.setGain(sound.getGain() - 50);
              sound.pause();
              sound.rewind();
            }
            gameState = GameState.shop;
            keyPressed = false;
          }
          else if (interactor instanceof NPC && ((NPC)interactor).isEnemy())
          {
            player.enterBattle();
            gameState = GameState.battle;
            keyPressed = false;
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
              gameState = GameState.interacting;
          }
        }
      }
      else if (key == 'c') {
        player.resetKeys();
        player.stopMoving();
        gameState = GameState.overview;
        ButtonList bl = new ButtonList(new String[]{"Stats","Inventory","Map","Quests","Back","Exit Game"}, false, new PVector(-450, 294), new PVector(0, 0), 175, false);
        player.getBlStack().push(bl);
      }
    }
    Portal portal = player.getPortal();
    if (portal != null) {
      gameState = GameState.transition;
      char spawn = portal.getSpawn();
      switch (spawn)
      {
        case 'u':
          room.setSpawnpoint(new PVector(portal.getPosition().x, portal.getPosition().y - portal.getDimensions().y / 2 - player.getImage().height / 2 - 10));
          break;
        case 'd':
          room.setSpawnpoint(new PVector(portal.getPosition().x, portal.getPosition().y + portal.getDimensions().y / 2 + player.getImage().height / 2 + 10));
          break;
        case 'l':
          room.setSpawnpoint(new PVector(portal.getPosition().x - portal.getDimensions().x / 2 - player.getImage().width / 2 - 10, portal.getPosition().y));
          break;
        case 'r':
          room.setSpawnpoint(new PVector(portal.getPosition().x + portal.getDimensions().x / 2 + player.getImage().width / 2 + 10, portal.getPosition().y));
          break;
      }
      camera.panTo(portal.getRoom());  //fades out, switches rooms to room spawnpoint, fades in
    }
  }
  
  private void displayInteracting() {
    room.display();
    player.display();
  }
  
  private void executeInteractingStateController() {
    if (keyPressed && key == 'x')
    {
      if (!player.getBubble().atEnd())
      {
        player.getBubble().nextSlide();
      }
      else 
      {
        //needs to make sure we are at the end
        if (player.getBubble().getText().isFinished())
        {
          player.getBubble().reset();
          //Stops displaying, resets bubble, and pops BL off stack
          player.setBubble(null);
          player.getBlStack().pop();
          keyPressed = false;
          gameState = GameState.vanilla;
        }
      }
    }
  }
  
  private void displayOverview() {
    room.display();
    player.display();
    overview.display();
  }
  
  private void executeOverviewStateController() {
    if (keyPressed && key == 'x') {
      switch (overview.getOverviewInterface())
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
              overview.setOverviewInterface(2);    //Sending to "inventory" interface
              
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
              player.getBlStack().pop();
              gameState = GameState.vanilla;
              break;
            //Pressing the "exit" button
            case 5:
              overview.setOverviewInterface(5);  //send to "are you sure you want to exit" interface
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
            overview.setOverviewInterface(0);
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
            overview.setOverviewInterface(0);  //If press no, send back to other interface
            player.getBlStack().pop();
          }
          break;
      }
      keyPressed = false;
    }
  }
  
  private void displayTransition() {
    room.display();
    player.display();
    camera.display();
  }
  
  private void executeTransitionStateController() {
    if (!camera.inTransition()) {
      gameState = GameState.vanilla;
    }
  }
  
  private void displayShop() {
    shop.display();
  }
  
  private void executeShopStateController() {
    if (keyPressed && key == 'x') {
      switch (shop.getShopInterface())
      {
        case 0:
          switch (player.getCurrentBl().getButton())
          {
            //IF IN MENU SCREEN AND PRESS "BUY"
            case 0:
              shop.setShopInterface(1);    //go to buy interface
                      
              //All this does is allocate an extra button to the buttonlist, one for "leave", in addition to the shop inventory
              String buyInterface[] = new String[shop.getInventory().size() + 1];
                      
              for (int i = 0; i < shop.getInventory().size(); i++)
              {
                buyInterface[i] = shop.getInventory().get(i).getName() + " - " + shop.getInventory().get(i).getCost() + "G";
              }
              buyInterface[shop.getInventory().size()] = "Back";
              //End
                      
             player.getBlStack().push(new ButtonList(buyInterface, false, new PVector(-200, 120), new PVector(150, 45), 25, true));
             break;
           //IF IN MENU SCREEN AND PRESS "SELL"
           case 1:
             shop.setShopInterface(2);    //go to sell interface
                      
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
             shop.setShopInterface(3);  //go to talk interface
                      
             //All this does is allocate an extra button to the buttonlist, one for "leave", in addition to the the shop dialogues
             String shopInterface[] = new String[shop.getDialogue().length + 1];
                      
             for (int i = 0; i < shop.getDialogue().length; i++)
             {
               shopInterface[i] = shop.getDialogue()[i][0];
             }
             shopInterface[shop.getDialogue().length] = "Back";
             //End
                      
             player.getBlStack().push(new ButtonList(shopInterface, false, new PVector(-200, 120), new PVector(150, 45), 50, true));
             break;
           //IF IN MENY SCREEN AND PRESS "LEAVE"
           case 3:
             player.exitShop();  //leaves shop
             shop.getText().getSound().pause();  //we don't want the shopkeeper to keep rambling on once we exit
             shop.getBackgroundSong().pause();   //rewinding and pausing song when we exit shop
             shop.getBackgroundSong().rewind();
             AudioPlayer sound = room.getSound();
             if (sound != null)                         //bring back sound on exit shop
             {
               sound.setGain(sound.getGain() + 50);
               sound.pause();
               sound.rewind();
             }
             gameState = GameState.vanilla;
             break;
           }
           break;
         
         //IN "BUY" SCREEN
         case 1:
           //If presses "leave"
           if (player.getCurrentBl().getButton() == shop.getInventory().size())
           {
             player.getBlStack().pop();      //go back to shop menu
             shop.setShopInterface(0);
           }
           else 
           {
             //CASE actually buy
             //Test for inventory space later on
             if (shop.getInventory().get(player.getCurrentBl().getButton()).getCost() <= player.getGold())  //must have enough gold
             {
               shop.setShopInterface(4);  //go to the "are you sure" buy screen
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
             shop.setShopInterface(0);
           }
           else 
           {
             //CASE actually sell
             shop.setShopInterface(5);    //go to the "are you sure" sell screen
             player.getBlStack().push(new ButtonList(new String[]{"Yes","No"}, false, new PVector(350, 270), new PVector(150, 45), 25, true));
           }
           break;
         //In "talk" screen
         case 3:
           //If presses leave
           if (player.getCurrentBl().getButton() == shop.getDialogue().length)
           {
             player.getBlStack().pop();
             shop.setShopInterface(0);
           }
           else 
           {
             //CASE actually talk
             shop.setShopInterface(6);    //sends to dialogue interface
             player.getBlStack().push(new ButtonList());
           }
           break;
         //In "are you sure you want to buy" screen
         case 4:
           //If presses yes
           if (player.getCurrentBl().getButton() == 0)
           {
             player.getInventory().add(shop.getInventory().get(player.getPreviousBl().getButton()));      //adds item
             player.gainGold(-1 * shop.getInventory().get(player.getPreviousBl().getButton()).getCost()); //subtracts cost from player balance
           }
           player.getBlStack().pop();
           shop.setShopInterface(1);  //sends back to "buy" screen
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
           shop.setShopInterface(2);    //sends back to "sell" interface
           break;
         //Case in dialogue with the shopkeeper
         case 6:
           //Can only do anything if the text is fully displayed
           if (shop.getText().isFinished())
           {
             if (shop.currentSlide() == shop.getDialogue()[player.getPreviousBl().getButton()].length - 1)
             {
               //case last slide
               shop.setShopInterface(3);  //sends back to "talk" interface
               shop.resetSlide();
               shop.getText().reset();
               player.getBlStack().pop();
             }
             else 
             {
               //not last slide
               shop.nextSlide();          //simply displays next slide
               shop.getText().reset();
             }
           }
           break;
      }
      keyPressed = false;
    }
  }
  
  private void displayBattle() {
    battle.display();
  }
  
  private void executeBattleStateController() {
    if (keyPressed && key == 'x') {
      switch (battle.getBattleInterface())
      {
        case 0:
          switch (player.getCurrentBl().getButton())
          {
            case 0:
              battle.setBattleInterface(1);
              player.getBlStack().push(new ButtonList());
              break;
          }
          break;
      }
      keyPressed = false;
    }
  }
};

public void keyPressed()
{ 
  Player player = gameController.getPlayer();
  if (player.getBlStack().empty())  //No interactions
  {
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

//Controls Game State
void executeRigidBodyController(Room room) {
  Player player = gameController.getPlayer();
  
  for (GameObject gameObject : room.getGameObjects()) {
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

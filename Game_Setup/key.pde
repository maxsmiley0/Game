public void keyPressed()
{ 
  if (p.getBlStack().empty())  //No interactions
  {
    if (key == 'c')  //Opening up character interface
    {
      p.resetKeys();
      p.stopMoving();
      p.setInOverview(true);
      ButtonList bl = new ButtonList(new String[]{"Stats","Inventory","Map","Quests","Back","Exit Game"}, false, new PVector(-450, 294), new PVector(0, 0), 175, false);
      p.getBlStack().push(bl);
    }
    
    if (key == 'x' && p.getInteractor() != null)  //If we have someone to interact with
    {
      p.getInteractor().setInteract(true);
      p.resetKeys();
      if (p.getInteractor() instanceof NPC && ((NPC)p.getInteractor()).isShopkeeper())
      {
        p.enterShop();
      }
      else if (p.getInteractor() instanceof NPC && ((NPC)p.getInteractor()).isEnemy())
      {
        p.enterBattle();
      }
    }
    
    if (keyCode == LEFT)
    {
      p.startMoving();     //Display animation
      p.setKey(1, false);  //Move left is true
      p.setKey(3, true);   //Move right is false
    }
    else if (keyCode == RIGHT)
    {
      p.startMoving();     //Display animation
      p.setKey(1, true);   //Move left is false
      p.setKey(3, false);  //Move right is true
    }
    if (keyCode == UP)
    {
      p.startMoving();     //Display animation
      p.setKey(0, true);   //Move up is true
      p.setKey(2, false);  //Move down is false
    }
    else if (keyCode == DOWN)
    {
      p.startMoving();     //Display animation
      p.setKey(0, false);  //Move up is false
      p.setKey(2, true);   //Move down is true
    }
  }
  else 
  {
    if (p.getCurrentBl().isExpandedVert())    //If the button list is expanded vertically
    {
      if (keyCode == UP)                      //Up and down will change the button, while left and right will do nothing
      {
        p.getCurrentBl().changeButton(false);
      }
      else if (keyCode == DOWN)
      {
        p.getCurrentBl().changeButton(true);
      }
    }
    else                                       //Case: horizontal expansion
    {
      if (keyCode == LEFT)                     //Left and right will change the button, while up and down will do nothing
      {
        p.getCurrentBl().changeButton(false);
      }
      else if (keyCode == RIGHT)
      {
        p.getCurrentBl().changeButton(true);
      }
    }
    
    //CASE PLAYER IS IN SHOP
    if (p.isInShop() && key == 'x')
    {
      implementShop();
    }
    
    //CASE PLAYER IS IN OVERVIEW
    if (p.inOverview() && key == 'x')
    {
      implementOverview();
    }
    
    if (p.isInBattle() && key == 'x')
    {
      implementBattle();
    }
  }
  
  //If not in shop or battle, this progresses the Bubble
  if (key == 'x' && p.getInteractor() != null)
    {
      if (!p.getInteractor().getBubble().atEnd())
      {
        p.getInteractor().getBubble().nextSlide();
      }
      else 
      {
        //needs to make sure we are at the end
        if (p.getInteractor().getBubble().getText().isFinished())
        {
          //Stops displaying, resets bubble, and pops BL off stack
          p.getInteractor().setInteract(false);
          p.getInteractor().getBubble().reset();
          p.getBlStack().pop();
        }
      }
    }
}

public void keyReleased()
{
  if (p.getBlStack().empty())
  {
    p.stopMoving();       //Display still instead of animation
    if (keyCode == LEFT)
    {
      p.setKey(3, false);
    }
    if (keyCode == RIGHT)
    {
      p.setKey(1, false);
    }
    if (keyCode == UP)
    {
      p.setKey(0, false);
    }
    if (keyCode == DOWN)
    {
      p.setKey(2, false);
    }
  }
}

public void implementBattle()
{
  switch (p.getBattle().getBattleInterface())
  {
    case 0:
      switch (p.getCurrentBl().getButton())
      {
        case 0:
          p.getBattle().setBattleInterface(1);
          p.getBlStack().push(new ButtonList());
          break;
      }
      break;
  }
}

public void implementOverview()
{
  switch (p.getOverview().getOverviewInterface())
  {
    //In default screen
    case 0:
      switch (p.getCurrentBl().getButton())
      {
        //Pressing the "stats" button
        case 0:
          break;
        //Pressing the "inventory" button
        case 1:
          p.getOverview().setOverviewInterface(2);    //Sending to "inventory" interface
          
          //All this does is allocate an extra button to the buttonlist, one for "leave", in addition to the player inventory
          String inventoryInterface[] = new String[p.getInventory().size() + 1];
                
          for (int i = 0; i < p.getInventory().size(); i++)
          {
            inventoryInterface[i] = p.getInventory().get(i).getName();
          }
          inventoryInterface[p.getInventory().size()] = "Back";
          //End
                
          p.getBlStack().push(new ButtonList(inventoryInterface, false, new PVector(-200, 15), new PVector(150, 45), 25, true));
          break;
        //Pressing the "map" button
        case 2:
          break;
        //Pressing the "quests" button
        case 3:
          break;
        //Pressing the "back" button
        case 4:
          p.setInOverview(false);
          p.getBlStack().pop();
          break;
        //Pressing the "exit" button
        case 5:
          p.getOverview().setOverviewInterface(5);  //send to "are you sure you want to exit" interface
          p.getBlStack().push(new ButtonList(new String[]{"Yes","No"}, false, new PVector(0, 0), new PVector(0, 0), 50, true));
          break;
      }
      break;
    //In "stats" overview
    case 1:
      break;
    //In "inventory" overview
    case 2:
      if (p.getCurrentBl().getButton() == p.getInventory().size())  //Only exit if click "back"
      {
        p.getOverview().setOverviewInterface(0);
        p.getBlStack().pop();
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
      if (p.getCurrentBl().getButton() == 0)  //If press yes, then exit
      {
        exit();
      }
      else 
      {
        p.getOverview().setOverviewInterface(0);  //If press no, send back to other interface
        p.getBlStack().pop();
      }
      break;
  }
}

public void implementShop()
{
  switch (p.getShop().getShopInterface())
  {
    case 0:
      switch (p.getCurrentBl().getButton())
      {
      //IF IN MENU SCREEN AND PRESS "BUY"
      case 0:
        p.getShop().setShopInterface(1);    //go to buy interface
                
        //All this does is allocate an extra button to the buttonlist, one for "leave", in addition to the shop inventory
        String buyInterface[] = new String[p.getShop().getInventory().size() + 1];
                
        for (int i = 0; i < p.getShop().getInventory().size(); i++)
        {
          buyInterface[i] = p.getShop().getInventory().get(i).getName() + " - " + p.getShop().getInventory().get(i).getCost() + "G";
        }
        buyInterface[p.getShop().getInventory().size()] = "Back";
        //End
                
       p.getBlStack().push(new ButtonList(buyInterface, false, new PVector(-200, 120), new PVector(150, 45), 25, true));
       break;
     //IF IN MENU SCREEN AND PRESS "SELL"
     case 1:
       p.getShop().setShopInterface(2);    //go to sell interface
                
       //All this does is allocate an extra button to the buttonlist, one for "leave", in addition to the player inventory
       String sellInterface[] = new String[p.getInventory().size() + 1];
                
       for (int i = 0; i < p.getInventory().size(); i++)
       {
         sellInterface[i] = p.getInventory().get(i).getName() + " - " + 4 * p.getInventory().get(i).getCost() / 5 + "G";
       }
       sellInterface[p.getInventory().size()] = "Back";
       //End
                
       p.getBlStack().push(new ButtonList(sellInterface, false, new PVector(-200, 120), new PVector(150, 45), 25, true));
       break;
     //IF IN MENU SCREEN AND PRESS "TALK"
     case 2:
       p.getShop().setShopInterface(3);  //go to talk interface
                
       //All this does is allocate an extra button to the buttonlist, one for "leave", in addition to the the shop dialogues
       String shopInterface[] = new String[p.getShop().getDialogue().length + 1];
                
       for (int i = 0; i < p.getShop().getDialogue().length; i++)
       {
         shopInterface[i] = p.getShop().getDialogue()[i][0];
       }
       shopInterface[p.getShop().getDialogue().length] = "Back";
       //End
                
       p.getBlStack().push(new ButtonList(shopInterface, false, new PVector(-200, 120), new PVector(150, 45), 50, true));
       break;
     //IF IN MENY SCREEN AND PRESS "LEAVE"
     case 3:
       p.exitShop();  //leaves shop
       p.getShop().getText().getSound().pause();  //we don't want the shopkeeper to keep rambling on once we exit
       p.getShop().getBackgroundSong().pause();   //rewinding and pausing song when we exit shop
       p.getShop().getBackgroundSong().rewind();
       break;
     }
     break;
     
   //IN "BUY" SCREEN
   case 1:
     //If presses "leave"
     if (p.getCurrentBl().getButton() == p.getShop().getInventory().size())
     {
       p.getBlStack().pop();      //go back to shop menu
       p.getShop().setShopInterface(0);
     }
     else 
     {
       //CASE actually buy
       //Test for inventory space later on
       if (p.getShop().getInventory().get(p.getCurrentBl().getButton()).getCost() <= p.getGold())  //must have enough gold
       {
         p.getShop().setShopInterface(4);  //go to the "are you sure" buy screen
         p.getBlStack().push(new ButtonList(new String[]{"Yes","No"}, false, new PVector(350, 270), new PVector(150, 45), 25, true));
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
     if (p.getCurrentBl().getButton() == p.getInventory().size())
     {
       p.getBlStack().pop();
       p.getShop().setShopInterface(0);
     }
     else 
     {
       //CASE actually sell
       p.getShop().setShopInterface(5);    //go to the "are you sure" sell screen
       p.getBlStack().push(new ButtonList(new String[]{"Yes","No"}, false, new PVector(350, 270), new PVector(150, 45), 25, true));
     }
     break;
   //In "talk" screen
   case 3:
     //If presses leave
     if (p.getCurrentBl().getButton() == p.getShop().getDialogue().length)
     {
       p.getBlStack().pop();
       p.getShop().setShopInterface(0);
     }
     else 
     {
       //CASE actually talk
       p.getShop().setShopInterface(6);    //sends to dialogue interface
       p.getBlStack().push(new ButtonList());
     }
     break;
   //In "are you sure you want to buy" screen
   case 4:
     //If presses yes
     if (p.getCurrentBl().getButton() == 0)
     {
       p.getInventory().add(p.getShop().getInventory().get(p.getPreviousBl().getButton()));      //adds item
       p.gainGold(-1 * p.getShop().getInventory().get(p.getPreviousBl().getButton()).getCost()); //subtracts cost from player balance
     }
     p.getBlStack().pop();
     p.getShop().setShopInterface(1);  //sends back to "buy" screen
     break;
   //In "are you sure you want to sell" screen
   case 5:
     //If presses yes
     if (p.getCurrentBl().getButton() == 0)
     {
       p.gainGold(4 * p.getInventory().get(p.getPreviousBl().getButton()).getCost() / 5);  //add gold to player balance (only 80% of initial worth)
       p.getInventory().remove(p.getInventory().get(p.getPreviousBl().getButton()));       //remove item from player inventory
     }
     p.getBlStack().pop();  //gets out of "are you sure you want to sell" BL, current is "sell choices" BL (associated with shopInterface = 2)
                
     //This reallocates the interface for displaying the player's current inventory, since the player may or may not have one less item than previously from selling it
     p.getBlStack().pop();  
                
     String sellInterface[] = new String[p.getInventory().size() + 1];
                
     for (int i = 0; i < p.getInventory().size(); i++)
     {
       sellInterface[i] = p.getInventory().get(i).getName() + " - " + 4 * p.getInventory().get(i).getCost() / 5 + "G";
     }
     sellInterface[p.getInventory().size()] = "Back";
     //End
                
     p.getBlStack().push(new ButtonList(sellInterface, false, new PVector(-200, 120), new PVector(150, 45), 25, true));
     p.getShop().setShopInterface(2);    //sends back to "sell" interface
     break;
   //Case in dialogue with the shopkeeper
   case 6:
     //Can only do anything if the text is fully displayed
     if (p.getShop().getText().isFinished())
     {
       if (p.getShop().currentSlide() == p.getShop().getDialogue()[p.getPreviousBl().getButton()].length - 1)
       {
         //case last slide
         p.getShop().setShopInterface(3);  //sends back to "talk" interface
         p.getShop().resetSlide();
         p.getShop().getText().reset();
         p.getBlStack().pop();
       }
       else 
       {
         //not last slide
         p.getShop().nextSlide();          //simply displays next slide
         p.getShop().getText().reset();
       }
     }
     break;
   }
}

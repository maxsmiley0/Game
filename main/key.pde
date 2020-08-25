void keyPressed()
{ 
  if (p.getBlStack().empty())  //No interactions
  {
    if (key == 'x' && p.getInteractor() != null)  //If we have someone to interact with
    {
      p.getInteractor().setInteract(true);
      
      if (p.getInteractor().isShopkeeper())
      {
        p.enterShop();
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
    if (p.isInShop())
    {
      if (key == 'x')
      {
        switch (shop.getShopInterface())
        {
          case 0:
            switch (p.getCurrentBl().getButton())
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
                
                p.getBlStack().add(new ButtonList(buyInterface, false, new PVector(-200, 120), new PVector(150, 45), buyInterface.length, 25, true));
                break;
              //IF IN MENU SCREEN AND PRESS "SELL"
              case 1:
                shop.setShopInterface(2);    //go to sell interface
                
                //All this does is allocate an extra button to the buttonlist, one for "leave", in addition to the player inventory
                String sellInterface[] = new String[p.getInventory().size() + 1];
                
                for (int i = 0; i < p.getInventory().size(); i++)
                {
                  sellInterface[i] = p.getInventory().get(i).getName() + " - " + 4 * p.getInventory().get(i).getCost() / 5 + "G";
                }
                sellInterface[p.getInventory().size()] = "Back";
                //End
                
                p.getBlStack().add(new ButtonList(sellInterface, false, new PVector(-200, 120), new PVector(150, 45), sellInterface.length, 25, true));
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
                
                p.getBlStack().add(new ButtonList(shopInterface, false, new PVector(-200, 120), new PVector(150, 45), shopInterface.length, 50, true));
                break;
              //IF IN MENY SCREEN AND PRESS "LEAVE"
              case 3:
                p.exitShop();  //leaves shop
                break;
            }
              break;
            //IN "BUY" SCREEN
            case 1:
              //If presses "leave"
              if (p.getCurrentBl().getButton() == shop.getInventory().size())
              {
                p.getBlStack().pop();      //go back to shop menu
                shop.setShopInterface(0);
              }
              else 
              {
                //CASE actually buy
                //Test for inventory space later on
                if (shop.getInventory().get(p.getCurrentBl().getButton()).getCost() <= p.getGold())  //must have enough gold
                {
                  shop.setShopInterface(4);  //go to the "are you sure" buy screen
                
                  String buyInterface[] = {"Yes", "No"};
                  p.getBlStack().add(new ButtonList(buyInterface, false, new PVector(350, 270), new PVector(150, 45), 2, 25, true));
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
                shop.setShopInterface(0);
              }
              else 
              {
                //CASE actually sell
                shop.setShopInterface(5);    //go to the "are you sure" sell screen
                
                String sellInterface[] = {"Yes", "No"};
                p.getBlStack().add(new ButtonList(sellInterface, false, new PVector(350, 270), new PVector(150, 45), 2, 25, true));
              }
              break;
            //In "talk" screen
            case 3:
              //If presses leave
              if (p.getCurrentBl().getButton() == shop.getDialogue().length)
              {
                p.getBlStack().pop();
                shop.setShopInterface(0);
              }
              else 
              {
                //CASE actually talk
                shop.setShopInterface(6);    //sends to dialogue interface
                
                String[] nextButton = {""};
                p.getBlStack().add(new ButtonList(nextButton, false, new PVector(0, 0), new PVector(0, 0), 1, 0, false));
              }
              break;
            //In "are you sure you want to buy" screen
            case 4:
              //If presses yes
              if (p.getCurrentBl().getButton() == 0)
              {
                p.getInventory().add(shop.getInventory().get(p.getPreviousBl().getButton()));      //adds item
                p.gainGold(-1 * shop.getInventory().get(p.getPreviousBl().getButton()).getCost()); //subtracts cost from player balance
              }
                p.getBlStack().pop();
                shop.setShopInterface(1);  //sends back to "buy" screen
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
                
                p.getBlStack().add(new ButtonList(sellInterface, false, new PVector(-200, 120), new PVector(150, 45), sellInterface.length, 25, true));
                shop.setShopInterface(2);    //sends back to "sell" interface
              break;
            //Case in dialogue with the shopkeeper
            case 6:
              //Can only do anything if the text is fully displayed
              if (shop.getText().isFinished())
              {
                if (shop.currentSlide() == shop.getDialogue()[p.getPreviousBl().getButton()].length - 1)
                {
                  //case last slide
                  shop.setShopInterface(3);  //sends back to "talk" interface
                  shop.resetSlide();
                  shop.getText().reset();
                  p.getBlStack().pop();
                  
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
      }
    }
  }
  
  //If not in shop, this progresses the Bubble
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

void keyReleased()
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

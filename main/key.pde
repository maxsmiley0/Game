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
              case 2:
                shop.setShopInterface(3);
                
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
              case 3:
                p.exitShop();
                break;
            }
              break;
            case 1:
              if (p.getCurrentBl().getButton() == shop.getInventory().size())
              {
                p.getBlStack().pop();
                shop.setShopInterface(0);
              }
              else 
              {
                //CASE actually buy
                //Test for inventory space later on
                if (shop.getInventory().get(p.getCurrentBl().getButton()).getCost() <= p.getGold())
                {
                  shop.setShopInterface(4);
                
                  String buyInterface[] = {"Yes", "No"};
                  p.getBlStack().add(new ButtonList(buyInterface, false, new PVector(350, 270), new PVector(150, 45), 2, 25, true));
                }
                else 
                {
                  //Error sound or "insufficient funds" message
                }
              }
              break;
            case 2:
              if (p.getCurrentBl().getButton() == p.getInventory().size())
              {
                p.getBlStack().pop();
                shop.setShopInterface(0);
              }
              else 
              {
                //CASE actually sell
                shop.setShopInterface(5);
                
                String sellInterface[] = {"Yes", "No"};
                p.getBlStack().add(new ButtonList(sellInterface, false, new PVector(350, 270), new PVector(150, 45), 2, 25, true));
              }
              break;
            case 3:
              if (p.getCurrentBl().getButton() == shop.getDialogue().length)
              {
                p.getBlStack().pop();
                shop.setShopInterface(0);
              }
              else 
              {
                //CASE actually talk
                shop.setShopInterface(6);
                
                String[] nextButton = {""};
                p.getBlStack().add(new ButtonList(nextButton, false, new PVector(0, 0), new PVector(0, 0), 1, 0, false));
              }
              break;
            case 4:
              if (p.getCurrentBl().getButton() == 0)
              {
                p.getInventory().add(shop.getInventory().get(p.getPreviousBl().getButton()));
                p.gainGold(-1 * shop.getInventory().get(p.getPreviousBl().getButton()).getCost());
              }
                p.getBlStack().pop();
                shop.setShopInterface(1);
              break;
            case 5:
              if (p.getCurrentBl().getButton() == 0)
              {
                
                //update?
                p.gainGold(4 * p.getInventory().get(p.getPreviousBl().getButton()).getCost() / 5);
                p.getInventory().remove(p.getInventory().get(p.getPreviousBl().getButton()));
              }
                p.getBlStack().pop();
                p.getBlStack().pop();
                
                String sellInterface[] = new String[p.getInventory().size() + 1];
                
                for (int i = 0; i < p.getInventory().size(); i++)
                {
                  sellInterface[i] = p.getInventory().get(i).getName() + " - " + 4 * p.getInventory().get(i).getCost() / 5 + "G";
                }
                sellInterface[p.getInventory().size()] = "Back";
                //End
                
                p.getBlStack().add(new ButtonList(sellInterface, false, new PVector(-200, 120), new PVector(150, 45), sellInterface.length, 25, true));
                
                shop.setShopInterface(2);
              break;
            case 6:
              if (shop.getText().isFinished())
              {
                if (shop.currentSlide() == shop.getDialogue()[p.getPreviousBl().getButton()].length - 1)
                {
                  //case at end
                  shop.setShopInterface(3);
                  shop.resetSlide();
                  shop.getText().reset();
                  p.getBlStack().pop();
                  
                }
                else 
                {
                  shop.nextSlide();
                  shop.getText().reset();
                }
                //set display here...
                /*
                display text over in shop::display
                if is finished and not at end(tell which one buy prevBlList)
                then go to next slide
                if at end and finished go back to shopInterface 3
                */
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

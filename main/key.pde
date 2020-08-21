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
    
    p.startMoving();       //Display animation
    if (keyCode == LEFT)
    {
      p.setKey(1, false);  //Move left is true
      p.setKey(3, true);   //Move right is false
    }
    else if (keyCode == RIGHT)
    {
      p.setKey(1, true);   //Move left is false
      p.setKey(3, false);  //Move right is true
    }
    if (keyCode == UP)
    {
      p.setKey(0, true);   //Move up is true
      p.setKey(2, false);  //Move down is false
    }
    else if (keyCode == DOWN)
    {
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
              case 0:
                shop.setShopInterface(1);
                
                //All this does is add an extra button to the buttonlist, will be easier once we work with arraylists as opposed to 
                String inventoryInterface[] = new String[shop.getInventory().length + 1];
                for (int i = 0; i < shop.getInventory().length; i++)
                {
                  inventoryInterface[i] = shop.getInventory()[i];
                }
                inventoryInterface[shop.getInventory().length] = "Leave";
                //End
                
                p.getBlStack().add(new ButtonList(inventoryInterface, true, new PVector(350, 130), new PVector(150, 45), inventoryInterface.length, 60, true));
                break;
              case 1:
                shop.setShopInterface(2);
                break;
              case 2:
                shop.setShopInterface(3);
                break;
              case 3:
                p.exitShop();
                break;
            }
              break;
            case 1:
            {
              if (p.getCurrentBl().getButton() == shop.getInventory().length)
              {
                p.getBlStack().pop();
                shop.setShopInterface(0);
              }
              else 
              {
                
              }
            }
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

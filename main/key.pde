void keyPressed()
{ 
  if (p.getBlStack().empty())  //Case we can move
  {
    if (key == 'x' && p.getInteractor() != null)
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
    
    if (p.isInShop())
    {
      if (key == 'x')
      {
        switch (p.getBlStack().size())
        {
          case 1:
            switch (p.getCurrentBl().getButton())
            {
              case 0:
                String choices[] = {"Gun","Sword","Shield"};
                p.getBlStack().add(new ButtonList(choices, true, new PVector(350, 130), new PVector(150, 45), 3, 60, true));
                break;
              case 1:
                break;
              case 2:
                break;
              case 3:
                p.exitShop();
                //p.getBlStack().pop();
                break;
            }
              break;
            case 2:
            {
              switch (p.getCurrentBl().getButton())
              {
                case 0:
                  break;
                case 1:
                  break;
                case 2:
                  p.getBlStack().pop();
             
              }
            }
        }
      }
    }
  }
  
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

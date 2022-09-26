//Controls Game State
void executeRigidBodyController(Room room) {
  for (GameObject gameObject : room.li) {
    /*
    Defining the borders of the rigidBody, with an extra term in relation to the player's dimensions
    This is so a player won't be stopped right at the border of the structure, i.e. half of the player's
    sprite won't be inside the rigidBody
    */
    if ((gameObject instanceof Struct && ((Struct)gameObject).hasRigidBody()) || gameObject instanceof NPC) {
      
      int leftBorder = (int)(gameObject.getPosition().x - (gameObject.getDimensions().x/2) - (p.getDimensions().x / 2));
      int rightBorder = (int)(gameObject.getPosition().x + (gameObject.getDimensions().x/2) + (p.getDimensions().x / 2));
      int topBorder = (int)(gameObject.getPosition().y - (gameObject.getDimensions().y/2) - (p.getDimensions().y/2));
      int bottomBorder = (int)(gameObject.getPosition().y + (gameObject.getDimensions().y/2) + (p.getDimensions().y/2));
      
      int offset = 10;     //Player's speed is tentatively 6, so 10 is okay
      
      //Applying an fixed impulse
      if (p.getPosition().x > leftBorder && p.getPosition().x < leftBorder + offset && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)
      {
        p.move(new PVector(-6, 0));  
      }
      
      if (p.getPosition().x > rightBorder - offset && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < bottomBorder)
      {
        p.move(new PVector(6, 0));
      }
      
      if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > topBorder && p.getPosition().y < topBorder + offset)
      {
        p.move(new PVector(0, -6));
      }
      
      if (p.getPosition().x > leftBorder && p.getPosition().x < rightBorder && p.getPosition().y > bottomBorder - offset && p.getPosition().y < bottomBorder)
      {
        p.move(new PVector(0, 6));
      }
    }
  }
}

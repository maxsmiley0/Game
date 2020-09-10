public class SaveFile {
  /*
  (saveData.txt)
  To understand SaveFile, one must understand data/saveData.txt. saveData.txt is a file where information between runs of the program can be stored.
  Each variable to be stored occupies its own line. It is stored in the format "name of field = field value". Ex: "playerX = 100", or even "0: playerX = 100"
  The name of the field is completely arbitrary, it is only used to help the user remember what it is storing. It is imperative to have " = " in between the name of field and field value
  The integer at the end of the line is the only thing that may change in between different program runs. It stored the value of the variable.
  */
  
  //In a given SaveFile, there is only one member, an array that essentially condenses the contents of saveData.txt.
  //The array, "saveData" stores the each line of "saveData.txt" as a String in separate entries of the array
  private String[] saveData;   
  
  //Upon constructing a Save File, we load the contents of "data/saveData.txt" into the saveData array
  public SaveFile()
  {
    saveData = loadStrings("data/saveData.txt");
  }
  
  //This loads the values in the text sheet into the variables. This, along with void save, must be changed for each program to include what needs to be loaded
  //It should have the same number of things loaded as things saved, which both equal lines in "saveData.txt"
  public void load()
  {
    //x = loadField(0);
    //y = loadField(1);
  }
  
  //This writes the current data from the game to the save file. This, along with void load, must be changed for each program to include what needs to be saved
  //It should have the same number of things saved as things loaded, which both equal lines in "saveData.txt"
  public void save()
  {
    //Updates array
    //updateField(0, x);
    //updateField(1, y);
    
    //Updates actual save file
    saveStrings("data/saveData.txt", saveData);
  }
  
  //Returns the number associated with given line
  private int loadField(int entry)
  {
    //Searches through string until " = " is found
    for (int i = 0; true; i++)
    {
      //Returns the string (casted as an int) after " = ", which will simply be the number
      if (saveData[entry].substring(i, i + 3).equals(" = "))
      {
        return Integer.parseInt(saveData[entry].substring(i + 3));
      }
    }
  }
  
  //Updates saveData array at a given entry to a given value (predicate, because this parameter will usually be some kind of accessor method)
  private void updateField(int entry, int predicate)
  {
    //Searches through string until " = " is found
    for (int i = 0; true; i++)
    {
      //After this is found, it saves the portion up to (and including) " = ", along with the predicate afterwards, then breaks from the otherwise infinite loop
      if (saveData[entry].substring(i, i + 3).equals(" = "))
      {
        saveData[entry] = saveData[entry].substring(0, i + 3) + Integer.toString(predicate);
        break;
      }
    }
  }
}

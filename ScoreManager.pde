public enum ScoreManager {
  INSTANCE;

    private ArrayList<String> attributes;
    private ArrayList<String> gamesPlayed;
    private Random rand;

  private ScoreManager() {
    attributes = new ArrayList();
    gamesPlayed = new ArrayList();
    rand = new Random();
   
  }

  public void loadAttributes(BufferedReader reader) {
    String line;
    if(reader == null) return;
    try {
      while ((line = reader.readLine()) != null) {
        if(line.startsWith("#")) continue;
        attributes.add(line);
      }
    } 
    catch(IOException e) {
      e.printStackTrace();
    }
    finally {
      try {
        if (reader != null)
          reader.close();
      } 
      catch (IOException e) { 
        e.printStackTrace();
      }
    }
  }
  
  public void addPlayedGame(String game) {
    gamesPlayed.add(game);  
  }
  
  public ArrayList<String> getPlayedGames() {
    return gamesPlayed;  
  }
  
  public String getHighestAttribute() {
    int r = rand.nextInt(attributes.size())+1;
    return attributes.get(r-1);
  }
}

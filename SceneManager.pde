import java.util.Random; //<>//

public enum SceneManager {
  INSTANCE;

  private Random rand;
  private HashMap<String, BaseScene> scenes;
  private ArrayList<String> games;
  private String current;
  private int sceneFrameCount;
  private int fps;
  private boolean changeScene;
  private boolean inGameMode;
  private int numberGames, gameCount;
  private int sameGameCount;


  private SceneManager() {
    rand = new Random();
    scenes = new HashMap();
    games = new ArrayList();
    current = null;
    sceneFrameCount = 0;
    fps = 0;
    changeScene = false;
    inGameMode = false;
    gameCount = 0;
    numberGames = 2;
    sameGameCount = 0;
  }

  public void addScene(BaseScene _scene) {
    if (_scene != null) {
      scenes.put(_scene.getId(), _scene);
      if (_scene.getId().contains("Game")) {
        games.add(_scene.getId());
      }
    }
  }

  public void removeScene(String _id) {
    if (_id != null && !_id.isEmpty()) {
      scenes.remove(_id);
    }
  }

  public void setScene(String _id) {
    if (inGameMode) {
      current = getRandomGame();
      gameCount++;
      if (gameCount >= numberGames)
        inGameMode = false;
    } else if (_id != null && scenes.containsKey(_id)) {
      current = _id;
    } else {
      throw new SceneNotFoundException("Scene not found!");
    }
    sceneFrameCount = 0;
    changeScene = true;
  }

  public int getSceneFrameCount() {
    return sceneFrameCount;
  }

  public void setSceneFrameCount(int _count) {
    sceneFrameCount = _count;
  }

  public void setInGameMode(boolean inMode) {
    inGameMode = inMode;
  }

  public int getFps() {
    return fps;
  }

  public void setFps(int _fps) {
    fps = _fps;
  }

  public BaseScene getCurrentScene() {
    if (current == null || current.isEmpty() || !scenes.containsKey(current))
      throw new SceneNotFoundException("Current set scene does not exist!");
    return scenes.get(current);
  }

  public String getCurrentId() {
    return current;
  }

  public void manageDraw() {
    if (sceneFrameCount == 0) {
      getCurrentScene().setup();
      changeScene = false;
    } else {
      getCurrentScene().update();
      getCurrentScene().draw();
    }
    if (!changeScene)
      ++sceneFrameCount;
  }

  private String getRandomGame() {
    int r = rand.nextInt(games.size())+1;
    String nextGame = games.get(r-1); 
    if (nextGame == current)
      sameGameCount++;
    if (sameGameCount >= 2 && games.get(r-1) == current) {
      while (current != games.get(r-1)) {
        r = rand.nextInt(games.size())+1;
      }
      sameGameCount = 0;
    }
    return nextGame;
  }

  public int getNumberGames() {
    return numberGames;
  }

  public int getGameCount() {
    return gameCount;
  }

  public void incrementNumGames() {
    inGameMode = true;
    numberGames++;
  }

  public void decrementNumGames() {
    if (numberGames > gameCount)
      numberGames--;
    else
      inGameMode = false;
  }

  class SceneNotFoundException extends RuntimeException {
    public SceneNotFoundException(String msg) {
      super("SceneNotFoundException: " + msg);
    }
  }
}

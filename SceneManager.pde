public enum SceneManager {
  INSTANCE;

  private HashMap<String, BaseScene> scenes;
  private String current;
  private int sceneFrameCount;
  private int fps;

  private SceneManager() {
    scenes = new HashMap();
    current = null;
    sceneFrameCount = 0;
    fps = 0;
  }

  public void addScene(BaseScene _scene) {
    if (_scene != null) {
      scenes.put(_scene.getId(), _scene);
    }
  }

  public void removeScene(String _id) {
    if (_id != null && !_id.isEmpty()) {
      scenes.remove(_id);
    }
  }

  public void setScene(String _id) {
    if (_id != null && scenes.containsKey(_id)) {
      current = _id;
      sceneFrameCount = 0;
    } else {
      throw new SceneNotFoundException("Scene not found!");
    }
  }

  public int getSceneFrameCount() {
    return sceneFrameCount;
  }

  public void setSceneFrameCount(int _count) {
    sceneFrameCount = _count;
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
    } else {
      getCurrentScene().update();
      getCurrentScene().draw();
    }
    ++sceneFrameCount;
  }

  class SceneNotFoundException extends RuntimeException {
    public SceneNotFoundException(String msg) {
      super("SceneNotFoundException: " + msg);
    }
  }
}

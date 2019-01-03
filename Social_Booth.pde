SceneManager manager;
SceneFactory factory;
DataGather data;

void setup() {
  fullScreen();
  manager = SceneManager.INSTANCE;
  factory = new SceneFactory();
  manager.setFps(60);
  data = new DataGather();
  frameRate(manager.getFps());
  if(!factory.createScenesFromDescription("setup/structure.txt")) {
    println("Error initializing!");
    exit();
  }
  setupShapes();
  manager.setScene("page2");
}

@Override
void draw() {
  manager.manageDraw();
}

@Override
void mouseClicked() {
  manager.getCurrentScene().onMouseClicked();
}

@Override
void mouseDragged() {
  manager.getCurrentScene().onMouseDragged();
}

@Override
void mouseEntered() {
  manager.getCurrentScene().onMouseEntered();
}

@Override
void mouseExited() {
  manager.getCurrentScene().onMouseExited();
}

@Override
void mouseMoved() {
  manager.getCurrentScene().onMouseMoved();
}

@Override
void mousePressed() {
  manager.getCurrentScene().onMousePressed();
}

@Override
void mouseReleased() {
  manager.getCurrentScene().onMouseReleased();
}

@Override
void mouseWheel() {
  manager.getCurrentScene().onMouseWheel();
}

@Override
void keyPressed() {
  if(key == 'q') {
    data.save();
    exit();
  }
  manager.getCurrentScene().onKeyPressed();
}

@Override
void keyReleased() {
  manager.getCurrentScene().onKeyReleased();
}

@Override
void keyTyped() {
  manager.getCurrentScene().onKeyTyped();
}

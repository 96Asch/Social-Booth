import gab.opencv.OpenCV;
import processing.video.Capture;

String DEFAULT_SCENE = "mainTitle";
SceneManager manager;
SceneFactory factory;
ScoreManager scoreManager;
DataGather data;
Capture video;
OpenCV opencv;  

int dispWidth = 1080;
int dispHeight = 720;
int camWidth = 640;
int camHeight = 480;

void setup() {
  size(1080, 720);
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  manager = SceneManager.INSTANCE;
  scoreManager = ScoreManager.INSTANCE;
  scoreManager.loadAttributes(createReader("setup/attributes.txt"));
  factory = new SceneFactory();
  manager.setFps(60);
  data = new DataGather();
  frameRate(manager.getFps());
  if (!factory.createScenesFromDescription("setup/structure.txt")) {
    println("Error initializing!");
    exit();
  }
  setupShapes();
  manager.setScene(DEFAULT_SCENE);
}

void captureEvent(Capture c) {
  c.read();
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
  if (key == 'q') {
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

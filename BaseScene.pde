abstract class BaseScene {
 
 PImage bg;
 String id;
 
 BaseScene(String _id) {
   id = _id;
 };
 
 public String getId() {
   return id;
 };
 
 public void setBg(String img) {
   bg = loadImage(img);
   bg.resize(width, height);
 }
 
 public PImage getBg() {
   return bg;
 }
 
 abstract public void setup();
 
 abstract public void update();
 
 abstract public void draw();
 
 abstract public void reset();
 
 public void onMouseClicked() {};

 public void onMouseDragged() {};

 public void onMouseEntered() {};

 public void onMouseExited() {};

 public void onMouseMoved() {};

 public void onMousePressed() {};

 public void onMouseReleased() {};

 public void onMouseWheel() {};

 public void onKeyPressed() {};

 public void onKeyReleased() {};

 public void onKeyTyped() {};
 
};

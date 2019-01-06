public class MouthGame extends Node implements Initializable {

  Timer timer;
  int numberMouths = 25;
  int numClicked;
  String MouthImg = "mouth.png";
  String bgImg = "Anti.jpg";
  PImage bg;
  boolean won;

  Mouth []  mouthCollection = new Mouth [numberMouths];  


  public MouthGame(int x, int y, int w, int h) {
    super(x, y, w, h);
    bg = loadImage(bgImg);
    timer = new Timer();
    timer.setDuration(30000);
    bg.resize(width, height); 
    numClicked = 0;
    won = false;

    for ( int i = 0; i < mouthCollection.length; i++) {
      mouthCollection[i] = new Mouth(MouthImg, 
        random(x, w), random(y, h), 
        w/8, h/8, 
        random  (5, 10), random (5, 10), 
        x, y, 
        w, h);
    }
  }

  @Override
    public void onInit() {
    for ( int i = 0; i < mouthCollection.length; i++) {
      mouthCollection[i].reset( random(x, w), random(y, h), 
        w/8, h/8, 
        random  (5, 10), random (5, 10));
    }
    won = false;
    numClicked = 0;
  }

  @Override
    public void draw() {
    super.draw();
    image(bg, x, y, w, h);
    if (won) {
      strokeWeight(5);
      fill(255, 160); 
      rect (w/3.5, h/1.2, w/2, 100); 
      fill(255, 0, 0); 
      textAlign(CENTER, CENTER);
      textSize(70); 
      text ("You Won", w/3.5, h/1.2, w/2, 100);
    } else {
      for ( int i = 0; i < mouthCollection.length; i++) {
        mouthCollection[i].run();
      }
    }
    strokeWeight(7);
    stroke(255);
    noFill();
    rect(x, y, w, h);
  }

  @Override
    public void update(int mx, int my) {
    super.update(mx, my);
    if (numClicked >= numberMouths)
      won = true;
  }

  @Override
    public void onClick() {
    for ( int i = 0; i < mouthCollection.length; i++) {
      if (mouthCollection[i].mouseclicked(mouseX, mouseY))
        numClicked++;
    }
  }
}

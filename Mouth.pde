class Mouth {
  //Here i store the main variables of the class
  float x = 0; 
  float y= 0; 
  float speedX;
  float speedY;
  float h, w;
  boolean isClicked;
  PImage img;
  float boundX, boundY, boundH, boundW;

  //CONSTRUCTOR here i specify how i build the class 
  Mouth (String mouthImage, float _x, float _y, 
    float _h, float _w, 
    float _speedX, float _speedY, 
    float _boundX, float _boundY, 
    float _boundW, float _boundH) {
    x = _x; 
    y = _y;
    h = _h;
    w = _w;
    speedX = _speedX;
    speedY = _speedY; 
    isClicked = false;
    img = loadImage(mouthImage);
    boundX = _boundX;
    boundY = _boundY;
    boundH = _boundH;
    boundW = _boundW;
  }



  //FUNCTIONS
  void run() {
    display();
    move();
    bounce();
    gravity ();
  } 

  boolean mouseclicked(int mx, int my) {
    if (!isClicked && x < mx && mx < w + x && y < my && my < h + y ) {
      isClicked = true;
      return true;
    }
    return false;
  }

  void gravity () {
    speedY += 0.02;
    if (speedY > 5)
      speedY = 5;
  }

  void bounce() {
    if (x > boundW) {
      speedX = speedX * -1;
    } else if (x < boundX) {
      speedX = speedX * -1;
    }

    if (y > boundH) {
      speedY = speedY * -1;
    } else if (y < boundY) {
      speedY = speedY * -1;
    }
  }

  boolean isclicked() {
    return isClicked;
  } 

  void move() {
    x += speedX;
    y += speedY;
  }   

  void display() {
    if (isClicked) {
      fill(255, 0, 0);
      rect(x, y, w, h);
    }
    image(img, x, y, w, h);
  }

  public void reset(float _x, float _y, 
    float _h, float _w, 
    float _speedX, float _speedY) {
    x = _x; 
    y = _y;
    h = _h;
    w = _w;
    speedX = _speedX;
    speedY = _speedY;
    isClicked = false;
  }
}

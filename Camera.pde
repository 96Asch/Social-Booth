import java.awt.Rectangle;

public class Camera extends Node implements Initializable {


  public Camera(int x, int y, int w, int h) {
    super(x, y, w, h);
  }

  @Override
    public void onInit() {
    video.start();
  }

  @Override
    public void draw() {
    super.draw();
    opencv.loadImage(video);
    pushMatrix();
      translate(x, y);
    image(video, 0, 0);

    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    Rectangle[] faces = opencv.detect();
    for (int i = 0; i < faces.length; i++) {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }

    strokeWeight(7);
    stroke(255);
    noFill();
    rect(x+10, y, w, h);
    popMatrix();
  }

  @Override
    public void update(int x, int y) {
    super.update(x, y);
  }
}

public static final int OFFSET = 50;
public static final float STROKE_R = 255;
public static final float STROKE_G = 255;
public static final float STROKE_B = 255;

public static final int STROKE_WEIGHT = 7;
public static final float OPACITY = 160;
public static final float SELECTED_R = 255;
public static final float SELECTED_G = 218;
public static final float SELECTED_B = 3;
public static final float FILL_COLOR = 0;
public static final float TEXT_COLOR = 255;

PShape dialog, title, subtitle;

public void drawBox(int x, int y, int w, int h, int offset) {
  fill(FILL_COLOR, OPACITY);
  strokeWeight(STROKE_WEIGHT);
  stroke(STROKE_R, STROKE_G, STROKE_B);
  quad(x+offset, y, x, y+h, x+w, y+h, x+w+offset, y); 
  noStroke();
  fill(TEXT_COLOR);
}

public void drawBoxOnHover(int x, int y, int w, int h, int offset) {
  fill(SELECTED_R, SELECTED_G, SELECTED_B, OPACITY);
  strokeWeight(STROKE_WEIGHT);
  stroke(STROKE_R, STROKE_G, STROKE_B);
  quad(x+offset, y, x, y+h, x+w, y+h, x+w+offset, y); 
  noStroke();
  fill(FILL_COLOR);
}

public void drawDialog(int x, int y, int w, int h) {
  dialog.disableStyle();
  fill(FILL_COLOR, OPACITY);
  stroke(STROKE_R, STROKE_G, STROKE_B);
  strokeWeight(STROKE_WEIGHT);
  shape(dialog, x-OFFSET-50, y-OFFSET, w+OFFSET+50, h+OFFSET+100);
  noStroke();
  noFill();
  dialog.enableStyle();
  fill(TEXT_COLOR);
}

public void drawTitle(int x, int y, int w, int h) {
  title.disableStyle();
  fill(FILL_COLOR, OPACITY);
  stroke(STROKE_R, STROKE_G, STROKE_B);
  strokeWeight(STROKE_WEIGHT);
  shape(title, x, y-60, w+OFFSET+50, h+80);
  noStroke();
  noFill();
  title.enableStyle();
  fill(TEXT_COLOR);
}

public void drawSubtitle(int x, int y, int w, int h) {
  subtitle.disableStyle();
  fill(FILL_COLOR, OPACITY);
  stroke(STROKE_R, STROKE_G, STROKE_B);
  strokeWeight(STROKE_WEIGHT);
  shape(subtitle, x, y, w+100, h-300);
  noStroke();
  noFill();
  subtitle.enableStyle();
  fill(TEXT_COLOR);
}


public void setupShapes() {
  dialog = loadShape("dialog.svg");
  title = loadShape("title.svg");
  subtitle = loadShape("subtitle.svg");
}

public class CountDown extends Node {

  private Timer timer;
  private String text;
  private PFont font;
  private String fontName;
  private int fontSize;

  public CountDown(int x, int y, int w, int h) {
    super(x, y, w, h);
  }

  public void draw() {
    super.draw();
    fill(FILL_COLOR, OPACITY);
    strokeWeight(STROKE_WEIGHT);
    stroke(STROKE_R, STROKE_G, STROKE_B);
    rect(x, y, w, h); 
    noStroke();
    fill(TEXT_COLOR);

    if (font != null)
      textFont(font);
    textAlign(CENTER, CENTER);
    text(text, x, y, w, h);
  }


  public void update(int x, int y) {
    super.update(x, y);
    if (timer != null) {
      text = millisToStr(timer.getEndT() - timer.getCurrentT());
    }
  }

  private String millisToStr(int millis) {
    return String.format("%.2f", float(millis) / 1000);
  }

  public int getFontSize() {
    return fontSize;
  }

  public void setFontSize(int _fontSize) {
    fontSize = _fontSize;
  }

  public String getFont() {
    return fontName;
  }

  public void setFont(String _fontName) {
    fontName = _fontName; 
    font = createFont(fontName, fontSize, true);
  }


  public void setTimer(Timer _timer) {
    timer = _timer;
  }

  public Timer getTimer() {
    return timer;
  }
}

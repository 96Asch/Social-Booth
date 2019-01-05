public class TimerBar extends Node implements Initializable {

  Timer timer;
  PShape warning;
  float progress;
  private int start;
  private boolean showWarning;
  private static final int INNER_OFFSET = 20;
  private static final float PERCENT_THRESHOLD = 0.8f;
  private static final int FLASH_RATE = 20;

  public TimerBar(int x, int y, int w, int h) {
    super(x, y, w, h);
    warning = loadShape("exclamation.svg");
    showWarning = false;
  }

  public void draw() {
    super.draw();
    fill(0);
    stroke(255);
    quad(x, y, 
      x + w, y, 
      x + w + OFFSET, y+h, 
      x + OFFSET, y+h);
    if (timer != null)
      progress = float(timer.getCurrentT() - start) / float(timer.getEndT() - start);  
    else 
    progress = 0;
    if (progress < 0.0f)
      progress = 0.1f;
    fill(SELECTED_R, SELECTED_G * (1-progress), SELECTED_B * (1-progress));
    float x2Start = x + (progress * w) - INNER_OFFSET;
    x2Start = x2Start < x + INNER_OFFSET ? x + INNER_OFFSET : x2Start;
    float x3Start = x + (progress * w) - INNER_OFFSET + OFFSET;
    x3Start = x3Start < x  + OFFSET + INNER_OFFSET ? x + OFFSET + INNER_OFFSET : x3Start;
    quad(x + INNER_OFFSET, y + INNER_OFFSET, 
      x2Start, y + INNER_OFFSET, 
      x3Start, y+h - INNER_OFFSET, 
      x + OFFSET + INNER_OFFSET, y+h - INNER_OFFSET);
    if(frameCount % FLASH_RATE == 0)
      showWarning = !showWarning;
      
    if (progress > PERCENT_THRESHOLD && showWarning) {
      stroke(STROKE_R, STROKE_G, STROKE_B);
      strokeWeight(STROKE_WEIGHT);
      fill(0);
      shape(warning, x2Start-w/8, y+(h/4), w/15, h/2.5);
    }
  }

  public void update(int x, int y) {
    super.update(x, y);
  }

  public void setStart(int _start) {
    start = _start;
  }


  public void setTimer(Timer _timer) {
    timer = _timer;
  }

  public Timer getTimer() {
    return timer;
  }

  @Override
    public void onInit() {
    setStart(millis());  
    println("restart timer");
  }
}

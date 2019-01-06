public class Score extends TextBody implements Initializable {

  private boolean set;
  
  public Score(int x, int y, int w, int h) {
    super("", x, y, w, h, 30);
    set = false;
  }

  public void draw() {
    super.draw();
  }

  public void update(int x, int y) {
    super.update(x, y);
  }

  @Override
    public void onInit() {
      if(!set) {
      setText(ScoreManager.INSTANCE.getHighestAttribute());
      set = true;  
    }
  }
}

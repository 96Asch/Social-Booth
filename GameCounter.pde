public class GameCounter extends TextBody {
  
  public GameCounter(int x, int y, int w, int h) {
    super("", x, y, w, h, 30);  
  }
  
    @Override
  public void draw() {
    super.draw();
    
    if(font != null)
      textFont(font);
    textAlign(alignX, alignY);
    text(text, x+offset.getOffsetX(), y+offset.getOffsetY(), w+offset.getOffsetW(), h+offset.getOffsetH());  
    textAlign(LEFT, BASELINE);
    noFill();
  }
  
  @Override
  public void update(int x, int y) {
   super.update(x, y); 
   text = "Game " + SceneManager.INSTANCE.getGameCount() + " of " + SceneManager.INSTANCE.getNumberGames();
  }
  
}

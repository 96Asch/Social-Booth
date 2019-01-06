public class DetailedScore extends Node implements Initializable {

  private final String[] param = {"Smile", "Dialog", "Listening"};
  private ArrayList<String> text;
  protected int fontSize;
  protected String fontName;
  protected PFont font;

  public DetailedScore(int x, int y, int w, int h) {
    super(x, y, w, h);
    text = new ArrayList();
  }

  public void draw() {
    super.draw();
    
    fill(255);
    if (font != null)
      textFont(font);
    println(text.size());
    for (int i = 0; i < text.size(); ++i) {
      text(text.get(i), x, y + (i * h), w, h);
    }
  }


  public void update(int x, int y) {
    super.update(x, y);
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

  @Override 
    public void onInit() {
    if (text.isEmpty())
      for (int i = 0; i < ScoreManager.INSTANCE.getPlayedGames().size(); ++i) {
        text.add(String.format("%d - %s : %s", i+1, ScoreManager.INSTANCE.getPlayedGames().get(i), param[int(random(0, param.length))]));
      }
  }
}

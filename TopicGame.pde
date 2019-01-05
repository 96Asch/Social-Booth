public class TopicGame extends Node implements Initializable {

  private BufferedReader reader;
  private ArrayList<String> loadedTopics;
  private String topicsFile;
  private String currentTopic;
  private PShape bg;
  private String bgName;
  private PFont font;
  private String fontName;
  private int fontSize;
  private OffsetStyling styling;

  public TopicGame(int x, int y, int w, int h) {
    super(x, y, w, h);
    currentTopic = "";
    loadedTopics = new ArrayList();
    styling = new OffsetStyling();
  }

  @Override
    public void onInit() {
    randomizeTopic();
  }


  public void randomizeTopic() {
    currentTopic = loadedTopics.get(int(random(0, loadedTopics.size())));
  }

  public void setTopicsFile(String _file) {
    topicsFile = _file;
    loadedTopics.clear();
    reader = createReader(topicsFile);
    String line;
    try {
      while ((line = reader.readLine()) != null) {
        if (line.startsWith("#")) continue;
        loadedTopics.add(line);
      }
    }
    catch (IOException e) {
      e.printStackTrace();
    }
    finally {
      try {
        if (reader != null) {
          reader.close();
        }
      }
      catch(IOException e) {
        e.printStackTrace();
      }
    }
  }

  public void draw() {
    super.draw();
    if (bg != null) {
      bg.disableStyle();
      fill(FILL_COLOR, OPACITY);
      stroke(STROKE_R, STROKE_G, STROKE_B);
      strokeWeight(STROKE_WEIGHT);
      shape(bg, x, y, w, h);
      noStroke();
      noFill();
      bg.enableStyle();
      fill(TEXT_COLOR);
    }
    if (font != null)
      textFont(font);
    textAlign(CENTER, CENTER);
    text(currentTopic, x + styling.getOffsetX(), 
      y + styling.getOffsetY(), 
      w + styling.getOffsetW(), 
      h + styling.getOffsetH());
  }

  public void update(int x, int y) {
    super.update(x, y);
  }

  public void setBg(String _bg) {
    bgName = _bg;
    bg = loadShape(bgName);
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

  public OffsetStyling getOffset() {
    return styling;
  }
}

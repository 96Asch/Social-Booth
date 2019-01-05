class DefaultStyling {

  private String bg;
  private TextStyling title, body, subtitle;
  private ButtonStyling button;
  private ScaleStyling scale;
  private Timer timer;
  private TimerBarStyling timerBar;

  DefaultStyling() {
    title = new TextStyling();
    body = new TextStyling();
    subtitle = new TextStyling();
    button = new ButtonStyling();
    scale = new ScaleStyling();
    timerBar = new TimerBarStyling();
  }

  public TextStyling getTitle() {
    return title;
  }

  public TextStyling getBody() {
    return body;
  }

  public TextStyling getSubtitle() {
    return subtitle;
  }

  public ButtonStyling getAdvButton() {
    return button;
  }

  public ScaleStyling getScale() {
    return scale;
  }

  public TimerBarStyling getTimerBar() {
    return timerBar;
  }

  public void setTimer(Timer _timer) {
    timer = _timer;
  }

  public Timer getTimer() {
    return timer;
  }

  public String getBg() {
    return bg;
  }

  public void setBg(String _bg) {
    bg = _bg;
  }
}

private class NodeStyling {

  protected PositionStyling position;
  protected int w;
  protected int h;
  protected Style style;

  public NodeStyling() {
    position = new PositionStyling();
  }

  public PositionStyling getPosition() {
    return position;
  }

  public int getWidth() {
    return w;
  }

  public void setWidth(int _w) {
    w = _w;
  }

  public int getHeight() {
    return h;
  }

  public void setHeight(int _h) {
    h = _h;
  }

  public Style getStyle() {
    return style;
  }

  public void setStyle(Style _style) {
    style = _style;
  }
}

private class TextStyling extends NodeStyling {
  protected int fontSize;
  protected String font;
  protected int alignX;
  protected int alignY;
  protected OffsetStyling offset;

  public TextStyling() {
    super();
    offset = new OffsetStyling();
  }

  public int getFontSize() {
    return fontSize;
  }

  public void setFontSize(int _f) {
    fontSize = _f;
  }

  public String getFont() {
    return font;
  }

  public void setFont(String _font) {
    font = _font;
  }

  public int getAlignX() {
    return alignX;
  }

  public void setAlignX(int _alignX) {
    alignX = _alignX;
  }

  public int getAlignY() {
    return alignY;
  }

  public void setAlignY(int _alignY) {
    alignX = _alignY;
  }

  public OffsetStyling getOffset() {
    return offset;
  }
}

private class TimerBarStyling extends NodeStyling {
  public TimerBarStyling() {
    super();
  }
}

private class ScaleStyling extends NodeStyling {

  protected int descFontSize, barFontSize;
  protected String descFontName, barFontName;
  protected int descWidth, descHeight;


  public void setDescFontSize(int _fontSize) {
    descFontSize = _fontSize;
  }

  public void setBarFontSize(int _fontSize) {
    barFontSize = _fontSize;
  }

  public int getDescFontSize() {
    return descFontSize;
  }

  public int getBarFontSize() {
    return barFontSize;
  }

  public String getDescFont() {
    return descFontName;
  }

  public String getBarFont() {
    return barFontName;
  }

  public void setDescFont(String _fontName) {
    descFontName = _fontName;
  }

  public void setBarFont(String _fontName) {
    barFontName = _fontName;
  }

  public void setDescWidth(int _x) {
    descWidth = _x;
  }

  public int getDescWidth() {
    return descWidth;
  }

  public void setDescHeight(int _h) {
    descHeight = _h;
  }

  public int getDescHeight() {
    return descHeight;
  }
}

private class ButtonStyling extends NodeStyling {

  protected int fontSize;
  protected String font;
  protected int alignX;
  protected int alignY;
  protected HoverEvent hover;
  protected PositionStyling previous;
  protected OffsetStyling offset;

  public ButtonStyling() {
    super();
    previous = new PositionStyling();
    offset = new OffsetStyling();
  }

  public int getFontSize() {
    return fontSize;
  }

  public void setFontSize(int _f) {
    fontSize = _f;
  }

  public String getFont() {
    return font;
  }

  public void setFont(String _font) {
    font = _font;
  }

  public HoverEvent getHover() {
    return hover;
  }

  public void setHover(HoverEvent _hover) {
    hover = _hover;
  }

  public PositionStyling getPreviousPosition() {
    return previous;
  }

  public int getAlignX() {
    return alignX;
  }

  public void setAlignX(int _alignX) {
    alignX = _alignX;
  }

  public int getAlignY() {
    return alignY;
  }

  public void setAlignY(int _alignY) {
    alignX = _alignY;
  }

  public OffsetStyling getOffset() {
    return offset;
  }
}

public class OffsetStyling {
  private int offsetX = 0;
  private int offsetY = 0;
  private int offsetW = 0;
  private int offsetH = 0;

  public int getOffsetX() {
    return offsetX;
  }

  public void setOffsetX(int _x) {
    offsetX = _x;
  }

  public int getOffsetY() {
    return offsetY;
  }

  public void setOffsetY(int _y) {
    offsetY = _y;
  }

  public int getOffsetW() {
    return offsetW;
  }

  public void setOffsetW(int _w) {
    offsetW = _w;
  }

  public int getOffsetH() {
    return offsetH;
  }

  public void setOffsetH(int _h) {
    offsetH = _h;
  }
}

public class PositionStyling {
  private int x;
  private int y;

  public int getPosX() {
    return x;
  }

  public void setPosX(int _x) {
    x = _x;
  }

  public int getPosY() {
    return y;
  }

  public void setPosY(int _y) {
    y = _y;
  }
}

// Very Hard-Coded (Thanks Processing for not having lambdas)
public class Scale extends Node implements IDatafiable {

  private final static int SPACING = 30;

  private int number = 0;
  private int value = -1;
  private int unitWidth, descWidth, descHeight;
  private int onUnit = -1;

  private String description = "";
  private int descFontSize, barFontSize;
  private String descFontName, barFontName;
  private PFont descFont, barFont;


  private final static int UNIT_OFFSET = 20;

  public Scale(int _number, int x, int y, int w, int h) {

    super(x, y, w, h);
    number = _number;
  }

  public void draw() {
    super.draw();
    fill(FILL_COLOR, OPACITY);
    strokeWeight(STROKE_WEIGHT);
    stroke(STROKE_R, STROKE_G, STROKE_B);
    for (int i = 0; i < number; ++i) {
      if (onUnit != i || onUnit != value)
        quad(SPACING + x + descWidth + (unitWidth * i), y, 
          SPACING + x + descWidth + (unitWidth * (i+1)), y, 
          SPACING + x + descWidth + (unitWidth * (i+1)) + UNIT_OFFSET, y+h, 
          SPACING + x + descWidth   + (unitWidth * i) + UNIT_OFFSET, y+h);
    }
    if (value >= 0) {
      fill(SELECTED_R, SELECTED_G, SELECTED_B, 255);
      quad(SPACING +x + descWidth + (unitWidth * value), y, 
        SPACING + x + descWidth + (unitWidth * (value+1)), y, 
        SPACING + x + descWidth + (unitWidth * (value+1)) + UNIT_OFFSET, y+h, 
        SPACING + x + descWidth + (unitWidth * value) + UNIT_OFFSET, y+h);
      fill(0);
      textAlign(CENTER, CENTER);
      if (barFont != null)
        textFont(barFont);
      text(""+(value+1), SPACING + x + descWidth + (unitWidth * value), y, unitWidth, h);
    }
    if (!description.isEmpty()) {
      textAlign(LEFT, BASELINE);
      fill(255);
      if (descFont != null)
        textFont(descFont);
      text(description, x, y, descWidth, descHeight);
    }
    noStroke();
    noFill();
    onHover();
  }

  public void update(int _mouseX, int _mouseY) {
    super.update(_mouseX, _mouseY);
    onUnit = -1;
    for (int i = 0; i < number; ++i) {
      if ((SPACING + x + descWidth + (unitWidth * i) < _mouseX && _mouseX < SPACING + x + descWidth + (unitWidth * (i+1)))
        && (y < _mouseY && _mouseY < y+h)) {
        onUnit = i;
      }
    }
  }

  public void onHover() {
    if (onUnit >= 0 && onUnit != value) {
      fill(FILL_COLOR, 255);
      strokeWeight(STROKE_WEIGHT);
      stroke(STROKE_R, STROKE_G, STROKE_B);
      quad(SPACING + x + descWidth + (unitWidth * onUnit), y, 
        SPACING + x + descWidth + (unitWidth * (onUnit+1)), y, 
        SPACING + x + descWidth + (unitWidth * (onUnit+1)) + UNIT_OFFSET, y+h, 
        SPACING + x + descWidth + (unitWidth * onUnit) + UNIT_OFFSET, y+h);
      fill(255);
      if (barFont != null)
        textFont(barFont);
      textAlign(CENTER, CENTER);
      text(""+(onUnit+1), SPACING + x + descWidth + (unitWidth * onUnit), y, unitWidth, h);
      noStroke();
      noFill();
    }
  }

  public void onClick() {
    if (onUnit >= 0)
      value = onUnit;
  }

  public void setDescWidth(int _x) {
    descWidth = _x;
  }

  public void setDescHeight(int _h) {
    descHeight = _h;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String _description) {
    description = _description;
  }

  public void setDescFontSize(int _fontSize) {
    descFontSize = _fontSize;
  }

  public void setBarFontSize(int _fontSize) {
    barFontSize = _fontSize;
  }

  public String getDescFont() {
    return descFontName;
  }

  public String getBarFont() {
    return barFontName;
  }

  public void setDescFont(String _fontName) {
    descFontName = _fontName; 
    descFont = createFont(descFontName, descFontSize, true);
  }

  public void setBarFont(String _fontName) {
    barFontName = _fontName; 
    barFont = createFont(barFontName, barFontSize, true);
  }

  public int getValue() {
    return value+1;
  }

  @Override
    public String getId() {
    return getDescription();
  }

  @Override
    public int getData() {
    return getValue();
  }

  @Override
    public void setWidth(int _width) {
    super.setWidth(_width);
    if (number > 0) {
      unitWidth = w / number;
    }
  }

  @Override
    public void setHeight(int _height) {
    super.setHeight(_height);
    descHeight = _height;
  }

  @Override
    public void setPosX(int _x) {
    super.setPosX(_x);
    if (description != null && description.isEmpty())
      descWidth = _x;
  }
}

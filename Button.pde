class Button extends Node{

  private ClickEvent click;
  private String text;
  private PFont font;
  private String fontName;
  private int fontSize;
  private int alignX;
  private int alignY;
  private OffsetStyling offset;

  Button(final int x, final int y, final int w, final int h, 
          ClickEvent _click) 
  {
   super(x, y, w, h);
   click = _click;
   text = "";
   alignX = LEFT;
   alignY = BASELINE;
   offset = new OffsetStyling();
  }
  
  public void draw() {
     super.draw();
     if(!text.isEmpty()) {
        if(font != null)
          textFont(font);
       fill(255);
       textAlign(alignX, alignY);
       text(text, x+offset.getOffsetX(), y+offset.getOffsetY(), w-offset.getOffsetW(), h-offset.getOffsetH());  
       textAlign(LEFT, BASELINE);
       noFill();  
     }
  }

  public void update(int x, int y) {
    super.update(x, y);
  }
  
  public void onClick() {
    if(inBounds)
      click.onClick();
  }
  
  public String getText() {
    return text;
  }
  
  public void setText(String _text) {
    text = _text;
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
  
  public void setAlignX(int _alignX) {
    alignX = _alignX;
  }
  
  public void setAlignY(int _alignY) {
    alignY = _alignY;
  }
  
  public OffsetStyling getOffset() {
    return offset;  
  }
  
  public void setOffset(OffsetStyling _offset) {
    offset = _offset; 
  }

  @Override
  public String toString() {
    return "Button: {"
            + "posX: " + x 
            + ", posY: " + y
            + ", width: " + w
            + ", height: " + h
            + "}";
  }
  

}

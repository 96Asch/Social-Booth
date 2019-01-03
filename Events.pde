abstract class ClickEvent {
  String id;
  
  public ClickEvent(String _id) {
    id = _id;  
  }
  
  public abstract void onClick();
}

abstract class Style {
  public abstract void setStyle(int x, int y, int w, int h);
}

abstract class HoverEvent{
  public abstract void onHover(int x, int y, int w, int h); 
}

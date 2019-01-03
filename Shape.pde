public class Shape extends Node {

  private PShape shape;
  private String shapeName;

  public Shape(int x, int y, int w, int h) {
    super(x, y, w, h);
  }

  public Shape(String _shapeName, int x, int y, int w, int h) {
    this(x, y, w, h);
    setShape(_shapeName);
  }

  @Override
    public void draw() {
    super.draw();
    if (shape != null) {
      shape(shape, x, y, w, h);
    }
  }

  @Override
    public void update(int x, int y) {
    super.update(x, y);
  }

  public String getShapeName() {
    return shapeName;
  }  

  public void setShape(String _shapeName) {
    shapeName = _shapeName;
    shape = loadShape(shapeName);
  }
}

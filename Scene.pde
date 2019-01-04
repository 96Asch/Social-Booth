class Scene extends BaseScene {

  private ArrayList<Node> nodes;
  private ArrayList<IDatafiable> dataNodes;
  private ClickEvent click;
  private boolean isDataPrepared;

  public Scene(String id) {
    super(id);           
    nodes = new ArrayList();
    dataNodes = new ArrayList();
    click = null;
    isDataPrepared = false;
  }

  public void setup() {
    println("Scene: " + getId());
    isDataPrepared = data.prepare(dataNodes, isDataPrepared);
    println("dsfsfsfsfsfs");
    println("AFTER: " + isDataPrepared);
    println();
  }

  @Override
    public void update() {
    for (int i = 0; i < nodes.size(); ++i) {
      nodes.get(i).update(mouseX, mouseY);
    }
  }

  public void draw() {
    background(bg);
    for (int i = 0; i < nodes.size(); ++i) {
      nodes.get(i).draw();
    }
  }

  public void addNode(Node node) {
    if (node != null) {
      nodes.add(node);
      if(node instanceof IDatafiable)
        dataNodes.add((IDatafiable) node);
    }
  }

  public void setOnClick(ClickEvent _click) {
    click = _click;
  }


  @Override
    public void onMouseClicked() {
    if (click != null)
      click.onClick();
    for (int i = 0; i < nodes.size(); ++i) {
      if (nodes.get(i) instanceof Button) {
        ((Button) nodes.get(i)).onClick();
        data.gather(dataNodes);
      } else if (nodes.get(i) instanceof Scale) {
        ((Scale) nodes.get(i)).onClick();
      }
    }
  }
}

class Scene extends BaseScene {

  private ArrayList<Node> nodes;
  private ArrayList<IDatafiable> dataNodes;
  private ClickEvent click;
  private boolean isDataPrepared;
  private Timer timer;

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
    if (timer != null)
      timer.start();
    for (Node node : nodes) {
      if (node instanceof Initializable) {
        ((Initializable) node).onInit();
      }
    }
  }

  @Override
    public void update() {
    for (int i = 0; i < nodes.size(); ++i) {
      nodes.get(i).update(mouseX, mouseY);
    }
    if (timer != null)
      timer.update();
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
      if (node instanceof IDatafiable)
        dataNodes.add((IDatafiable) node);
    }
  }

  public void setOnClick(ClickEvent _click) {
    click = _click;
  }

  public Timer getTimer() {
    return timer;
  }

  public void setTimer(Timer _timer) {
    timer = _timer;
  }
  
  @Override
  public void reset() {
    for(Node node : nodes)
      node.reset();
  }

  @Override
    public void onMouseClicked() {
    if (click != null)
      click.onClick();
    for (Node node : nodes) {
      node.onClick();
    }
    data.gather(dataNodes);
  }
}

class Scene extends BaseScene {

  private ArrayList<Node> nodes;
  private ClickEvent click;
  private TableRow dataRow;
  private boolean dataPrepared = false, dataGathered = false;

  public Scene(String id) {
    super(id);           
    nodes = new ArrayList();
    click = null;
  }

  public void setup() {
    println("Scene: " + getId());
    prepareData();
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
    }
  }

  public void removeText(int i) {
    if (0 <= i && i < nodes.size()) {
      nodes.remove(i);
    }
  }

  public void setOnClick(ClickEvent _click) {
    click = _click;
  }

  public void gatherData() {
    if (dataGathered) return;
    
    for (int i = 0; i < nodes.size(); ++i) {
      if (nodes.get(i) instanceof Scale) {
        Scale scale = (Scale) nodes.get(i); print(scale.getValue());
        dataRow.setInt(scale.getDescription(), scale.getValue());
      }
    }
    dataGathered = true;
  }

  private void prepareData() {
    if (dataPrepared) return;
    for (int i = 0; i < nodes.size(); ++i) {
      if (nodes.get(i) instanceof Scale) {
        Scale scale = (Scale) nodes.get(i); 
        data.getTable().addColumn(scale.getDescription());
      }
    }
    dataRow = data.getTable().addRow();
    dataPrepared = true;
  }

  @Override
    public void onMouseClicked() {
    if (click != null)
      click.onClick();
    for (int i = 0; i < nodes.size(); ++i) {
      if (nodes.get(i) instanceof Button) {
        ((Button) nodes.get(i)).onClick();
        gatherData();
      } else if (nodes.get(i) instanceof Scale) {
        ((Scale) nodes.get(i)).onClick();
      }
    }
  }
}

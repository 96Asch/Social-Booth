public class DataGather {
 
  private int y, m, d, h;
  private Table table;
  
  
  public DataGather() {
    y = year();
    m = month();
    d = day();
    h = hour();
    table = new Table();
  }
  
  public Table getTable() {
    return table;  
  }
  
  public void save() {
    String outName = String.format("data/SB_(%d-%d-%d-h%d)-(%d-%d-%d-h%d).csv", y, m, d, h, year(), month(), day(), hour());
    saveTable(table, outName);
  }
  
}

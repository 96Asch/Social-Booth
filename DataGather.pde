import java.util.List;

public class DataGather {

  private int y, m, d, h;
  private Table table;
  private TableRow currentRow;
  private boolean shouldPrepare, shouldGather;

  public DataGather() {
    y = year();
    m = month();
    d = day();
    h = hour();
    table = new Table();
    shouldGather = false;
    shouldPrepare = false;
  }

  public boolean prepare(List<IDatafiable> data, boolean isPrepared) {
    boolean ret = isPrepared;
    if (shouldPrepare && !data.isEmpty()) {
      if (!isPrepared) {
        for (IDatafiable d : data) {
          table.addColumn(d.getId(), Table.INT);
        }
        ret = true;
      }
      currentRow = table.addRow();
      shouldPrepare = false;
    }
    return ret;
  }

  public void gather(List<IDatafiable> data) {
    if (shouldGather && currentRow != null) {
      for (IDatafiable d : data) {
        currentRow.setInt(d.getId(), d.getData());
      }
      shouldGather = false;
    }
  }

  public void setShouldPrepare(boolean val) {
    shouldPrepare = val;
  }

  public void setShouldGather(boolean val) {
    shouldGather = val;
  }

  public Table getTable() {
    return table;
  }

  public void save() {
    String outName = String.format("data/SB_(%d-%d-%d-h%d)-(%d-%d-%d-h%d).csv", y, m, d, h, year(), month(), day(), hour());
    saveTable(table, outName);
  }
}

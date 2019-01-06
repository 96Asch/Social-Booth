public static class Util {
  public final static ArrayList<Node> EMPTY_LIST = new ArrayList();

  public static ArrayList<Node> check(ArrayList<Node> list) {
    return list == null ? EMPTY_LIST : list;
  }
}

int randInt(int start, int end) {
  return int(random(start, end));  
}

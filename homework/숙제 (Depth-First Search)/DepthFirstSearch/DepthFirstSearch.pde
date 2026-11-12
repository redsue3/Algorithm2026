// 숙제 (Depth-First Search)
// 참고: https://www.geeksforgeeks.org/dsa/depth-first-search-or-dfs-for-a-graph/

void setup() {
  int V = 5;
  ArrayList<ArrayList<Integer>> adj = new ArrayList<ArrayList<Integer>>();
  for (int i = 0; i < V; i++) adj.add(new ArrayList<Integer>());

  addEdge(adj, 1, 2);
  addEdge(adj, 1, 0);
  addEdge(adj, 2, 0);
  addEdge(adj, 2, 3);
  addEdge(adj, 2, 4);

  for (int x : dfs(adj)) print(x + " ");
  println();
}

void addEdge(ArrayList<ArrayList<Integer>> adj, int u, int v) {
  adj.get(u).add(v);
  adj.get(v).add(u);
}

void dfsRec(ArrayList<ArrayList<Integer>> adj, boolean[] visited, int s, ArrayList<Integer> res) {
  visited[s] = true;
  res.add(s);

  for (int i : adj.get(s)) {
    if (!visited[i]) dfsRec(adj, visited, i, res);
  }
}

ArrayList<Integer> dfs(ArrayList<ArrayList<Integer>> adj) {
  boolean[] visited = new boolean[adj.size()];
  ArrayList<Integer> res = new ArrayList<Integer>();
  dfsRec(adj, visited, 0, res);
  return res;
}

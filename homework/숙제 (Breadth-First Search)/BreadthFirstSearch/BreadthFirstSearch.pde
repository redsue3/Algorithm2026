// 숙제 (Breadth-First Search)
// 참고: https://www.geeksforgeeks.org/dsa/breadth-first-search-or-bfs-for-a-graph/

import java.util.LinkedList;
import java.util.Queue;

void setup() {
  int V = 5;
  ArrayList<ArrayList<Integer>> adj = new ArrayList<ArrayList<Integer>>();
  for (int i = 0; i < V; i++) adj.add(new ArrayList<Integer>());

  addEdge(adj, 1, 2);
  addEdge(adj, 1, 0);
  addEdge(adj, 2, 0);
  addEdge(adj, 2, 3);
  addEdge(adj, 2, 4);

  for (int x : bfs(adj)) print(x + " ");
  println();
}

void addEdge(ArrayList<ArrayList<Integer>> adj, int u, int v) {
  adj.get(u).add(v);
  adj.get(v).add(u);
}

ArrayList<Integer> bfs(ArrayList<ArrayList<Integer>> adj) {
  int V = adj.size();
  int src = 0;
  ArrayList<Integer> res = new ArrayList<Integer>();
  boolean[] visited = new boolean[V];
  Queue<Integer> q = new LinkedList<Integer>();

  visited[src] = true;
  q.add(src);

  while (!q.isEmpty()) {
    int curr = q.poll();
    res.add(curr);

    for (int x : adj.get(curr)) {
      if (!visited[x]) {
        visited[x] = true;
        q.add(x);
      }
    }
  }
  return res;
}

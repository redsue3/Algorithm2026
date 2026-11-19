// 숙제 (Minimum Spanning Tree) - 프림 알고리즘
// 참고: https://lotuslee.tistory.com/46

import java.util.PriorityQueue;

int V = 6;
ArrayList<Pair>[] arr = new ArrayList[V + 1];
boolean[] visited = new boolean[V + 1];

class Pair implements Comparable<Pair> {
  int n, w;

  Pair(int n, int w) {
    this.n = n;
    this.w = w;
  }

  public int compareTo(Pair o) {
    return w - o.w;
  }
}

void setup() {
  for (int i = 1; i <= V; i++) arr[i] = new ArrayList<Pair>();

  addEdge(1, 2, 10);
  addEdge(1, 3, 4);
  addEdge(2, 3, 2);
  addEdge(2, 4, 5);
  addEdge(3, 4, 16);
  addEdge(3, 5, 7);
  addEdge(4, 5, 8);
  addEdge(4, 6, 12);
  addEdge(5, 6, 23);

  println(getMST());
}

void addEdge(int u, int v, int w) {
  arr[u].add(new Pair(v, w));
  arr[v].add(new Pair(u, w));
}

long getMST() {
  PriorityQueue<Pair> pq = new PriorityQueue<Pair>();
  long sum = 0;
  pq.offer(new Pair(1, 0));

  while (!pq.isEmpty()) {
    Pair pair = pq.poll();

    if (visited[pair.n]) continue;
    visited[pair.n] = true;
    sum += pair.w;

    for (Pair np : arr[pair.n]) {
      if (!visited[np.n]) pq.offer(np);
    }
  }
  return sum;
}

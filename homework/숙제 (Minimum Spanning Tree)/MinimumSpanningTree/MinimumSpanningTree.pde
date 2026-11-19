// 숙제 (Minimum Spanning Tree) - 프림 알고리즘
// 참고: https://lotuslee.tistory.com/46
//       https://gmlwjd9405.github.io/2018/08/28/algorithm-mst.html

import java.util.PriorityQueue;

int V = 6;

// 정점 1~6의 위치 (0번은 안 씀)
float[][] pos = {
  {0, 0}, {80, 250}, {270, 100}, {270, 400}, {520, 100}, {520, 400}, {700, 250}
};

// {정점, 정점, 가중치}
int[][] EDGES = {
  {1, 2, 10}, {1, 3, 4}, {2, 3, 2}, {2, 4, 5}, {3, 4, 16},
  {3, 5, 7}, {4, 5, 8}, {4, 6, 12}, {5, 6, 23}
};

ArrayList<Pair>[] arr = new ArrayList[V + 1];
boolean[] visited = new boolean[V + 1];
int[] order = new int[V];        // MST에 들어간 정점 순서
int[] parent = new int[V + 1];   // 어느 정점에서 이어졌는지
int[] cost = new int[V + 1];     // 이어진 간선의 가중치
int count = 0;
long sum;

class Pair implements Comparable<Pair> {
  int n, w, from;

  Pair(int n, int w, int from) {
    this.n = n;
    this.w = w;
    this.from = from;
  }

  public int compareTo(Pair o) {
    return w - o.w;
  }
}

void setup() {
  size(780, 500);
  textFont(createFont("Malgun Gothic", 16));

  for (int i = 1; i <= V; i++) arr[i] = new ArrayList<Pair>();
  for (int[] e : EDGES) {
    arr[e[0]].add(new Pair(e[1], e[2], e[0]));
    arr[e[1]].add(new Pair(e[0], e[2], e[1]));
  }

  sum = getMST();

  for (int k = 1; k < count; k++) {
    int v = order[k];
    println(parent[v] + " - " + v + " : " + cost[v]);
  }
  println("sum = " + sum);
  noLoop();
}

long getMST() {
  PriorityQueue<Pair> pq = new PriorityQueue<Pair>();
  long sum = 0;
  pq.offer(new Pair(1, 0, 0));

  while (!pq.isEmpty()) {
    Pair pair = pq.poll();

    if (visited[pair.n]) continue;
    visited[pair.n] = true;
    sum += pair.w;

    order[count++] = pair.n;
    parent[pair.n] = pair.from;
    cost[pair.n] = pair.w;

    for (Pair np : arr[pair.n]) {
      if (!visited[np.n]) pq.offer(np);
    }
  }
  return sum;
}

void draw() {
  background(255);

  // 간선
  stroke(200);
  strokeWeight(2);
  for (int[] e : EDGES) {
    line(pos[e[0]][0], pos[e[0]][1], pos[e[1]][0], pos[e[1]][1]);
  }

  // MST 간선
  stroke(255, 130, 0);
  strokeWeight(6);
  for (int k = 1; k < count; k++) {
    int v = order[k], p = parent[v];
    line(pos[p][0], pos[p][1], pos[v][0], pos[v][1]);
  }

  // 가중치
  textAlign(CENTER, CENTER);
  textSize(14);
  for (int[] e : EDGES) {
    float x = (pos[e[0]][0] + pos[e[1]][0]) / 2;
    float y = (pos[e[0]][1] + pos[e[1]][1]) / 2;
    noStroke();
    fill(255);
    rect(x - 14, y - 11, 28, 22);
    fill(0);
    text(e[2], x, y);
  }

  // 정점과 MST에 들어간 순서
  for (int k = 0; k < count; k++) {
    int i = order[k];
    stroke(40, 60, 120);
    strokeWeight(2);
    fill(110, 170, 255);
    ellipse(pos[i][0], pos[i][1], 50, 50);
    fill(0);
    textSize(16);
    text(i, pos[i][0], pos[i][1]);
    fill(80);
    textSize(12);
    text("#" + (k + 1), pos[i][0] + 32, pos[i][1] - 26);
  }

  // 결과
  fill(0);
  textSize(16);
  textAlign(LEFT, CENTER);
  String s = "MST 간선:";
  for (int k = 1; k < count; k++) {
    int v = order[k];
    s += "  " + parent[v] + "-" + v + "(" + cost[v] + ")";
  }
  s += "    합계: " + sum;
  text(s, 20, 470);
}

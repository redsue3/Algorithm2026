// DFS: 1번 정점에서 시작해 번호가 작은 이웃부터 방문한다

final int N = 8;

// 정점 1~8의 위치 (배열 인덱스는 0~7)
float[][] pos = {
  {400, 70}, {200, 180}, {560, 180}, {480, 330},
  {660, 330}, {80, 420}, {200, 330}, {320, 230}
};

int[][] EDGES = {{1, 2}, {1, 3}, {1, 8}, {2, 7}, {3, 4}, {3, 5}, {4, 5}, {6, 7}, {7, 8}};

boolean[][] adj = new boolean[N][N];
boolean[] visited = new boolean[N];
int[] order = new int[N];    // 방문 순서
int[] parent = new int[N];   // 어느 정점에서 왔는지
int count = 0;

void setup() {
  size(760, 500);
  textFont(createFont("Malgun Gothic", 16));
  for (int[] e : EDGES) {
    adj[e[0] - 1][e[1] - 1] = true;
    adj[e[1] - 1][e[0] - 1] = true;
  }
  for (int i = 0; i < N; i++) parent[i] = -1;

  dfs(0);

  String s = "DFS :";
  for (int k = 0; k < count; k++) s += " " + (order[k] + 1);
  println(s);
  noLoop();
}

void dfs(int u) {
  visited[u] = true;
  order[count++] = u;
  for (int v = 0; v < N; v++) {
    if (adj[u][v] && !visited[v]) {
      parent[v] = u;
      dfs(v);
    }
  }
}

void draw() {
  background(255);

  // 간선
  stroke(200);
  strokeWeight(2);
  for (int[] e : EDGES) {
    int a = e[0] - 1, b = e[1] - 1;
    line(pos[a][0], pos[a][1], pos[b][0], pos[b][1]);
  }

  // 탐색 트리 간선
  stroke(255, 130, 0);
  strokeWeight(6);
  for (int k = 1; k < count; k++) {
    int v = order[k], p = parent[v];
    line(pos[p][0], pos[p][1], pos[v][0], pos[v][1]);
  }

  // 정점과 방문 번호
  textAlign(CENTER, CENTER);
  for (int k = 0; k < count; k++) {
    int i = order[k];
    stroke(40, 60, 120);
    strokeWeight(2);
    if (k == count - 1) fill(255, 80, 80);   // 마지막에 방문한 정점
    else fill(110, 170, 255);
    ellipse(pos[i][0], pos[i][1], 50, 50);
    fill(0);
    textSize(16);
    text(i + 1, pos[i][0], pos[i][1]);
    fill(80);
    textSize(12);
    text("#" + (k + 1), pos[i][0] + 32, pos[i][1] - 26);
  }

  // 방문 순서
  fill(0);
  textSize(16);
  textAlign(LEFT, CENTER);
  String s = "DFS 방문 순서: ";
  for (int k = 0; k < count; k++) s += (order[k] + 1) + (k < count - 1 ? " -> " : "");
  text(s, 20, 475);
}

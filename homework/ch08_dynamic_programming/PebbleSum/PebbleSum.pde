int n = 5;                        // 열 개수
int[][] table = new int[3][101];  // 3×n 테이블 (1번 열부터 씀)
int[][] w = new int[101][5];      // w[i][p] : i열을 패턴 p로 놓을 때 i열에 돌이 놓인 곳의 점수 합
int[][] peb = new int[101][5];    // peb[i][p] : i열을 패턴 p로 놓을 때 i열까지의 최대 점수 합

// 패턴 q가 패턴 p와 양립하는가 (패턴 1: 위, 2: 가운데, 3: 아래, 4: 위+아래)
boolean compatible(int q, int p) {
  if (p == 1) return q == 2 || q == 3;
  if (p == 2) return q == 1 || q == 3 || q == 4;
  if (p == 3) return q == 1 || q == 2;
  return q == 2;
}

int pebbleSum(int n) {
  for (int p = 1; p <= 4; p++)
    peb[1][p] = w[1][p];
  for (int i = 2; i <= n; i++) {
    for (int p = 1; p <= 4; p++) {
      int max = Integer.MIN_VALUE;
      for (int q = 1; q <= 4; q++)
        if (compatible(q, p) && peb[i-1][q] > max) max = peb[i-1][q];
      peb[i][p] = w[i][p] + max;
    }
  }
  int result = Integer.MIN_VALUE;
  for (int p = 1; p <= 4; p++)
    if (peb[n][p] > result) result = peb[n][p];
  return result;
}

void setup() {
  // Input : -9 ~ 9 난수
  for (int r = 0; r < 3; r++)
    for (int i = 1; i <= n; i++)
      table[r][i] = floor(random(-9, 10));

  // w 계산
  for (int i = 1; i <= n; i++) {
    w[i][1] = table[0][i];
    w[i][2] = table[1][i];
    w[i][3] = table[2][i];
    w[i][4] = table[0][i] + table[2][i];
  }

  // 테이블 출력
  for (int r = 0; r < 3; r++) {
    String line = "";
    for (int i = 1; i <= n; i++) line += nfp(table[r][i], 4) + " ";
    println(line);
  }
  println();

  int answer = pebbleSum(n);

  // peb 테이블 출력
  for (int p = 1; p <= 4; p++) {
    String line = "패턴" + p + " : ";
    for (int i = 1; i <= n; i++) line += nfp(peb[i][p], 4) + " ";
    println(line);
  }
  println();

  println(answer);
}

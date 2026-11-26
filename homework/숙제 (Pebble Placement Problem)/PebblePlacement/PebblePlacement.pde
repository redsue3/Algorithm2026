// 숙제 (Pebble Placement Problem)


int[][] table = {
  {  6,  7, 12, -5,  5,  3, 11,  3 },
  { -8, 10, 14,  9,  7, 13,  8,  5 },
  { 11, 12,  7,  4,  8, -2,  9,  4 }
};

void setup() {
  int cnt = table[0].length;
  int[][] Value = new int[4][cnt];   // Value[p][i] : i열을 패턴 p+1로 놓을 때 얻는 점수
  int[][] DP = new int[4][cnt];      // DP[p][i]    : i열을 패턴 p+1로 놓을 때 i열까지의 최대 합

  for (int i = 0; i < 3; i++)
    for (int j = 0; j < cnt; j++)
      Value[i][j] = table[i][j];

  for (int i = 0; i < cnt; i++)
    Value[3][i] = Value[0][i] + Value[2][i];

  DP[0][0] = Value[0][0];
  DP[1][0] = Value[1][0];
  DP[2][0] = Value[2][0];
  DP[3][0] = Value[3][0];

  for (int i = 1; i < cnt; i++) {
    DP[0][i] = max(DP[1][i - 1], DP[2][i - 1]) + Value[0][i];                    // 패턴 1 <- 패턴 2, 3
    DP[1][i] = max(max(DP[0][i - 1], DP[2][i - 1]), DP[3][i - 1]) + Value[1][i];  // 패턴 2 <- 패턴 1, 3, 4
    DP[2][i] = max(DP[0][i - 1], DP[1][i - 1]) + Value[2][i];                    // 패턴 3 <- 패턴 1, 2
    DP[3][i] = DP[1][i - 1] + Value[3][i];                                       // 패턴 4 <- 패턴 2
  }

  println("입력 테이블");
  for (int i = 0; i < 3; i++) {
    String line = "";
    for (int j = 0; j < cnt; j++) line += String.format("%4d", table[i][j]);
    println(line);
  }
  println();

  println("DP 테이블");
  for (int p = 0; p < 4; p++) {
    String line = "패턴" + (p + 1) + " : ";
    for (int j = 0; j < cnt; j++) line += String.format("%5d", DP[p][j]);
    println(line);
  }
  println();

  println("최대 합 : " + max(max(max(DP[0][cnt - 1], DP[1][cnt - 1]), DP[2][cnt - 1]), DP[3][cnt - 1]));
}

int i, j, cnt = 3;
int m[][] = new int[cnt+1][cnt+1];
void setup() {
  for (i = 0; i < cnt; i++) {
    for (j = 0; j < cnt; j++) {
      m[i+1][j+1] = (int) random(10);
      print(nfp(m[i+1][j+1],2)+" ");
    }
    println();
  }
  println(matrixPath(cnt , cnt));
}

void draw() {
}

int matrixPath(int i, int j) {
  if (i == 1 && j == 1)
    return m[i][j];
  else if(i == 1)
    return (matrixPath(1, j-1) + m[i][j]);
  else if(j == 1)
    return (matrixPath(i-1, 1) + m[i][j]);
  else
    return (min(matrixPath(i-1, j), matrixPath(i, j-1)) + m[i][j]);
}

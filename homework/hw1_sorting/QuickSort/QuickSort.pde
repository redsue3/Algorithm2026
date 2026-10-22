// Quick Sort (퀵 정렬)
// 맨 끝 원소를 기준(pivot)으로 삼아 작은 값은 왼쪽, 큰 값은 오른쪽으로 나눈 뒤 양쪽을 다시 정렬한다.
// 시간 복잡도: 평균 O(n log n), 이미 정렬된 배열처럼 한쪽으로만 나뉘면 최악 O(n^2)

int len = 16;
int[] list;

void setup() {
  list = new int[len];
  for (int i = 0; i < len; i++) {
    list[i] = (int) random(100);
  }
  printList("before          ");
  quickSort(0, len - 1);
  printList("after           ");
}

void draw() {
}

void quickSort(int p, int r) {
  if (p < r) {
    int q = partition(p, r);
    printList("pivot " + nf(list[q], 2) + " -> [" + nf(q, 2) + "]");
    quickSort(p, q - 1);
    quickSort(q + 1, r);
  }
}

// list[r]을 기준으로 나누고, 기준이 자리 잡은 위치를 돌려준다
int partition(int p, int r) {
  int x = list[r];
  int i = p - 1;
  for (int j = p; j < r; j++) {
    if (list[j] <= x) {
      i++;
      swap(i, j);
    }
  }
  swap(i + 1, r);
  return i + 1;
}

void swap(int i, int j) {
  int tmp = list[i];
  list[i] = list[j];
  list[j] = tmp;
}

void printList(String label) {
  print(label + ": ");
  for (int i = 0; i < len; i++) {
    print(nf(list[i], 2) + " ");
  }
  println();
}

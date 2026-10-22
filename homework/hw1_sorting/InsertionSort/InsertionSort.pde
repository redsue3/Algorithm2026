// Insertion Sort (삽입 정렬)
// 앞쪽은 이미 정렬된 구간으로 두고, 다음 원소를 그 안의 알맞은 자리에 끼워 넣는다.
// 시간 복잡도: O(n^2), 이미 정렬된 배열은 O(n)

int len = 16;
int[] list;

void setup() {
  list = new int[len];
  for (int i = 0; i < len; i++) {
    list[i] = (int) random(100);
  }
  printList("before ");
  insertionSort();
  printList("after  ");
}

void draw() {
}

void insertionSort() {
  int i, j, temp;
  for (i = 1; i < len; i++) {
    temp = list[i];
    for (j = i - 1; j >= 0 && list[j] > temp; j--) {   // temp보다 큰 값은 한 칸씩 뒤로
      list[j + 1] = list[j];
    }
    list[j + 1] = temp;
    printList("i = " + nf(i, 2) + " ");
  }
}

void printList(String label) {
  print(label + ": ");
  for (int i = 0; i < len; i++) {
    print(nf(list[i], 2) + " ");
  }
  println();
}

// Selection Sort (선택 정렬)
// 정렬되지 않은 구간에서 가장 큰 값을 찾아 그 구간의 맨 끝 원소와 맞바꾼다.
// 시간 복잡도: 항상 O(n^2)

int len = 16;
int[] list;

void setup() {
  list = new int[len];
  for (int i = 0; i < len; i++) {
    list[i] = (int) random(100);
  }
  printList("before  ");
  selectionSort();
  printList("after   ");
}

void draw() {
}

void selectionSort() {
  int i, j, max, index;
  for (i = len - 1; i > 0; i--) {   // list[0..i]가 아직 정렬되지 않은 구간
    max = -1;
    index = -1;
    for (j = 0; j <= i; j++) {
      if (max < list[j]) {
        max = list[j];
        index = j;
      }
    }
    swap(index, i);
    printList("pass " + nf(len - i, 2) + " ");
  }
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

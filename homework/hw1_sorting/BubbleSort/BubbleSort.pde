// Bubble Sort (버블 정렬)
// 이웃한 두 원소를 비교해 큰 값을 뒤로 보내면, 한 번 돌 때마다 가장 큰 값이 맨 뒤에 자리 잡는다.
// 시간 복잡도: O(n^2), 한 번도 교환이 없으면 바로 끝나므로 이미 정렬된 배열은 O(n)

int len = 16;
int[] list;

void setup() {
  list = new int[len];
  for (int i = 0; i < len; i++) {
    list[i] = (int) random(100);
  }
  printList("before  ");
  bubbleSort();
  printList("after   ");
}

void draw() {
}

void bubbleSort() {
  int i, j;
  boolean swapped;
  for (i = 0; i < len - 1; i++) {
    swapped = false;
    for (j = 0; j < len - 1 - i; j++) {   // j+1이 배열 밖으로 나가지 않도록 len-1-i까지
      if (list[j] > list[j + 1]) {
        swap(j, j + 1);
        swapped = true;
      }
    }
    printList("pass " + nf(i + 1, 2) + " ");
    if (!swapped) break;
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

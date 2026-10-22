// Heap Sort (힙 정렬)
// 배열을 최대 힙으로 만든 뒤, 루트(가장 큰 값)를 맨 뒤로 보내고 남은 부분을 다시 힙으로 만드는 일을 반복한다.
// 시간 복잡도: 항상 O(n log n), 배열 안에서 바로 정렬한다
// 0번부터 쓰는 배열이므로 k번 노드의 자식은 2k+1, 2k+2번이다.

int len = 16;
int[] list;

void setup() {
  list = new int[len];
  for (int i = 0; i < len; i++) {
    list[i] = (int) random(100);
  }
  printList("before      ");
  heapSort();
  printList("after       ");
}

void draw() {
}

void heapSort() {
  buildHeap();
  printList("build heap  ");
  for (int i = len - 1; i > 0; i--) {
    swap(0, i);       // 가장 큰 값을 맨 뒤로
    heapify(0, i);    // 남은 list[0..i-1]을 다시 힙으로
    printList("heap size " + nf(i, 2));
  }
}

void buildHeap() {
  for (int i = len / 2 - 1; i >= 0; i--) {
    heapify(i, len);
  }
}

// k번 노드 아래가 최대 힙이 되도록 큰 자식과 자리를 바꾸며 내려간다
void heapify(int k, int n) {
  int left = 2 * k + 1;
  int right = 2 * k + 2;
  int larger = k;
  if (left < n && list[left] > list[larger]) larger = left;
  if (right < n && list[right] > list[larger]) larger = right;
  if (larger != k) {
    swap(k, larger);
    heapify(larger, n);
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

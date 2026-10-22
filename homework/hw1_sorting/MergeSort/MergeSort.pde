// Merge Sort (병합 정렬)
// 배열을 반으로 나눠 각각 정렬한 뒤, 정렬된 두 부분을 하나로 합친다.
// 시간 복잡도: 항상 O(n log n), 합칠 때 같은 크기의 임시 배열이 필요하다

int len = 16;
int[] list;
int[] tmp;

void setup() {
  list = new int[len];
  tmp = new int[len];
  for (int i = 0; i < len; i++) {
    list[i] = (int) random(100);
  }
  printList("before        ");
  mergeSort(0, len - 1);
  printList("after         ");
}

void draw() {
}

void mergeSort(int p, int r) {
  if (p < r) {
    int q = (p + r) / 2;
    mergeSort(p, q);
    mergeSort(q + 1, r);
    merge(p, q, r);
    printList("merge [" + nf(p, 2) + ".." + nf(r, 2) + "]");
  }
}

// 정렬된 list[p..q]와 list[q+1..r]을 합친다
void merge(int p, int q, int r) {
  int i = p, j = q + 1, t = 0;
  while (i <= q && j <= r) {
    if (list[i] <= list[j]) tmp[t++] = list[i++];
    else tmp[t++] = list[j++];
  }
  while (i <= q) tmp[t++] = list[i++];
  while (j <= r) tmp[t++] = list[j++];
  for (i = p, t = 0; i <= r; i++, t++) {
    list[i] = tmp[t];
  }
}

void printList(String label) {
  print(label + ": ");
  for (int i = 0; i < len; i++) {
    print(nf(list[i], 2) + " ");
  }
  println();
}

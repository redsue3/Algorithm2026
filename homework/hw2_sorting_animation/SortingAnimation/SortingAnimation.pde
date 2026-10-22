// 정렬 알고리즘 애니메이션
// 실행하면 같은 배열로 Selection → Bubble → Insertion → Merge → Quick → Heap 정렬을 차례로 보여 준다.
// 빨간 막대는 지금 비교하거나 옮기는 원소, 정렬이 끝나면 전체가 초록색으로 바뀐다.

int N = 30;        // 막대 개수
int SPEED = 2;     // 한 단계를 보여 주는 프레임 수 (작을수록 빠르다)
String[] NAMES = {"Selection Sort", "Bubble Sort", "Insertion Sort", "Merge Sort", "Quick Sort", "Heap Sort"};

int[] original;    // 모든 정렬이 같은 배열로 시작한다
int[] a;           // 정렬 중인 배열
ArrayList<int[]> states = new ArrayList<int[]>();   // 단계별 배열 상태
ArrayList<int[]> marks = new ArrayList<int[]>();    // 단계별로 강조할 두 칸
int algo = 0;
int step = 0;
int waitFrames = 0;

void setup() {
  size(1280, 720);
  original = new int[N];
  for (int i = 0; i < N; i++) original[i] = i + 1;
  for (int i = N - 1; i > 0; i--) {   // 1~N을 무작위로 섞는다
    int j = (int) random(i + 1);
    int t = original[i];
    original[i] = original[j];
    original[j] = t;
  }
  prepare();
}

// 현재 알고리즘으로 정렬하면서 모든 단계를 기록해 둔다
void prepare() {
  a = original.clone();
  states.clear();
  marks.clear();
  record(-1, -1);
  if (algo == 0) selectionSort();
  else if (algo == 1) bubbleSort();
  else if (algo == 2) insertionSort();
  else if (algo == 3) mergeSort(0, N - 1);
  else if (algo == 4) quickSort(0, N - 1);
  else heapSort();
  record(-1, -1);
  step = 0;
  waitFrames = 0;
}

void record(int i, int j) {
  states.add(a.clone());
  marks.add(new int[] {i, j});
}

void swap(int i, int j) {
  int t = a[i];
  a[i] = a[j];
  a[j] = t;
}

void draw() {
  background(25);
  boolean finished = step == states.size() - 1;
  int[] s = states.get(step);
  int[] m = marks.get(step);

  float w = (width - 100) / (float) N;
  noStroke();
  for (int i = 0; i < N; i++) {
    if (finished) fill(80, 200, 120);
    else if (i == m[0] || i == m[1]) fill(235, 80, 70);
    else fill(220);
    float h = s[i] * (height - 180) / (float) N;
    rect(50 + i * w + 2, height - 40 - h, w - 4, h);
  }
  fill(255);
  textSize(36);
  textAlign(LEFT, TOP);
  text(NAMES[algo], 50, 30);

  if (!finished) {
    if (frameCount % SPEED == 0) step++;
  } else if (algo < NAMES.length - 1) {
    waitFrames++;
    if (waitFrames > 90) {   // 1.5초 쉬고 다음 정렬
      algo++;
      prepare();
    }
  }
}

// 매 회차 최댓값을 찾아 맨 오른쪽 원소와 교환한다
void selectionSort() {
  for (int last = N - 1; last > 0; last--) {
    int k = 0;
    for (int i = 1; i <= last; i++) {
      record(k, i);
      if (a[i] > a[k]) k = i;
    }
    swap(k, last);
    record(k, last);
  }
}

// 이웃한 두 원소를 비교해 왼쪽이 크면 교환한다
void bubbleSort() {
  for (int last = N - 1; last > 0; last--) {
    for (int i = 0; i < last; i++) {
      record(i, i + 1);
      if (a[i] > a[i + 1]) {
        swap(i, i + 1);
        record(i, i + 1);
      }
    }
  }
}

// 2번째 원소부터 앞쪽 정렬된 부분의 알맞은 자리까지 옮긴다
void insertionSort() {
  for (int i = 1; i < N; i++) {
    int j = i;
    record(j - 1, j);
    while (j > 0 && a[j - 1] > a[j]) {
      swap(j - 1, j);
      j--;
      record(j, j + 1);
    }
  }
}

// 반으로 나누어 각각 정렬한 뒤 임시 배열로 병합한다
void mergeSort(int p, int r) {
  if (p >= r) return;
  int q = (p + r) / 2;
  mergeSort(p, q);
  mergeSort(q + 1, r);
  int[] tmp = new int[r - p + 1];
  int i = p, j = q + 1, t = 0;
  while (i <= q && j <= r) {
    record(i, j);
    if (a[i] <= a[j]) tmp[t++] = a[i++];
    else tmp[t++] = a[j++];
  }
  while (i <= q) tmp[t++] = a[i++];
  while (j <= r) tmp[t++] = a[j++];
  for (int k = 0; k < tmp.length; k++) {
    a[p + k] = tmp[k];
    record(p + k, -1);
  }
}

// 맨 끝 원소를 기준으로 작은 수는 왼쪽, 큰 수는 오른쪽으로 분할한다
void quickSort(int p, int r) {
  if (p >= r) return;
  int x = a[r];
  int i = p - 1;
  for (int j = p; j < r; j++) {
    record(j, r);
    if (a[j] < x) {
      i++;
      swap(i, j);
      record(i, j);
    }
  }
  swap(i + 1, r);
  record(i + 1, r);
  quickSort(p, i);
  quickSort(i + 2, r);
}

// 최대 힙을 만든 뒤 루트(최댓값)를 맨 뒤로 보내고 다시 힙으로 만든다
void heapSort() {
  for (int k = N / 2 - 1; k >= 0; k--) heapify(k, N);
  for (int last = N - 1; last > 0; last--) {
    swap(0, last);
    record(0, last);
    heapify(0, last);
  }
}

void heapify(int k, int size) {
  while (true) {
    int l = 2 * k + 1, r = 2 * k + 2, big = k;
    if (l < size && a[l] > a[big]) big = l;
    if (r < size && a[r] > a[big]) big = r;
    if (big == k) return;
    record(k, big);
    swap(k, big);
    record(k, big);
    k = big;
  }
}

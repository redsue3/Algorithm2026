// 이진 검색 트리(BST) 애니메이션
// 실행하면 삽입 → 검색 → Inorder·Preorder·Postorder 순회 → 삭제를 차례로 보여 준다.
// 노란색: 지나가는 노드, 초록색: 새 노드·찾은 노드·방문한 노드, 빨간색: 삭제할 노드, 주황색: 대신 올라오는 노드

int[] INSERT_KEYS = {50, 30, 70, 20, 40, 60, 80, 35, 45, 65};
int DELAY = 40;    // 한 단계를 보여 주는 프레임 수

final int C_VISIT = 1, C_GREEN = 2, C_DELETE = 3, C_UP = 4;

class Node {
  int key;
  Node left, right;

  Node(int k) {
    key = k;
  }

  Node copy() {
    Node c = new Node(key);
    if (left != null) c.left = left.copy();
    if (right != null) c.right = right.copy();
    return c;
  }
}

// 화면 한 장면: 트리 사본, 노드 색, 위쪽 문구, 아래쪽 순회 결과
class Step {
  Node tree;
  HashMap<Integer, Integer> colors;
  String label, output;
}

Node root = null;
ArrayList<Step> steps = new ArrayList<Step>();
HashMap<Integer, Integer> colors = new HashMap<Integer, Integer>();
String label = "", output = "";
int current = 0;

void setup() {
  size(1280, 720);
  for (int k : INSERT_KEYS) insert(k);
  search(45);
  search(55);
  traverse("Inorder", 0);
  traverse("Preorder", 1);
  traverse("Postorder", 2);
  delete(20);   // 리프 노드
  delete(60);   // 자식이 하나인 노드
  delete(50);   // 자식이 둘인 노드 (루트)
}

void draw() {
  background(25);
  Step s = steps.get(current);
  if (s.tree != null) drawNode(s.tree, width / 2, 170, width / 4, s.colors);

  fill(255);
  textAlign(LEFT, TOP);
  textSize(36);
  text(s.label, 50, 30);
  textSize(30);
  text(s.output, 50, height - 80);

  if (frameCount % DELAY == 0 && current < steps.size() - 1) current++;
}

// 왼쪽 자식은 왼쪽 절반, 오른쪽 자식은 오른쪽 절반에 그린다
void drawNode(Node t, float x, float y, float dx, HashMap<Integer, Integer> c) {
  strokeWeight(2);
  if (t.left != null) {
    stroke(150);
    line(x, y, x - dx, y + 110);
    drawNode(t.left, x - dx, y + 110, dx / 2, c);
  }
  if (t.right != null) {
    stroke(150);
    line(x, y, x + dx, y + 110);
    drawNode(t.right, x + dx, y + 110, dx / 2, c);
  }
  int code = c.containsKey(t.key) ? c.get(t.key) : 0;
  if (code == C_VISIT) fill(245, 200, 60);
  else if (code == C_GREEN) fill(80, 200, 120);
  else if (code == C_DELETE) fill(235, 80, 70);
  else if (code == C_UP) fill(240, 140, 60);
  else fill(230);
  stroke(255);
  ellipse(x, y, 56, 56);
  fill(20);
  textAlign(CENTER, CENTER);
  textSize(22);
  text(t.key, x, y - 2);
}

void snap() {
  Step s = new Step();
  s.tree = root == null ? null : root.copy();
  s.colors = new HashMap<Integer, Integer>(colors);
  s.label = label;
  s.output = output;
  steps.add(s);
}

// 루트부터 작으면 왼쪽, 크면 오른쪽으로 내려가 빈자리에 넣는다
void insert(int x) {
  label = "Insert " + x;
  output = "";
  colors.clear();
  if (root == null) {
    root = new Node(x);
  } else {
    Node t = root;
    while (true) {
      colors.clear();
      colors.put(t.key, C_VISIT);
      snap();
      if (x == t.key) return;
      if (x < t.key) {
        if (t.left == null) { t.left = new Node(x); break; }
        t = t.left;
      } else {
        if (t.right == null) { t.right = new Node(x); break; }
        t = t.right;
      }
    }
  }
  colors.clear();
  colors.put(x, C_GREEN);
  snap();
  colors.clear();
}

void search(int x) {
  label = "Search " + x;
  output = "";
  Node t = root;
  while (t != null) {
    colors.clear();
    if (t.key == x) {
      label = "Search " + x + " : found";
      colors.put(t.key, C_GREEN);
      snap();
      colors.clear();
      return;
    }
    colors.put(t.key, C_VISIT);
    snap();
    t = x < t.key ? t.left : t.right;
  }
  colors.clear();
  label = "Search " + x + " : not found";
  snap();
}

// kind 0: Inorder, 1: Preorder, 2: Postorder
void traverse(String name, int kind) {
  label = name;
  output = "";
  colors.clear();
  walk(root, kind);
  snap();
  colors.clear();
}

void walk(Node t, int kind) {
  if (t == null) return;
  if (kind == 1) visit(t);
  walk(t.left, kind);
  if (kind == 0) visit(t);
  walk(t.right, kind);
  if (kind == 2) visit(t);
}

void visit(Node t) {
  output += t.key + "   ";
  colors.put(t.key, C_VISIT);
  snap();
  colors.put(t.key, C_GREEN);
}

// 자식이 없거나 하나면 자식이 그 자리를 대신하고,
// 자식이 둘이면 오른쪽 서브트리의 최솟값(직후원소)을 그 자리로 올린다
void delete(int x) {
  label = "Delete " + x;
  output = "";
  Node parent = null, t = root;
  while (t != null && t.key != x) {
    colors.clear();
    colors.put(t.key, C_VISIT);
    snap();
    parent = t;
    t = x < t.key ? t.left : t.right;
  }
  if (t == null) return;
  colors.clear();
  colors.put(x, C_DELETE);
  snap();

  if (t.left != null && t.right != null) {
    Node sp = t, s = t.right;
    while (s.left != null) {
      sp = s;
      s = s.left;
    }
    colors.put(s.key, C_UP);
    snap();
    t.key = s.key;
    if (sp == t) sp.right = s.right;
    else sp.left = s.right;
    colors.clear();
    colors.put(t.key, C_UP);
  } else {
    Node child = t.left != null ? t.left : t.right;
    if (parent == null) root = child;
    else if (parent.left == t) parent.left = child;
    else parent.right = child;
    colors.clear();
    if (child != null) colors.put(child.key, C_UP);
  }
  snap();
  colors.clear();
}

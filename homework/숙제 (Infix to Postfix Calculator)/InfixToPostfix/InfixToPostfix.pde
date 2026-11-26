// 숙제 (Infix to Postfix Calculator)

import java.util.Stack;

String[] exps = {
  "2 + 3 * 4",
  "(2 + 3) * 4",
  "2 ^ 3 ^ 2",
  "100 / 5 / 2",
  "3 + 4 * 2 / (1 - 5) ^ 2",
  "6*4+2^5-3"
};

void setup() {
  for (String exp : exps) {
    String postfix = infixToPostfix(exp);
    println("중위 : " + exp);
    println("후위 : " + postfix);
    println("결과 : " + evaluatePostfix(postfix));
    println();
  }
}

// 연산자 우선순위
int prec(char c) {
  if (c == '^') return 3;
  else if (c == '/' || c == '*') return 2;
  else if (c == '+' || c == '-') return 1;
  else return -1;
}

// ^ 만 오른쪽부터 계산한다
boolean isRightAssociative(char c) {
  return c == '^';
}

// 중위 표기식 -> 후위 표기식
String infixToPostfix(String s) {
  Stack<Character> st = new Stack<Character>();
  StringBuilder res = new StringBuilder();

  for (int i = 0; i < s.length(); i++) {
    char c = s.charAt(i);
    if (c == ' ') continue;

    if (Character.isDigit(c)) {
      // 숫자는 바로 출력 (여러 자리 숫자는 한 덩어리로)
      while (i < s.length() && Character.isDigit(s.charAt(i))) {
        res.append(s.charAt(i));
        i++;
      }
      i--;
      res.append(' ');
    } else if (c == '(') {
      st.push(c);
    } else if (c == ')') {
      // '(' 를 만날 때까지 꺼내서 출력
      while (st.peek() != '(') {
        res.append(st.pop()).append(' ');
      }
      st.pop();
    } else {
      // 스택 위의 연산자가 우선순위가 더 높거나, 같으면서 왼쪽부터 계산하는 연산자면 꺼낸다
      while (!st.isEmpty() && st.peek() != '(' &&
             (prec(st.peek()) > prec(c) ||
              (prec(st.peek()) == prec(c) && !isRightAssociative(c)))) {
        res.append(st.pop()).append(' ');
      }
      st.push(c);
    }
  }

  while (!st.isEmpty()) {
    res.append(st.pop()).append(' ');
  }
  return res.toString().trim();
}

// 후위 표기식 계산
double evaluatePostfix(String postfix) {
  Stack<Double> st = new Stack<Double>();

  for (String tok : split(postfix, ' ')) {
    if (Character.isDigit(tok.charAt(0))) {
      st.push(Double.parseDouble(tok));
    } else {
      double b = st.pop();   // 오른쪽 피연산자를 먼저 꺼낸다
      double a = st.pop();
      char op = tok.charAt(0);
      if (op == '+') st.push(a + b);
      else if (op == '-') st.push(a - b);
      else if (op == '*') st.push(a * b);
      else if (op == '/') st.push(a / b);
      else if (op == '^') st.push(Math.pow(a, b));
    }
  }
  return st.pop();
}

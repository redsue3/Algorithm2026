int a =1;
int b = 1;
int c;
for(int i=0; i<10; i++) {
  c = b + a;
  println(c);
  a = b;
  b = c;
}

int[] arr;

void setup() {
  int i, j,tmp;
  arr = new int[16];
  
  
  for(i=0;i<arr.length;i++) {
    arr[i] = (int)random(100);
  }

  for(i=0;i<arr.length;i++) {
    for(j=0;j<arr.length-1;j++) {
      if(arr[j] > arr[j+1]) {
        tmp = arr[j];
        arr[j] = arr[j+1];
        arr[j+1] = tmp;
      }
  }
}

  for (i=0;i<arr.length;i++) {
    print(arr[i] + " ");
  }
}

void draw() {
  
}

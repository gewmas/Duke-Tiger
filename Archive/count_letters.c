#include <stdio.h>
#include <string.h>

#define TRUE 1
#define FALSE 0

char A[20] = "how is everything?";
char B[20] = "ssasasassassaaa";

// This function iterates through the character string "str" (which is of
// length "str_len" and counts how many instances there are of the
// character "c".
int
count_letters(char str[], int str_len, char c) {
  int count = 0;
  for (int i = 0 ; i < str_len ; ++ i) {
	 if (str[i] == c) {
		count ++;
	 }
  }
  return count;
}

// This function iterates through the character string "str" (which is of
// length "str_len" and counts how many instances there are of the
// string "sub_str" (which is of length "substr_len"). 
int
count_substring(char str[], int str_len, char sub_str[], int substr_len) {
  int count = 0;
  for (int i = 0 ; i < (str_len - substr_len) ; ++ i) {
    int match = TRUE;
    for (int j = 0 ; j < substr_len ; ++ j) {
      if (str[i+j] != sub_str[j]) {
        match = FALSE;
        break;
      }
    }
    if (match) {
      count ++;
    }      
  }
  return count;
}

int
main(int argc, char *argv[]) {
  int v = count_letters(A, strlen(A), 'v');
  printf("%d, %d\n", v, strlen(A));
  int w = count_substring(B, strlen(B), "sa", 2);
  printf("%d %d\n", w, strlen(B));
  return 0;
}

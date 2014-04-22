/* 
 * Find the largest palindromic number formed from two factors
 * given that each factor is of n digits.
 * TODO - Improve efficiency by generating multiplicative products
 *        of n digit numbers in descending order.
*/

#include "stdlib.h"
#include "stdio.h"
#include "math.h"

int isPalindrome(int _num)
{
  int num = _num,
      inv = 0;
  while (num > 0)
  {
    inv = (inv*10) + num%10;
    num /= 10;
  }
  return inv == _num;
}

int main(int argc, char** argv)
{
  if (argc < 2)
    return 1;
  int n = atoi(argv[1]);
  int upper = pow(10, n),
      lower = pow(10, n - 1),
      crrt = 0, palin = 0;
  for (int i = lower; i < upper; i++)
  for (int j = lower; j < upper; j++)
  {
    crrt = i*j;
    if (isPalindrome(crrt) && crrt > palin)
      palin = crrt;
  }
  printf("Upper: %d\nLower: %d\n", upper, lower);
  printf("Highest palindrom factor: %d\n", palin);
  return 0;
}

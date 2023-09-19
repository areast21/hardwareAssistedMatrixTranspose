#include "omsp_system.h"

int main(void) {
  WDTCTL = WDTPW | WDTHOLD;

  int c = 0;

  P1DIR  = 0xFF;                     

  while (1) 
    P1OUT = c++;
  
}

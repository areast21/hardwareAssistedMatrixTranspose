#include "omsp_system.h"
#include "omsp_uart.h"

void myprintf(char *c) {
  while (*c)
    putchar(*c++);
}

int main(void) {
  WDTCTL = WDTPW | WDTHOLD;          // Disable watchdog timer

  P1DIR  = 0xFF;                     // P1 as output

  uartinit();

  myprintf("Hello World!\n");
  
  P1OUT  = 0xF0;                    //  Simulation Stopping Command

}

#include "omsp_system.h"
#include "omsp_uart.h"

#define REG1   (*(volatile unsigned      *) 0x110)
#define REG2   (*(volatile unsigned char *) 0x112)
#define REG3   (*(volatile unsigned char *) 0x115)

char c16[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

void puthex(unsigned k) {
  putchar(c16[((k>>12) & 0xF)]);
  putchar(c16[((k>>8 ) & 0xF)]);
  putchar(c16[((k>>4 ) & 0xF)]);
  putchar(c16[((k    ) & 0xF)]);
}

int main(void) {
  WDTCTL = WDTPW | WDTHOLD;  // Disable watchdog timer

  uartinit();

  REG1 = 0x1234;
  REG2 = 0x56;
  REG3 = 0x78;

  putchar('R');
  puthex(REG1);
  putchar(' ');

  putchar('R');
  puthex(REG2);
  putchar(' ');

  putchar('R');
  puthex(REG3);
  putchar(' ');

  putchar('+');
  putchar('+');
  putchar('+');

  P1OUT  = 0xF0;                    //  Simulation Stopping Command
  return 0;
}


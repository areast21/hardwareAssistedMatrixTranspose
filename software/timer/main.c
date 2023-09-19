#include "omsp_system.h"
#include "omsp_uart.h"

char c16[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

void puthex(unsigned k) {
  putchar(c16[((k>>12) & 0xF)]);
  putchar(c16[((k>>8 ) & 0xF)]);
  putchar(c16[((k>>4 ) & 0xF)]);
  putchar(c16[((k    ) & 0xF)]);
}

unsigned count = 0;

unsigned TimerLap() {
  unsigned lap;
  TACTL &= ~(MC1 | MC0);
  lap = TAR - count;
  count = TAR;
  TACTL |= MC1;
  return lap;
}

unsigned euclid(unsigned a, unsigned b) {
  while (a != b) {
    if (a > b)
      a = a - b;
    else
      b = b - a;
  }
  return a;
}

int main(void) {
  int e, d;

  WDTCTL = WDTPW | WDTHOLD;  // Disable watchdog timer
  TACTL  |= (TASSEL1 | MC1 | TACLR); // Configure timer

  uartinit();
  
  /*TimerLap();
  P1OUT = 0x01;
  e = euclid(0x1,0x1770);
  P1OUT = 0x00;
  d = TimerLap();

  putchar('R');
  puthex(e);
  putchar(' ');
  puthex(d);*/
  
  /*TimerLap();
  P1OUT = 0x01;
  e = euclid(0x1, 0x9AB);
  P1OUT = 0x00;
  d = TimerLap();

  putchar('R');
  puthex(e);
  putchar(' ');
  puthex(d);
  */
  
  for(int j = 1000; j <= 65535 ; j = j + 1000){
  	
  	TimerLap();
  	P1OUT = 0x01;
  	e = euclid(1,j);
  	P1OUT = 0x00;
  	d = TimerLap();
	
	putchar('O');
	puthex(j);
	putchar(' ');
  	putchar('R');
  	puthex(e);
  	putchar(' ');
  	putchar('C');
  	puthex(d);
  	putchar(' ');
  	putchar(' ');
  	putchar(' ');
  		
  }

  putchar('+');
  putchar('+');
  putchar('+');

  P1OUT  = 0xF0;                    //  Simulation Stopping Command
  return 0;
}

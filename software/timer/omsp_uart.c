#include "omsp_system.h"
#include "omsp_uart.h"

// BAUDRATE = 10M @ 20MHz clock
// The BAUD divisor is equal to ceil(systemclock/baudrate - 1)
#define BAUD 1

void uartinit() {
  UART_BAUD = BAUD;         
  UART_CTL  = UART_EN | UART_IEN_RX;
}

int putchar (int txdata) {
  while (UART_STAT & UART_TX_FULL);
  UART_TXD = txdata;
  return 0;
}

char rxdata;

interrupt (UART_RX_VECTOR) INT_uart_rx(void) {
  rxdata = UART_RXD;
  UART_STAT = UART_RX_PND;
}

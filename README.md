# hardwareAssistedMatrixTranspose-targettedForMSP430
Aim of the project was to make a comparative study on latency and area that a microcontroller takes to perform a 64-bit (8x8) matrix transpose through firmware (C code) versus using a hardware peripheral (Verilog implementation) to achieve the same result. <br/>
The running time to perform a single transpose in firmware - 431.7 ps and with hardware assistance - 151.7 ps. It is observed that there is a speed up by 2.8 times when transpose is performed through the transpose peripheral.<br/>
Through synthesis it was evident that speedup was achieved through a negible increase in area (from 76.5 K Sq. Um to 79.3 K Sq. Um). 

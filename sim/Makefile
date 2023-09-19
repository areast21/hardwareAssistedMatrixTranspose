# SYSDIR = ../software/sandbox
# SYSDIR = ../software/uart
# SYSDIR = ../software/timer
# SYSDIR = ../software/mmreg
SYSDIR = ../software/transpose

TARGET = $(SYSDIR)/app.elf

TOPLEVEL = topleveltb.v

PMEM_SIZE = 8192

all:
	@echo "iver		Simulate with iVerilog"
	@echo "clean		Cleanup"

iver:
	msp430-elf-objcopy -O ihex $(TARGET) pmem.ihex
	./ihex2mem.tcl -ihex pmem.ihex -out pmem.mem -mem_size $(PMEM_SIZE)
	iverilog -y ../rtl -y . -y ../rtl/periph -y $(SYSDIR) -I ../rtl -I ../rtl/periph -DSEED=1 topleveltb.v

clean:
	rm -rf a.out *~ *vcd pmem.ihex pmem.mem

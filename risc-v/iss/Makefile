INC_DIR = ../shared
CFLAGS = -Wall -I $(INC_DIR)
DEPS = riscv_instr_defines.h
TESTNAME =

hex: src/*.c
	gcc -fPIC $(CFLAGS) -shared -g -O2 $^ -o lib$@.so

hex_preload: src/*.c
	gcc -fPIC $(CFLAGS) -shared -g -O2 $^ -o lib$@.so -D PRELOAD_ARCH_REGS

iss: src/*.c
	gcc -fPIC $(CFLAGS) -shared -g -m32 -O2 $^ -o $@.so

iss_preload: src/*.c
	gcc -fPIC $(CFLAGS) -shared -g -m32 -O2 $^ -o $@.so -D PRELOAD_ARCH_REGS

sim: src/*.c
	gcc $(CFLAGS) -g -O2 $^ -o $@

iss_comp: src/*.c
	gcc -fPIC $(CFLAGS) -g -O2 $^ -o $@

iss_run: iss_comp
	./iss_comp $(TESTNAME)

.PHONY: clean
clean:
	rm -rf *.so *~ sim iss*

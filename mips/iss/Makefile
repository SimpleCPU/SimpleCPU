INC_DIR = ../shared
CFLAGS = -Wall -I $(INC_DIR)
DEPS = mips_instr_defines.h

hex: src/*.c
	gcc -fPIC $(CFLAGS) -shared -g -O2 $^ -o lib$@.so

iss: src/*.c
	gcc -fPIC $(CFLAGS) -shared -g -m32 -O2 $^ -o $@.so

sim: src/*.c
	gcc $(CFLAGS) -g -O2 $^ -o $@

.PHONY: clean
clean:
	rm -rf *.so *~ sim

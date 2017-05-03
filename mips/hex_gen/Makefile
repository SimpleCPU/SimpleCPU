INC_DIR = ../shared
CFLAGS = -Wall -I $(INC_DIR)
DEPS = mips_instr_defines.h

all: src/*.c
	gcc $(CFLAGS) -g -O2 $^ -o hex_gen -l :lib/libhex.so -D GEN_USER_TEST

hex: src/*.c
	gcc $(CFLAGS) -g -O2 $^ -o hex_gen -l :lib/libhex.so

.PHONY: clean
clean:
	rm -rf hex_gen pc_values_hex instr_hex

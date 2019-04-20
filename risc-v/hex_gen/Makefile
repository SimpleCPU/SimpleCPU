INC_DIR = ../shared
CFLAGS = -Wall -I $(INC_DIR)
DEPS = riscv_instr_defines.h

all: src/*.c
	gcc $(CFLAGS) -g -O2 $^ -o hex_gen -L. lib/libhex.so -D GEN_USER_TEST

hex: src/*.c
	gcc $(CFLAGS) -g -O2 $^ -o hex_gen -L. lib/libhex.so

hex_preload: src/*.c
	gcc $(CFLAGS) -g -O2 $^ -o hex_gen -L. lib/libhex_preload.so

.PHONY: clean
clean:
	rm -rf hex_gen pc_values_hex instr_hex

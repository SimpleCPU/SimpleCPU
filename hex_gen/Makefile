all: src/hex_gen.c
	gcc -W -g -O2 $^ -o hex_gen -l :lib/libhex.so

.PHONY: clean
clean:
	rm -rf hex_gen

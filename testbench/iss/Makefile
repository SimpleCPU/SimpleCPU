hex: src/main.c src/sim.c
	gcc -fPIC -W -shared -g -O2 $^ -o lib$@.so

iss: src/main.c src/sim.c
	gcc -fPIC -W -shared -g -m32 -O2 $^ -o $@.so

sim: src/main.c src/sim.c
	gcc -W -g -O2 $^ -o $@

.PHONY: clean
clean:
	rm -rf *.so *~ sim

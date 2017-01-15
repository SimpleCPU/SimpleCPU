hex: main.c sim.c
	gcc -fPIC -W -shared -g -O2 $^ -o lib$@.so

iss: main.c sim.c
	gcc -fPIC -W -shared -g -m32 -O2 $^ -o $@.so

.PHONY: clean
clean:
	rm -rf *.so *~ sim

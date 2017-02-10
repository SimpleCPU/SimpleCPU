hex: src/*.c src/*.h
	gcc -fPIC -W -shared -g -O2 $^ -o lib$@.so

iss: src/*.c src/*.h
	gcc -fPIC -W -shared -g -m32 -O2 $^ -o $@.so

sim: src/*.c src/*.h
	gcc -W -g -O2 $^ -o $@

.PHONY: clean
clean:
	rm -rf *.so *~ sim

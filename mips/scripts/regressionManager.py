import os
import shutil
import subprocess
from pexpect import fdpexpect


def regression():
	main_dir = '../mips-single-cycle/'
	test_dir = '../hex_gen/tests/'

	sub_dir = os.listdir(test_dir)
	hex_dir = ''
	pc = 'pc'

	for s in sub_dir:
		stress_test = []
		basic_test = []
		if len(os.listdir(test_dir + s)) == 2:
			directory = os.listdir(test_dir + s)[1]
		else:
			directory = os.listdir(test_dir + s)[0]

		hex_dir = test_dir + s + '/' + directory + '/'	
		for f in os.listdir(hex_dir):
			stress = 'stress'
			basic = 'basic'
			if stress in f:
				stress_test.append(f)
			if basic in f:
				basic_test.append(f)
		if basic_test:
			for files in basic_test:
				if pc not in files:
					print "\n" + "*" * 10 + "Running tests from: " + hex_dir + "*" * 10 + "\n"
					child = fdpexpect.fdspawn(subprocess.call("perl " + main_dir + "run.pl -regress 1 -test " + hex_dir + files.split('.')[0], shell=True))
					c = child.expect(['Fatal: TEST FAILED'])
					if c == 1:
						child.kill(0)
		
		if stress_test:
			for files in stress_test:
				if pc not in files:
					print "\n" + "*" * 10 + "Running tests from: " + hex_dir + "*" * 10 + "\n"
					child = fdpexpect.fdspawn(subprocess.call("perl " + main_dir + "run.pl -regress 1 -test " + hex_dir + files.split('.')[0], shell=True))
					c = child.expect(['Fatal: TEST FAILED'])
					if c == 1:
						child.kill(0)


def main():
	regression()

if __name__ == '__main__':
	main()
		

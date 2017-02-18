import os
import shutil
import subprocess


def regression():
	main_dir = '../mips-single-cycle/'
	test_dir = '../hex_gen/tests/'

	sub_dir = os.listdir(test_dir)
	hex_dir = ''

	for s in sub_dir:
		stress_test = []
		basic_test = []
		hex_dir = test_dir + s + '/' + os.listdir(test_dir + s)[1] + '/'	
		for f in os.listdir(hex_dir):
			stress = 'stress'
			basic = 'basic'
			if stress in f:
				stress_test.append(f)
			if basic in f:
				basic_test.append(f)
		if basic_test:
			pc = 'pc'
			for files in basic_test:
				if pc in files:
					shutil.copyfile(hex_dir + files, main_dir + 'pc_values_hex')
				elif pc not in files:
					shutil.copyfile(hex_dir + files, main_dir + 'instr_hex')
			for files in stress_test:
				if pc in files:
					shutil.copyfile(hex_dir + files, main_dir + 'pc_values_hex')
				elif pc not in files:
					shutil.copyfile(hex_dir + files, main_dir + 'instr_hex')
		subprocess.call("perl " + main_dir + "run.pl | tee results.txt", shell=True)

def main():
	regression()

if __name__ == '__main__':
	main()
		

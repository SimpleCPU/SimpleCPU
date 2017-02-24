import os
import re
import time
import shutil
import subprocess
from pexpect import fdpexpect

Logfilename = str(int(time.time()))

def regression():
	main_dir = '../mips-single-cycle/'
	test_dir = '../hex_gen/tests/'

	sub_dir = os.listdir(test_dir)
	hex_dir = ''
	pc = 'pc'
	testfile = open(Logfilename, "w+")
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
					cmd = "perl " + main_dir + "run.pl -regress 1 -test " + hex_dir + files.split('.')[0]
					subprocess.Popen(cmd, shell = True, stdout=testfile, stderr=testfile)
		
		if stress_test:
			for files in stress_test:
				if pc not in files:
					print "\n" + "*" * 10 + "Running tests from: " + hex_dir + "*" * 10 + "\n"
					cmd = "perl " + main_dir + "run.pl -regress 1 -test " + hex_dir + files.split('.')[0]
					subprocess.Popen(cmd, shell = True, stdout=testfile,stderr=testfile)

	testfile.close()

def parseLog():
	Logfile = open(Logfilename,'r+')
	test = r"# Loading ..\/hex_gen\/tests\/(.*)"
	testfile = ''
	regex = r"# TEST PASSED"
	match = 0
	for line in Logfile:
		matchtest = re.match(test, line)
		if matchtest:
			testfile = matchtest.group(1)
			print testfile
		if re.match(regex, line):
			match = match + 1
			print "[ERROR] " + testfile +" failed during regression run, Logging results in " + Logfilename
			
	if match == 0:
		print "[DEBUG] No tests failed, no log files created"
		os.remove(Logfilename)
	Logfile.close()

def main():
	regression()
	parseLog()

if __name__ == '__main__':
	main()
		

import sys
if len(sys.argv) != 2:
	print 'usage : parselog.py <path-to-file> \nYou must specify the path to the log file as the first argument'
	sys.exit(1)


filename = sys.argv[1]

logfile = open(filename, "r").readlines()

#data arrays
items = []
itemsList = []

#extracting data from file
for line in logfile:
	if 'RESULTS' in line:
			itemsList.append(line.split()[-1])

#parsing data 
it = iter(itemsList)
for item in it:
	print "{0}, {1}".format(item, it.next())
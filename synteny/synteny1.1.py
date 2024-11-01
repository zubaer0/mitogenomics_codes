#!/usr/bin/python

import sys
file = open (sys.argv[1], 'r')
mystr = ''
for line in file:
	try:
		mylist = line.split(';')
		mystr = mystr + ''.join(mylist[3])
	except:
		continue
newlist = mystr.split('gene=')
#remove blank string from list
while '' in newlist:
	newlist.remove('')

#remove duplicate items 
#finalist=[]
#for item in newlist:
#	if item not in finalist:
#		finalist.append(item)

#starting from cox1
outputlist=[]
for i, item in enumerate(newlist):
	if item == 'cox1':
		outputlist = newlist[i:] + newlist[:i]

print ' '.join(outputlist)

file.close()
	

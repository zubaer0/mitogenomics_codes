#!/usr/bin/python

import sys
import os
file = open (sys.argv[1], 'r')


genelist = ['cox1','COX1', 'CO1','COXI', 'cox2','COX2','COXII', 'CO2', 'cox3','COX3', 'CO3','COXIII', 'cob', 'CYTB', 'nad1', 'ND1', 'nad2', 'ND2', 'nad3', 'ND3', 'nad4','ND4', 'nad4L', 'ND4L', 'nad5', 'ND5', 'nad6', 'ND6', 'atp6', 'ATP6', 'atp8', 'ATP8', 'atp9', 'ATP9', 'rps3', 'RPS3', 'rnl','MTRNR2', 'rns', 'MTRNR1']

genename = [
	'NADH dehydrogenase subunit 1', 'NADH-ubiquinone oxidoreductase subunit 1',
	'NADH dehydrogenase subunit 2','NADH-ubiquinone oxidoreductase subunit 2',
	'NADH dehydrogenase subunit 3','NADH-ubiquinone oxidoreductase subunit 3',
	'NADH dehydrogenase subunit 4','NADH-ubiquinone oxidoreductase subunit 4',
	'NADH dehydrogenase subunit 4L','NADH-ubiquinone oxidoreductase subunit 4L',
	'NADH dehydrogenase subunit 5','NADH-ubiquinone oxidoreductase subunit 5',
	'NADH dehydrogenase subunit 6','NADH-ubiquinone oxidoreductase subunit 6',
	'cytochrome oxidase subunit I', 'cytochrome oxidase subunit 1', 'cytochrome c oxidase subunit 1',
	'cytochrome oxidase subunit II', 'cytochrome oxidase subunit 2','cytochrome c oxidase subunit 2',
	'cytochrome oxidase subunit III', 'cytochrome oxidase subunit 3','cytochrome c oxidase subunit 3',
	'cytochrome oxidase subunit b',
	'ATP synthase subunit 6',
	'ATP synthase subunit 8',
	'ATP synthase subunit 9',
	'ribosomal protein S5', 'ribosomal protein S3',
	'small ribosomal subunit', 'small subunit',
	'large ribosomal subunit', 'large subunit'
	]


mylist = []
mylist2 = []


for line in file:
	for item in genelist:
		if (item in line) and (item not in mylist):
			mylist.append(item)
			
			
			
if not mylist: # the pythonic way to check mylist == [] or len(mylist) == 0
	file.seek(0,0)
	for line in file:
		for x in genename:
			if (x in line) and (x not in mylist2):
				mylist2.append(x)
	print mylist2, '\n'
else:
	#starting from cox1
	outputlist=[]
	for i, item in enumerate(mylist):
		if item == 'cox1' or item == 'CO1' or item == 'COXI':
			outputlist = mylist[i:] + mylist[:i]
	if not outputlist:
		print mylist
	else:
		print ' '.join(outputlist)


file.close()
	

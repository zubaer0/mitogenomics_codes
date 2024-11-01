#!/usr/bin/python

import sys
genelib = {
    'cox1': 'A',     'cox2': 'C',     'cox3': 'D',     'cob': 'E',
    'nad1': 'F',     'nad2': 'G',     'nad3': 'H',     'nad4': 'I',
    'nad4l': 'K',    'nad5': 'L',     'nad6': 'M',     # N is not used       
    'rns': 'P',      'rnl': 'Q',      'rps3': 'R',
    'atp6': 'S',     'atp8': 'T',     'atp9': 'W'      # V and Y are not used      
    }

file = open(sys.argv[1], 'r')

for line in file:
	if line[0] == '':
		continue 
	
	elif line[0] == '>':
		header = ''
		header = line
	else: 
		seq = ''
		seq = line.lower()
		for key, i in genelib.iteritems():
			seq = seq.replace(key, i)
			
		seq = seq.replace(' ', '') 	
		#seq = ''.join(seq.split())
		fasta = header + seq
		print fasta

file.close()


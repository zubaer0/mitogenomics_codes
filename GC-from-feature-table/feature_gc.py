#!/usr/bin/python

def gc_pos(pos1,pos2):
	pos1= int(pos1)
	pos2= int(pos2)
        fasta = open ('seq')
        seq = fasta.read()
        k = seq[pos1-1:pos2]
        g = k.count('G')
        c = k.count('C')
        GC_per = float((g+c)*100/len(k))
        GC = int(GC_per)
        fasta.close()
        return GC



file1 = open('dataset_gc', 'r')

z=1
for line in file1:
	line=line.strip()
	listo=line.split(',')
	
	x = listo[0]
	y = listo[1]
	
	if z > int(x):
		print x,'ERR'
	elif z == int(x):
		print x, y, gc_pos(x,y)
	else:
		k=int(x)-1
		print z, k, gc_pos(z,k)
		print x, y, gc_pos(x,y)

	z = int(y)+1

file1.close()










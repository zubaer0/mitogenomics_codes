#!/bin/bash
#Thu Jul 13 15:16:05 CDT 2017


for file in ../*.gff3;
do 
	a=$file
	b=$(basename $a)
	
	echo '>'$b >> synteny.txt
	grep 'gene' $file | grep -v 'intron' | grep -v 'exon' |  grep -v 'tRNA' | grep -v 'CDS' | grep -vi 'ORF' | grep -v 'ribosomal'  > $b-temp.txt
	python synteny1.1.py $b-temp.txt >> synteny.txt
	#rm *temp.txt
	
	
done

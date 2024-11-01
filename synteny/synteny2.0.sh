#!/bin/bash
#Thu Jul 13 15:16:05 CDT 2017


for file in ../*.gff3;
do 
	a=$file
	b=$(basename $a | cut -d '.' -f1)
	echo '>'$b >> result-synteny.txt
	
	
	python synteny2.0.py $file >> result-synteny.txt
	#rm *temp.txt
	
	
done

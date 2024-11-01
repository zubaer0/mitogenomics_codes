#!/bin/bash
#Wed 05 Jul 2017 12:43:41 PM CDT 


for file in ../*.gff3
do 
	a=$file
	b=$(basename $a)
	
	# getting genome size
	echo ">genome-size" > $b-result.txt
	grep 'mitochondrion' $file | awk '{print $5}' >> $b-result.txt
	
	# getting introns
	echo ">intron" >> $b-result.txt
	grep 'intron' $file | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }' >> $b-result.txt
	
	# getting tRNAs
	echo ">tRNA" >> $b-result.txt
	grep 'tRNA' $file | grep 'gene_biotype=tRNA' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }' >> $b-result.txt
	
	# getting rRNAs
	echo ">rRNA" >> $b-result.txt
	grep 'exon' $file | grep 'rRNA' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }' >> $b-result.txt

	# getting CDSs 
	echo ">CDS" >> $b-result.txt
	grep 'CDS' $file | grep -vi 'ORF' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }' >> $b-result.txt

	# getting intronic ORFs
	echo ">ORF" >> $b-result.txt
	grep 'CDS' $file | grep -i 'ORF' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }' >> $b-result.txt
	
done

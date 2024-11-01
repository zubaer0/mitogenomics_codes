#!/bin/bash

# The input file should be named as "sequence.gff3" (in GFF3 format) 
# and the output will be printed in a file named "numbers.txt" 
# in the same directory.

# getting genome size 
echo ">genome-size" > numbers.txt
grep 'region' sequence.gff3 | awk '{print $5}' >> numbers.txt

# getting introns
echo ">intron" >> numbers.txt
grep 'intron' sequence.gff3 | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }' >> numbers.txt

# getting tRNAs
echo ">tRNA" >> numbers.txt
grep 'tRNA' sequence.gff3 | grep 'gene_biotype=tRNA' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }' >> numbers.txt

# getting rRNAs
echo ">rRNA" >> numbers.txt
grep 'exon' sequence.gff3 | grep 'rRNA' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }' >> numbers.txt

# getting CDSs 
echo ">CDS" >> numbers.txt
grep 'CDS' sequence.gff3 | grep -vi 'ORF' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }' >> numbers.txt

# getting intronic ORFs
echo ">ORF" >> numbers.txt
grep 'CDS' sequence.gff3 | grep -i 'ORF' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }' >> numbers.txt

# making the output in tabular format 
python listrip_TABv2.pyc
sed -i '1,14 d' numbers.txt

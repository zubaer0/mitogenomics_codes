#!/bin/bash
#Thu Jul 13 15:16:05 CDT 2017


for file in ../*.gff3;
do 
	a=$file
	b=$(basename $a)
	
	# getting genome size
	echo ">genome-size" > $b-result.txt
	grep 'mitochondrion' $file | awk '{print $5}' >> $b-result.txt
		
	# getting tRNAs
	echo ">tRNA" >> $b-result.txt
	y=$(grep 'tRNA' $file | grep 'gene_biotype=tRNA' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }')
	echo $y >> $b-result.txt
	
	# getting rRNAs
	echo ">rRNA" >> $b-result.txt
	z=`grep 'exon' $file | grep 'rRNA' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'`
	echo $z >> $b-result.txt
	
	
	####-------------------------------------------------------------------#######
	
	
		
	# getting CDSs 
	echo ">CDS" >> $b-result.txt
	m=`grep 'CDS' $file | grep -vi 'ORF' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'`
	echo $m >> $b-result.txt
	
	((x=$y+$z+$m))
	echo "in total = $x" >> $b-result.txt
	
	
	###-------------------------------------------------------------------------###
	
	# getting intronic ORFs
	echo ">ORF" >> $b-result.txt
	n=`grep 'CDS' $file | grep -i 'ORF' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'`
	if [ -z $n ]; 
	then
		echo 0 >> $b-result.txt
	else
		echo $n >> $b-result.txt
	fi
	
	# getting introns
	echo ">intron" >> $b-result.txt
	q=`grep 'intron' $file | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'`
	echo $q >> $b-result.txt
	
	echo ">intron_more" >> $b-result.txt
	p=`grep 'gene' $file | grep -v 'intron' | grep -v 'exon' | grep -v 'tRNA' |  grep -v 'tRNA' | grep -v 'CDS' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'` 
	# >> $b-result.txt
	#echo 'hi'>> $b-result.txt
	#p=`grep 'gene' $file | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'`
	i=`expr $p - $x`
	echo $i	>> $b-result.txt
	
done

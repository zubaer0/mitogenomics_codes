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
	tr=$(awk '{ if ($3 == "tRNA") print ($5-$4+1); }' $file | awk '{ sum += $1 } END { print sum }')
	echo $tr >> $b-result.txt
	
	# getting rRNA exons
	echo ">rRNA" >> $b-result.txt
	rexon=`grep 'exon' $file | grep 'rRNA' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'`
	echo $rexon >> $b-result.txt
	
	# calculate rRNA gene 
	rgene=$(awk '{ if ($3 == "rRNA") print $0; }' $file | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }')
	
	
	####-------------------------------------------------------------------#######
	
	
		
	# getting CDSs 
	echo ">CDS" >> $b-result.txt
	cds=`grep 'CDS' $file | grep -vi 'ORF' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'`
	echo $cds >> $b-result.txt
	
	#x=$((y+z+m))
	x=$((rexon+cds))
	#echo "CDS+rRNAexon = $x" >> $b-result.txt
	
	
	###-------------------------------------------------------------------------###
	
	# getting intronic ORFs
	echo ">ORF" >> $b-result.txt
	orf=`grep 'CDS' $file | grep -i 'ORF' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'`
	if [ -z $orf ]; # -z option means if n is 0. 
	then
		echo 0 >> $b-result.txt
	else
		echo $orf >> $b-result.txt
	fi
	
	
	# getting introns
	echo ">intron_annotated" >> $b-result.txt
	intron=`grep 'intron' $file | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'`
	if [ -z $intron ]; then 
		echo 0 >> $b-result.txt
	else
		echo $intron >> $b-result.txt
	fi



	#############################################################################################################################################
	
	
	
		
	echo ">intron_total(calculated)" >> $b-result.txt
	p=`grep 'gene' $file | grep -v 'intron' | grep -v 'exon' | grep -v 'tRNA' | grep -v 'rRNA' | grep -v 'CDS' | grep -vi 'ORF' |grep -vi 'oi' | grep -vi 'pseudo' | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'` 
	# >> $b-result.txt
	#echo 'hi'>> $b-result.txt
	#p=`grep 'gene' $file | awk '{ print ($5-$4+1) }' | awk '{ sum += $1 } END { print sum }'`
	#echo $p >> $b-result.txt
	#echo $x >> $b-result.txt
	i=$((p + rgene - x))
	echo $i	>> $b-result.txt
	
	
	
done

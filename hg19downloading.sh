#!/bin/bash
wget --timestamping'ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/*'
mkdir hg19
for chr in *.gz
 do 
  gunzip -c $chr > hg19/`echo $chr | sed s/.gz//`
done
cd hg19cat *.fa > hg19_ref_genome.fa  

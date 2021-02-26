#!/bin/bash
for i in $(ls *.sam)
do 
echo “Kompresja dla pliku: $i”
 j=${i::-3}6 samtools view -Sb -@ 2 ${i} > ${j}bam
done   

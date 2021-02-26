#!/bin/bash
for num in `seq 42 45`
do
 echo SRR31915${num}
 hisat2 -q -x /home/iza/Pobrane/index/index -1 /home/iza/Pulpit/fastqgzip/TRIMM/PAIRED/paired_1_SRR31915${num}fg.gz -2 paired_2_SRR31915${num}.fg.gz -S wynik_SRR31915${num}.hisat.sam
done


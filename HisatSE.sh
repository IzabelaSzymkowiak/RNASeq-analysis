#!/bin/bash
for num in `seq 28 31`
do
 echo SRR31944${num}
 hisat2 -q -x /home/iza/Pobrane/index/index -U /home/iza/Pulpit/fasq-gzip/TRIMM/SINGLE/sample_SRR31944${num}.fq.gz -S wynik_SRR31944${num}.hisat.sam
done

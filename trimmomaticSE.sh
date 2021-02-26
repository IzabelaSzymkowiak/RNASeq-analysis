#!/bin/bash
for num in `seq 28 31`
do
 echo SRR31944${RUN}
 java -jar /home/iza/miniconda3/share/trimmomatic-0.39-
1/trimmomatic.jar SE -phred33 /home/iza/Pulpit/fastqgzip/SRR31944${num}_1.fastq.gz /home/iza/Pulpit/fasqgzip/TRIMM/SINGLE/sample_ SRR31944${num}.fq.gz SLIDINGWINDOW:4:20
MINLEN:60
done

#!/bin/bash

for num in `seq 42 45`
do
  echo $num
  java -jar /home/izaprojekt/miniconda3/share/trimmomatic-0.39-1/trimmomatic.jar PE -phred33 /home/izaprojekt/Pulpit/fasq-gzip/SRR31915${num}_1.fastq.gz /home/izaprojekt/Pulpit/fasq-gzip/SRR31915${num}_2.fastq.gz /home/izaprojekt/Pulpit/fasq-gzip/TRIMM/PAIRED/paired_1_SRR31915${num}.fq.gz /home/izaprojekt/Pulpit/fasq-gzip/TRIMM/PAIRED/unpaired_1_SRR31915${num}.fq.gz /home/izaprojekt/Pulpit/fasq-gzip/TRIMM/PAIRED/paired_2_SRR31915${num}.fq.gz /home/izaprojekt/Pulpit/fasq-gzip/TRIMM/PAIRED/unpaired_2_SRR31915${num}.fq.gz SLIDINGWINDOW:4:20 MINLEN:60
done


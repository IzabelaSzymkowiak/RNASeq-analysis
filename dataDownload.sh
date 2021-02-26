#!/bin/bash

arrRun=( $(esearch -db sra -query PRJNA313294 | efetch -format runinfo -mode xml | xtract -pattern SraRunInfo -element Run) )
arrType=( $(esearch -db sra -query PRJNA313294 | efetch -format runinfo -mode xml | xtract -pattern SraRunInfo -element LibraryLayout) )
mkdir fastq-gzip
cd fastq-gzip

for i in "${!arrType[@]}"
do
  if [[ "${arrType[i]}" == "PAIRED" ]]
   then
    echo "Pobieranie: ${arrRun[i]} typ: ${arrType[i]}"
    fastq-dump --split-files --gzip ${arrRun[i]}
  else
    echo "Pobieranie: ${arrRun[i]} typ: ${arrType[i]}"
    fastq-dump --gzip ${arrRun[i]}
  fi
done

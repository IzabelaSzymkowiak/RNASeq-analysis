#!/bin/bash

mkdir QC
for file in $(ls fasq-gzip/*)
 do
  echo "Kontrola i raport dla ${file}"
  fastqc ${file} --noextract --nogroup --outdir QC
 done

#!/bin/bash
featureCounts -a hg19.refGene.gtf -g gene_name –ocounts_refGene_single.txt *4[2345].bam

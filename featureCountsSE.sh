#!/bin/bash
featureCounts -a hg19.refGene.gtf -g gene_name –o counts_refGene_pair.txt *4[2345].bam
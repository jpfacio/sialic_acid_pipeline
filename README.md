### Sialic Acid Pipeline

This pipeline was elaborated as part of a project which aims to find sialic acid metabolism genes in the shotgun sequencing data provided by Trevelline & Kohl (2022).

## Data origin

The data was downloaded from the ENA database, which consists of intestinal microbiome shotgun sequencing from three mice species with three different diets, although the objective of the study was not related to sialic acid metabolism, we found their sequencing data useful for our purposes. More information about the data is provided in the paper.

## Pipeline Steps

In simple words, this pipeline consists in a quality control analysis, trimming data, genome alignment with the three mice species and an assembly of the parts of the sequencing which didn't align with the mices genomes, indicating that these unaligned parts are part of the microbiome.

# First Step: Quality control

The quality control was performed with FastQC (https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and MultiQC (https://multiqc.info) was used for easy visualization of the outputs.

# Second Step: Trimming


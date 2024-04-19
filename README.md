# Sialic Acid Pipeline

This pipeline was elaborated as part of a project which aims to find sialic acid metabolism genes in the shotgun sequencing data provided by Trevelline & Kohl (2022).

## Data origin

The data was downloaded from the ENA database, which consists of intestinal microbiome shotgun sequencing from three mice species with three different diets, although the objective of the study was not related to sialic acid metabolism, we found their sequencing data useful for our purposes. More information about the data is provided in the paper.

## Pipeline Steps

In simple words, this pipeline consists in a quality control analysis, trimming data, genome alignment with the three mice species and an assembly of the parts of the sequencing which didn't align with the mices genomes, indicating that these unaligned parts are part of the microbiome.

### First Step: Quality control

The quality control was performed with FastQC (https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and MultiQC (https://multiqc.info) was used for easy visualization of the outputs.

### Second Step: Trimming

The trimming step was performed using Trimmomatic, the correspondent adapters file is written in the script and we used as main parameters a leading cut of 15 bp, trailing cut of 3 bp and a sliding window of 4 to 15 bp.

### Third Step: Trimmed data quality control

The same step 1 process was applied to the trimmed data.

### Fourth Step: Download NCBI data

The script downloads the annotated genomes from the three mice species used in the study from the NCBI database, performs directory arrangement and uncompression.

### Fifth Step: Alignment

The alignment step was performed using Bowtie (https://bowtie-bio.sourceforge.net/index.shtml), the script rearranges all the samples based on the metadata table which can be found in the NCBI project webpage (https://www.ncbi.nlm.nih.gov/bioproject/PRJNA629007/). The bowtie output contains a sam file with sequences aligned with the mice genome and a fastq file containing the unaligned sequences, corresponding to the microbiome metagenome, which is the target of the project.

### Sixth Step: Assembly

The sixth step consists in a metagenome assembly performed by MEGAHIT (https://github.com/voutcn/megahit), we used the unaligned data from the fifth step as input to find contigs correspondent to the species present in the mice metagenome.

## Directory Configuration

For all the steps explained above the script creates a new directory with its indicative name, for the NCBI data organization, alignment and assembly the files are divided by a subdirectory correspondent to each species name. It's recommended to, before running the pipeline, create or choose an appropriated local directory, since the pipeline will create a "sialic_acid_data" directory with it's subdivisions.

## References 

Trevelline, Brian K., and Kevin D. Kohl. "The gut microbiome influences host diet selection behavior." Proceedings of the National Academy of Sciences 119.17 (2022): e2117537119.


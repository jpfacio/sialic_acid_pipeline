public_data=(
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/044/SRR11927444/SRR11927444.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/055/SRR11927455/SRR11927455.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/037/SRR11927437/SRR11927437.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/040/SRR11927440/SRR11927440.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/036/SRR11927436/SRR11927436.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/048/SRR11927448/SRR11927448.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/051/SRR11927451/SRR11927451.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/059/SRR11927459/SRR11927459.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/062/SRR11927462/SRR11927462.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/056/SRR11927456/SRR11927456.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/060/SRR11927460/SRR11927460.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/043/SRR11927443/SRR11927443.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/054/SRR11927454/SRR11927454.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/049/SRR11927449/SRR11927449.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/038/SRR11927438/SRR11927438.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/057/SRR11927457/SRR11927457.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/061/SRR11927461/SRR11927461.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/050/SRR11927450/SRR11927450.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/053/SRR11927453/SRR11927453.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/039/SRR11927439/SRR11927439.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/042/SRR11927442/SRR11927442.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/045/SRR11927445/SRR11927445.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/034/SRR11927434/SRR11927434.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/047/SRR11927447/SRR11927447.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/058/SRR11927458/SRR11927458.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/041/SRR11927441/SRR11927441.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/046/SRR11927446/SRR11927446.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/063/SRR11927463/SRR11927463.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/035/SRR11927435/SRR11927435.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR119/052/SRR11927452/SRR11927452.fastq.gz
)

if [[ -d sialic_acid_data/shotgun_data ]]
then
    echo "THE DATASETS ARE READY"
else
    mkdir sialic_acid_data
    mkdir sialic_acid_data/shotgun_data
    for i in "${public_data[@]}"; do
        wget -nc "$i" -P "sialic_acid_data/shotgun_data"
    done

    for i in sialic_acid_data/shotgun_data/*; do
        gzip -d "$i"
    done
fi

sequence=">PrefixNX/1\nAGATGTGTATAAGAGACAG\n>PrefixNX/2\nAGATGTGTATAAGAGACAG\n>Trans1\nTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG\n>Trans1_rc\nCTGTCTCTTATACACATCTGACGCTGCCGACGA\n>Trans2\nGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG\n>Trans2_rc\nCTGTCTCTTATACACATCTCCGAGCCCACGAGAC"
echo -e "$sequence" > sialic_acid_data/adapters.fasta
    
echo "####################          PERFORMING FASTQC ANALYSIS          ####################"

if [[ -d sialic_acid_data/fastqc_output ]]
then
    echo "FASTQC ANALYSIS ALREADY DONE, PASSING"
else
    mkdir sialic_acid_data/fastqc_output
    for i in sialic_acid_data/shotgun_data/*; do
        fastqc -o sialic_acid_data/fastqc_output "$i"
    done
fi

echo "####################          PERFORMING MULTIQC ANALYSIS          ####################"

if [[ -d sialic_acid_data/multiqc_report ]]
then
    echo "MULTIQC ANALYSIS ALREADY DONE, PASSING"
else
    mkdir sialic_acid_data/multiqc_report
    mkdir sialic_acid_data/multiqc_report/normal
    multiqc -o sialic_acid_data/multiqc_report/normal sialic_acid_data/fastqc_output
fi 

echo "####################          PERFORMING TRIMMOMATIC ANALYSIS          ####################"

if [[ -d sialic_acid_data/data_trimmed ]]
then
    echo "THE SEQUENCES ARE ALREADY TRIMMED, PASSING"
else
    mkdir sialic_acid_data/data_trimmed
    for i in sialic_acid_data/shotgun_data/*; do
        no_suf=$(basename -s .fastq "$i")
        trimmomatic SE "$i" sialic_acid_data/data_trimmed/"$no_suf".trimmed.fastq ILLUMINACLIP:sialic_acid_data/adapters.fasta:2:30:10:2:True LEADING:15 TRAILING:3 SLIDINGWINDOW:4:15
    done
fi

echo "####################          PERFORMING FASTQC ON TRIMMED DATA          #####################"

if [[ -d sialic_acid_data/trimmed_fastqc_output ]]
then
    echo "FASTQC ON TRIMMED DATA ALREADY DONE, PASSING"
else
    mkdir sialic_acid_data/trimmed_fastqc_output
    for i in sialic_acid_data/data_trimmed/*; do
        fastqc -o sialic_acid_data/trimmed_fastqc_output "$i"
    done
fi

echo "####################          PERFORMING FINAL MULTQC ANALYSIS          ####################"

if [[ -d sialic_acid_data/multiqc_report/trimmed ]]
then
echo "MULTIQC ON TRIMMED DATA ALREADY DONE, PASSING"
else
    mkdir sialic_acid_data/multiqc_report/trimmed
    multiqc -o sialic_acid_data/multiqc_report/trimmed sialic_acid_data/trimmed_fastqc_output
fi

echo "####################          DOWNLOADING NCBI DATASETS          ####################"

if [[ -d sialic_acid_data/ncbi_data ]]
then
echo "NCBI DATASETS ARE AVAILABLE"
else
    mkdir sialic_acid_data/ncbi_data
    mkdir sialic_acid_data/ncbi_data/Onychomys

    datasets download genome accession GCF_903995425.1 --include gff3,rna,cds,protein,genome,seq-report --dehydrated --filename sialic_acid_data/ncbi_data/Onychomys/onychomys.zip 

    mkdir sialic_acid_data/ncbi_data/Peromyscus

    datasets download genome accession GCF_004664715.2 --include gff3,rna,cds,protein,genome,seq-report --dehydrated --filename sialic_acid_data/ncbi_data/Peromyscus/peromyscus.zip

    mkdir sialic_acid_data/ncbi_data/Microtus

    datasets download genome accession GCA_020392405.1 --include gff3,rna,cds,protein,genome,seq-report --dehydrated --filename sialic_acid_data/ncbi_data/Microtus/microtus.zip

    unzip sialic_acid_data/ncbi_data/Onychomys/onychomys.zip -d sialic_acid_data/ncbi_data/Onychomys/
    unzip sialic_acid_data/ncbi_data/Peromyscus/peromyscus.zip -d sialic_acid_data/ncbi_data/Peromyscus/
    unzip sialic_acid_data/ncbi_data/Microtus/microtus.zip -d sialic_acid_data/ncbi_data/Microtus/ 

    datasets rehydrate --gzip --directory sialic_acid_data/ncbi_data/Onychomys
    datasets rehydrate --gzip --directory sialic_acid_data/ncbi_data/Peromyscus
    datasets rehydrate --gzip --directory sialic_acid_data/ncbi_data/Microtus

    gzip -dv sialic_acid_data/ncbi_data/Onychomys/ncbi_dataset/data/GCF_903995425.1/GCF_903995425.1_mOncTor1.1_genomic.fna.gz
    gzip -dv sialic_acid_data/ncbi_data/Peromyscus/ncbi_dataset/data/GCF_004664715.2/GCF_004664715.2_UCI_PerLeu_2.1_genomic.fna.gz
    gzip -dv sialic_acid_data/ncbi_data/Microtus/ncbi_dataset/data/GCA_020392405.1/GCA_020392405.1_ASM2039240v1_genomic.fna.gz
fi

echo "####################          PERFORMING ALIGNMENT          ####################"

if [[ -d sialic_acid_data/bowtie_results ]]; then
  echo "ALIGNMENT ALREADY DONE, PASSING"
else
  mkdir -p sialic_acid_data/bowtie_results/Onychomys
  mkdir -p sialic_acid_data/bowtie_results/Peromyscus
  mkdir -p sialic_acid_data/bowtie_results/Microtus

  Onychomys=()
  Peromyscus=()
  Microtus=()

  dir="sialic_acid_data/data_trimmed"

  count=0
  for i in "$dir"/*; do
    if [ -f "$i" ]; then
      if [ "$count" -lt 8 ]; then
        Onychomys+=("$i")
      elif [ "$count" -lt 18 ]; then
        Peromyscus+=("$i")
      elif [ "$count" -lt 29 ]; then
        Microtus+=("$i")
      else
        break
      fi

      ((count++))
    fi
  done

  echo "Onychomys: ${Onychomys[@]}"
  echo "Peromyscus: ${Peromyscus[@]}"
  echo "Microtus: ${Microtus[@]}"

  bowtie2-build sialic_acid_data/ncbi_data/Onychomys/ncbi_dataset/data/GCF_903995425.1/GCF_903995425.1_mOncTor1.1_genomic.fna sialic_acid_data/bowtie_results/Onychomys/onychomys
  bowtie2-build sialic_acid_data/ncbi_data/Peromyscus/ncbi_dataset/data/GCF_004664715.2/GCF_004664715.2_UCI_PerLeu_2.1_genomic.fna sialic_acid_data/bowtie_results/Peromyscus/peromyscus
  bowtie2-build sialic_acid_data/ncbi_data/Microtus/ncbi_dataset/data/GCA_020392405.1/GCA_020392405.1_ASM2039240v1_genomic.fna sialic_acid_data/bowtie_results/Microtus/microtus

  ony_out="sialic_acid_data/bowtie_results/Onychomys/"
  mkdir -p "$ony_out"

  for i in "${Onychomys[@]}"; do
    s=$(echo "$i" | sed 's/.*\/\([^.]*\)\..*/\1/')
    bowtie2 -x sialic_acid_data/bowtie_results/Onychomys/onychomys -U "$i" -S "$ony_out""$s"_align.sam --un "$ony_out""$s"_unalign.fastq --sensitive-local > "$ony_out""$s".log 2>&1
  done

  mic_out="sialic_acid_data/bowtie_results/Microtus/"
  mkdir -p "$mic_out"

  for i in "${Microtus[@]}"; do
    s=$(echo "$i" | sed 's/.*\/\([^.]*\)\..*/\1/')
    bowtie2 -x sialic_acid_data/bowtie_results/Microtus/microtus -U "$i" -S "$mic_out""$s"_align.sam --un "$mic_out""$s"_unalign.fastq --sensitive-local > "$mic_out""$s".log 2>&1
  done

  per_out="sialic_acid_data/bowtie_results/Peromyscus/"
  mkdir -p "$per_out"

  for i in "${Peromyscus[@]}"; do
    s=$(echo "$i" | sed 's/.*\/\([^.]*\)\..*/\1/')
    bowtie2 -x sialic_acid_data/bowtie_results/Peromyscus/peromyscus -U "$i" -S "$per_out""$s"_align.sam --un "$per_out""$s"_unalign.fastq --sensitive-local > "$per_out""$s".log 2>&1
  done
fi


echo "####################          MEGAHIT ANALYSIS          ####################"

if [[ -d sialic_acid_data/megahit_analysis ]]; then
    echo "MEGAHIT ANALYSIS COMPLETE!"
else
    mkdir -p sialic_acid_data/megahit_analysis
    mkdir -p sialic_acid_data/megahit_analysis/files

    cat sialic_acid_data/bowtie_results/Onychomys/*unalign.fastq > sialic_acid_data/megahit_analysis/files/onychomys_cat.fastq
    cat sialic_acid_data/bowtie_results/Microtus/*unalign.fastq > sialic_acid_data/megahit_analysis/files/microtus_cat.fastq
    cat sialic_acid_data/bowtie_results/Peromyscus/*unalign.fastq > sialic_acid_data/megahit_analysis/files/peromyscus_cat.fastq

    MEGAHIT-1.2.9-Linux-x86_64-static/bin/megahit -r sialic_acid_data/megahit_analysis/files/onychomys_cat.fastq -o sialic_acid_data/megahit_analysis/onychomys_megahit 
    MEGAHIT-1.2.9-Linux-x86_64-static/bin/megahit -r sialic_acid_data/megahit_analysis/files/microtus_cat.fastq -o sialic_acid_data/megahit_analysis/microtus_megahit
    MEGAHIT-1.2.9-Linux-x86_64-static/bin/megahit -r sialic_acid_data/megahit_analysis/files/peromyscus_cat.fastq -o sialic_acid_data/megahit_analysis/peromyscus_megahit
fi

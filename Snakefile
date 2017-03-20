configfile: "config.yaml"

rule all:

  input:

    expand("{sample}.{yourparam}.output.pdf", sample=config["samples"], param=config["yourparam"])

rule star_map:

  input:
    fastq1="example_input/Pipeline-RNAseqVariantCaller.1.fq.gz example_input/Pipeline-RNAseqVariantCaller.1.fq.gz"
    fastq2="example_input/Pipeline-RNAseqVariantCaller.1.fq.gz example_input/Pipeline-RNAseqVariantCaller.2.fq.gz"

  output:
    "star_align/"

  shell:
    "STAR "
    "--readFilesIn {input.fastq1} {input.fastq2} "
    "--genomeDir  config["star_genome_dir"] "
    "--readFilesCommand zcat "
    "--runThreadN 6 "
    "--genomeLoad NoSharedMemory "
    "--outFilterMultimapNmax 20 "
    "--alignSJoverhangMin 8 "
    "--alignSJDBoverhangMin 1 "
    "--outFilterMismatchNmax 999 "
    "--outFilterMismatchNoverReadLmax 0.04 "
    "--alignIntronMin 20 "
    "--alignIntronMax 1000000 "
    "--alignMatesGapMax 1000000 "
    "--outSAMunmapped Within "
    "--outFilterType BySJout "
    "--outSAMattributes NH HI AS NM MD "
    "--sjdbScore 1 "
    "--twopassMode Basic "
    "--twopass1readsN -1 "
    "--outFileNamePrefix {output}"
from os.path import join

configfile: "config.yaml"

SAMPLES = ["Pipeline-RNAseqVariantCaller"]

rule all:
	input:
		expand("star_align/{sample}.Aligned.out.sam", sample=SAMPLES)

rule star_map:
	input:
		fastq1 = join(config["input_dir"], "{sample}.1.fq.gz)"),
		fastq2 = join(config["input_dir"], "{sample}.1.fq.gz)"),
		star_genome_dir=config["star_genome_dir"]

	output:
		"star_align/{sample}.Aligned.out.sam"

	shell:
		"STAR "
		"--readFilesIn {input.fastq1} {input.fastq2} "
		"--genomeDir  {input.star_genome_dir} "
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
		"--outFileNamePrefix star_align/{wildcards.sample}"
configfile: "config.yaml"

rule all:
	input:
		"star_align/star_align"

rule star_map:
	input:
		fastq1=config["fastq1"],
		fastq2=config["fastq2"],
		star_genome_dir=config["star_genome_dir"]
		sample_id=config["sample_id"]

	output:
		"star_align/{input.sample_id}Aligned.out.sam"

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
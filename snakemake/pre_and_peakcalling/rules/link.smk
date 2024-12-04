# link (raw_data)
rule link:
    input:
        f"{fastq_1_dir}",
        f"{fastq_2_dir}"
    output:
        f"{data_dir}/{prefix}_1.fastq.gz",
        f"{data_dir}/{prefix}_2.fastq.gz"
    shell:
        """
        ln -s {fastq_1_dir} {data_dir}/{prefix}_1.fastq.gz
        ln -s {fastq_2_dir} {data_dir}/{prefix}_2.fastq.gz
        """

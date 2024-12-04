# fastqc (raw)
rule fastqc_raw:
    input:
        f"{data_dir}/{prefix}_1.fastq.gz",
        f"{data_dir}/{prefix}_2.fastq.gz"
    output:
        f"{raw_fastqc_dir}/{prefix}_1_fastqc.html",
        f"{raw_fastqc_dir}/{prefix}_1_fastqc.zip",
        f"{raw_fastqc_dir}/{prefix}_2_fastqc.html",
        f"{raw_fastqc_dir}/{prefix}_2_fastqc.zip"
    shell:
        """
        fastqc {input} --threads {mycores} -o {raw_fastqc_dir}
        """
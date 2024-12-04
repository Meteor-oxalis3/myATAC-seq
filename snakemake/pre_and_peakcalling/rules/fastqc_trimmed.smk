# fastqc(trimmed)
rule fastqc_trimmed:
    input:
        f"{fastp_dir}/fastp_{prefix}_1.fastq.gz",
        f"{fastp_dir}/fastp_{prefix}_2.fastq.gz"
    output:
        f"{trimmed_fastqc_dir}/fastp_{prefix}_1_fastqc.html",
        f"{trimmed_fastqc_dir}/fastp_{prefix}_1_fastqc.zip",
        f"{trimmed_fastqc_dir}/fastp_{prefix}_2_fastqc.html",
        f"{trimmed_fastqc_dir}/fastp_{prefix}_2_fastqc.zip"
    shell:
        "fastqc {input} --threads {mycores} -o {trimmed_fastqc_dir}"
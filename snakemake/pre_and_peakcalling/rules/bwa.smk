# bwa
rule bwa:
    input:
        f"{fastp_dir}/fastp_{prefix}_1.fastq.gz",
        f"{fastp_dir}/fastp_{prefix}_2.fastq.gz"
    output:
        f"{bwa_dir}/{prefix}.sam"
    shell:
        "bwa mem -t {mycores} {bwa_index_dir} {input[0]} {input[1]} > {output}"
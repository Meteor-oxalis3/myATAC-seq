# fastp
rule fastp:
    input:
        f"{data_dir}/{prefix}_1.fastq.gz",
        f"{data_dir}/{prefix}_2.fastq.gz"
    output:
        f"{fastp_dir}/fastp_{prefix}_1.fastq.gz",
        f"{fastp_dir}/fastp_{prefix}_2.fastq.gz",
        f"{fastp_dir}/fastp_{prefix}.json",
        f"{fastp_dir}/fastp_{prefix}.html"
    threads:
        16
    shell:
        """
        fastp -i {input[0]} -I {input[1]} \
        -o {output[0]} -O {output[1]} \
        --detect_adapter_for_pe -5 -c \
        --cut_mean_quality {cut_mean_quality} \
        --length_required {length_required} \
        -j {output[2]} \
        -h {output[3]} \
        -w 16
        """
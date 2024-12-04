# multiqc 汇总
rule multiqc:
    input:
        f"{raw_fastqc_dir}/{prefix}_1_fastqc.html",
        f"{raw_fastqc_dir}/{prefix}_1_fastqc.zip",
        f"{raw_fastqc_dir}/{prefix}_2_fastqc.html",
        f"{raw_fastqc_dir}/{prefix}_2_fastqc.zip",
        f"{trimmed_fastqc_dir}/fastp_{prefix}_1_fastqc.html",
        f"{trimmed_fastqc_dir}/fastp_{prefix}_1_fastqc.zip",
        f"{trimmed_fastqc_dir}/fastp_{prefix}_2_fastqc.html",
        f"{trimmed_fastqc_dir}/fastp_{prefix}_2_fastqc.zip",
        f"{bwa_dir}/{prefix}_stats.txt"
    output:
        f"{multiqc_dir}/multiqc_report.html"
    shell:
        """
        multiqc {trimmed_fastqc_dir} {raw_fastqc_dir} {bwa_dir} -o {prefix};
        mv {prefix}/multiqc_report.html {multiqc_dir}/multiqc_report.html;
        mv {prefix}/multiqc_data/ {multiqc_dir}
        """
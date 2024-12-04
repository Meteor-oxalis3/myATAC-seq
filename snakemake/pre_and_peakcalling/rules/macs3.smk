# MACS3
# https://macs3-project.github.io/MACS/
rule macs3:
    input:
        f"{alignmentSieve_dir}/ATACshifted_{prefix}.bam"
    output:
        f"{macs3_dir}/{prefix}_peaks.narrowPeak",
        f"{macs3_dir}/{prefix}_peaks.xls",
        f"{macs3_dir}/{prefix}_summits.bed"
    shell:
        """
        macs3 callpeak --format BAM --treatment {input} \
        --gsize {gsize} \
        --name {prefix} \
        --outdir {macs3_dir} \
        --keep-dup all \
        --cutoff-analysis \
        --qvalue {qvalue}
        """
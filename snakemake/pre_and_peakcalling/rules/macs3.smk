# MACS3
# https://macs3-project.github.io/MACS/
rule macs3:
    input:
        f"{alignmentSieve_dir}/ATACshifted_{prefix}.bam"
    output:
        f"{macs3_dir}/{prefix}_peaks.narrowPeak",
        f"{macs3_dir}/{prefix}_peaks.xls",
        f"{macs3_dir}/{prefix}_summits.bed",
        f"{macs3_dir}/{prefix}_treat_pileup.bdg",
        f"{macs3_dir}/{prefix}_treat_pileup.bw"

    shell:
        """
        macs3 callpeak --format BAM \
        --treatment {input} \
        --gsize {gsize} \
        --name {prefix} \
        --outdir {macs3_dir} \
        --keep-dup all \
        --cutoff-analysis \
        --qvalue {qvalue} \
        --bdg \
        --nomodel --shift -100 --extsize 200;
        bedGraphToBigWig {output[3]} {genome_index} {output[4]}
        """
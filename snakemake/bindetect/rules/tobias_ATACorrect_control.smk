# TOBIAS
# https://github.com/loosolab/TOBIAS
# 注意：TOBIAS 无需 ATACshift! (自带ATACshift)
rule tobias_ATACorrect_control:
    input:
        control_merged_bam = f"{control_prefix}/{samtools_merge_dir}/merged_{control_prefix}.bam",
        merged_peaks = f"{bedtools_merge_dir}/merged_peaks.bed"
    output:
        f"{control_tobias_dir}/{control_prefix}_AtacBias.pickle",
        f"{control_tobias_dir}/{control_prefix}_atacorrect.pdf",
        f"{control_tobias_dir}/{control_prefix}_bias.bw",
        f"{control_tobias_dir}/{control_prefix}_corrected.bw",
        f"{control_tobias_dir}/{control_prefix}_expected.bw",
        f"{control_tobias_dir}/{control_prefix}_uncorrected.bw"
    shell:
        """
        TOBIAS ATACorrect \
        --bam {input[0]} \
        --genome {genome} \
        --peaks {input[1]} \
        --prefix {control_prefix} \
        --outdir {control_tobias_dir} \
        --cores {mycores}
        """

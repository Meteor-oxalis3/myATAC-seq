# TOBIAS
# https://github.com/loosolab/TOBIAS
# 注意：TOBIAS 无需 ATACshift! (自带ATACshift)
rule tobias_ATACorrect_case:
    input:
        case_merged_bam = f"{case_prefix}/{samtools_merge_dir}/merged_{case_prefix}.bam",
        merged_peaks = f"{bedtools_merge_dir}/merged_peaks.bed"
    output:
        f"{case_tobias_dir}/{case_prefix}_AtacBias.pickle",
        f"{case_tobias_dir}/{case_prefix}_atacorrect.pdf",
        f"{case_tobias_dir}/{case_prefix}_bias.bw",
        f"{case_tobias_dir}/{case_prefix}_corrected.bw",
        f"{case_tobias_dir}/{case_prefix}_expected.bw",
        f"{case_tobias_dir}/{case_prefix}_uncorrected.bw"
    shell:
        """
        TOBIAS ATACorrect \
        --bam {input[0]} \
        --genome {genome} \
        --peaks {input[1]} \
        --prefix {case_prefix} \
        --outdir {case_tobias_dir} \
        --cores {mycores}
        """

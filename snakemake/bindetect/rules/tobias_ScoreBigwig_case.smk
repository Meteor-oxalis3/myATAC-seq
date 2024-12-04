# TOBIAS ScoreBigwig (case)
rule tobias_ScoreBigwig_case:
    input:
        case_signal = f"{case_tobias_dir}/{case_prefix}_corrected.bw",
        regions = f"{bedtools_merge_dir}/merged_peaks.bed"
    output:
        f"{case_tobias_dir}/{case_prefix}_footprints.bw"
    shell:
        """
        TOBIAS ScoreBigwig \
        --signal {input[0]} \
        --regions {input[1]} \
        --output {output[0]} \
        --cores {mycores} \
        """
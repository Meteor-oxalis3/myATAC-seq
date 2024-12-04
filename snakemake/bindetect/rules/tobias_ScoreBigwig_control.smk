# TOBIAS ScoreBigwig (control)
rule tobias_ScoreBigwig_control:
    input:
        control_signal = f"{control_tobias_dir}/{control_prefix}_corrected.bw",
        regions = f"{bedtools_merge_dir}/merged_peaks.bed",
    output:
        f"{control_tobias_dir}/{control_prefix}_footprints.bw"
    shell:
        """
        TOBIAS ScoreBigwig \
        --signal {input[0]} \
        --regions {input[1]} \
        --output {output[0]} \
        --cores {mycores} \
        """
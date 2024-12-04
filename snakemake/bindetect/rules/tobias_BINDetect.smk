# TOBIAS BINDetect
rule tobias_BINDetect:
    input:
        f"{case_tobias_dir}/{case_prefix}_footprints.bw",
        f"{control_tobias_dir}/{control_prefix}_footprints.bw",
        f"{bedtools_merge_dir}/merged_peaks.bed"
    output:
        f"{tobias_BINDetect_dir}/bindetect_results.txt"
    shell:
        """
        TOBIAS BINDetect \
        --motifs {motifs} \
        --signals {input[0]} {input[1]} \
        --genome {genome} \
        --peaks {input[2]} \
        --outdir {tobias_BINDetect_dir} \
        --cond_names {case_prefix} {control_prefix} \
        --cores {mycores}
        """
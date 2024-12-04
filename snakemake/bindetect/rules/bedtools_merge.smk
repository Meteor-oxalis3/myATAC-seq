rule bedtools_merge:
    input:
        f"{control_idr_dir}/{control_prefix}_idr.narrowPeak",
        f"{case_idr_dir}/{case_prefix}_idr.narrowPeak"
    output:
        f"{bedtools_merge_dir}/merged_peaks.bed"
    shell:
        """
        cat {input[0]} {input[1]} | bedtools sort -i - -g {genome_index} | bedtools merge -i - | grep -Ev {MT_DNA} > {output[0]}
        """
# samtools (merge & index)
rule samtools_merge_case:
    input:
        case1_dedup_bam =  glob(join(case1_dir, "samtools/dedup_*.bam")),
        case2_dedup_bam =  glob(join(case2_dir, "samtools/dedup_*.bam"))
    output:
        f"{case_prefix}/{samtools_merge_dir}/merged_{case_prefix}.bam",
        f"{case_prefix}/{samtools_merge_dir}/merged_{case_prefix}.bam.bai"
    shell:
        """
        samtools merge {input[0]} {input[1]} -o {output[0]} -@ {mycores};
        samtools index {output[0]} -o {output[1]} -@ {mycores};
        """
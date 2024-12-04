# samtools (merge & index)
rule samtools_merge_control:
    input:# 注意这里的 bam 输入被写死了！
        control1_dedup_bam = glob(join(control1_dir, "samtools/dedup_*.bam")),
        control2_dedup_bam = glob(join(control2_dir, "samtools/dedup_*.bam"))
    output:
        f"{control_prefix}/{samtools_merge_dir}/merged_{control_prefix}.bam",
        f"{control_prefix}/{samtools_merge_dir}/merged_{control_prefix}.bam.bai"
    shell:
        """
        samtools merge {input[0]} {input[1]} -o {output[0]} -@ {mycores};
        samtools index {output[0]} -o {output[1]} -@ {mycores};
        """
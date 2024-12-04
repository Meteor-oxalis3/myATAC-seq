# samtools
rule samtools:
    input:
        f"{bwa_dir}/{prefix}.sam"
    output:
        f"{samtools_dir}/{prefix}.bam",
        f"{samtools_dir}/fixmate_{prefix}.bam",
        f"{samtools_dir}/sorted_fixmate_{prefix}.bam",
        f"{samtools_dir}/dedup_{prefix}.bam",
        f"{samtools_dir}/dedup_{prefix}.bam.bai",
        f"{bwa_dir}/{prefix}_stats.txt"
    shell:
        """
        samtools stats {input} -@ {mycores} > {output[5]};
        samtools view -Sb {input} -o {output[0]} -@ {mycores};
        samtools fixmate -m {output[0]} {output[1]} -@ {mycores};
        samtools sort {output[1]} -o {output[2]} -@ {mycores};
        samtools markdup -r {output[2]} {output[3]} -@ {mycores};
        samtools index {output[3]} -@ {mycores}
        """
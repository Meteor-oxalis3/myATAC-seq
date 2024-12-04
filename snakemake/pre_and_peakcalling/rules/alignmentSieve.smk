# alignmentSieve (from deeptools)
# https://deeptools.readthedocs.io/en/develop/content/tools/alignmentSieve.html
rule alignmentSieve:
    input:
        f"{samtools_dir}/dedup_{prefix}.bam"
    output:
        f"{alignmentSieve_dir}/ATACshifted_{prefix}.bam",
        f"{alignmentSieve_dir}/{prefix}_metrics.txt"
    shell:
        """
        alignmentSieve -b {input} -o {output[0]} \
                       --ATACshift \
                       --minMappingQuality {minMappingQuality} \
                       --ignoreDuplicates \
                       --filterMetrics {output[1]} \
                       --blackListFileName {blacklist} \
                       --numberOfProcessors {mycores}
        """
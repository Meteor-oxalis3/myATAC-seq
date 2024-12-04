# idr (case)
# https://github.com/nboley/idr

rule idr_case:
    input:
        case1_peak = glob(join(case1_dir, "macs3/*_peaks.narrowPeak")),
        case2_peak = glob(join(case2_dir, "macs3/*_peaks.narrowPeak"))
    output:
        f"{case_idr_dir}/{case_prefix}_idr.txt",
        f"{case_idr_dir}/{case_prefix}_idr.log",
        f"{case_idr_dir}/{case_prefix}_idr.txt.png",
        f"{case_idr_dir}/{case_prefix}_idr.narrowPeak"
    shell:
        """
        {idr_bin} --sample  {input[0]} {input[1]} \
        --input-file-type narrowPeak \
        --rank p.value \
        --idr-threshold {idr_threshold} \
        --plot \
        --output-file {output[0]}\
        --log-output-file {output[1]};

        awk \
        -v OFS="\t" \
        'BEGIN {{FS=OFS}} \
        {{ $4=$1":"$2"_"$3; print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10 }}' \
        {output[0]} | sort -k1,1 -k2,2n -k3,3n \
        > {output[3]}
        """
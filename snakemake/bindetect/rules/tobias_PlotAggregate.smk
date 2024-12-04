rule tobias_PlotAggregate:
    input:

    output:

    shell:
        """
        TOBIAS PlotAggregate \
        --TFBS footprinting/_EHF_HUMAN.H11MO.0.B/beds/_EHF_HUMAN.H11MO.0.B_Diabetic_hs_bound.bed \
            footprinting/_EHF_HUMAN.H11MO.0.B/beds/_EHF_HUMAN.H11MO.0.B_Diabetic_hs_unbound.bed \
        footprinting/_EHF_HUMAN.H11MO.0.B/beds/_EHF_HUMAN.H11MO.0.B_Healthy_hs_bound.bed \
        footprinting/_EHF_HUMAN.H11MO.0.B/beds/_EHF_HUMAN.H11MO.0.B_Healthy_hs_unbound.bed \
        --TFBS-labels Diabetic_bound Diabetic_unbound Healthy_bound Healthy_unbound \
        --signals footprinting/Diabetic_hs_corrected.bw \
        footprinting/Diabetic_hs_uncorrected.bw \
        footprinting/Healthy_hs_corrected.bw \
        footprinting/Healthy_hs_uncorrected.bw \
        --signal-labels Diabetic_corrected Diabetic_uncorrected Healthy_corrected corrected_uncorrected \
        --output footprinting/_EHF_HUMAN.H11MO.0.B/_EHF_HUMAN.H11MO.0.B_PlotAggregate.pdf \
        --share_y both \
        --plot_boundaries \
        --signal-on-x
        """
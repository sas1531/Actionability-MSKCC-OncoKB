#!/usr/bin/env bash

cd ~/oncokb_anno/oncokb-annotator

IMAF="~/msk_impact_2017/data_mutations_extended.txt"
OMAF="~/msk_impact_2017/data_mutations_extended_oncokb.txt"
IF="~/msk_impact_2017/data_fusions.txt"
OF="~/msk_impact_2017/data_fusions_oncokb.txt"
ICNA="~/msk_impact_2017/data_CNA.txt"
OCNA="~/msk_impact_2017/data_CNA_oncokb.txt"
IC="~/msk_impact_2017/data_clinical_sample.txt"
OC="~/msk_impact_2017/data_clinical_sample_oncokb.txt"
OCPDF="~/msk_impact_2017/data_clinical_sample_oncokb.pdf"
TOKEN=#OncoKB API Token
README="~/msk_impact_2017/example_README.txt"

python MafAnnotator.py -i $IMAF -o $OMAF -c $IC -b $TOKEN
python FusionAnnotator.py -i $IF -o $OF -c $IC -b $TOKEN
python CnaAnnotator.py -i $ICNA -o $OCNA -c $IC -b $TOKEN
python ClinicalDataAnnotator.py -i $IC -o $OC -a $OMAF,$OCNA,$OF
python OncoKBPlots.py -i $OC -o $OCPDF -c ONCOTREE_CODE #-n 10
python GenerateReadMe.py -o $README

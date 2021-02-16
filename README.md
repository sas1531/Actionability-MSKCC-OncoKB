# Actionability
Shaleigh Smith  
smiths5@mskcc.org  

## [OncoKB](https://www.oncokb.org): Precision Oncology Knowledge Base  
Annoate IMPACT files using [oncokb-annotator](https://github.com/oncokb/oncokb-annotator)  
> Chakravarty D, Gao J, Phillips SM, et al. OncoKB: A Precision Oncology Knowledge Base. JCO Precis Oncol. 2017;2017:PO.17.00011. doi:10.1200/PO.17.00011    
 
## Usage: 
### Functions
##### `action_levels_barplot_fun`: Creates actionability barplot displaying the highest level of evidence for each sample across all cancer types.
```
action_levels_barplot_fun(cna_df, mut_df, fus_df, clin_df, data_freeze,
                          group_col = "ONCOTREE_CODE",
                          status = c("somatic", "germline", "both"),
                          consent_col = "Consent") 
```                                                   
##### `action_alterations_barplot_fun`: Creates actionable alterations barplot displaying the frequency of alteration type across all actionable alterations.
```
action_alterations_barplot_fun(cna_df, mut_df, fus_df, clin_df, data_freeze,
                               prop_level_df = "./actionability_levels_barplot_table.txt",
                               group_col = "ONCOTREE_CODE",
                               status = c("somatic", "germline", "both"),
                               consent_col = "Consent")
```  
##### `action_count_barplot_fun`: Creates actionable alteration count barplot displaying the number of actionable alterations for each sample across all cancer types. 
```
action_count_barplot_fun(clin_df, data_freeze,
                         prop_level_df = "./actionability_levels_barplot_table.txt",
                         alt_final_df = "./actionability_master_alterations_table.txt",
                         group_col = "ONCOTREE_CODE",
                         status = c("somatic", "germline", "both"),
                         consent_col = "Consent")
```  
##### `action_main_fun`: Creates main tile plot displaying the frequency of highest level of evidence of a specific alteration across all cancer types. 
```
action_main_fun(cna_df, mut_df, fus_df, clin_df, data_freeze,
                path_df, tsg_list, fusion_list, gene_order,
                prop_level_df = "./actionability_levels_barplot_table.txt",
                group_col = "ONCOTREE_CODE",
                status = c("somatic", "germline", "both"),
                consent_col = "Consent"
                alt_min = 1)
```  

### Example script [here](https://github.mskcc.org/SmithS5/Actionability/blob/master/R/example_script.R)  
#### Script Requirements & Options:  
- Update working directory and paths. 
- Status options:  
  - `somatic`: selects somatic mutations only. 
  - `germline`: selects germline mutations only.
  - `both`: all mutations, germline status indicated by an asterisk. Provides total `n` and Part C consented `n`.  
- Optional Inputs:  
  - `fusion_list`: Groups fusions by gene and removes unlisted fusion partner (ie. NTRK1-LMNA fusion becomes NTRK1 fusion). 
  - `gene_order`: Sets gene order for main plot, all genes not included will follow order indicated in pathway data. 

## Input Parameters  
##### Text file format required
`cna_df`: OncoKB annotated IMPACT CNA data.   
`mut_df`: OncoKB annotated IMPACT mutation data.   
`fus_df`: OncoKB annotated IMPACT fusion data.   
`clin_df`: OncoKB annotated IMPACT clinical sample data.   
`data_freeze`: Sample data, must include `SAMPLE_ID`, `group_col`, and `consent_col` columns.    
`group_col`: Column name for the groups (cancer types).   
`consent_col`: Columns name for 12-245 Part C consent status (YES/NO/NA), fill with NA if not required.   
`path_df`: Pathway data, must include gene and correpsonding pathway columns (in that order).   
`tsg_list`: List of tumor suppresor genes (no header).   
`fusion_list`: List of genes to isolate from fusion partners (no header).   
`prop_level_df`: Output from action_levels_barplot_fun *actionability_levels_barplot_table.txt*.   
`alt_final_df`: Output from action_alterations_barplot_fun *actionability_master_alterations_table.txt*.   
`alt_min`: Minimum alteration percentage required in one cancer type to visualize alteration on main plot (default 1).    
`status`: Include only somatic mutations, only germline mutations, or both (options: somatic, germline, both).  
`gene_order`: List of genes for gene order (no header).   

## Example Data
cBioPortal Study: [MSK-IMPACT Clinical Sequencing Cohort (MSKCC, Nat Med 2017)](https://www.cbioportal.org/study/summary?id=msk_impact_2017)  
> Zehir A, Benayed R, Shah RH, et al. Mutational landscape of metastatic cancer revealed from prospective clinical sequencing of 10,000 patients [published correction appears in Nat Med. 2017 Aug 4;23 (8):1004]. Nat Med. 2017;23(6):703-713. doi:10.1038/nm.4333

![Actionability Figure](https://github.com/sas1531/Actionability_MSKCC/blob/master/example_data/example_output/actionability_figure.png)  
  
  
## Inspired by Figure 7 in [Sanchez-Vega et al. Cell 2018](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6070353/): 
> Sanchez-Vega, Francisco et al. “Oncogenic Signaling Pathways in The Cancer Genome Atlas.” Cell vol. 173,2 (2018): 321-337.e10. doi:10.1016/j.cell.2018.03.035

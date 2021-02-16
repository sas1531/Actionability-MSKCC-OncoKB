#!/usr/bin/env Rscript

### Shaleigh Smith
### smiths5@mskcc.org

setwd("/Users/smiths5/Desktop/work/Actionability/")

# Set paths
impact_df_path_cna <- "./example_data/example_input/data_CNA_oncokb.txt"
impact_df_path_fus <- "./example_data/example_input/data_fusions_oncokb.txt"
impact_df_path_mut <- "./example_data/example_input/data_mutations_extended_oncokb.txt"
clin_df_path <- "./example_data/example_input/data_clinical_sample_oncokb.txt"
data_freeze_path <- "./example_data/example_input/data_freeze_all_n50.txt"
pathway_data_path <- "./example_data/example_input/pathway_assignment.txt"
tsg_path <- "./example_data/example_input/tsg_oncokb_08282020.txt"
fusion_path <- "./example_data/example_input/fusion_list.txt"
gene_path <- "./example_data/example_input/gene_order.txt"

# Source
source("./R/actionability_functions.R")

# Create actionability barplot
action_levels_barplot <- action_levels_barplot_fun(cna_df = impact_df_path_cna,
                                                   mut_df = impact_df_path_mut,
                                                   fus_df = impact_df_path_fus,
                                                   clin_df = clin_df_path,
                                                   data_freeze = data_freeze_path,
                                                   group_col = "ONCOTREE_CODE",
                                                   status = "somatic",
                                                   consent_col = "Consent")
action_levels_barplot

# Create actionability alterations barplot
action_alt_barplot <- action_alterations_barplot_fun(cna_df = impact_df_path_cna,
                                                     mut_df = impact_df_path_mut,
                                                     fus_df = impact_df_path_fus,
                                                     clin_df = clin_df_path,
                                                     data_freeze = data_freeze_path,
                                                     group_col = "ONCOTREE_CODE",
                                                     prop_level_df = "./actionability_levels_barplot_table.txt",
                                                     consent_col = "Consent",
                                                     status = "somatic")
action_alt_barplot

# Create actionability alterations count barplot
action_count_barplot <-  action_count_barplot_fun(clin_df = clin_df_path,
                                                  data_freeze = data_freeze_path,
                                                  group_col = "ONCOTREE_CODE",
                                                  prop_level_df = "./actionability_levels_barplot_table.txt",
                                                  alt_final_df = "./actionability_master_alterations_table.txt",
                                                  consent_col = "Consent",
                                                  status = "somatic")
action_count_barplot


# Combine and save barplots
action_barplot <- plot_grid(action_levels_barplot, action_alt_barplot, action_count_barplot,
                            align = "v", nrow = 3, rel_heights = c(0.40, 0.25, 0.25))
action_barplot

# Save figure
pdf("actionability_bar_plots.pdf", height = 6, width = 9)
action_barplot
dev.off()

main_plot <- action_main_fun(cna_df = impact_df_path_cna,
                             mut_df = impact_df_path_mut,
                             fus_df = impact_df_path_fus,
                             clin_df = clin_df_path,
                             data_freeze = data_freeze_path,
                             path_df = pathway_data_path,
                             tsg_list = tsg_path,
                             fusion_list = fusion_path,
                             prop_level_df = "./actionability_levels_barplot_table.txt",
                             group_col = "ONCOTREE_CODE",
                             alt_min = 1,
                             status = "somatic",
                             consent_col = "Consent",
                             gene_order = gene_path)
main_plot

# Combine all figures
actionability_final_fig <- plot_grid(action_levels_barplot, main_plot, action_alt_barplot, action_count_barplot,
                                     align = "v", nrow = 4, rel_heights = c(0.2, 0.6, 0.10, 0.10))
actionability_final_fig

# Export figure
pdf("actionability_figure.pdf", height = 12, width = 8)
actionability_final_fig
dev.off()
#
# Plot ancestral corm types inferred using CTMC models of character evolution.
#
#
# author: Will Freyman
#

#library(devtools)
#install_github("revbayes/RevGadgets")

library(RevGadgets)


models = c("2_rate_model", "rj_model")

for (i in 1:length(models)) {

    tree_file = paste("output/ancestral_states_", models[i], ".tree", sep="")
    out_file = paste("ancestral_states_", models[i], ".pdf", sep="")

    plot_ancestral_states(tree_file, summary_statistic="MAP",
                          tip_label_size=0,
                          xlim_visible=c(0, 0.1),
                          node_label_size=0,
                          node_size_range=c(1, 5)) +
                          geom_tiplab(align=TRUE, size=1.7, linetype="1F", linesize=0.1) + 
                          guides(colour=guide_legend("Corm Morphology")) +
                          scale_colour_discrete(labels=c("Unknown", "Trilobate", "Bilobate"))

    ggsave(out_file, width = 11, height = 9)

}

module load app/R/4.3.2

R

library(LEA)
library(ggplot2)
library(readxl)
library(tidyr)
library(dplyr)

#load project
project_snmf_outlier = load.snmfProject("~/outlier_final.snmfProject")

pdf("plot.outlier.K.pdf")
plot(project_snmf_outlier, cex = 1.2, col = "lightblue", pch = 19)
dev.off() #K=5

#pdf("plot.outlier.K1.pdf")
#plot(project_snmf_outlier, run = 2, cex = 1.2, col = "lightblue", pch = 19)
#dev.off()

#K NEUTRAL PRE-PLOT 
#DEPENDS ON K (K, colors - from R) 
ce_outlier <-  cross.entropy(project_snmf_outlier, K = 5) 

best_run_outlier <- which.min(ce_outlier)

q_mat_outlier <- LEA::Q(project_snmf_outlier, K = 5, run = best_run_outlier)
 
colnames(q_mat_outlier) <- paste0("P", 1:5)

samplelist_admix <- read_excel("~/honours_resubmission/samplelist_admix_resubmission.xlsx")
pop_order <- samplelist_admix

q_df_outlier <- q_mat_outlier %>%
   as_tibble() %>%
	mutate(individual = pop_order$sample,         
	region = pop_order$pop,         
	order = pop_order$order)

q_df_long_outlier <- q_df_outlier %>%   
pivot_longer(cols = starts_with("P"), 
	names_to = "pop", values_to = "q")

q_df_prates_outlier <- q_df_long_outlier %>%
	arrange(order) %>%
	mutate(individual = forcats::fct_inorder(factor(individual)))

q_df_prates_outlier$region_f <- factor(
	q_df_prates_outlier$region, 
	levels=c('SW', 'BU', "KA", "KO","NA"))

#k=5 OUTLER PLOT
q_df_prates_outlier$region_f <- factor(q_df_prates_outlier$region, levels=c('SW', 'BU', "KA", "KO","NA"))

plot.outlier.admix.snmf<-q_df_prates_outlier %>%
ggplot() +
geom_col(aes(x = individual, y = -q, fill = pop)) +
scale_fill_manual(values=c("#21918c","#5ec962","#fde725","#440154","#CC7722"))+
labs(
x = "Individual",
y ="Ancestry Proportion",
title ="K=5",
fill = "pop") +
theme_minimal()+
theme(panel.spacing.x = unit(0.25, "lines"),
axis.line = element_blank(),
strip.background = element_rect(
fill = "transparent", color = "transparent"),
panel.background = element_blank(),
axis.text = element_blank(),
#axis.title = element_blank(),
panel.grid = element_blank(),
strip.placement = "outside", # Place facet labels outside x axis labels.
axis.title.x = element_text(size = 8),
axis.title.y = element_text(size = 8),
#axis.text.x = element_text(size = 8),
#axis.text.y = element_text(size = 8),
title = element_text(size = 8),
strip.text = element_text(size = 8)) +
facet_grid(~region_f,
scales = "free_x", # Let the x axis vary across facets.
space = "free_x",  # Let the width of facets vary and force all bars to have the same width.
switch = "x") # Move the facet labels to the bottom.


pdf("plot.outlier.admix.pdf")
plot.outlier.admix.snmf
dev.off()
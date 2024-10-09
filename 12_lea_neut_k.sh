module load app/R/4.3.2

R

library(LEA)
library(ggplot2)
library(readxl)
library(tidyr)
library(dplyr)

#load project
project_snmf_neutral = load.snmfProject("~/honours_resubmission/populations.snp.resubmission72_neutral.snmfProject")

pdf("plot.neutral.K.pdf")
plot(project_snmf_neutral, cex = 1.2, col = "lightblue", pch = 19)
dev.off() #K=4

#K NEUTRAL PRE-PLOT 
#DEPENDS ON K (K, colors - from R) 
ce_neutral <-  cross.entropy(project_snmf_neutral, K = 4) 

best_run_neutral <- which.min(ce_neutral)

q_mat_neutral <- LEA::Q(project_snmf_neutral, K = 4, run = best_run_neutral)
 
colnames(q_mat_neutral) <- paste0("P", 1:4)

samplelist_admix <- read_excel("~/honours_resubmission/samplelist_admix_resubmission.xlsx")
pop_order <- samplelist_admix

q_df_neutral <- q_mat_neutral %>%
   as_tibble() %>%
	mutate(individual = pop_order$sample,         
	region = pop_order$pop,         
	order = pop_order$order)

q_df_long_neutral <- q_df_neutral %>%   
pivot_longer(cols = starts_with("P"), 
	names_to = "pop", values_to = "q")

q_df_prates_neutral <- q_df_long_neutral %>%
	arrange(order) %>%
	mutate(individual = forcats::fct_inorder(factor(individual)))

q_df_prates_neutral$region_f <- factor(
	q_df_prates_neutral$region, 
	levels=c('SW', 'BU', "KA", "KO","NA"))

#k=4 NEUTRAL PLOT
q_df_prates_neutral$region_f <- factor(q_df_prates_neutral$region, levels=c('SW', 'BU', "KA", "KO","NA"))

plot.neutral.admix.snmf<-q_df_prates_neutral %>%
ggplot() +
geom_col(aes(x = individual, y = -q, fill = pop)) +
scale_fill_manual(values=c("#fde725","#CC7722","#21918c","#440154"))+
labs(
x = "Individual",
y ="Ancestry Proportion",
title ="K=4",
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


pdf("plot.neutral.admix.pdf")
plot.neutral.admix.snmf
dev.off()
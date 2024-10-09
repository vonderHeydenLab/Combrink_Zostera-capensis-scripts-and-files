module load app/R/4.3.2

R

library(LEA)
library(ggplot2)
library(readxl)
library(tidyr)
library(dplyr)

#load project
project_snmf_full = load.snmfProject("~/honours_resubmission/populations.snp.resubmission72.snmfProject")

#K=2 FULL PRE-PLOT 
ce_2_full <- cross.entropy(project_snmf_full, K = 2)

best_run_2_full <- which.min(ce_2_full)
best_run_2_full #48

q_mat_2_full <- LEA::Q(
	project_snmf_full, 
	K = 2, 
	run = best_run_2_full)

colnames(q_mat_2_full) <- paste0("P", 1:2)

samplelist_admix <- read_excel("~/honours_resubmission/samplelist_admix_resubmission.xlsx")
pop_order <- samplelist_admix

q_df_2_full <- q_mat_2_full %>% as_tibble() %>% mutate(
		individual = pop_order$sample, 
		region = pop_order$pop,
		order = pop_order$order)

q_df_long_2_full <- q_df_2_full %>%
	pivot_longer(
		cols = starts_with("P"), 
		names_to = "pop", 
		values_to = "q")
		
q_df_prates_2_full <- q_df_long_2_full %>%
	arrange(order) %>%
	mutate(individual = forcats::fct_inorder(factor(individual)))

q_df_prates_2_full$region_f <- factor(
	q_df_prates_2_full$region, 
	levels=c('SW', 'BU', "KA", "KO","NA"))

#K=2 FULL PLOT
plot.full.K2.snmf<-q_df_prates_2_full %>%
	ggplot() +
	geom_col(aes(x = individual, y = -q, fill = pop)) +
	scale_fill_manual(
		values=c("cadetblue3","tomato"), 
		labels = c("Western lineage", "Eastern lineage")) +
	labs(
		x = "Individual",
		y ="Ancestry Proportion",
		title ="K=2",
		fill = "pop") +
	theme_minimal()+
	theme(
		panel.spacing.x = unit(0.25, "lines"),        
		axis.line = element_blank(),        
		strip.background = element_rect(
		fill = "transparent", 
		color = "transparent"),        
		panel.background = element_blank(),        
		axis.text = element_blank(),
		panel.grid = element_blank(),        
		strip.placement = "outside", # Place facet labels outside x axis labels.
    axis.title.x = element_text(size = 28),         
		axis.title.y = element_text(size = 28),               
		title = element_text(size = 30),        
		legend.text = element_text(size = 20),        
		strip.text = element_text(size = 25)) +  
	facet_grid(
		~region_f,
		scales = "free_x", # Let the x axis vary across facets.
		space = "free_x", # Let the width of facets vary and force all bars to have the same width.          
		switch = "x")  # Move the facet labels to the bottom.

pdf("snmf.full.K2.pdf")
plot.full.K2.snmf
dev.off()
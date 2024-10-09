pdf("plot.full.K.pdf")
plot(project_snmf_full, cex = 1.2, col = "lightblue", pch = 19)
dev.off()

#K=5 FULL PRE-PLOT 
#DEPENDS ON K (K, colors - from R) 
ce4 <-  cross.entropy(project_snmf_full, K = 5) 

best_run4 <- which.min(ce4)

q_mat4 <- LEA::Q(project_snmf_full, K = 5, run = best_run4)
 
colnames(q_mat4) <- paste0("P", 1:5)

samplelist_admix <- read_excel("~/honours_resubmission/samplelist_admix_resubmission.xlsx")
pop_order <- samplelist_admix

q_df4 <- q_mat4 %>%
   as_tibble() %>%
	mutate(individual = pop_order$sample,         
	region = pop_order$pop,         
	order = pop_order$order)

q_df_long4 <- q_df4 %>%   
pivot_longer(cols = starts_with("P"), 
	names_to = "pop", values_to = "q")

q_df_prates_4 <- q_df_long4 %>%
	arrange(order) %>%
	mutate(individual = forcats::fct_inorder(factor(individual)))

q_df_prates_4$region_f <- factor(
	q_df_prates_4$region, 
	levels=c('SW', 'BU', "KA", "KO","NA"))

#k=5 FULL PLOT
q_df_prates_4$region_f <- factor(q_df_prates_4$region, levels=c('SW', 'BU', "KA", "KO","NA"))

#palette_4 <- c("#35b779","#fde725","#440154","#31688e")
#palette_5 <-c("#21918c","#3b528b","#5ec962","#440154","#fde725")
#q_palette <- c("#21918c","#5ec962","#3b528b","#440154","#CC7722") 

plot.full.admix.snmf<-q_df_prates_4 %>%
ggplot() +
geom_col(aes(x = individual, y = -q, fill = pop)) +
scale_fill_manual(values=c("#21918c","#5ec962","#CC7722","#440154","#fde725"))+
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


pdf("plot.full.admix.pdf")
plot.full.admix.snmf
dev.off()
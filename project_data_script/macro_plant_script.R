#########

# code for macro/plant ecology project

library(ggplot2)
plant = read.csv('project_data_script/macro_plant.csv')
View(plant)
plant$site = as.integer(plant$site)
names = labels=c("Macroinvertebrates","Macrophytes")


## scatterplot
ggplot(plant, aes(x=reorder(site,treatment), y=diversity, col = treatment))+
  geom_point()+
  scale_color_manual(labels=c("Macroinvertebrates","Macrophytes"),values = c("red","royalblue"))+     ## adds the legend according to color of "treatment" category
  scale_fill_hue(labels=c("Macroinvertebrates","Macrophytes"))+
  guides(col = guide_legend(title = "Treatment"))+
  labs(x="Site", y="Diversity Index")+
  theme(legend.position = "Left")



## bar graph
ggplot(data=plant, aes(x=reorder(site,treatment), y=diversity, fill=treatment)) +
  geom_bar(stat="identity", color = "black", position=position_dodge())+
  scale_fill_manual(values=c("blue3","lightgreen"))+
  guides(fill = guide_legend(title = "Sample Type")) +      ### changes name OF legend
  labs(x="Site No", y="Diversity Index") +
  theme_classic()
  

## box plt
ggplot(plant, aes(x=treatment, y=diversity))+
  geom_boxplot()+
  stat_boxplot(geom="errorbar", width = 0.25)+
  labs(x="Sample Type", y = "Diversity Index")+
  scale_x_discrete(labels=c("Macroinvertebrates","Macrophytes"))+
  theme(text = element_text(size = 15))

t_test_macro=read.csv("project_data_script/t_testmacro.csv")
head(t_test_macro)
  
t_test_macro$sample = as.numeric(t_test_macro$sample)
t.test(diversity ~ sample, t_test_macro, paired = FALSE)
View(t_test_macro)

summary(split_data$macroinvertebrate$diversity)

var(split_data$macroinvertebrate$diversity)

##### linear regression

model = lm(diversity ~ sample, data = t_test_macro)
summary(model)
model

plot(model, 5)
par(mfrow=c(2,2))

hats <- as.data.frame(hatvalues(model))
hats

plot(diversity, xlab = "Site Number",ylab = "Diversity Index")

split_data <- split(plant, f = plant$treatment)   
View(split_data)
split_data[["macroinvertebrate"]]
split_data[["macrophyte"]]

summary(split_data[["macrophyte"]]$diversity)
summary(split_data[["macroinvertebrate"]]$diversity)

library(dplyr)






test_plant = read.csv("project_data_script/species_count.csv")
View(test_plant)
head(test_plant)
test_plant$site = as.character(test_plant$site)

richness = ggplot(test_plant, aes(x=sample, y=richness))+
  geom_boxplot()+
  labs(x="Sample Type", y="Species Richness")+
  theme(text = element_text(size = 13))
abundance = ggplot(test_plant, aes(x=sample, y=abundance))+
  geom_boxplot()+
  labs(x="Sample Type", y="Species Abundance")+
  ylim(0,60)+
  theme(text = element_text(size = 13))
richness
library(cowplot)
richness_abundance = plot_grid(richness, abundance, ncol = 2, nrow= 1)
richness_abundance

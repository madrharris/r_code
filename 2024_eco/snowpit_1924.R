#######. snowpit data
library(ggplot2)
pit = read.csv("snow temp.csv")

head(pit)

snowpit <- ggplot(pit,aes(x=depth_cm, y=temperature_degrees_celsius))+
  geom_line()+geom_point(size=2)+
  labs(x="Temperature (C)", y="Snow Height (cm)")+
  ggtitle("Snowpit Height and Temperature",subtitle = "Taegen, Haven, & Maddie")+
  theme_bw()

snowpit

ggplot(pinecone, aes(x=p_height, y = p_weight, col = treatment))+
  geom_line()+geom_point(size=2)+
  scale_color_manual(labels = c("Treatment 1", "Treatment 2"),values = c("red","royalblue"))+     ## adds the legend according to color of "treatment" category
  scale_fill_hue(labels = c("Treatment 1", "Treatment 2"))+
  guides(col = guide_legend(title = "Treatment"))+
  labs(x="Pinecone Height", y="Pinecone Weight")+
  ggtitle("Pinecone Ex")+
  theme(plot.title = element_text(size = 20))+
  theme_bw()

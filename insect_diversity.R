######### 
# r code for t-test insect data

library(ggplot2)
library(cowplot)
citation(package = "cowplot")
treatment <- c(1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2)
cover <- c(19,43,20,7,16,2,7,46,66,73,74,71,79,83,86,68)
diversity <- c(0.401,1.082,1.296,1.4,0.127,1.166,0.149,1.0507,1.13,1.67,1.2009,1.208,1.309,1.6,1.563,1.483)
insect <- data.frame(treatment, cover, diversity)

head(insect)

t.test(insect$diversity, insect$cover, paired = TRUE)

error = stat_boxplot(geom = "errorbar", # Error bars
                     width = 0.25)    # Bars width
insect$treatment = as.character(insect$treatment)

new_split_insect <- split(insect, f = insect$treatment)   
View(new_split_insect)
split_data[["macroinvertebrate"]]
split_data[["macrophyte"]]
var(new_split_insect$1$cover)


var(19,43,20,7,16,2,7,46)

## ggplot

titles = ggtitle("Insect Diversity Caught per Canopy Treatment") + 
  legend.title=element_text(size=20)


box = ggplot(insect, aes(treatment, diversity, fill = treatment)) + 
  geom_boxplot()+
  error +
  scale_fill_hue(labels = c("Sagebrush", "Tree Cover")) + ### changes names under legend 
  guides(fill = guide_legend(title = "Treatment")) + ### changes name OF legend
  labs(x="Treatment", y="Diversity") + ### labels of axes
  theme_bw() ### theme

line = ggplot(insect, aes(x=cover, y = diversity, col = treatment))+
  geom_point(size=2)+
  scale_color_manual(labels = c("Sagebrush", "Tree Cover"),values = c("red","royalblue"))+
  scale_fill_hue(labels = c("Sagebrush", "Tree Cover"))+
  guides(col = guide_legend(title = "Treatment"))+
  labs(x="Percent Canopy Cover", y="Diversity")+
  ggtitle("Insect Diversity Caught per Canopy Treatment")+
  geom_smooth(method="lm", se = FALSE)+
  theme(plot.title = element_text(size = 20))+
  theme_bw()

line
box

ggplot(insect, aes(x=treatment))+
  geom_histogram()+
  theme_bw()
  

plot_grid(line, box,
          ncol = 1, nrow = 2)


write.csv(insect, "Desktop\\insect.csv", row.names=FALSE)











########################## Interview Data

## how many students as a whole thought this....
# total number of students: 

questions = c(1,2,3,4,5)
answers = c(16,20,11,25,13)
interview = data.frame(questions, answers)
interview$questions = as.character(interview$questions)

subq = c(1.1,2.1,4.1,4.2,4.3,4.4,5.1,5.2)
subanswers = c(4,11,0,6,6,9,0,0)
subint = data.frame(subq,subanswers)
View(subint)
subint$subq = as.character(subint$subq)


ggplot(interview, aes(x=questions,y=answers))+
  geom_bar(stat = "identity",width=0.5, fill="darkblue")+
  labs(x="Question Number", y="No. of Answers")+
  geom_text(aes(label=answers), vjust=1.6, color="white", size=4)+
  scale_y_continuous(expand = expansion(mult = c(0, 0.05)))+
  theme_classic()

ggplot(subint, aes(x=subq,y=subanswers))+
  geom_bar(stat = "identity",width=0.75, fill="darkblue")+
  labs(x="Question Number", y="No. of Answers")+
  geom_text(aes(label=subanswers), vjust=1.6, color="white", size=4)+
  scale_y_continuous(expand = expansion(mult = c(0, 0.05)))+
  theme_classic()

##   supp dose  len
## 1   VC D0.5  6.8
## 2   VC   D1 15.0
## 3   VC   D2 33.0
## 4   OJ D0.5  4.2
## 5   OJ   D1 10.0
## 6   OJ   D2 29.5







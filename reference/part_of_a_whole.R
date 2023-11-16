#################################
#
#       Part of a whole
#
# install.packages("ggplot2")
#################################

## Bar Plot (more advanced than what's in the ggplot library)
#     see stacked and grouped in ggplot_library



####### Percent Stacked
specie <- c(rep("sorgho" , 3) , rep("poacee" , 3) , rep("banana" , 3) , rep("triticum" , 3) )
condition <- rep(c("normal" , "stress" , "Nitrogen") , 4)
value <- abs(rnorm(12 , 0 , 15))
data <- data.frame(specie,condition,value)
View(data)

# Stacked  percent (POSITION: FILL)
ggplot(data, aes(x=specie, y=value, fill=condition)) + 
  geom_bar(position="fill", stat="identity")


###### Small multiple
# can be used instead of stacking
# facet_wrap()

install.packages("viridis")
install.packages("hrbrthemes")
  # colors and stacking

# same dataset
library(hrbrthemes)
ggplot(data, aes(fill=condition, y=value, x=condition)) +     ## x, y, and fill can be interchanged in order
  geom_bar(position="dodge", stat="identity") +     
  scale_fill_viridis(discrete = T, option = "E") +       ## just makes one graph
  ggtitle("Studying 4 species..") +                       ## title
  facet_wrap(~specie) +                               ## separates plots based on ...
  theme_ipsum() +
  theme(legend.position="none") +                      ## removes legend
  xlab("")                                            ## removes x axis labels


########### Stacked barplot with negative values with ggplot2. Just add negative values lmao

# download data. has months and different group data
data <- read.table("https://raw.githubusercontent.com/holtzy/R-graph-gallery/master/DATA/stacked_barplot_negative_values.csv", header=T, sep=",")

# load in required packages
library(tidyr)
library(dplyr)

# transform data from short to long format. combines separate group columns into one column
data_long <- gather(data, group, value, groupA:groupD) %>%
  arrange(factor(x, levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct"))) %>% 
  mutate(x=factor(x, levels=unique(x)))
head(data_long)


### Stack the data
library(ggplot2)

# plot
ggplot(data_long, aes(fill=group, y=value, x=x)) + 
  geom_bar(position="stack", stat="identity") +

### extras
scale_fill_viridis(discrete=TRUE, name="") +
  theme_ipsum() +
  ylab("Money input") + 
  xlab("Month")


############### Barplot for likert type items
### GOOD FOR QUESTIONAIR STUFF 👀🫵🫵👈👉

install.packages("likert")
library(likert) 
# load in data from https://github.com/jbryer/likert/blob/6fc296a44679c103bae8a26b7aeceac2fc857a22/data/pisaitems.rda

data(pisaitems) 
items28 <- pisaitems[, substr(names(pisaitems), 1, 5) == "ST24Q"] 

p <- likert(items28) 
plot(p)

# basically data where each "thing" (aka question) has two options, two answers. 
# And you have the percentages of both. Percentage of A & B, out of 100%. 




############################################
#
#           Circular Bar Chart
#
#library(tidyverse)
############################################

# most basic

# make data:
data <- data.frame(
  id=seq(1,60),
  individual=paste( "Mister ", seq(1,60), sep=""),
  value=sample( seq(10,100), 60, replace=T))
head(data)

# make the plot

ggplot(data, aes(x=as.factor(id), y=value)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  
      # This add the bars with a blue color
  geom_bar(stat="identity", fill=alpha("red", 0.3)) +
  
      # Limits of the plot = very important. 
      # The negative value controls the size of the inner circle, 
      # the positive one to add size over each bar
  ylim(-100,120) +
  
      # Custom the theme: no axis titles and no cartesian grid
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-2,4), "cm")) +     
      # This remove unnecessary margin around plot
 
    # This makes the coordinate polar instead of cartesian. Circle
  coord_polar(start = 0)

# makes an empty pink plot


######    Add Labels

# make functions for each labeling aspect. Then combine into a dataframe

label_data <- data

    # calculate the ANGLE of the labels
number_of_bar <- nrow(label_data)
angle <-  90 - 360 * (label_data$id-0.5) /number_of_bar     
  # Substract 0.5 because the letter must have the angle of the center of the bars. 
  # Not extreme right(1) or extreme left (0)

  # calculate the alignment of labels: right or left
  # If I am on the left part of the plot, my labels have currently an angle < -90
label_data$hjust<-ifelse( angle < -90, 1, 0)

  # flip angle BY to make them readable
label_data$angle<-ifelse(angle < -90, angle+180, angle)

###### make the graph


ggplot(data, aes(x=as.factor(id), y=value)) +       
    # Note that id is a factor. If x is numeric, there is some space between the first bar
  
    # This add the bars with a blue color
  geom_bar(stat="identity", fill=alpha("skyblue", 0.7)) +
  
    # Limits of the plot = very important. 
    # The negative value controls the size of the inner circle, 
    # the positive one is useful to add size over each bar
  ylim(-100,120) +
  
    # Custom the theme: no axis title and no cartesian grid
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm")      # Adjust the margin to make in sort labels are not truncated!
  ) +
  
  # This makes the coordinate polar instead of cartesian.
  coord_polar() +
  
  
  # Add the labels, using the label_data dataframe that we have created before
  geom_text(data=label_data, aes(x=id, y=value+10, label=individual, hjust=hjust), color="black", 
            fontface="bold",alpha=0.6, size=2.5, angle= label_data$angle, inherit.aes = FALSE ) 


############## circle bar plot, with gap

# Set a number of 'empty bar'
empty_bar <- 10

# Add lines to the initial dataset
to_add <- matrix(NA, empty_bar, ncol(data))
colnames(to_add) <- colnames(data)
data <- rbind(data, to_add)
data$id <- seq(1, nrow(data))

# Get the name and the y position of each label
label_data <- data
number_of_bar <- nrow(label_data)
angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
label_data$hjust <- ifelse( angle < -90, 1, 0)
label_data$angle <- ifelse(angle < -90, angle+180, angle)

## make the plot
ggplot(data, aes(x=as.factor(id), y=value)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  geom_bar(stat="identity", fill=alpha("green", 0.3)) +
  ylim(-100,120) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm") 
  ) +
  coord_polar(start = 0) + 
  geom_text(data=label_data, aes(x=id, y=value+10, label=individual, hjust=hjust), color="black", fontface="bold",alpha=0.6, size=2.5, angle= label_data$angle, inherit.aes = FALSE ) 
















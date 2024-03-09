#########################################

## "library" of ggplot stuff and copy/paste code

#++++++++++++++++++
#+  box plot, scatter plot, bar graph
#+  https://r-graph-gallery.com/

#########################################
library(ggplot2)
library(cowplot)
install.packages("RColorBrewer")
library(RColorBrewer)

data = data.frame(replicate(10,sample(0:100,100,rep=TRUE)))
View(soil_m)

##### Box Plot #####

## ggplot

# must convert X to either FACTOR or AS.CHARACTER       "as.factor()"
# data = 
head(mtcars)
typeof(mtcars$cyl)
###
# Most Basic BoxPlot

ggplot(mtcars, aes(x=as.factor(cyl), y=mpg))+      # lays out framework
  geom_boxplot()

## white boxes on graph. no axis names, no titles, just white
#### customize: 

ggplot(mtcars, aes(x=as.factor(cyl), y=mpg))+
  geom_boxplot(fill = "blue", alpha = .3) +## colors the boxes all the same. alpha controls the opacity. 0-1
  xlab("cyl") ### changes xlabel. this or "labels(c("Label Name Here"))

####   Geom_boxplot() options
head(mpg)

ggplot(mpg, aes(x=class, y = hwy))+
  geom_boxplot(
    
    # custom boxes
    color="green", #### this controls the outline
    fill="pink",   #### this controls the inside
    alpha=0.6,
    
    # Notch? adds a little edge to the box
    notch=F,
    notchwidth = 0.8,
    
    # custom outliers
    outlier.colour="red",
    outlier.fill="red",
    outlier.size=2
  )

##### Control colors of different sections

# Set a unique color with fill, colour, and alpha
    # same for each box
ggplot(mpg, aes(x=class, y=hwy)) + 
  geom_boxplot(color="red", fill="orange", alpha=0.2)

# Set a different color for each group. Per a datagroup
ggplot(mpg, aes(x=class, y=hwy, fill=class)) + 
  geom_boxplot(alpha=0.3) +
  theme(legend.position="none") # removes legend
#       set fill to whatever is being used to separate the groups (x-axis)

# Use a specific palette
ggplot(mpg, aes(x=class, y=hwy, fill=class)) + 
  geom_boxplot(alpha=0.6) +
  theme(legend.position="none") +
  scale_fill_brewer(palette="BuPu") ## put palette name here

# Different palette
ggplot(mpg, aes(x=class, y=hwy, fill=class)) + 
  geom_boxplot(alpha=0.3) +
  theme(legend.position="none") +
  scale_fill_brewer(palette="Dark2")


#### Grouped boxplot. 2+ boxes per x-axis section














#




#





#



#




ggplot(soil_m, aes(x = month, y = soil_moisture, fill = month)) +     ### fill: fills the color based on the X value. needed for legend
  geom_boxplot()+
  stat_boxplot(geom = "errorbar",                     # Error bars
               width = 0.25)+                         # bars width
  scale_fill_hue(labels = c("July", "August")) +      ### changes names under legend 
  guides(fill = guide_legend(title = "Month")) +      ### changes name OF legend
  labs(x="Month of sample", y="Soil Moisture") +      ### labels of axes
  ggtitle("Soil Moisture per Month") +                ### adds figure title
  theme_classic() +                                         ### theme
  theme(legend.position = "bottom")

  theme(legend.position = "none")           ## removes legend, but keeps identifier. None, right, left, top, bottom
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
  
  
  
  
  
##### Scatterplots & Point and line

View(pinecone)  
  

p_height <- matrix(runif(n=20, min = 8, max = 15), nrow = 20)
p_weight <- matrix(runif(n=20, min = 10, max = 40), nrow = 20)
p_diameter <- matrix(runif(n=20, min = 3, max = 10), nrow = 20)
pinecone = data.frame(p_height, p_weight, p_diameter)
pinecone$treatment <- c(1,1,1,1,1,2,2,2,1,1,2,2,1,2,2,1,2,1,2,1)
pinecone$treatment = factor(pinecone$treatment)



#### geom_line : adds the line between points. 
#### geom_point: scatterplot

### both line & point
  ggplot(pinecone, aes(x=p_height, y = p_weight, col = treatment))+
    geom_line()+geom_point(size=2)+
    scale_color_manual(labels = c("Treatment 1", "Treatment 2"),values = c("red","royalblue"))+     ## adds the legend according to color of "treatment" category
    scale_fill_hue(labels = c("Treatment 1", "Treatment 2"))+
    guides(col = guide_legend(title = "Treatment"))+
    labs(x="Pinecone Height", y="Pinecone Weight")+
    ggtitle("Pinecone Ex")+
    theme(plot.title = element_text(size = 20))+
    theme_bw()

#### geom_line
  ggplot(pinecone, aes(x=p_height, y = p_weight, col = treatment))+
    geom_line()+
    scale_color_manual(labels = c("Treatment 1", "Treatment 2"),values = c("red","blue"))+
    scale_fill_hue(labels = c("Treatment 1", "Treatment 2"))+
    guides(col = guide_legend(title = "Treatment"))+
    labs(x="Pinecone Height", y="Pinecone Weight")+
    ggtitle("Pinecone Ex")+
    theme(plot.title = element_text(size = 20))+
    theme_bw()  

#### geom_point
  ggplot(pinecone, aes(x=p_height, y = p_weight, col = treatment))+
    geom_point(size=2)+       ### size of points
    scale_color_manual(labels = c("Treatment 1", "Treatment 2"),values = c("red","blue"))+
    scale_fill_hue(labels = c("Treatment 1", "Treatment 2"))+
    guides(col = guide_legend(title = "Treatment"))+
    labs(x="Pinecone Height", y="Pinecone Weight")+
    ggtitle("Pinecone Ex")+
    theme(plot.title = element_text(size = 20))+
    theme_bw()
  
#### notated
  ggplot(pinecone, aes(x=p_height, y = p_weight, col = treatment))+
    geom_point(size=2)+       ### size of points
    scale_color_manual(labels = c("Treatment 1", "Treatment 2"),values = c("red","blue"))+
      ### scale color manual: manually adds color and labels to the categories
    guides(col = guide_legend(title = "Treatment"))+
      ### legend title
    labs(x="Pinecone Height", y="Pinecone Weight")+
    ggtitle("Pinecone Ex")+
    theme_bw()
  

###### Bar Graph
 
  ## Example 
  ggplot(interview, aes(x=questions,y=answers))+
    geom_bar(stat = "identity",width=0.5, fill="darkblue")+
    labs(x="Question Number", y="No. of Answers")+
    geom_text(aes(label=answers), vjust=1.6, color="white", size=4)+
    scale_y_continuous(expand = expansion(mult = c(0, 0.05)))+
    theme_classic()
  
## data  
df <- data.frame(dose=c("D0.5", "D1", "D2"),
                   len=c(4.2, 10, 29.5))
head(df)
  
## basic plot
ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity")
  
## flip it
ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity")+
  coord_flip()
  
# Change the width of bars
ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity", width=0.5)

# Change colors
ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity", color="blue", fill="white")

# Minimal theme + blue fill color
ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity", fill="steelblue")+
  theme_minimal()

### limit scale shown:
##  + scale_x_discrete(limits=c("D0.5", "D2"))


### add data value labels to columns. 
    ## outside bars
+ geom_text(aes(label=len), vjust=-0.3, size=3.5)+
  theme_minimal()
    ## inside bars
+ geom_text(aes(label=len), vjust=1.6, color="white", size=3.5)+
  theme_minimal()
        ### need the color for it to show up inside the bar. change color to fit as needed. 

### color columns by category
ggplot(df, aes(x=dose, y=len, color = dose))+
  geom_bar(stat="identity")
  ## changes outline of bar. fill with white in geom_bar to see better

#   scale_color_manual() : to use custom colors. (values=c("#999999", "#E69F00", "#56B4E9"))
#   scale_color_brewer() : to use color palettes from RColorBrewer package. (palette="Dark2")
#   scale_color_grey() : to use grey color palettes + theme_bw()

## color columns by category, FILL the columns
ggplot(df, aes(x=dose, y=len, fill = dose))+
  geom_bar(stat="identity")

#   scale_fill_manual() : to use custom colors
#   scale_fill_brewer() : to use color palettes from RColorBrewer package
#   scale_fill_grey() : to use grey color palettes

#### fill with outline

ggplot(df, aes(x=dose, y=len, fill=dose))+
  geom_bar(stat="identity", color="black")+
  scale_fill_manual(values=c("grey", "red", "blue"))+
  theme_minimal()

########## fill vs color. COLOR is outline, FILL is all fill





####      Bar Graph labels and legends

## + theme(legend.position = "  "). Top, bottom, right, left, none

## change order of legend:
#       scale_x_discrete(limits=c("D2", "D0.5", "D1"))

########### stacked bar graphs, or having more than one set of data on graph

df2 <- data.frame(supp=rep(c("VC", "OJ"), each=3),
                  dose=rep(c("D0.5", "D1", "D2"),2),
                  len=c(6.8, 15, 33, 4.2, 10, 29.5))
head(df2)

###     Stacked barplot with multiple groups
ggplot(data=df2, aes(x=dose, y=len, fill=supp)) +
  geom_bar(stat="identity")
      ## FILL data is different from X
###       Use position=position_dodge()
ggplot(data=df2, aes(x=dose, y=len, fill=supp)) +
  geom_bar(stat="identity", position=position_dodge())
      ## position of FILL: to the side, not stacked

## change colors
ggplot(data=df2, aes(x=dose, y=len, fill=supp)) +
  geom_bar(stat="identity", color="black", position=position_dodge())+
  theme_minimal()+
      ## black outline
 scale_fill_manual(values=c('#999999','#E69F00'))
      ## fill with custom colors


###### Labels. adds value labels to the bars
+ geom_text(aes(label=len), vjust=1.6, color="white",
          position = position_dodge(0.9), size=3.5)

ggplot(data=df2, aes(x=dose, y=len, fill=supp)) +
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_text(aes(label=len), vjust=1.6, color="black", position = position_dodge(0.9), size=3.5) +
  theme_minimal()

### position dodge: adjust where the value goes. inside bar or outside (IF OUTSIDE: change text color)

######    To add labels to stacked bar graph data, requires an extra package: plyr

# library(plyr)
    # Sort by dose and supp
# df_sorted <- arrange(df2, dose, supp) 
# head(df_sorted)

    # Calculate the cumulative sum of len for each dose
# df_cumsum <- ddply(df_sorted, "dose", transform, label_ypos=cumsum(len))
# head(df_cumsum)

    # create bar plot

# ggplot(data=df_cumsum, aes(x=dose, y=len, fill=supp)) +     ## contains df_cumsum: combined and calculated data for labeling
  # geom_bar(stat="identity")+
  # geom_text(aes(y=label_ypos, label=len), vjust=1.6, 
  #           color="white", size=3.5)+
  # scale_fill_brewer(palette="Paired")+
  # theme_minimal()


#######   Barplot with a numeric x-axis
# If the variable on x-axis is numeric, it can be useful to 
  # treat it as a continuous or a factor variable depending on what you want to do:

# Create some data
df2 <- data.frame(supp=rep(c("VC", "OJ"), each=3),
                  dose=rep(c("0.5", "1", "2"),2),
                  len=c(6.8, 15, 33, 4.2, 10, 29.5))
head(df2)

# x axis treated as continuous variable
df2$dose <- as.numeric(as.vector(df2$dose))

# plot
ggplot(data=df2, aes(x=dose, y=len, fill=supp)) +       ## fill = how to split data
  geom_bar(stat="identity", position=position_dodge())+     ## bar_plot, keep stat as "identity". position= dodge, put two bars next to each other. 
  scale_fill_brewer(palette="Paired")+      ## set color
  theme_minimal()

# Axis treated as discrete variable
df2$dose<-as.factor(df2$dose)

# plot
ggplot(data=df2, aes(x=dose, y=len, fill=supp)) +
  geom_bar(stat="identity", position=position_dodge())+
  scale_fill_brewer(palette="Paired")+
  theme_minimal()

### difference: 1.5 value there or not


####### Barplot with error bars
## need to use function to calculate the mean and the standard deviation for each group
#  need to calculate data to show

## +++++++++++++++++++++++++
# data : a data frame
# varname : the name of a column containing the variable
#to be summariezed
# groupnames : vector of column names to be used as
# grouping variables

## run this function first
data_summary <- function(data, varname = "name", groupnames=c("name", "name")){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE))
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}

######      ^^^^^^^^^

df3 <- data_summary(ToothGrowth, varname="len", groupnames=c("supp", "dose"))

  # Convert dose to a factor variable
df3$dose=as.factor(df3$dose)

# Standard deviation of the mean as error bar
ggplot(df3, aes(x=dose, y=len, fill=supp)) +                # data. fill regular
  geom_bar(stat="identity", position=position_dodge()) +    # geom bar, identity stat, dodge to side positioning 
  geom_errorbar(aes(ymin=len-sd, ymax=len+sd), width=.2,    # add geom_error bar. ymin/max: column-/+sd (standard dev)
                position=position_dodge(.9))+               # position the error bar in middle. 
  scale_fill_brewer(palette="Spectral") + theme_minimal()     # color & theme



### ++++++++++++++ COLORS ++++++++++++++++ ###

scale_fill_manual(values=c(''))  # write name of color, or use hex code
## comes together when needing a legend in something other than a bar graph. Label 1 = Value 1.    
    scale_color_manual(labels = c("Treatment 1", "Treatment 2"),values = c("red","royalblue"))+
    scale_fill_hue(labels = c("Treatment 1", "Treatment 2"))

scale_fill_brewer(palette='') # requires RColorBrewer package. google palette names
  # examples: PuBuGn, purple, blue, green gradient. Set1-3, Spectral, PiYG, Greens, Reds, Blues, greyscale, etc. 



############  3D graphs and plots

 
  
####      Simple add ons
  ## linear regression line
  geom_smooth(method = "lm", se = FALSE)
  
  
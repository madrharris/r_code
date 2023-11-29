#################################
#
#       ggplot
#     RANKING PLOTS
#
# install.packages("ggplot2")
#################################
library(ggplot2)
library(dplyr)

## Make a table
# optional & required packages: kableExtra, gt, reacttable, and DT
install.packages("gt")
library(gt)

## GT tables



# Create a data frame to use, or use a preexisting one

data = data.frame(
  Country = c("USA", "China", "India", "Brazil"),
  Capitals = c("Washington D.C.", "Beijing", "New Delhi", "Brasília"),
  Population = c(331, 1441, 1393, 212),
  GDP = c(21.43, 14.34, 2.87, 1.49)
)

######      title and subtitle with  tab_header()
# %>% is a pipe, use instead of + (ggplot2)


data %>%
  gt() %>%
  tab_header(title = md("What a **nice title**"),
             subtitle = md("Pretty *cool subtitle* too, `isn't it?`"))
## ** text ** bold
## * text * italics
## ' text ' change font to courier

## we can write title with html too
data %>%
  gt() %>%
    tab_header(title = html("<span style='color:blue;'>A red title</span>"))


######      Footer and source with tab_footnote()

data %>%
  gt() %>%
  tab_footnote(
    footnote = "Source: James & al., 2020",
    locations = cells_body(columns = Country, rows = 3)
  )

######      Customize footer
# dataset
data = data.frame(
  Planet = c("Earth", "Mars", "Jupiter", "Venus"),
  Moons = c(1, 2, 79, 0),
  Distance_from_Sun = c(149.6, 227.9, 778.3, 108.2),
  Diameter = c(12742, 6779, 139822, 12104)
)

# create and display the gt table (equivalent to "gt(data)")
data %>%
  gt()
#   gt(data)

data %>%
  gt() %>%
  tab_footnote(footnote = md("Measured in **millions** of Km"),
               locations = cells_column_labels(columns = Distance_from_Sun))
## adds footnote with location to Distance from sun

## can add multiple footnotes, just add on another %>%
data %>%
  gt() %>%
  tab_footnote(footnote = md("Measured in **millions** of Km"),
               locations = cells_column_labels(columns = Distance_from_Sun)) %>%
  tab_footnote(footnote = md("Measured in **Km**"),
               locations = cells_column_labels(columns = Diameter))

### change from number footnotes to letters, and add a proper footer

data %>%
  gt() %>%
  tab_footnote(footnote = md("Measured in **millions** of Km"),
               locations = cells_column_labels(columns = Distance_from_Sun)) %>%
  tab_footnote(footnote = md("Measured in **Km**"),
               locations = cells_column_labels(columns = Diameter)) %>%
  tab_footnote(footnote = md("The original data are from *Some Organization*")) %>%
  opt_footnote_marks(marks = "LETTERS")       ## changes number to letter


######      subheader, with tab_spanner() function lets you group columns into categories.

data %>%
  gt() %>%
  tab_spanner(
    label = "Number",
    columns = c(GDP, Population)) %>%
  tab_spanner(
    label = "Label",
    columns = c(Country, Capitals))



#######       Example of a total table

# data.frame

pinecone = data.frame(
  p_height=c(10.5, 11.7, 10.5, 9.5, 9, 9, 11, 5.5),
  p_weight=c(31.0595, 33.51, 27.4, 23.74, 36.13, 25.6318, 30.55, 11.412),
  p_diameter=c(7, 7.5, 7.5, 6.5, 7, 7, 8.5, 4.5)
)

pinecone %>%
  gt() %>%
  ## add title
  tab_header(title = md("**Pinecone Data**"),
             subtitle= md("Ponderosa pine cones")) %>%
  ## add footnotes describing units
  tab_footnote(footnote = md("Measured in **measurements** of cm"),
               locations = cells_column_labels(columns = p_height)) %>%
  tab_footnote(footnote = md("Measured in **mg**"),
               locations = cells_column_labels(columns = p_weight)) %>%
  ## add footnote for location
  tab_footnote(footnote = md("Data taken from ponderosa pinecones in Ponderosa Park"))



####################################################################
# =+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
# Radar/Spider/Web Chart
# using fmsb package
# =+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
install.packages("fmsb")
library(fmsb)

# each row must be an entity. each column a quantitative variable, First 2 rows must have the min and max for each variable

# example data:
data_web <- as.data.frame(matrix( sample( 2:20 , 10 , replace=T) , ncol=10))
colnames(data_web) <- c("math" , "english" , "biology" , "music" , "R-coding", "data-viz" , "french" , "physic", "statistic", "sport" )

## add the min and max rows

data_web <- rbind(rep(20,10) , rep(0,10) , data_web)
head(data_web)

# default chart
# par(mfrow = c(1,1)) use if graph comes out super small for some reason
radarchart(data_web)


# =+=+=+=+=+=+=+=Customization+=+=+=+=+=+=+=+

#   polygon features:
# pcol: line color
# pfcol: fill color
# plwd: line width

#   Grid features:
# cglcol: color of the net
# cglty: net line type 
# axislabcol: color of axis labels
# caxislabels: vector of axis labels to display
# cglwd: net width

#   labels:
# vlcex: group labels size


##### Plot it

radarchart(data_web, axistype=1 , 
            
            #custom polygon
            pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 , 
            
            #custom the grid
            cglcol="darkgrey", cglty=1, axislabcol="blue", caxislabels=seq(0,20,5), cglwd=0.8,
            
            #custom labels
            vlcex=0.8 
)


# =+=+=+=+=+=+=+=Multi-group spider chart, no options+=+=+=+=+=+=+=+ #

set.seed(99)
data <- as.data.frame(matrix( sample( 0:20 , 15 , replace=F) , ncol=5))
colnames(data) <- c("math" , "english" , "biology" , "music" , "R-coding" )
rownames(data) <- paste("mister" , letters[1:3] , sep="-")
head(data)
# three different sets. 

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each variable to show on the plot!
data <- rbind(rep(20,5) , rep(0,5) , data)

# plot with default options:
radarchart(data)
    ## shows three groups of data. don't show more than 3-4


# =+=+=+=+=+=+=+=Customization+=+=+=+=+=+=+=+
# same options as above


# Color vector
colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )

# plot with default options:
radarchart( data  , axistype=1 , 
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,   ### fills in polygons with custom colors ^^^
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
            #custom labels
            vlcex=0.8 
)

# Add a legend
legend(x=1.15, y=0.2, legend = rownames(data[-c(1,2),]), bty = "n", pch=20, col=colors_in , text.col = "black", cex=1.2, pt.cex=3)


####################################################################

# =+=+=+=+=+=+=+=Circular Bar Plot+=+=+=+=+=+=+=+
#           (looks cool af)

## warning: final graph is a bit fucky. don't use
# link: https://r-graph-gallery.com/web-circular-barplot-with-R-and-ggplot2.html


library(dplyr)
library(ggplot2)
library(stringr)

## download dataset for example
#   https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-24/hike_data.rds
    ## needs to download then load directly into R via the file organizer.
hike_data <- `hike_data (1)`
head(hike_data)

# The first step is to extract the region from the location column. 
# This is given by the text before the "--".

hike_data$region <- as.factor(word(hike_data$location, 1, sep = " -- "))

## do same for number of miles
hike_data$length_num <- as.numeric(sapply(strsplit(hike_data$length, " "), "[[", 1))

# compute the cumulative length and mean gain for each region
# record the number of tracks per region.

plot_df <- hike_data %>%
  group_by(region) %>%
  summarise(
    sum_length = sum(length_num),
    mean_gain = mean(as.numeric(gain)),
    n = n()
  ) %>%
  mutate(mean_gain = round(mean_gain, digits = 0))
plot_df
### makes a table 

######### Radar Chart
##    convert plot from cartesian to circular (polar) coordinates
## HUGE PLOT AND CODE


plt <- ggplot(plot_df) +
  # Make custom panel grid
  geom_hline(
    aes(yintercept = y), 
    data.frame(y = c(0:3) * 1000),
    color = "black") +  ### color of rings
          # Add bars to represent the cumulative track lengths
          # str_wrap(region, 5) wraps the text so each line has at most 5 characters
          # (but it doesn't break long words!)
  geom_col(
    aes(
      x = reorder(str_wrap(region, 5), sum_length),
      y = sum_length,
      fill = n
    ),
    position = "dodge2",
    show.legend = TRUE,
    alpha = .9) +  ## makes bar graph by itself, ordered in small -> big, with scale 
  
                    # Add dots to represent the mean gain
  geom_point(
    aes(
      x = reorder(str_wrap(region, 5),sum_length),
      y = mean_gain
    ),
    size = 3,
    color = "darkblue") +    ### color of points
  
  # Lollipop shaft for mean gain per region
  geom_segment(
    aes(
      x = reorder(str_wrap(region, 5), sum_length),
      y = 0,
      xend = reorder(str_wrap(region, 5), sum_length),
      yend = 3000
    ),
    linetype = "dashed",
    color = "grey12") +    ### dashed lines color
  
        # Make it circular! Final step
  coord_polar()

plt


####################### Add annotations and legend
###### LONG CODE
# Annotate the bars and the lollipops so the reader understands the scaling
## adds data points to big bar for numbers and ease of viewing
plt <- plt +
  annotate(
    x = 11, 
    y = 1300,
    label = "Mean Elevation Gain\n[FASL]",
    geom = "text",
    angle = -67.5,
    color = "gray12",
    size = 2.5,
    family = "Bell MT"
  ) +
  annotate(
    x = 11, 
    y = 3150,
    label = "Cummulative Length [FT]",
    geom = "text",
    angle = 23,
    color = "gray12",
    size = 2.5,
    family = "Bell MT"
  ) +
  # Annotate custom scale inside plot
  annotate(
    x = 11.7, 
    y = 1100, 
    label = "1000", 
    geom = "text", 
    color = "gray12", 
    family = "Bell MT"
  ) +
  annotate(
    x = 11.7, 
    y = 2100, 
    label = "2000", 
    geom = "text", 
    color = "gray12", 
    family = "Bell MT"
  ) +
  annotate(
    x = 11.7, 
    y =3100, 
    label = "3000", 
    geom = "text", 
    color = "gray12", 
    family = "Bell MT"
  ) +
  # Scale y axis so bars don't start in the center
  scale_y_continuous(
    limits = c(-1500, 3500),
    expand = c(0, 0),
    breaks = c(0, 1000, 2000, 3000)
  ) + 
  # New fill and legend title for number of tracks per region
  scale_fill_gradientn(
    "Amount of Tracks",
    colours = c( "#6C5B7B","#C06C84","#F67280","#F8B195")
  ) +
  # Make the guide for the fill discrete
  guides(
    fill = guide_colorsteps(
      barwidth = 15, barheight = .5, title.position = "top", title.hjust = .5
    )
  ) +
  theme(
    # Remove axis ticks and text
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.text.y = element_blank(),
    # Use gray text for the region names
    axis.text.x = element_text(color = "gray12", size = 12),
    # Move the legend to the bottom
    legend.position = "bottom",
  )
plt



plt <- plt + 
  # Add labels
  labs(
    title = "\nHiking Locations in Washington",
    subtitle = paste(
      "\nThis Visualisation shows the cummulative length of tracks,",
      "the amount of tracks and the mean gain in elevation per location.\n",
      "If you are an experienced hiker, you might want to go",
      "to the North Cascades since there are a lot of tracks,",
      "higher elevations and total length to overcome.",
      sep = "\n"
    ),
    caption = "\n\nData Visualisation by Tobias Stalder\ntobias-stalder.netlify.app\nSource: TidyX Crew (Ellis Hughes, Patrick Ward)\nLink to Data: github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-11-24/readme.md") +
  # Customize general theme
  theme(
    
    # Set default color and font family for the text
    text = element_text(color = "gray12", family = "Bell MT"),
    
    # Customize the text in the title, subtitle, and caption
    plot.title = element_text(face = "bold", size = 25, hjust = 0.05),
    plot.subtitle = element_text(size = 14, hjust = 0.05),
    plot.caption = element_text(size = 10, hjust = .5),
    
    # Make the background white and remove extra grid lines
    panel.background = element_rect(fill = "white", color = "white"),
    panel.grid = element_blank(),
    panel.grid.major.x = element_blank()
  )
# Use `ggsave("plot.png", plt,width=9, height=12.6)` to save it as in the output
plt


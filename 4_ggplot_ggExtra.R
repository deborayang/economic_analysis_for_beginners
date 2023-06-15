# ===========================================
# Special Unit 1 ggplot & ggExtra
# ===========================================
#### Uni-variate distribution

library(tidyverse)

set.seed(42)
graph.data.1 <- data.frame(x.c = rnorm(200, mean = 5, sd=2),
                           x.d = sample(LETTERS[1:8], size = 200, replace = T))
head(graph.data.1)

# Distribution of Continuous Variables

ggplot(graph.data.1, mapping = aes(x=x.c))+ #   Aesthetic mappings describe how variables in the data are mapped to visual properties (aesthetics) of geoms.
  geom_histogram(bins = 20, fill="white", color="black") #    histogram
# bins-grouping, fill- bar's fill color, color- bar's outer border color

ggplot(graph.data.1, aes(x=x.c))+ # 'mapping=' can be omitted
  geom_density() # Density map, in fact, is the kernel density curve, for the smoothing of the histogram
ggplot(graph.data.1, aes(x=x.c))+
  geom_line(stat = "density") # Another method - density map
                                                         #    earlier version - 'y=..density..'
ggplot(graph.data.1, aes(x=x.c, y=after_stat(density)))+ #    y=after_stat(density) - density and histogram put in the same y coordinate system
  geom_histogram(bins = 20, fill="white", color="black")+ 
  geom_line(stat = "density", color="blue", linewidth=1)+ #    linewidth - line thickness，earlier version - 'size=1' 
  geom_line(stat = "density", adjust=1.5, color="red", linewidth=1) #    adjust - smoothness 

# Categorical variable distribution
ggplot(graph.data.1, aes(x=x.d)) + 
  geom_bar()


#### Multivariate relationship diagram

set.seed(42)
graph.data.2 <- data.frame(v1=sample(1:30, 200, replace = T)+rnorm(200, sd=5),
                           v2=sample(LETTERS[1:5], 200, replace = T),
                           v3=sample(month.name, 200, replace = T))
graph.data.2 <- graph.data.2 %>% mutate(v4=2+3*v1+rnorm(200, sd=5))
head(graph.data.2)

# Relationship between two variables
ggplot(graph.data.2, aes(x=v1, y=v4))+
  geom_point(color="blue")

ggplot(graph.data.2, aes(x=v1, y=v4))+
  geom_point(color="blue") + 
  geom_smooth(method = "lm", color="red")

# Relationship between two categorical variables
ggplot(graph.data.2, aes(x=v2, y=v3))+
  geom_count() #    size of the points - frequency 

graph.data.2 %>% count(v2, v3) %>% #    count the frequency of combinations of v2 and v3
  ggplot(aes(x=v2, y=v3))+
  geom_tile(aes(fill=n))

graph.data.2 %>% count(v2, v3)

# Relationship between categorical and continuous variables
ggplot(graph.data.2, aes(x=v2, y=v4))+
  geom_boxplot() # Under different v2 values, the distribution of v4 is different
# However, whether there is a relationship requires statistical testing

graph.data.3 <- graph.data.2 %>% group_by(v3) %>% summarise(m.v4=mean(v4)) #    Calculate the mean of v4 grouped by v3
ggplot(graph.data.3, aes(x=v3, y=m.v4))+
  geom_col()
                                                              
                                                            
                                                            
# other icons
# Scatterplot + additional variable distribution
# install.packages("ggplot2")
install.packages("ggExtra")
# See how to use it at https://daattali.com/shiny/ggExtra-ggMarginal-demo/
library(ggExtra)
library(ggplot2)
# example 
plot.iris <- ggplot(`iris`, aes_string('Sepal.Length', 'Sepal.Width')) +
  aes_string(colour = 'Species') +
  geom_point() + theme_bw(15)

ggExtra::ggMarginal(
  plot.iris,
  type = 'density',
  margins = 'both',
  size = 5,
  colour = '#090D01FC',
  fill = '#BD86EB'
)


#Variable correlation graph

install.packages("DataExplorer")
library(DataExplorer)
plot_correlation(mtcars) # The depth of the color - the size of the correlation coefficient

#### Graphic details adjustment
# Title, subtitle 
ggplot(graph.data.3, aes(x=v3, y=m.v4))+
  geom_col() + labs(title = "Histogram", subtitle = "Random sample") + #    title name 
  theme(plot.title = element_text(hjust = 0.5),                        #    hjust = 0.5 - center alignment
        plot.subtitle = element_text(hjust = 1))                       #    hjust = 1 - right alignment   

# axis label, angle, range
ggplot(graph.data.3, aes(x=v3, y=m.v4))+
  geom_col() + labs(title = "Histogram", subtitle = "Random sample",
                    x="Month", y="Frequency") + #    name the axes
  scale_y_continuous(limits = c(0, 75), #    Set the range and group spacing for the axes
                     breaks = seq(from =0, to=75, by=15))+ #    Indicates that every 15 marks a scale
  scale_x_discrete(breaks = month.name, 
                     labels = paste("New", month.name, sep=" ")) + #    Prefix each label of the x-coordinate variable with "New"
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 1),
        axis.text = element_text(angle = 51, hjust = 1)) #    Because the variables of the x coordinate are prefixed, the labels are too long to see clearly, so adjust the angle of the text.

# Legend 

ggplot(graph.data.2, aes(x=v1, y=v4, color=v2))+
  geom_point()+
  labs(x="Motives", y="Incomes", color="Groups")+ #    'color' indicates the label of the legend 
  scale_color_discrete(labels=letters[1:5])+ #    Change the label to lowerclass letters 
  theme(legend.position = c(1,0),         # 'position' - middle point of the whole legend 
        legend.justification = c(1,0),    # 'justification' - lower right corner of the legend
        # These two lines of code together place the legend in the lower right corner of the main plot
        legend.background = element_blank(),  #    Legend background set to blank
        legend.key = element_blank(),         #    The background of the key (colored point) of the legend is set to blank
        panel.grid.major = element_blank(),   #    These two lines of code set the background of the main image to blank (divided into major and minor). 
        panel.grid.minor = element_blank(),   #    You don't want the reviewers to see a gray checkered background when you submit it. 
        panel.background = element_rect(fill="white"), #    Set the background as white 
        axis.line = element_line(color = "black", linewidth = 0.2)) #    Color the axis and set the sizes. 

                                                            
                                                              
                                                            
                                                  






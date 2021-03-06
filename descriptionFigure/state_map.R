library(ggplot2)
library(maps)
library(dplyr)
all_states <- map_data("state")

mydata <- read.csv("/Users/lekelyu/Documents/GitHub/swineFlu/descriptionFigure/geo.csv", header=TRUE, sep=",")
df <- data.frame(x1 = -89.6501, x2 = -84.3880, y1 = 39.7817, y2 = 33.7490)

p1 <- ggplot() + geom_polygon( data=all_states, aes(x=long, y=lat, group = group),colour="white", fill="grey10" ) + geom_point( data=mydata, aes(x=long, y=lat), shape = 19, color="coral1") + geom_text( data=mydata, hjust=-0.05, vjust=-0.6, aes(x=long, y=lat, label=region), colour="gold2", size=4 ) + geom_curve(aes(x = x1, y = y1, xend = x2, yend = y2), data = df, curvature = -0.2, colour="red2", size = 1, arrow = arrow(length = unit(0.05, "inches")))
p1 <- p1 + xlab("Longitude") + ylab("Latitude") + labs(title ="Geological Location of Swine Production Systems") + theme(plot.title = element_text(hjust = 0.5))

md <- read.csv("/Users/lekelyu/Documents/GitHub/swineFlu/descriptionFigure/FarmStatePod.csv", header=TRUE, sep=",")
md$State_f = factor(md$State, levels=c('Georgia','Illinois','Oklahoma','Nebraska'))
p2 <- ggplot(md,aes(x=Pod)) + geom_bar(aes(fill=factor(Farm))) + labs(fill="Farm Type") +facet_grid(.~State_f) + xlab("") + labs(title ="Number of Sampled Gene Segments in Each Pod, in Each State") + theme(plot.title = element_text(hjust = 0.5))
#ggplot(md,aes(x=Pod)) + geom_bar(aes(fill=factor(Farm))) + labs(fill="Farm Type") +facet_grid(cols = vars(State)) + xlab("") + labs(title ="Number of Sampled Gene Segments in Each Pod, in Each State") + theme(plot.title = element_text(hjust = 0.5))

md2 <- read.csv("/Users/lekelyu/Documents/GitHub/swineFlu/descriptionFigure/datePod.csv", header=TRUE, sep=",")
md2$Date_f = factor(md2$Date, levels=c('2012/1/1','2012/10/1','2012/11/1','2012/12/1','2013/1/1','2013/2/1','2013/3/1','2013/5/1','2013/6/1','2013/7/1','2013/8/1','2013/9/1','2013/11/1','2013/12/1','2014/1/1'))
p3 <- ggplot(md2,aes(x=Date_f)) + geom_bar(aes(fill=factor(Pod)),position="stack") + labs(title ="Sample Proportion in Each Pod by Month ") + theme(plot.title = element_text(hjust = 0.5)) + xlab("") + labs(fill="Pods")
md2$Date <- as.Date(md2$Date)
p4 <- ggplot(md2,aes(x=Date)) + geom_bar(aes(y = (..count..)/sum(..count..))) + stat_ecdf(geom = "step", pad = FALSE) + labs(title ="Sampled Percentage by Month and The Cumulative Plot") + theme(plot.title = element_text(hjust = 0.5))

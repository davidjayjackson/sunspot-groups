library(tidyverse)
library(data.table)
library(xts)
#
rm(list=ls())
#
gndb <- fread("gndb.csv",header=F)
gndb$Year <- as.integer(substr(gndb$V1,1,4))
gndb$Ymd <- as.Date(paste(substr(gndb$V1,1,4),substr(gndb$V1,5,6),
                          substr(gndb$V1,7,8), sep = "-"))
gndb$Station <- as.integer(substr(gndb$V1,9,13))
gndb$Obs <- as.integer(substr(gndb$V1,14,16))
gndb$Group <- as.integer(substr(gndb$V1,17,19))
gn <- gndb %>% select(Year,Ymd,Station,Obs,Group) %>% 
  filter(!is.na(Ymd) & Year >=1850)
 

# Create monthly summary field with XTS
##
isn.xts <- xts(x = gn$Group, order.by = gn$Ymd)
isn.monthly <- apply.monthly(isn.xts, mean)
isn <-as.data.table(isn.monthly)
#
ggplot(data=isn,aes(x=index,y=V1)) +geom_line() +
  geom_smooth(method="loess") +
  ggtitle("NOAA/AAVSO Group Summary",subtitle= "1850 - 2010") + 
  xlab("Year") + ylab("Monthly Mean") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.subtitle = element_text(hjust = 0.5))

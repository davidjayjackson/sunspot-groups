library(tidyverse)
library(data.table)
library(xts)
library(lubridate)
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
  filter(!is.na(Ymd) & Year >=1944)
 

# Create monthly summary field with XTS
##
isn.xts <- xts(x = gn$Group, order.by = gn$Ymd)
isn.monthly <- apply.monthly(isn.xts, mean)
isn <-as.data.table(isn.monthly)
#
ggplot(data=isn,aes(x=index,y=V1)) +geom_col() +
  geom_smooth(method="loess") +
  ggtitle("NOAA/AAVSO Group Summary",subtitle= "1945 - 2010") + 
  xlab("Year") + ylab("Monthly Mean") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.subtitle = element_text(hjust = 0.5))
#
# Begin Kanzel processing
kanzel <- fread("~/R/db/kh_spots.csv")
kanzel$Ymd <- as.Date(kanzel$Ymd)
kanzel$Year <- year(kanzel$Ymd)
kanzel <- kanzel %>% filter(Year>=1945 & Year<=2010)
K <- kanzel %>% select(Year,Ymd,g_n,g_s,s_n,s_s)
K$Group <- K$g_n + K$g_s

#
ggplot(data=K,aes(x=Ymd,y=Group)) +geom_line() +
  geom_smooth(method="loess") +
  ggtitle("Kanzel Group Summary",subtitle= "1944 - 2019") + 
  xlab("Year") + ylab("Monthly Mean") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.subtitle = element_text(hjust = 0.5))

# All togather now
# Create monthly summary field with XTS
##
isn.xts <- xts(x = K$Group, order.by = K$Ymd)
isn.monthly <- apply.monthly(isn.xts, mean)
kisn <-as.data.table(isn.monthly)
colnames(kisn) <-c("Ymd","Group")
#
ggplot(data=kisn,aes(x=Ymd,y=Group,col="Kanzel")) +geom_line() +
  geom_line(data=isn,aes(x=index,y=V1,col="SilSo")) +
    ggtitle("Kanzel Group Summary",subtitle= "1944 - 2019") + 
  xlab("Year") + ylab("Monthly Mean") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.subtitle = element_text(hjust = 0.5))

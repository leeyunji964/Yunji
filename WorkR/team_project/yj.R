setwd('D:/workD/5_project/teamproect')

# 전체 도민(total) 중 입도민(fromout) 비중

total <- read.csv('행정시별_세대_및_인구_20191217172904.csv')
fromout <- read.csv('주민등록_전입지별_인구이동_타시도→제주__20191212153625.csv')

fromout <- fromout[1,4:9]
names(fromout) <- c('2012년','2013년','2014년','2015년','2016년','2017년')
fromout <- as.numeric(fromout)
fromout

total <- total[2,3:length(total)-1]
total <- total[,-1]
names(total) <- c('2012년','2013년','2014년','2015년','2016년','2017년')
total
total <- as.numeric(total)

per <- fromout / total * 100
names(per) <- c('2012년','2013년','2014년','2015년','2016년','2017년')
per
round(per, 2)

plot(per, col = "yellowgreen", cex = 1.5, pch = 19)
barplot( per, ylim = c(0,8), col = rainbow(7),
         xlab = "연도별 입도민 비중",
         ylab = "비중(%)", main = "전체 도민 중 입도민 비중")

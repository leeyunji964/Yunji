setwd('D:/workD/5_project/teamproect')

# 전체 도민(total) 중 입도민(fromout) 비중

total <- read.csv('행정시별_세대_및_인구_20191217172904.csv')
fromout <- read.csv('주민등록_전입지별_인구이동_타시도→제주__20191212153625.csv')

fromout <- fromout[1,3:9]
names(fromout) <- c('2011년','2012년','2013년','2014년','2015년','2016년','2017년')
fromout

total <- total[2,2:length(total)]
names(total) <- c('2011년','2012년','2013년','2014년','2015년','2016년','2017년','2018년')
total





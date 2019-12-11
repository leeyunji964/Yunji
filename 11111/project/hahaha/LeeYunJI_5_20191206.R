#
# 문제 3) 제주 전통시장 현황을 분석한다.

# 특정 시장별 소비패턴 - 카드 이용자수, 카드 금액, 카드 이용건수 사용
pattern <- read.csv(file = "D:/workR/hahaha/data/제주특별자치도_시장별소비패턴현황_2014~2016.csv")
pattern <- pattern[ , c(1:6)]
pattern

names(pattern) <- c("year", "no","market","card_user","freq_card","total")
# year = 연도, no = 시장 번호, market = 시장이름, card_user = 카드 이용자수
# freq_card = 카드 이용건수, total = 카드 이용금액
pattern <- pattern[ , -2 ]
pattern

pattern15 <- subset( pattern, year == 2015 )
pattern15 <- subset( pattern15,
                     market == c("제주 동문시장", "제주 서문시장",
                                 "제주 보성시장", "서귀포 매일올레시장",
                                 "모슬포 중앙시장"))
pattern15

pattern16 <- subset( pattern, year == 2016 )
#pattern16
pattern16 <- subset( pattern16,
                     market == c("제주 동문시장", "제주 서문시장",
                                 "제주 보성시장", "서귀포 매일올레시장",
                                 "모슬포 중앙시장"))
pattern16

# market 전처리 - 5개만 추출

# 시장 14개와 해당 시장 별 , 연도별 일평균 매출과 일평균 고객 수
market <- read.csv(file = "D:/workR/hahaha/data/market_info_new.csv")

market[is.na(market)] = 0
market <- market[ , c(-4,-5,-8,-9)]
market  #2015,2016년 데이터만.

market1 <- subset( market, Market  == "제주 동문시장" )
market1

market2 <- subset( market, Market  == "제주 서문시장" )
market2

market3 <- subset( market, Market  == "제주 보성시장" )
market3

market4 <- subset( market, Market  == "서귀포 매일올레시장" )
market4

market5 <- subset( market, Market  == "모슬포 중앙시장" )
market5

install.packages("dplyr")
library(dplyr)

RMarket<- bind_rows( market1, market2, market3, market4, market5 )
names(RMarket) <- c("market","Income.15", "Income.16", "Visit.15", "Visit.16")
RMarket

RMarket15 <- subset( RMarket[ , c(-3,-5)])
RMarket15

RMarket16 <- subset( RMarket[ , c(-2,-4)])
RMarket16

mp15 <- merge( RMarket15, pattern15, all = T )
mp15 # 2015년도 

mp16 <- merge( RMarket16, pattern16, all = T )
mp16 # 2016년도


plot( mp15[ , -1] )
#plot( mp15$Visit.15 ~ mp15$total , data= mp15)
summary(mp15[,-1])

domestic <- read.csv(file = "D:/workR/hahaha/data/domestic_visitor.csv")
domestic <- domestic[c(2,3),]
domestic
# 내국인 제주 방문자 수와 내국인 전통시장 방문자 수

foreigner <- read.csv(file = "D:/workR/hahaha/data/foreginer_visitor.csv")
foreigner <- foreigner[c(2,3),]
foreigner
# 외국인 제주 방문자 수와 외국인 전통시장 방문자 수

visitor <- merge( domestic, foreigner, by = c("year" ) )

visitor # 내/외국인 제주 방문자와 전통시장 방문자 수

# domestic; foreigner; visitor

mpv15 <- merge( mp15, visitor[,c(-2,-4)], by = c("year"))
mpv15

mpv16 <- merge( mp16, visitor[,c(-2,-4)], by = c("year"))
mpv16
#dv_market : 내국인 중 시장 방문한 인원 수 합, fv_market = 외국인


plot(mpv15[ , c(-1,-2)])
plot(mpv16[ , c(-1,-2)])

par( mfrow = c(1,3))

barplot(mpv15$Visit.15, main = '2015 일평균 고객수',
        xlab = '시장별', ylab = '방문객 수')
barplot(mpv16$Visit.16, main = '2016 일평균 고객수',
        xlab = '시장별', ylab = '매출액')

barplot(mpv15$Income.15, main = '2015 일평균 매출액',
        xlab = '시장별', ylab = '방문객 수')
barplot(mpv16$Income.16, main = '2016 일평균 매출액',
        xlab = '시장별', ylab = '매출액')

par( mfrow = c(1,1))

plot( mpv15$Income.15 ~ mpv15$freq_card,col = "purple", pch = 19,
      xlab = "2015년 카드 이용건수", ylab = "일평균 매출액")
res_mpv15.1 <- lm( mpv15$Income.15 ~ mpv15$freq_card, data = mpv15 )
res_mpv15.1
abline(res_mpv15.1)
# Coefficients:
#   (Intercept)  mpv15$freq_card  
# -646.3808           0.1631  
#   절편              기울기

plot( mpv15$total ~ mpv15$Income.15, col = "blue", pch = 19,
      xlab = "2015년 일평균 매출액", ylab = "2015년 카드 이용금액")
res_mpv15.2 <- lm( mpv15$total ~ mpv15$Income.15, data = mpv15 )
res_mpv15.2
abline(res_mpv15.2)
# 
# Coefficients:
#   (Intercept)  mpv15$Income.15  
# 486354847           416472 
#   절편              기울기


plot( mpv15$dv_market ~ mpv15$total, col = "red", pch = 19,
      xlab = "2015년 카드 이용금액", ylab = "2015년 내국인 방문자 수")
res_mpv15.3 <- lm( mpv15$dv_market ~ mpv15$total, data = mpv15 )
res_mpv15.3
abline(res_mpv15.3)
# Coefficients:
# (Intercept)  mpv15$total  
# 1164            0 




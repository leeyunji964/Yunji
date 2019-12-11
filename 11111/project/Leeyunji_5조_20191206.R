#
#
# 문제 3번)
# 제주 전통시장 현황을 분석한다. - 관광산업과 시너지는?
#
#
setwd("D:/workR/project/data")
market <- read.csv(file = "D:/workR/project/data/market_info.csv")
market

domestic <- read.csv(file = "D:/workR/project/data/domestic_visitor.csv")
domestic

foreigner <- read.csv(file = "D:/workR/project/data/foreginer_visitor.csv")
foreigner

dofo <- merge( domestic, foreigner, by = c("year") )
class(dofo)
dofo

dofos <- subset( dofo, select = c("v_market.x","v_market.y") )
# 연도별로 시장 방문자 수만 출력(x = 내국인, y = 외국인
dofos
dofov15 <- sum( dofos[1,1], dofos[1,2] );       dofov15
dofov16 <- sum( dofos[2,1], dofos[2,2] );       dofov16
dofov17 <- sum( dofos[3,1], dofos[3,2] );       dofov17


dongmun <- market[1,c(5,6,7)];      dongmun
hanlim <- market[2,c(5,6,7)];       hanlim
seongsan <- market[3,c(5,6,7)];     seongsan
daejung <- market[4,c(5,6,7)];      daejung
ohlle <- market[5,c(5,6,7)];        ohlle


# 1) 2015년 ~ 2017년도 : (해당 시장 방문자 수) / (내/외국인들 전통시장 방문자 수)
# 2015년 
dongmun$Visit.15  / dofov15 * 100 # 126.0306 (%)
hanlim$Visit.15   / dofov15 * 100 # 22.37927 (%)
seongsan$Visit.15 / dofov15 * 100 # 2.944641 (%)
daejung$Visit.15  / dofov15 * 100 # 121.3192 (%)
ohlle$Visit.15    / dofov15 * 100 # 807.4205 (%)

# 2016년 
dongmun$Visit.16  / dofov16 * 100 # 66.95652 (%)
hanlim$Visit.16   / dofov16 * 100 # 11.30435 (%)
seongsan$Visit.16 / dofov16 * 100 # 0.869565 (%)
daejung$Visit.16  / dofov16 * 100 # 63.18841 (%)
ohlle$Visit.16    / dofov16 * 100 # 503.4783 (%)










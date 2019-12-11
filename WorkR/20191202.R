#
# 5일차
#
setwd("D:/workR")
df <- read.table( file = "airquality.txt", header = T )
df

class(df)
dim(df)
str(df)
head(df,3)
tail(df,3)

install.packages("xlsx")
install.packages("rJava")

library( rJava )
library( xlsx )

df.xlsx <- read.xlsx( file = "airquality.xlsx", sheetIndex = 1,
                      encoding = "UTF-8" )
df.xlsx
class( df.xlsx )
str( df.xlsx )
head( df.xlsx )
tail( df.xlsx )

score <- c( 76,84,69,50,95,6,82,71,88,84)
which( score == 69 ) # score가 69인 데이터의 인덱스 값 구하는 것.
which( score >= 85 )
max( score )
which.max( score )
min( score )
which.min( score )

idx <- which( score >= 60 )
idx
score[idx] <- 61
score

#조건에 만족하는 행과 열의 인덱스 값을 가져오는 것.
idx <- which( iris[ , 1:4 ] > 5.0, arr.ind = TRUE )
idx

#
# 단일변수(일변량) 범주형 자료 탐색
#
favorite <- c('WINTER','SUMMER','WINTER',
              'AUTUMN','FALL','FALL',
              'WINTER','SPRING','FALL','SUMMER')

favorite
class( favorite )
table( favorite )
table (favorite ) / length( favorite ) # 비율계산
ds <- table( favorite )
ds
barplot( ds, main = 'favorite season')

ds.new <- ds[ c(3,4,1,2,5) ] #vertor 순서가 아마도 변수 순서인 것 같은데...
# ds가 autumn(1), fall(2), spring(3), summer(4), winter(5) 순으로 되어 있는데
# 이걸 봄여름가을겨울 순으로 바꾸고 싶어서 ds.new에다가 ds[ c(3,4,1,2,5) ]로 인덱스 순서를 바꿔서 넣어줌.
ds.new
barplot( ds.new, main = 'favorite season')

pie( ds, main='favorite season')
pie( ds.new, main = 'favorite season')




# 범주형이면서 일변량
favorite.color <- c(2, 3, 2, 1, 1, 2, 2,
                    1, 3, 2, 1, 3, 2, 1, 2) # 값의 범위가 정해져 있다 : 범주형
#숫자로 되어 있다고 해서 범주형이 아니다,라고 할 수 없다.
ds <- table( favorite.color );    ds
barplot( ds, main = "favorite season ")
colors <- c( 'green','red','blue')
names(ds) <- colors;       ds
barplot( ds, main = 'favorite season', col = colors) # col : 색상 부여하는 함수
pie( ds, main = 'favorite season', col = colors)




# 단일변수(일변량) 연속형 자료
weight <- c( 60,62,64,65,68,69 ); weight
weight.heavy <- c( weight, 120 ); weight.heavy
#평균
mean( weight );     mean( weight.heavy )
#중앙값
median( weight );   median( weight.heavy )
#절사평균 : 상하위 20%( trim = 0.2 )씩 잘라내서 낸 평균
mean( weight, trim = 0.2 )
mean( weight.heavy, trim = 0.2)

#사분위수
quantile( weight.heavy ) 
quantile( weight.heavy, ( 0:10 ) / 10 )
summary( weight.heavy )
#산포 - 값이 퍼져있는 정도 파악
#분산
var( weight )
#표준편차 
sd( weight )
#분산,표춘편차의 값이 작다 : 모여있다 = 연관성이 크다. 값이 흩어져있다 = 연관성이 적다.ㅣㅐ



#값의 범위(최소값과 최대값)
range( weight )
#최대값과 최소값의 차이
diff( range( weight ) )



#histogram : 연속형 자료의 분포를 시각화
# 연속형 자료에서는 구간을 나누고 구간에 속한 값들의 개수를 세는 방법으로 사용
str( cars )
dist <- cars[,2]
hist( dist, main = 'Histogram for 제도거리',
     xlab = '제동거리',ylab='빈도수',
     border = 'black', col = 'yellowgreen',
     las = 2, breaks = 5 )
# las = 1 ~ 3, breaks = 막대 수



# 상자그림(boxplot, 상자수열그림)
# 사분위수를 시각화하여 그래프 형태로 표시
# 상자그림은 하나의 그래프로 데이터의 분포형태를 포함한 다양한 정보를 전달
# 자료의 전반적인 분포를 이해하는데 도움
# 구체적인 최소/최대/중앙값을 알기는 어렵다.
boxplot( dist, main = "자동차 제동거리")

boxplot.stats( dist )
boxplot.stats( dist )$stats # 정상범위 사분위수
boxplot.stats( dist )$n     # 관측치 개수
boxplot.stats( dist )$conf  # 중앙값 신뢰구간
boxplot.stats( dist )$out   # 이상치(특이값) 목록


head(iris)

# 일변량 중 <그룹>으로 구성된 자료의 상자그림
boxplot( Petal.Length~Species,
         data = iris, # data 준 것
         main = '품종별 꽃잎의 길이' )

boxplot( iris$Petal.Length~iris$Species,
         main = '품종별 꽃잎의 길이' )


# 한 화면에 여러 그래프 작성
par( mfrow = c(1,3) ) # 1 X 3 가상화면 분할
barplot( table( mtcars$carb ), main = "C",
         xlab = "carburetors", ylab = "freq",
         col = "blue" )
barplot( table( mtcars$cyl ), main = "D",
         xlab = "cyl", ylab = "freq",
         col = "red" )
barplot( table( mtcars$gear ), main = "C",
         xlab = "gear", ylab = "freq",
         col = "yellowgreen" )


par( mfrow = c(1,1) ) # 가상화면 해제




















#
# 이름 : 이윤지
# 작성일 : 2019. 12. 04
# 제출일 : 2019. 12. 05

#문1)
#다음과 같이 결측값이 포함된 데이터셋 ds를 생성한 후, 다음 문제를 해결하기 위한 R 코드를 작성하시오.

ds <- state.x77
ds[2,3] <- NA; ds[3,1] <- NA; ds[2,4] <- NA; ds[4,3] <- NA

#(1) 각 열별로 결측값이 몇 개인지 출력하시오.
class(ds)
head(ds)
sum(is.na(ds))

for( i in 1:ncol(ds)){
  ds.na <- is.na(ds[,i])
  cat( colnames(ds)[i], "\t",
       sum(ds.na),"\n" )
}

#(2) 결측값이 포함된 행들의 데이터를 출력하시오.
ds[ !complete.cases(ds), ]


#(3) 결측값이 포함된 행은 몇 개인지 출력하시오.
sum( rowSums( is.na(ds) ) > 0 )

#(4) 결측값이 포함된 행들을 제외하고(=NA가 없는 행만) 새로운 데이터셋 ds.new를 만들어보시오.
ds.new <- ds[ complete.cases(ds), ]
ds.new
sum(is.na(ds.new)) # = 0 : 결측치 없음

# ----------------------------------------------------------------------------------------------------

#문2)
#다음과 같이 state.x77 데이터셋을 st에 저장한 후 다음 문제를 해결하기 위한 R 코드를 작성하시오.

st <- data.frame(state.x77)

#(1) st의 각 변수(열)들에 대해 특이값이 존재하는지 상자그림을 그려 확인하시오.

boxplot( st ) # : Populationm, Income, Area만 특이값(이상치) 있음.

#boxplot( st$Population ) 이상치 있음
#boxplot( st$Income)      이상치 있음 
#boxplot(st$Illiteracy)   이상치 없음
#boxplot(st$Life.Exp)     이상치 없음
#boxplot(st$Murder)       이상치 없음
#boxplot(st$HS.Grad)      이상치 없음
#boxplot(st$Frost)        이상치 없음
#boxplot(st$Area)         이상치 있음


#(2) 특이값이 존재하는 경우 이상치를 NA로 대체하여 저장하시오.
out.val1 <- boxplot.stats( st$Population )$out
out.val2 <- boxplot.stats( st$Income )$out
out.val3 <- boxplot.stats( st$Area )$out

st$Population[st$Population %in% out.val1] <- NA
st$Income[st$Income %in% out.val2] <- NA
st$Area[st$Area %in% out.val3] <- NA

#for ( i in 1:ncol( st ) ) {
#  outlier <- boxplot.stats( st[ , i ] )$out
#  if ( length( outlier ) > 0 ) {
#    st[ st[ , i ] %in% outlier, i ] <- NA
#  }
#}


sum(is.na(st))

head(st)


#(3) st에서 NA가 존재하는 행들을 제거하여(=NA가 없는 행들만 존재하게) st2에 저장하시오.
st2 <- st[ complete.cases(st), ]
sum(is.na(st2))

# ----------------------------------------------------------------------------------------------------

#문3) 
#R에서 제공하는 airquality 데이터셋에 대해 다음의 문제를 해결하기 위한 R 코드를 작성하시오.

#(1) airquality를 AQ에 저장하시오.

AQ <- data.frame(airquality)
AQ
sum(is.na(AQ))
head(AQ)

#(2) AQ에서 <열별>로 NA의 개수를 출력하시오.
for (i in 1:ncol(AQ)){
  AQ.na <- is.na(AQ[,i])
  cat(colnames(AQ)[i],
      "\t", sum(AQ.na), "\n")
}

#for ( i in 1:ncol(AQ)){
#  cat(colnames(AQ)[i],
#      "\t", sum(is.na(AQ[,i])), "\n" )
#}



#(3) AQ에서 행별로 NA의 개수를 출력하시오.
dim(AQ)

for (i in 1:nrow(AQ)){
  AQr.na <- is.na(AQ[i,])
  cat(rownames(AQ)[i],
      "\t", sum(AQr.na), "\n")
}


#(4) AQ에서 NA를 포함하지 않은 행들만 출력하시오.

AQ[ complete.cases(AQ),]


#(5) AQ에서 NA를 NA가 속한 열의 평균값으로 치환하여 AQ2로 저장하고, AQ2의 내용을 출력하시오.
#AQ[is.na(AQ)] <- 
  
# 열의 평균 

colSums(is.na(AQ))
# Ozone Solar.R    Wind    Temp   Month     Day 
# 37       7       0       0       0       0 

AQ2 <- AQ

OZ <- mean(AQ2$Ozone, na.rm = T );     OZ # 42.12931
AQ2$Ozone[is.na(AQ$Ozone)] <- OZ

sum(is.na(AQ2$Ozone)) # 결측치 : 0개
AQ2$Ozone # 결측치가 원본의 Ozone에서 na를 제외한 값들의 평균으로 대체 됨.

SR <- mean(AQ2$Solar.R, na.rm = T );   SR # 185.9315

AQ2$Solar.R[is.na(AQ2$Solar.R)] <- SR
sum(is.na(AQ2$Solar.R)) # 결측치 : 0개
AQ2$Solar.R

AQ2 # 결측치 모두 바뀜


# colmean <- colMeans( AQ, na.rm = T )
# colmean

# AQ2 <- AQ
# for ( i in 1:ncol( AQ2 ) ) {
#   AQ2[ is.na( AQ2[ , i ] ), i ] <- colmean[ i ]
# }
# AQ2 


# ----------------------------------------------------------------------------------------------------

#문4)
#R에서 제공하는 state.x77 데이터셋에 대하여 다음 문제를 해결하기 위한 R 코드를 작성하시오.

install.packages("dplyr")
library(dplyr)

#(1) state.x77 데이터셋을 Population(인구수)를 기준으로 오름차순 정렬하시오.

state <- data.frame(state.x77)
state
class(state)

state %>%
  arrange( Population )

#(2) state.x77 데이터셋을 Income(소득)을 기준으로 내림차순 정렬하시오.

state %>% arrange( desc( Income ) )

#(3) Illiteracy(문맹률)가 낮은 상위 10개 주의 이름과 문맹률을 출력하시오.
state %>% 
  mutate( city = rownames(state) ) %>% 
  arrange( Illiteracy ) %>% 
  select( city, Income) %>% 
  head(10)

# tmp <- state.x77[ order( state.x77[ , 'Illiteracy' ] ) , ]
# tmp[ 1:10, 'Illiteracy' ]

# ----------------------------------------------------------------------------------------------------

#문5)
#R에서 제공하는 mtcars 데이터셋에 대하여 다음 문제를 해결하기 위한 R 코드를 작성하시오.

#(1) mtcars 데이터셋을 gear(기어)의 개수에 따라 그룹을 나누어 mt.gear에 저장하시오.
#(단, split() 함수를 사용)
mt.gear <- split(mtcars, mtcars$gear)
mt.gear

#(2) mt.gear에서 gear(기어)의 개수가 4인 그룹의 데이터를 출력하시오.
#str(mt.gear); summary(mt.gear)
mt.gear$`4`

#(3) mt.gear에서 gear(기어)의 개수가 3인 그룹과 5인 그룹의 데이터를 합쳐서
#mt.gear.35에 저장하고 내용을 출력하시오.

mt.gear3 <- mt.gear$`3`
mt.gear5 <- mt.gear$`5`

nrow(mt.gear3);   nrow(mt.gear5)

mt.gear.35 <- bind_rows( mt.gear3, mt.gear5 )
mt.gear.35

#(4) mtcars 데이터셋에서 wt(중량)가 1.5~3.0 사이인 행들을 추출하여 출력하시오.

mtcars %>% 
  filter( wt >= 1.5 & wt <= 3.0 )

#subset( mtcars, wt >= 1.5 & wt < 3.0 )

# ----------------------------------------------------------------------------------------------------

#문6)
#다음의 문제를 해결하기 위한 R코드를 작성하시오.

#다음과 같이 데이터프레임 authors와 books를 생성하고 authors와 books의 내용을 출력하시오.	

authors <- data.frame( surname = c( "Twein", "Venables", "Tierney", "Ripley", "McNeil" ),
                       nationality = c( "US", "Australia", "US", "UK", "Australia" ),
                       retired = c( "yes", rep( "no", 4 ) ) )
books <- data.frame( name = c( "Johns", "Venables", "Tierney", "Ripley", "Ripley", "McNeil" ),
                     title = c( "Exploratory Data Analysis", 
                                "Modern Applied Statistics ...",
                                "LISP-STAT",
                                "Spatial Statistics", "Stochastic Simulation",
                                "Interactive Data Analysis" ),
                     other.author = c( NA, "Ripley", NA, NA, NA, NA ) )

#(1) surname과 name을 <공통 열로 하여> authors와 books를 병합하여 출력하시오.
#(두 데이터프레임에서 공통 열의 값이 일치하는 것들만 병합).
merge( authors, books, by.x = c("surname"), by.y = c("name") )

#(2) surname과 name을 <공통 열로 하여> authors와 books를 병합하여 출력하되
#authors의 행들이 모두 표시되도록 하시오.
merge( authors, books, by.x = c("surname"), by.y = c("name"), all.x = T )

#(3) surname과 name을 <공통 열로 하여> authors와 books를 병합하여 출력하되
#books의 행들은 모두 표시되도록 하시오.
merge( authors, books, by.x = c("surname"), by.y = c("name"), all.y = T )

#(4) surname과 other.author를 "공통 열로 하여" authors와 books를 병합하여 출력하시오.
# 틀림 : merge( authors, books, by.x = c("surname"), by.y = c("name"), all = T)

merge( authors, books, by.x = c( 'surname' ), by.y = c( 'other.author' ) )


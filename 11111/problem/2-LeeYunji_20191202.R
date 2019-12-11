# 이름 : 이윤지
# 작성일 : 2019. 11. 29.
# 제출일 : 2019. 12. 02.

# ---------------------------------------------------------------

# 문제 1)

# 1-1 : matrix score를 생성
m <- c(10,40,60,20)
f <- c(21,60,70,30)
score <- cbind(m,f);      score

# 1-2 : score의 열 이름을 각각 male, female로 바꾸시오
colnames(score) <- c( "male","female" )
score

# 1-3 : 2행에 있는 모든 값을 출력
score[2,]

# 1-4 : female의 모든 값 출력
score[,2]

# 1-5 : 3행 2열의 값을 출력
score[3,2]

# ---------------------------------------------------------------

# 문제 2)

# 2-1. state.x77을 변환하여 st에 data frame으로 작성
st <- data.frame( state.x77 )
class(st)

# 2-2. st의 내용을 출력
st

# 2-3. st의 열 이름 출력
colnames(st)

# 2-4. st의 행 이름 출력
rownames(st)

# 2-5. st의 행의 개수와 열의 개수 출력
nrow(st);     ncol(st)

# 2-6. st의 요약 정보 출력
summary(st)

# 2-7. st의 행별 합계와 평균 출력
apply( st[ , ], 1, sum );     apply( st[ , ], 1, mean )

# 2-8. st의 열별 합계와 평균 출력
apply( st[ , ], 2, sum);      apply( st[ , ], 2, mean )

# 2-9. Florida 주의 모든 정보 출력
florida <- subset( st['Florida',] );     florida

# 2-10. 50개 주의 수입(Income) 정보만 출력
st$Income

# 2-11. Texas 주의 면적(Area)을 출력
Texas <- subset( st['Texas',], select = 'Area');    Texas

# 2-12. Ohio 주의 인구(Population)와 수입(Income) 출력
Ohio <- subset( st['Ohio',])
#Ohio$Population;  Ohio$Income
Ohio[1:2]

# 2-13. 인구가 5,000 이상인 주의 데이터만 출력
pop <- subset( st, Population >= 5000);  pop

# 2-14. 수입이 4,500 이상인 주의 인구, 수입, 면적을 출력
inc <- subset( st, Income >= 4500 );      inc[c(1,2,8)]

# 2-15. 수입이 4,500 이상인 주는 몇 개인지 출력
nrow(inc)

# 2-16. 전체 면적(Area)이 100,000 이상이고, 결빙일수(Frost)가 120 이상인 주의 정보 출력
af <- subset(st, Area >= 100000 & Frost >= 120 );   af

# 2-17. 인구(Population)가 2,000 미만이고, 범죄율(Murder)이 12미만인 주의 정보 출력
pm <- subset(st, Population < 2000 & Murder < 12);    pm

# 2-18. 문맹률(Illiteracy)이 2.0 이상인 주의 평균 수입은 얼마인지 출력
Ill <- subset( st, Illiteracy >= 2.0 );           mean(Ill$Income)

# 2-19. 문맹률(Illiteracy)이 2.0 미만인 주와 2.0 이상인 주의 평균 수입의 차이 출력
Ill2 <- subset( st, Illiteracy < 2.0 )
abs(mean(Ill$Income) - mean(Ill2$Income))

# 2-20. 기대수명(Life Exp)이 가장 높은 주는 어디인지 출력
st[ st$Life.Exp == max(st$Life.Exp), ]
# HL <- subset( st, st$Life.Exp == max(st$Life.Exp) );  HL

# 2-21 Pennsylvania 주보다 수입(Income)이 높은 주들 출력
st[ st$Income > st["Pennsylvania",]$Income, ]
# HP <- subset( st, st$Income > st["Pennsylvania",]$Income ); HP

#nrow(HP);     nrow( st[ st$Income > st["Pennsylvania",]$Income, ] )


# ---------------------------------------------------------------
#R에서 제공하는 mtcars 데이터셋은 자동차 모델에 대한 제원 정보를 담고 있다.

# 문제 3)

mtcars

# 3-1. 이 데이터셋의 자료구조 출력
str(mtcars)

# 3-2. 이 데이터셋의 행의 개수와 열의 개수 출력
nrow(mtcars);       ncol(mtcars)

# 3-3. 이 데이터셋 열들의 자료형 출력
mode(mtcars$mpg);   mode(mtcars$cyl);   mode(mtcars$disp);    mode(mtcars$hp);
mode(mtcars$drat);  mode(mtcars$wt);    mode(mtcars$qsec);    mode(mtcars$vs);
mode(mtcars$am);    mode(mtcars$gear);  mode(mtcars$carb);

# 3-4. 연비(mpg)가 가장 좋은 자동차 모델 출력
mtcars[ mtcars$mpg == max(mtcars$mpg), ]

# 3-5. gear가 4인 자동차 모델 중 연비가 가장 낮은 모델 출력
mtcars[ mtcars$mpg == min(mtcars$mpg), ]

# 3-6. Honda Civic의 연비(mpg)와 gear 수 출력
honda <- subset( mtcars['Honda Civic',] )
honda[c(1,10)]  # honda[c('mpg','gear')]

# 3-7. Pontiac Firebird 보다 연비가 좋은 자동차 모델 출력
mtcars[ mtcars$mpg > mtcars["Pontiac Firebird",]$mpg, ]

# 3-8. 자동차 모델들의 평균 연비 출력
mean(mtcars$mpg)

# 3-9. gear의 수 종류 출력
unique(mtcars$gear)

# ---------------------------------------------------------------
# R에서 제공하는 airquality 데이터셋은 일별로 대기의 질을 측정한 정보를 담고 있다.

# 문제 4)

airquality

# 4-1. 이 데이터셋의 자료구조 출력
str(airquality)

# 4-2. 이 데이터셋의 앞쪽 일부분 내용만 출력
head(airquality)

# 4-3. 기온(Temp)이 가장 높은 날은 언제인지 월(Month)과 일(Day) 출력
airquality[ airquality$Temp == max(airquality$Temp), c('Month','Day')]

# 4-4. 6월달에 발생한 가장 강한 바람(Wind)의 세기 출력
june <- subset( airquality, airquality$Month == 6 )
max(june$Wind)

# 4-5. 7월 달의 평균 기온(Temp) 출력
july <- subset( airquality, airquality$Month == 7 )
mean(july$Temp)

# 4-6. 오존(Ozone) 농도가 100을 넘는 날은 며칠이나 되는지 출력
overOz <- subset( airquality, airquality$Ozone > 100 );   overOz
nrow(overOz)

# 5-1. R에서 제공하는 state.x77 데이터셋에서 수입(Income)이 5,000 이상인 주의 데이터에서
#수입(Income), 인구(Population), 면적(Area) 열의 값들만 추출하여 rich_state.csv에 저장

state.x77 # state.x77 = Matrix
state <- data.frame(state.x77);   class(state)
state.rich <- subset( state, state$Income >= 5000 );   state.rich
write.csv(state.rich, "C:/yj/bigdata/rich_state.csv")

# 5-2. 1.에서 만든 rich_state.csv파일을 읽어서 ds 변수에 저장한 후 ds 내용 출력
ds <- read.csv("C:/yj/bigdata/rich_state.csv");   ds


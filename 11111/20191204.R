#
# 7일차
#
# 결측치 처리

#vector의 결측치 처리
z <- c( 1,2,3,NA,5,NA,8)
sum(z)
is.na(z)                  # z에서 NA인 것을 논리값으로 반환 (is로 시작하는 함수 : 논리값으로 반환)
sum(is.na(z))             # z에서 NA인 것들의 개수
sum( z, na.rm = TRUE )    # na.rm = TRUE : z에서 NA인 것들을 제외한, sum() : 합계
                          # Iterator : 반복 기능

# 결측치 대체 및 제거
z1 <- z
z2 <- c( 5,8,1,NA,3,NA,7 )
z1[is.na(z1)] <- 0                # 단순대입법 : 꼭 0이 아니더라도 다른 값들로 대체할 수 있음. ex) 평균
z1

#Listwise Deletion
z3 <- as.vector( na.omit(z2) )    # na.omit : 결측치가 포함된 데이터를 삭제하는 함수.
z3                                # as : 변화할 때 쓰는 함수.



# Matrix / Data Frame  결측치 처리
x <- iris
x[1,2] <- NA
x[1,3] <- NA
x[2,3] <- NA
x[3,4] <- NA
head(x)

# 1. Matrix / Data Frame 열별 결측치 확인
# for문 이용
for ( i in 1:ncol(x)){
  this.na <- is.na(x[,i])
  cat( colnames(x)[i],
       "\t", sum(this.na),
       "\n")
}

# apply 이용
col_na <- function(y){
  return ( sum( is.na(y) ) ) 
}
na_count <- apply( x, 2, col_na )
na_count

# apply 이용방법 
na_count <- apply( x, 2,function( y ) sum( is.na( y ) ) ) # 함수 이름이 없음. 1이서는 col_na를 사용함.
na_count

barplot( na_count[ na_count > 0 ] ) # 결측치가 있는 대상만 그래프를 그려라.

install.packages('VIM')
require( VIM ) # = library

# 결측치 자료 조합 확인용 시각화 도구
aggr( x, prop = FALSE, numbers = TRUE )   # Combinations에서 147 = 결측치 없는 데이터의 개수

# 두 개의 변수 간의 결측치 관계 확인 시각화 도구
marginplot( x[c( "Sepal.Width","Petal.Width" )],
            pch = 20,
            col = c( "darkgray","red","blue" ) )      # red = 결측치 -> sepal.width와 petal.width에 각 한 개씩 존재

# 머신러닝을 할 때는 결측치 제거를 신중하게 해야 함.


# Matrix / Data Frame의 행(data) 별 결측치 확인
# 행 = column의 집합

rowSums( is.na(x) )
sum( rowSums( is.na(x) ) > 0 ) #결측치가 포함된 행의 수

sum( is.na(x) )   # 행인지 열인지 구분은 안되지만, 결측치가 4개 있다.


# Listwise Deletion : NA가 들어간 행 전체를 삭제한다. -> 결측치가 없는 변수도 지워지는 문제점이 있음.
# 데이터 수가 많을 때 사용하는 게 좋음. 적을 때는 대입법을 사용하는 게 best

# 결측치를 제외한 새로운 데이터셋 생성
head( x )
x[ !complete.cases( x ), ]            # NA가 포함된 행 출력
y <- x[ complete.cases( x ), ]        # NA가 포함되지 않은 행을 y에 입력. = 결측치가 포함된 행 제외하고 출력.
head( y )


# 특이값, 이상치( outlier )
st <- data.frame( state.x77 )
summary( st$Income)
boxplot(st$Income)
boxplot.stats( st$Income )$out # boxplot.state : 통계자료 보여줌

# 특이값(결측치) 처리 : NA로 변환 후 결측치 처리방법 이용

out.val <- boxplot.stats( st$Income )$out
st$Income[ st$Income %in% out.val] <- NA
sum(is.na(st))
newdata <- st[ complete.cases( st ), ]
head(newdata)


# 데이터 가공

# 데이터 정렬
# Vector 정렬
v1 <- c(1,7,6,8,4,2,3)
order(v1)
vl <- sort(v1)
v1
v2 <- sort(v1, decreasing = T)
v2

# Matrix / Data Frame 정렬
head( iris )
order( iris$Sepal.Length )
iris[ order ( iris$Sepal.Length ), ]                  #Asending
iris[ order ( iris$Sepal.Length, decreasing = T ), ]  # Decreasing
iris.new <- iris[ order( iris$Sepal.Length ), ]       # 오름차순으로 정렬한 걸 iris.new에 입력
head( iris.new )
iris[ order( iris$Species, decreasing = T ,
      iris$Sepal.Length ), ]                          #정렬 기준을 2개 설정 ex)나이가 동일하면 학번으로 정렬한다. ...


# 데이터 분리
sp <- split( iris, iris$Species )                     # iris를 품종별로 구분해서 sp에 넣음
sp
summary( sp )
sp$setosa

# 데이터 선택
subset( iris, Species == "setosa" )
subset( iris, Sepal.Length > 7.5 )
subset( iris, Sepal.Length > 5.1 & Sepal.Width > 3.9 )
subset( iris, Sepal.Length > 7.6,
        select = c( Petal.Length, Petal.Width ) )

# 데이터 sampling
# 숫자를 임의로 추출
x <- 1:100
y <- sample( x, size = 10, replace = FALSE )    #비복원 추출 : replace = FALSE
y

# 행을 임의로 추출
idx <- sample( 1:nrow(iris), size = 50, replace = FALSE )
iris.50 <- iris[idx, ]
dim( iris.50 )
head( iris.50 )

sample( 1:20, size = 5 )
sample( 1:20, size = 5 )
sample( 1:20, size = 5 )

set.seed( 100 )           # 같은 값을 보내줌.. sample 앞에 넣었기 때문,,? set.seed( 임의의 값 )
sample( 1:20, size = 5 )
set.seed( 100 )
sample( 1:20, size = 5 )
set.seed( 100 )
sample( 1:20, size = 5 )


# 데이터 조합
combn(1:5,3) #combination의 약자. -> combn(조합할 수의 범위, 조합할 수의 개수(=행의 개수) )

x = c( "red","green","blue","black","white")
com <- combn( x,2 )
com

for ( i in 1:ncol( com )){    # ncol(com) = 10
  cat( com[ ,i ], "\n" )
}

# 데이터 집계
agg <- aggregate( iris[, -5 ],
                  by = list( iris$Species),
                  FUN = mean) # 집계함수 ( 집계대상, 집계기준, 동작 : 평균 )
agg

agg <- aggregate( iris[, -5 ],
                  by = list( iris$Species),
                  FUN = sd) # 집계함수 ( 집계대상, 집계기준, 동작 : 표준편차 )
agg

head( mtcars )
agg <- aggregate( mtcars,
                  by = list( cyl = mtcars$cyl,
                             vs = mtcars$vs),
                  FUN = max) # 집계함수 ( 집계대상, 집계기준, 동작 : 최대값)
agg


# 데이터 병합 : 일치하는 변수 => 데이터 병합
x <- data.frame( name = c("a","b","c"),
                 math = c( 90, 80, 40) )
y <- data.frame( name = c("a","b","d"),
                 korean = c( 75,60,90) )
z <- merge( x, y, by = c("name") ) # name을 기준으로 병합
z


merge( x, y ) # = z : 번수 추가
merge( x, y, all.x = T ) # x 변수 다 나오게 병합 : x 기준으로 병합 -> a,b,c + NA : 변수 추가
merge( x, y, all.y = T ) # y 변수 다 나오게 병합 : y 기준으로 병합 -> a,b,d + NA : 변수 추가
merge( x, y, all = T )    # x, y 변수 모두 나오게 병합 -> a,b,c,d + NA : 변수, 데이터(x,y 서로에게 없는 데이터) 추가


x <- data.frame( name = c("a","b","c"),
                 math = c( 90, 80, 40) )
y <- data.frame( sname = c("a","b","d"),
                 korean = c( 75,60,90) )
merge( x, y, by.x = c( "name" ), by.y = c("sname") )

#dplyr packages : 데이터 가공 패키지

install.packages( 'dplyr' )
library(dplyr)

df <- data.frame( var1 = c(1,2,1),
                  var2 = c(2,3,2) )
df

# rename() : 이름 변경
df <- rename(df, v1 = var1, v2 = var2)  # 변경할 이름 = 원래 이름
df

# 파생변수 추가
df$sum <- df$v1 + df$v2
df

df[2,1] <- 5
df


df <- data.frame( id = c(1,2,3,4,5,6),
                  class = c(1,1,1,1,2,2),
                  math = c(50,60,45,30,25,50),
                  english = c(98,97,86,98,80,89),
                  science = c(50,60,78,58,65,98) )
df


# filter() : 행 추출
df %>% filter( class == 1 )
df %>% filter( class == 2 )
df %>% filter( class != 1 )
df %>% filter( class != 2 )

df %>% filter( science > 70 )
df %>% filter( math < 50 )

df %>%  filter( class == 1 & math >= 50 )
df %>%  filter( math >= 50 | english >= 90 )
df %>%  filter( class %in% c(1,3,5) )

class1 <- df %>%  filter( class == 1 )
class2 <- df %>%  filter( class == 2 )
class1
class2


# select() : 변수 추출
df %>%  select( math )
df %>%  select( science )

df %>%  select( class, math, science )

df %>%  select( -math )


# dplyr 함수 조합
df %>% 
  filter( class == 1 ) %>% 
  select( science )

df %>% 
  select( id, science ) %>% 
  head

df %>% 
  select( id, science ) %>% 
  sum

df %>% 
  select( id, science ) %>% 
  max

# arrange() : 정렬
df %>%  arrange( science )
df %>%  arrange( desc( science ) )

# mutate() : 파생변수 추가
df %>% 
  mutate( total = math + english + science,
          average = ( math + english + science ) /3 ) %>%
  head

df %>% 
  mutate( grade = ifelse( science >= 60, 'pass','fail')) %>% 
  head

df %>% 
  mutate( total = math + english + science,
          average = ( math + english + science ) /3 ) %>%
  mutate( grade = ifelse( average >= 90, 'pass',
                          ifelse(average < 60, 'fail',
                                 'normal' ) ) ) %>% 
  head

df %>% 
  mutate( total = math + english + science,
          average = ( math + english + science ) /3 ) %>%
  arrange( desc( average ) ) %>% 
  head

df.sort <- df %>% 
  mutate( total = math + english + science,
          average = ( math + english + science ) /3 ) %>%
  arrange( desc( average ) ) %>% 
  head

df.sort


# summarise() : 집단별 요약
# group_by() : 집단별 나누기
df %>%  summarise( mean_math = mean(math) )

df %>%
  group_by( class ) %>% 
  summarise( mean_math = mean(math),
             mean_english = mean(english),
             mean_science = mean(science),
             n = n() ) # n() : 빈도 수 계산 함수 - 인수 없음.

# ↑ 결과
# A tibble: 2 x 5
#class mean_math mean_english mean_science     n     : 변수
#<dbl>     <dbl>        <dbl>        <dbl> <int>     : 자료형
#  1     1      46.2         94.8         61.5     4 : 그룹별로 묶은 것 중 그룹1
#  2     2      37.5         84.5         81.5     2 : 그룹2

install.packages("ggplot2")
library(ggplot2)

str( ggplot2::mpg)
mpg <- data.frame( ggplot2::mpg) # :: <- scope ? : 누가 가지고 있는지.. mpg라는 걸 ggplot2가 갖고 있다.
# 라이브러리 없이, 패키지에서 .. 갖고오는.. 설치 없이...
dim(mpg)
str(mpg)
head(mpg)
View(mpg) # 주의할 점 : view에서 V는 대문자!


mpg %>% 
  group_by( manufacturer, drv ) %>%           # 그룹화
  summarise( mean_cty = mean( cty )) %>%      # 요약 
  head(10)                                    # 출력

mpg %>% 
  group_by(manufacturer) %>%                  # 그룹화
  filter( class == 'suv' ) %>%                # 행 추출 : class = suv
  mutate( tot = (cty + hwy)/2 ) %>%           # 파생 변수 추가
  summarise( mean_tot = mean(tot) ) %>%       # 요약
  arrange( desc(mean_tot)) %>%                # 정렬
  head(5)                                     # 출력


# 데이터 합치기
# left_join() : 가로로 합치기 (변수 추가)
# inner_join() : 가로로 합치기 (변수 추가) = merge
# full_join() : 가로로 합치기 (변수 추가)
# bind_rows() : 세로로 합치기 (data 추가)

df1 <- data.frame( id = c(1,2,3,4,5),
                   midterm = c(60,80,70,90,85))
df2 <- data.frame( id = c(1,2,3,4,5),
                   final = c(60,80,70,90,85) )
total <- left_join( df1, df2, by="id" ) # 변수 추가

total

df1 <- data.frame( id = c(1,2,3),
                   address = c("서울","부산","제주"),
                   stringsFactors = F ) # stringsFactors : 스트링을 팩터로 보지 않는다! - factor 타입으로 변형 X
df2 <- data.frame( id = c(1,2,4),
                   gender = c("남","여","남") )

df_left <- left_join(df1, df2, by = 'id')
df_left
df_inner <- inner_join(df1, df2, by = 'id')
df_inner
df_full <- full_join(df1, df2, by = 'id')
df_full # 열 추가(가로 추가)


df1 <- data.frame( id = c(1,2,3,4,5),
                   test = c(60,80,70,90,85))
df2 <- data.frame( id = c(1,2,3,4,5),
                   test = c(60,80,70,90,85) )
df_all <- bind_rows( df1, df2 )
df_all # 행 추가(세로 추가)

install.packages("psych")
library(psych)

summary( mtcars )
describe( mtcars ) #개수, 관측치, 평균, 표준편차, 최소값, 최대값 등등 다 나옴
#summary()와 비슷한데 describe가 더 많은 요약 정보가 있음.


install.packages("descr")
library(descr)

df <- data.frame( id = c(1,2,4),
                   gender = c("남","여","남") )
table(df$gender) # 범주형 - 도수분포표 만들 때 사용

freq( df$gender ) # table 대신에 freq 써도 됨. 왜냐면 도수분포표와 그래프 동시에 보여주니까.
freq( df$gender, plot = F ) # plot = F : 차트 그리지 않기










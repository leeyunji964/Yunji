# 4일차

# 함수 반환값(return 값)이 여러 개일 때의 처리

myfunc <- function(x,y){
    val.sum <- x + y
    val.mul <- x * y
    
    return ( list (sum = val.sum, mul = val.mul) )
    # 리스트의 구조가 2개로 구성되어 있는거지, 값이 2개 반환되는 건 아님.
}

result <- myfunc( 5,8 )
s <- result$sum
m <- result$mul
cat('5 + 8 = ',s,'\n')
cat('5 * 8 = ',m,'\n')



# ------------------------------------------------------------------------
# 오후 수업 : Matrix 

#Matrix 생성
z <- matrix( 1:20, nrow = 4 )           # 관측치 : 4, 변수 : 5
z

z <- matrix( 1:20, ncol = 4)            # 관측치 : 5, 변수 : 4,  열 우선방식 <- R은 이게 default
z

z <- matrix( 1:20, nrow = 4, ncol = 5 ) # 관측치 : 4, 변수 : 5
z

# 매트릭스는 항상 full로 채워져야 함.

z <- matrix( 1:20, nrow = 4, ncol = 5, byrow = T)
z     # byrow = T : 행 우선으로 채우겠다.

x <- 1:4
x
y <- 5:8
y
z <- matrix( 1:20, nrow = 4, ncol = 5 )
z

m1 <- cbind( x,y )
m1
m2 <- rbind( x,y )
m2
m3 <- rbind( m2, x )  # 기존 matrix에 관측치로 데이터 추가
m3
m4 <- cbind( z,x )
m4

# Matrix에서 cell의 값 추출하기
z[ 2,3 ]
z[ 1,4 ]
z[ 2, ]
z [ ,4 ] # 열(matrix)이긴 하지만 결과(vector)는 -> 방향으로  나탄서 일려줌.

z[ 2, 1:3 ]
z[ 1,c(1,2,4) ]
z[ 1:2 ]
z[ , c(1,4) ] # 1열과 4열 전체 (행은 지정 x -> 행 전체)


# Matrix에서 행/열에 이름 지정
score <- matrix( c(90,85,69,78,
                    85,96,49,95,
                    90,80,70,70),
                  nrow = 4, ncol = 3)
score
rownames( score ) <- c('Hong','Kim','Lee','Yoo')   #관측치 이름
colnames( score ) <- c('English','Math','Science') #변수 이름

score[ 'Hong', 'Math' ]
score[ 'Kim', c('Math','Science') ]
score[ 'Lee' ]
score[ , 'English']
rownames( score )
colnames( score )
colnames( score)[2]

# ------------------------------------------------------------

#Data Frame 생성
city <- c("Seoul","Tokyo","Washington")
rank <- c( 1,3,2 )
city.info <- data.frame(city, rank)
city.info # 3행 2열 데이터프레임 생성

name <- c( "Hong","Kim","Lee")
age <- c(22,20,25)
gender <- factor(c("M","F","M"))
blood.type <- factor( c("A","O","B")) #factor 타입
person.info <- data.frame( name, age, gender, blood.type )
person.info # 3행 4열 데이터프레임 생성

#person2.info <- data.frame(c( "Hong","Kim","Lee"),
#                           c(22,20,25),
#                           factor(c("M","F","M")),
#                           factor( c("A","O","B")))
#person2.info

# 요소 접근 방법
city.info[ 1,1 ] # ctiry dataframe의 1행 1열 데이터
city.info[ 1 , ]
city.info[ , 1 ]
#city.info[ c( "Seoul", "Washington"), ]
city.info[ city.info$city, ]
city.info[,"rank"]

person.info$name
person.info[ person.info$name == "Hong", ] # name이 hong인 관측치의 모든 데이터 출력
person.info[ person.info$name == "Hong", c("name","age") ] # name이 hong인 관측치의 name과 age 출력


data() #R이 내부적으로 여러 데이터셋을 만들어 놓은 것.그 중 하나가 iris

iris # iris : Edgar Anderson's Iris Data

iris[ , c(1:2) ] # 모든 관측치, 변수1,2의 데이터 출력
iris[ , c(1,3,5) ] # 모든 관측치, 변수 1,3,5의 데이터 출력
iris[ , c("Sepal.Length","Species") ] #모든 관측치, Sepal.Length과 Species의 데이터만 출력
iris[ 1:5, ]; # 관측치 1부터 5까지의 모든 변수 데이터 출력
iris[ 1:5, c(1,3) ] # 관측치 1부터 5까지, 변수 1과 3의 데이터 출력


#Matrix와 Data Frame에서 사용하는 함수
dim( person.info ) # 몇 행 몇 열인지 알려줌. : 관측치(행)의 수, 변수(열)의 수
#dim(iris)
nrow( person.info ) # 행의 숫자
nrow( m3 )
ncol( person.info ) # 열의 숫자
ncol( m3 )
head( iris ) # 앞부분 일부 -> 실제 데이터를 확인해보려고 하는데, 데이터가 많을 때 부분적으로 확인하기 위해 사용함.
tail( iris ) # 뒷부분 일부 -> 보통은 10%, 11%, 50% 정도만 보여줌.
str( iris ) # 150 obs.(관측치 수) of 5 variables(변수의 수) <- 데이터프레임의 구조를 알 수 있다.
#str( city.info )  3 obs. of 2 

# str( city.info )
#'data.frame':	3 obs. of  2 variables:
#  $ city: Factor w/ 3 levels "Seoul","Tokyo",..: 1 2 3 : 데이터프레임으로 바뀌면서 R이 데이터를 factor로 변환시켜 버림.
#  $ rank: num  1 3 2
# data type 잘 살펴보기! -> 나중에 분석할 때 산술연산이 가능한 타입으로 변환해줘야 할 수도 있으니까.

#str( person.info ) 
iris[ , 5 ]
unique( iris[ , 5 ] ) # 중복된 데이터를 하나씩만 뽑아서 vector로 나열하는 함수 : iris의 변수 5의 데이터들을 중복 없이 출력
table( iris[, "Species"] )
table( person.info[ , "blood.type"]) # 종류별로 count를 세주는 함수 : person.info의 blood.type별로 카운트 세 줌.
table( person.info[, "gender"] ) # person.info의 gender 별 카운트. F 1명, M 2명

# matrix와 다른 점은 [ data frame은 변수 중심으로 접근하게 된다. ]
# matrix에 비해 변수의 중요도가 높다.


# Matrix/Data Frame 사용 함수
# 행별/열별 합계와 평균 계산
colSums( iris[ , -5]);     apply( iris[ , 1:4 ], 2, sum) # 같은 결과가 나오기는 하나, apply가 활용도가 높음.
colMeans( iris[, -5]);     apply( iris[ , 1:4 ], 2, mean)
rowSums( iris[, -5]);      apply( iris[ , -5 ], 1, sum)
rowMeans( iris[, -5]);     apply( iris[ , -5 ], 1, mean)  
apply( iris[, -5], 2, median ) #중앙값


# iris의 5번째 변수를 제외한 변수(열)별 합계               
# iris의 5번째 변수를 제외한 변수별(열) 평균
# iris의 5번째 관측치를 제외한 관측치별(행) 합계 : factor는 연산이 안 되니까 iris[,-5] 한 것.
# iris의 5번째 관측치를 제외한 관측치별(행) 평균

# apply( 데이터 명[ 범위 ], 행(1)/열(2) 방향, 연산 )


# 행/열 방향 전환
z <- matrix( 1:20, nrow = 4, ncol = 5); # 4행 5열
t(z) # t함수 -> 방향 바꿈 : 5행 4열 ( 전치 행렬 )

# 조건에 맞는 행과 열의 값 추출(Data Frame만 가능)
IR.1 <- subset( iris, Species == "setosa");                      IR.1 # iris의 변수인 Species가 setosa인 것만 추출(부분 추출)
IR.2 <- subset( iris, Sepal.Length > 5.0 & Sepal.Width > 4.0 );  IR.2 # iris의 변수인 Sepal.Length가 5.0 초과하면서 Width가 4.0 초과인 것만 추출 
IR.2[ , c(2,4) ] # IR.2에서 모든 관측치와 변수 2, 변수 4만 출력
#subset : : data frame에서만 가능한 함수

# Matrix / DataFrame 산술연산 - 구조가 같은 행렬이여야만 가능함.
a <- matrix( 1:20, 4, 5);     a
b <- matrix( 21:40, 4, 5);    b

2 * a
b - 5
2 * a + 3 * b

a + b
b - a
b / a
a * b


# Matrix / Data Frame 자료구조 확인/변환
class( iris );              str(iris)                   # "data.frame"
class( state.x77 );         str( state.x77)             # "matrix"
is.matrix( iris )                                       # "FALSE"           'is'로 시작하는 함수는 결과값이 논리값
is.data.frame( iris )                                   # "TRUE"
is.matrix( state.x77 )                                  # "TRUE"
is.data.frame( state.x77 )                              # "FALSE"

st <- data.frame( state.x77 ) # state.x77를 dataframe 형식으로 저장
str( st ) # data frame으로 저장된 거 확인.
# class( state.x77 )의 결과는 ..$ : chr [1:50] "Alabama" "Alaska" "Arizona" "Arkansas" ...
#                             ..$ : chr [1:8] "Population" "Income" "Illiteracy" "Life Exp" ...
#으로 나와서 위([1:50])가 행, 아래가 열인 것을 알 수 있는데, data frame으로 바꿔서 str로 구조 살펴보면 obs와 variable로더 편하게 알아 볼 수 있음.
head( st )
class( st )
dim(st)

iris.m <- as.matrix( iris[, 1:4]) # data frame의 변수 1부터 4까지를 matrix로 전환
# 'as'로 시작하는 함수는 <변환>할 때 사용하는 함수
head( iris.m )
class( iris.m ) # "matrix"
str(iris.m)


head( st )
Population
attach( st )  # 뜻 - 붙이다 : 변수 이름 자체를 쓰기 원할 땐 attach( 데이터프레임 ) 후,
Population    # 다시 변수 이름을 출력하면 데이터가 나옴
Income

detach( st )  # 뜻 - 떼다 : attach 취소
Population


# --------------------------------------------------------------------------------------
# csv 파일 불러오기(내용 읽기)

setwd( "D:/workR" ) # 경로 변경         * 역슬래시(\) 아니고 슬래시!(/)
air <- read.csv( "airquality.csv", header = T ) # header = Ozone, Wind ... 만약 헤더가 없고 바로 데이터면 header = F

class(air) # data.frame
dim(air)
str(air)
head(air)
tail(air)
 
# csv 파일 생성하기

name <- c( "Hong","Kim","Lee")
age <- c(22,20,25)
gender <- factor(c("M","F","M"))
blood.type <- factor( c("A","O","B")) #factor 타입
person.info <- data.frame( name, age, gender, blood.type )
person.info # 3행 4열 데이터프레임 생성

setwd( "D:/workR" ) # 경로 변경         * 역슬래시(\) 아니고 슬래시!(/)
write.csv( person.info, "person_info.csv", row.names = F )



























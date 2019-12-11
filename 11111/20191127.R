#
# R 프로그래밍 1일 차
#
# first.R
#
# 작성자 : 이윤지
#
# 최초 작성일 : 2019. 11. 26.
#
print("Hello, World!")

number <- 10
number2 <- 100

number3 <- number+number2


numberValue <- 1              # camel 표기법
str_value <-  "R Language"    # snake 표기법
booleanvalue <- TRUE          # 참고로 R은 대소문자를 구분함.


numberValue <- "R Script"
numberValue <- 1

print(numberValue)
print(str_value)
print(booleanvalue)

cat( "Numeric number : ", numberValue, "\n" )
cat( "String : ", str_value, "\n" )
cat( "Boolean : ", booleanvalue, "\n" )


numberValue <- scan()

cat( "Numeric number : ", numberValue, "\n" )


number1 <- 10
number2 <- 20
resultAdd <- number1 + number2
resultSub <- number1 - number2
resultMul <- number1 * number2
resultDiv <- number1 / number2
resultRem <- number2 %% number1
resultSec <- number2 ** 5

print( resultAdd )
print( resultSub )
print( resultMul )
print( resultDiv )
print( resultRem )
print( resultSec )


number1 <-  0
number1 <- number1 + 10
number1

number1 <- number1 + 10
number1

number1 <- number1 + 10
number1

number2 <- 100
number1 <- number2 + 10
number1
number2

print((number1 + 10) * number2 / 2)

number300 <- 10
number300 <- number300 + 10
number300

number301 <- number300 * 2
number301

number1 <- 10.5
number2 <- 10
print( number1 > number2 )
print( number1 >= number2 )
print( number1 < number2 )
print( number1 <= number2 )
print( number1 == number2 )
print( number1 != number2 )

print(number1 > 10 & number2 >10 )    # AND
print( number1 > 100 | number2 > 10 ) # OR
print( !(number1 >10 ) )              # NOT

number <- 100
str <- "R Language"
result = number + str
print(result)

number <- "100"
str <- "R Language"
result = number + str
print(result)


# 제어구조 - 선택구조

job.type <- 'A'

if (job.type == 'B'){
    bonus <- 200
} else {
  bonus <- 100
}
cat( "joy type : ", job.type, "\t\tbonus : ", bonus)


#제어구조 - 선택 구조

job.type <- 'B'
if ( job.type  == 'A'){
  bonus <- 200
}
cat( "joy type : ", job.type, "\t\tbonus : ", bonus)



#제어구조 - 선택 구조

score <- 75

if ( score >= 90 ){
  grade <- 'A'
} else if ( score >= 80 ){
  grade <- 'B'
} else if ( score >= 70 ){
  grade <- 'C'
} else if ( score >= 60) {
  grade <- 'D'
} else {
  grade <- 'F'
}
cat( "joy type : ", score, "\t\tgrade : ", grade)



number <- 6
# reminder <- number %% 2
if ( number %% 2 == 0){
  result = "짝수"
} else {
  result = "홀수"
}
cat ( "Number : ", number, "는 ",result,"이다.")


a <- 5
b <- 20

if ( a > 5 & b > 5){
  cat (a, ">5 and ", b,">5")
} else {
  cat (a, "<=5 or ", b,"<=5")
}

a <- 10
b <- 20

if ( a>b ){
  c <- a
} else {
  c <- b
}
cat ("a = ",a,"\tb = ",b,"\tc = ",c)

c <- ifelse( a > b, a,b)
cat ("a = ",a,"\tb = ",b,"\tc = ",c)


#a,b,c 중 가장 큰 값을 max에 저장 후 max를 출력
a <- 4
b <- 45
c <- 8


if ( a > b & a > c) {
  max = a
} else if ( b > a & b >c ){
  max = b
} else if ( c > b & c > a){
  max = c
}
cat ("a = ",a,"\tb = ",b,"\tc = ",c, "\tmax = ", max)

# max <- a
# if (b> max){
# max = b
#}
# if (c > max){
# max = c
#}
#cat ("a = ",a,"\tb = ",b,"\tc = ",c, "\tmax = ", max)


#반복구조
#for문
for ( i in  1:10 ){
  print( '*' )
}



multiple = 2
for ( i in 2:9 ){
  cat ( multiple, ' x ', i, ' = ', multiple * i, '\n')
}

#while문
i <- 1
while ( i <= 10 ) {
  print(i)
  i <- i+1          # i = 반복제어 변수
}


multiple <- 2
i <- 2
while (i <= 9) {
  cat ( multiple, ' x ', i, ' = ', multiple * i, '\n')
  i<-i+1
}


# 1부터 100까지 10단위로 출력. 총 10줄. for문 이용.
for ( i in 1:100) {
  cat (i, ' ')
  if ( i %% 10 == 0){
    print('\n')
  }
}

# 강사님_1
#lineCount <- 1
#for ( i in 1:100 ) {
#   cat(i,' ')
#   lineCount <- lineCount + 1
#   if ( lineCount > 10 ) {
#     print('\n')
#     lineCount <- 1        #Reset
#   }
#}


count = 0
for (i in 1:1000){
  if ( i %% 3 == 0 | i %% 5 == 0){
    cat(i, '')
    count = count+1
    if (count %% 10 == 0){
      print('\n')
    }
  }
}
#print(count)
cat('1-1000 사이의 3의 배수와 5의 배수의 개수 : ', count, '개\n')
















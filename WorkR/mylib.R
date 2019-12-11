#
#mylib.R

# 최대값 구하는 함수
my_max <- function(x,y){         # 함수 정의
  num.max <- x
  if ( y > num.max ){
    num.max <- y
  }
  return ( num.max )
}

# 나눗셈 함수
my_div <- function (x,y = 2) {     # defualt  값 설정
  result <- x / y
  
  return ( result )
}




































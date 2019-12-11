
# 이름 : 이윤지
# 작성일 : 2019. 11. 28
# 제출일 : 2019. 11. 29



#문제 1)
#1-1
d1 <- 1:50;     d2 <- 51:100
d1;     d2

#1-2
length(d2)

#1-3
D_sum <- d1 + d2;   D_sum # 합
D_sub <- d2 - d1;   D_sub # 빼기
D_mul <- d1 * d2;   D_mul # 곱
D_div <- d2 / d1;   D_div # 나누기

#1-4
d1_sum <- sum(d1); d1_sum
d2_sum <- sum(d2); d2_sum

#1-5
D_Total <- sum(d1,d2); D_Total
#sum( c( d1, d2 ) )

#1-6
D2_max <- max(d2);  D2_max # 최대값
D2_min <- min(d2);  D2_min # 최소값

#1-7
d1_mean <- mean(d1);  d1_mean
d2_mean <- mean(d2);  d2_mean
print(abs(d2_mean - d1_mean))

#1-8
print( sort(d1, decreasing = TRUE) )

#1-9
srt_d1 <- sort(d1, decreasing = FALSE);   srt_d2 <- sort(d2, decreasing = FALSE)
srt_d1;   srt_d2
d3_d1 <- head(srt_d1,10);      d3_d1
d3_d2 <- head(srt_d2,10);      d3_d2
#d3 <- c( sort(d1)[1:10], sort(d2)[1:10] );   d3

# -------------------------------------------------------------------------------------


#문제 2)
v1 <- 51:90; v1

#2-1
print( v1[v1 < 60] )

#2-2
sum( v1 < 70 )

#2-3
sum( v1[ v1 > 65 ])

#2-4
print( v1[v1 > 60 & v1 < 73])

#2-5
print( v1[v1 < 65 | v1 > 80] )

#2-6 : 7로 나누었을때 나머지가 3인 수를 모두 출력
v1 <- 51:90
for ( i in v1 ){
  if ( i %% 7 == 3){
    cat(i,'')
  }
}
# v1[ v1 %% 7 == 3 ]


#2-7 : 7의 배수들의 값을 0으로 변경
v1 <- 51:90;
for ( i in 1:length(v1) ){
  if ( i %% 7 == 0 ){
    v1[i-1] <- 0
  }
}
v1

#v1[ v1 %% 7 == 0 ] <- 0
#v1


#2-8
v1 <- 51:90;
v_sum = 0
for ( i in v1){
  if ( i %% 2 == 0 ){
    v_sum = v_sum + i
  }
}
v_sum
# sum( v1[ v1 %% 2 == 0 ] )


#2-9 : 홀수이거나 80보다 큰 수 모두 출력
v1 <- 51:90;
odd <- v1 %% 2 != 0 | v1 > 80 ; odd
v1[ odd ]

# v1[ v1 %% 2 == 1 | v1 > 80 ]


#2-10 
v1 <- 51:90;
for ( i in v1){
  if ( i %% 3 == 0 & i %% 5 == 0 ){
    cat(i,'')
  }
}
# v1[ v1 %% 3 == 0 & v1 %% 5 == 0 ]

#2-11
v1 <- 51:90;
for ( i in 1:length(v1) ){
  if ( i %% 2 == 0 ){
    v1[i] = v1[i] * 2
  }
}
v1
# 짝수에 대해서만 2를 곱해서 저장
# v1[ v1 %% 2 == 0 ] <- v1[ v1 %% 2 == 0 ] * 2; v1


#2-12 - 7의 배수들을 제거한 후 v1 내용 출력
v1 <- 51:90;
v1_zero <- v1[ v1 %% 7 == 0 ] # 제거해야 하니까 치환해야 함.
#v1_zero
setdiff(v1,v1_zero)



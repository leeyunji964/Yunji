# 이름 : 이윤지
# 작성일 : 2019. 12. 18
# 제출일 : 2019. 12. 18

# 문1)
# R에서 제공하는 state.x77 데이터셋에 대해 k-평균 군집화를 실시하고 결과를 그래프로 출력하시오.
# • 군집의 수는 5로 한다.
# • state.x77은 각 변수(열)의 값들의 단위의 차이가 많이 나기 때문에 0~1 표준화를 실시한 후 군집화를 실행한다.

data <- state.x77

std <- function( x ){
  return ( ( x - min(x) ) / (max(x) - min(x) ) )
}

data <- apply( data,2,std)
fit <- kmeans( x = data, center = 5 )

fit$cluster; fit$centers

library( cluster )
clusplot( data, fit$cluster, color = TRUE, shade = TRUE, labels = 2, lines = 1)



# 문2)
# mlbench 패키지에서 제공하는 Sonar 데이터셋에 대해 k-평균 군집화를 실시하고 결과를 그래프로 출력하시오.
# • 군집의 수는 2로 한다.
# • Sonar 데이터셋에서 마지막에 있는 Class 열은 제외하고 군집화를 실행한다.
library( mlbench )
data( "Sonar" ) 			# 데이터셋 불러오기

data_s <- Sonar[,1:length(Sonar)-1]
data_s

fit_s <- kmeans( x= data_s, centers = 2)

clusplot( data_s, fit_s$cluster, color = TRUE, shade = TRUE, labels = 1, lines = 1)




# 문3) 
# mlbench 패키지에서 제공하는 Sonar 데이터셋에 대해 k-최근접 이웃 알고리즘을 이용하여 모델을 만들고 예측 정확도를 측정하시오.
# . Sonar 데이터셋에서 마지막에 있는 Class 열이 그룹 정보이다.
# . Sonar 데이터셋에서 홀수 번째 데이터(관측값)를 훈련용 데이터로 하고, 짝수번째 데이터(관측값)를 테스트용 데이터로 한다.
# . k-최근접 이웃에서 k를 3, 5, 7로 다르게 하여 예측 정확도를 비교한다.

s <- as.integer(rownames(Sonar))
#짝수
se <- subset(s, s%%2 == 0)
se

#홀수
so <- subset(s, s%%2 != 0)
so

s.tr <- Sonar[so,1:60]; s.tr #훈련용
s.ts <- Sonar[se,1:60]; s.ts #테스트용

gr.tr <- factor( Sonar[so,61] ); gr.tr
gr.ts <- factor( Sonar[se,61] ); gr.ts

s_pred3 <- knn( s.tr, s.ts, gr.tr, k = 3, prob = TRUE)
s_pred5 <- knn( s.tr, s.ts, gr.tr, k = 5, prob = TRUE)
s_pred7 <- knn( s.tr, s.ts, gr.tr, k = 7, prob = TRUE)
  
acc3 <- mean( s_pred3 == gr.tr ); acc3 # 예측도 : 0.8365385
acc5 <- mean( s_pred5 == gr.tr ); acc5 # 예측도 : 0.7596154
acc7 <- mean( s_pred7 == gr.tr ); acc7 # 예측도 : 0.7211538



# 문4) 
# mlbench 패키지에서 제공하는 Sonar 데이터셋에 대해 k-최근접 이웃 알고리즘을 이용하여 모델을 만들고 예측 정확도를 측정하시오.
# . Sonar 데이터셋에서 마지막에 있는 Class 열이 그룹 정보이다.
# . k-최근접 이웃에서 k는 3으로 한다.
# . 5-fold 교차 검증 방법으로 예측 정확도를 측정한다.

#install.packages( "cvTools")
library(cvTools)

k = 5
s_fold <- cvFolds( nrow(Sonar), K = k )

acc_s <- c()
for( i in 1:k ){
  ts.idx <- folds$which == i
  ds.tr <- Sonar[ -ts.idx, 1:60 ]
  ds.ts <- Sonar[ ts.idx, 1:60 ]
  cl.tr <- factor( Sonar[ -ts.idx, 61 ] )
  cl.ts <- factor( Sonar[ ts.idx, 61 ] )
  pred <- knn( ds.tr, ds.ts, cl.tr, k=3 )
  acc_s[i] <- mean( pred == cl.ts ) # 예측 정확도
}
acc_s
mean(acc_s)
# 예측 정확도 평균 : 0.8952381







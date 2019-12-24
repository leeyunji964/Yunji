# 16일차
# 클러스터링
# 군집화( Clustering ) / 분류(Classification)
#
# 군집화( Clustering) : 주어진 대상 데이터들을 유사성이 높은 것끼리 묶어주는 기술
#                       ( 군집, 범주, 그룹 )
#
# K-means(평균) 군집화 알고리즘

mydata <- iris[,1:4]
fit <- kmeans( x= mydata, center = 3) # center = 3 : 3개의 그룹으로 나눠라
fit

# K-means clustering with 3
# clusters of sizes 50, 62, 38 : 3개 군집에 속한 데이터 개수
# 
# Cluster means: -> 3개 군집의 중심점 좌표
#   Sepal.Length Sepal.Width Petal.Length Petal.Width
# 1     5.006000    3.428000     1.462000    0.246000
# 2     5.901613    2.748387     4.393548    1.433871
# 3     6.850000    3.073684     5.742105    2.071053
# 
# Clustering vector: -> 각 데이터에 대한 군집번호
#   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2
# [52] 2 3 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 2
# [103] 3 3 3 3 2 3 3 3 3 3 3 2 2 3 3 3 3 2 3 2 3 2 3 3 2 2 3 3 3 3 3 2 3 3 3 3 2 3 3 3 2 3 3 3 2 3 3 2
# 
# Within cluster sum of squares by cluster:
#   [1] 15.15100 39.82097 23.87947
# (between_SS / total_SS =  88.4 %)
# 
# Available components:
#   
#   [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss" "betweenss"   
# [7] "size"         "iter"         "ifault"

fit$cluster
fit$centers

library( cluster )
clusplot( mydata,                  # 군집대상
          fit$cluster,             # 군집번호
          color = TRUE,            # 원의 색
          shade = TRUE,            # 원의빗급표시 유무
          labels = 1,              # 관측값 출력 형태
          lines = 1 )              # 중심선 연결 표시
subset( mydata, fit$cluster == 2 )

# 대상 데이터 표준화 후 군집화
#
#     데이터와 데이터의 거리를 계산할 때 발생하는 문제
#     모든 변수가 거리 계산에 동등한 영향을 갖도록 하기 위해서
#     모든 변수의 자료 범위를 0~1 사이로 표준화한 후 거리 계산을 한다.
#
#     ( x - min( A ) ) / ( max( A ) - min( A ) )
#     x : 변수 A 의 임의의 관측값
#     max( A ), min( A )는 변수 A  관측값 중 최대/최소값

std <- function( x ){
  return ( ( x - min( x ) ) / ( max( x ) - min( x ) ) )
}

mydata <- apply( iris[,1:4],2,std)
fit <- kmeans( x = mydata, center = 3 )
fit

#
# KNN( K-Nearest Neighbor, K-최근접 이웃) 분류 알고리즘
#
library( class )
# 훈련용/테스트용 데이터 준비
tr.idx <- c( 1:25, 51:75, 101:125 )
ds.tr <- iris[ tr.idx, 1:4 ] #훈련용
ds.ts <- iris[ -tr.idx, 1:4] #테스트용
cl.tr <- factor( iris[ tr.idx, 5 ] )  # 훈련용 그룹정보
cl.ts <- factor( iris[ -tr.idx, 5 ] ) # 테스트 그룹정보
pred <- knn( ds.tr, ds.ts, cl.tr, k = 3, prob = TRUE )
pred
acc <- mean( pred == cl.ts )
acc   # 예측 정확도 : 0.92
table( pred, cl.ts )

# cl.ts
# pred         setosa versicolor virginica
# setosa         25          0         0
# versicolor      0         23         4
# virginica       0          2        21

# 대각선이 맞춘 값, 대각선이 아닌 건 못 맞춘 값.

#
# 교차 검증 방법( K-fold cross Validation )
#
install.packages( "cvTools")
library(cvTools)

k = 10
folds <- cvFolds( nrow( iris ), K = k )

acc <- c() # 
for( i in 1:k ){
  ts.idx <- folds$which == i
  ds.tr <- iris[ -ts.idx, 1:4 ]
  ds.ts <- iris[ ts.idx, 1:4 ]
  cl.tr <- factor( iris[ -ts.idx, 5 ] )
  cl.ts <- factor( iris[ ts.idx, 5 ] )
  pred <- knn( ds.tr, ds.ts, cl.tr, k=5 )
  acc[i] <- mean( pred == cl.ts ) # 예측 정확도
}
acc # 폴드별 예측 정확도
mean( acc ) # 폴드평균 예측정확도

# p.512 ~55455













                                                                                              







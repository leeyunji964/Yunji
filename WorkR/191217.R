#
# 다중선형 회귀분석 (multiple linear regression analysis)
#
# 다중성행 회귀모델 : 여러 개의 독립변수를 다루는 회귀모델
#
# 회귀식
# y = B0 + B1X1 + B2X2 + B3X3 + ... +BnXn
#
# 독립변수가 n개인 다중선형 회귀에서 주어진 자료를 이용해
# B0.B1,B2,B3, .... , Bn의 값을 알아내는 회귀모델
library( tidyverse )
library( car )

str( Prestige )
head( Prestige )

newdata <- Prestige[,c(1:4)]
head(newdata)
plot( newdata, pch = 16, col = 'blue', main = "Matrix Scatterpolt")
정
model <- lm( income ~ education + prestige + women,
             data = newdata )
model
# (Intercept)    education     prestige        women  
# -253.8          177.2        141.4          - 50.9 

coef(model)
# (Intercept)   education    prestige       women 
#  -253.8497    177.1990      141.4354      -50.8957

#회귀식
#income = (-253.8497) + 
          # (177.1990 * newdata$education) +
          # (141.4354*newdata$prestige) -
          # (50.8957 * newdata$women)
# 예측치
fitted( model)
# 실제값과의 차이
residuals( model )
# 잔차
deviance( model ) / length( newdata$education ) # 평균제곱오차

summary( model )
#               Estimate Std. Error t value Pr(>|t|)    
# (Intercept)   -253.850   1086.157  -0.234    0.816    
# education    177.199      187.632   0.944    0.347    
# prestige     141.435      29.910   4.729 7.58e-06 ***
#   women        -50.896      8.556  -5.948 4.19e-08 ***

newdata2 <- Prestige[, c(1:5)]
model2 <- lm( income~., data=newdata2)
summary( model2 )
#              Estimate   Std. Error  t value   Pr(>|t|)    
#(Intercept)  -1.068e+03  2.849e+03  -0.375     0.709  

library( MASS )
# 단순하고 더 설명력이 높은, 더 적합한 모델을 선별
# 부적절한(기여도가 낮은) 자료는 제거하고 모델 생성 - stepAIC
model3 <- stepAIC( model2 )
summary(model3)
#             Estimate  Std. Error t value  Pr(>|t|)    
#(Intercept)  431.574    807.630   0.534    0.594  

# model2 Estimate : -1.068e+03 < model 3 Estimate : 431.574

# ** Linear Regression : 연속형 data에 대한 예측
# ** Logical Regression : 범주형 data에 대한 예측
#  => 결과값을 범주형태로 변환 => "one-hot encoding" : 0/1로 바꿔라..

# Logistic Regression(  로지스틱 회귀분석 )
#
#     회귀모델에서 종속변수의 값의 형태가 범주형인 경우의 예측모델
#     주어진 data로부터 어떤 범주를 예측하는 분야를 회귀와 구분하여 분류(classification)이라고 한다.
#
#     로지스틱 회귀도 기본적으로 회귀 기법이기 때문에 종속변수는 숫자로 표현되어야 한다.
#     예) YES와 NO는 0과 1로 setosa, versicolor, virginica는
#          1,2,3과 같이 숫자로 바꾼 후에 로지스틱 회귀 적용

iris.new <- iris
iris.new$Species <- as.integer( iris.new$Species )
head( iris.new )

#Logistic Regression
iris_model <- glm( Species ~., data = iris.new )
# glm() : 로지스틱 회귀분석에서 사용하는 lm()함수 같은 회귀식 생성 함수 ** Y값이 범주형 data여야 함.
iris_model
coef( iris_model )
summary( iris_model )

unknown <- data.frame( rbind( c(5.1, 3.5, 1.4, 0.2) ) )
names(unknown) <- names( iris )[1:4]
unknown

pred <- predict( iris_model, unknown )
# predict( 선형모델, 예측을 수행할 새로운 데이터) : 새로운 데이터에 대한 예측값을 구하는 함수
pred
#결과 값
# 1
# 0.9174506 << 무슨 의민지 ㅠㅡㅠ,,
round( pred, 0) # 반올림
# 1 
# 1  >> 이 데이터를 갖고있는 건 1번 품종이다..!
pred <- round( pred, 0 )
levels( iris$Species )[pred]
# levels 결과 : "setosa"

test <- iris[, 1:4]
test

pred <- predict( iris_model, test )
pred <- round( pred, 0 )

answer <- as.integer( iris$Species )
pred == answer
acc <- mean( pred == answer )
acc #  예측 성공률



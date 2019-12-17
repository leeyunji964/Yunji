#
# day14_answer.R
#
# 단순선형 회귀분석 실습
#
#문1)
#   state.x77 데이터셋에서 문맹률(Illiteracy)을 이용해 범죄율(Murder)을 예측
#   하는 단순선형 회귀모델을 만드시오. 그리고 문맹률이 0.5, 1.0, 1.5일 때 범
#   죄율을 예측하여 보시오.
str( state.x77 )
head( state.x77 )

state.x77_df <- data.frame( state.x77 )
str( state.x77_df )
head( state.x77_df )

state.x77_model <- lm( Murder~Illiteracy , data = state.x77_df )
plot( Murder~Illiteracy , data = state.x77_df )
abline( state.x77_model )

coef( state.x77_model )
# (Intercept)  Illiteracy 
#    2.396776    4.257457
summary( state.x77_model )
#               Estimate Std. Error   t value   Pr(>|t|)    
# (Intercept)   2.3968        0.8184   2.928   0.0052 ** 
# Illiteracy    4.2575        0.6217   6.848   1.26e-08 ***

# 회귀식
Murder = 4.257457 * state.x77_df$Illiteracy + 2.396776
Murder
# 훈련 data에 있는 샘플에 대한 예측값
fitted( state.x77_model )
# 잔차 : 실제 값과 회귀식으로 추정된 값과의 차이
residuals( state.x77_model )


# 범죄율 예측
Illiteracy_df <- data.frame( Illiteracy = c( 0.5, 1.0, 1.5 ) )
# state.x77_model에서 illteracy_df가 0.5,1.0,1.5인 예측 값을 murder_pred에 입력(?)
Murder_pred <- predict( state.x77_model, Illiteracy_df )
Murder_pred

#문맹률 0.5 : 4.525504
#문맹률 1.0 : 6.654232
#문맹률 1.5 : 8.782961

#문2)
#   trees 데이터셋에서 나무둘레(Girth)로 나무의 볼륨(Volume)을 예측하는 단
#   선형 회귀모델을 만드시오. 그리고 나무 둘레가 8.5, 9.0, 9.5일 때, 나무의
#   볼륨(Volume)을 예측하여 보시오.
str( trees )
head( trees )

trees_model <- lm( Volume~Girth , data = trees )
plot( Volume~Girth , data = trees )
abline( trees_model )

coef( trees_model )
# (Intercept)       Girth 
# -36.943459        5.065856 
summary( trees_model )
#               Estimate Std. Error   t value Pr(>|t|)    
# (Intercept) -36.9435        3.3651  -10.98  7.62e-12 ***
#   Girth       5.0659        0.2474   20.48   < 2e-16 ***


# 회귀식
Volume = 5.065856 * trees$Girth - 36.943459
Volume
# 훈련 data에 있는 샘플에 대한 예측값
fitted( trees_model )
# 잔차 : 실제 값과 회귀식으로 추정된 값과의 차이
residuals( trees_model )

# 볼륨 예측
Grith_df <- data.frame( Girth = c( 8.5, 9.0, 9.5 ) )
Volume_pred <- predict( trees_model, Grith_df )
Volume_pred

#나무 둘레 8.5 : 6.116320
#나무 둘레 9.0 : 8.649249
#나무 둘레 9.5 : 11.182177

#문3) 
#   pressure 데이터셋에서 온도(temperature)로 기압(pressure)을 예측하는 단
#   순선형 회귀모델을 만드시오. 그리고 온도가 65, 95, 155일 때 기압을 예측
#   하여 보시오.
data( pressure )

str( pressure )
head( pressure )

pressure_model <- lm( pressure~temperature , data = pressure )
plot( pressure~temperature , data = pressure )
abline( pressure_model )

coef( pressure_model )
# (Intercept)   temperature 
# -147.89887     1.51242 
summary( pressure_model )
#                 Estimate Std. Error   t value Pr(>|t|)    
#   (Intercept)   -147.8989    66.5529  -2.222  0.040124 *  
#   temperature    1.5124       0.3158   4.788  0.000171 ***

# 회귀식
pressure = 1.51242 * pressure$temperature -147.89887
pressure
fitted( pressure_model )
residuals( pressure_model )

# 기압 예측
temperature_df <- data.frame( temperature = c( 65, 95, 155 ) )
pressure_pred <- predict( pressure_model, temperature_df )
pressure_pred

 #온도 65 : -49.591581
#온도 95 : -4.218984
#온도 155 : 86.526208

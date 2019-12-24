# 이름   : 이윤지
# 작성일 : 2019. 12. 16
# 제출일 : 2019. 12. 16
# 
# 문1)
# state.x77 데이터셋에서 문맹률(Illiteracy)을 이용해 범죄율(Murder)을 예측하는 단순선형 회귀모델을 만드시오.
# 그리고 문맹률이 0.5, 1.0, 1.5일 때 범죄율을 예측하여 보시오.
state <- data.frame(state.x77)
class(state)
str(state)
head(state)
plot( Murder ~ Illiteracy, data = state )

im <- lm( Murder ~ Illiteracy, state )
im
# (Intercept)   Illiteracy  
#   2.397          4.257 
abline( im, col = 'red')

coef( im )  #매개변수 출력 : w = -17.579095, b = 3.932409

# 훈련 data에 있는 샘플에 대한 예측값
fitted( im )
# 잔차 : 실제 값과 회귀식으로 추정된 값과의 차이
residuals( im )
# 평균제곱오차(MES)
deviance( im ) / length( state$Illiteracy )

b <- coef(im)[2]
W <- coef(im)[1]

stm <- data.frame( Illiteracy = c(0.5, 1.0, 1.5) )
predict( im, stm )
plot( stm$Illiteracy, predict( im, stm ), col = "blue", cex = 2, pch=20)
abline( im )


# 문2)
# trees 데이터셋에서 나무둘레(Girth)로 나무의 볼륨(Volume)을 예측하는 단선형 회귀모델을 만드시오.
# 그리고 나무 둘레가 8.5, 9.0, 9.5일 때, 나무의 볼륨(Volume)을 예측하여 보시오.
tree <- data.frame(trees)
plot( Volume~Girth, data = tree )

tr <- lm( Volume ~ Girth, data = tree )
tr
# Coefficients:
#   (Intercept):y        Girth:x
#       -36.943          5.066
abline(tr, col="blue")

coef( tr )
# W : -36.943459,   b : 5.065856
b <- coef(tr)[2]
W <- coef(tr)[1]

trGirth <- data.frame( Girth = c(8.5, 9.0, 9.5) )
trGirth
predict( tr, trGirth )
# 1         2         3 
# 6.116320  8.649249 11.182177 
plot(trGirth$Girth, predict(tr, trGirth), col = "green", cex=1, pch=19)
abline( tr )
 
# 문3) 
# pressure 데이터셋에서 온도(temperature)로 기압(pressure)을 예측하는 단순선형 회귀모델을 만드시오.
# 그리고 온도가 65, 95, 155일 때 기압을 예측하여 보시오.
pressure <- data.frame(pressure)
plot( pressure ~ temperature, data = pressure )

pr <- lm( pressure ~ temperature, data = pressure )
pr
# (Intercept)  temperature  
# -147.899        1.512 
abline( pr, col = "purple")

coef(pr)
# (Intercept) temperature 
# -147.89887     1.51242

W <- coef(pr)[1]
b <- coef(pr)[2]

P_model <- data.frame( temperature = c(65,95,155) )
P_model
predict( pr, P_model )
#     1          2          3 
# -49.591581  -4.218984  86.526208

plot( P_model$temperature, predict( pr, P_model), cex = 1.3, pch = 19)
abline( pr )
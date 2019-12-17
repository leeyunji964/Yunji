# 이름 : 이윤지
# 작성일 : 2019. 12. 17
# 제출일 : 2019. 12. 17

# 문1)
# trees 데이터셋에 대해 다음의 문제를 해결하는 R 코드를 작성하시오.
trees <- data.frame(trees)
# (1) 나무 둘레(Girth)와 나무의 키(Height)로 나무의 볼륨을 예측하는 다중선형 회귀모델을 만드시오.
trees

Volume_model <- lm( Volume ~ ., data = trees)
Volume_model
# (Intercept)      Girth       Height  
#   -57.9877       4.7082      0.3393

coef( Volume_model )
# (Intercept)       Girth      Height 
# -57.9876589   4.7081605     0.3392512

#회귀 모델 : Vol_model <- 4.7081605*trees$Girth + 0.3392512*trees$Height - 57.9876589


# (2) 다중선형 회귀모델을 이용하여 trees 데이터셋의 나무 둘레(Girth)와 나무의 키(Height)로 나무의 볼륨을 예측하시오.
Vol_model <- 4.7081605*trees$Girth + 0.3392512*trees$Height - 57.9876589
Vol_model

# (3) (2)에서 예측한 볼륨과 실제 trees 데이터셋의 볼륨(Volume)이 얼마나 차이가 나는지 보이시오.
# (예측값, 실제값, 예측값-실제값을 나타낸다.)

summary( Volume_model )
#               Estimate  Std. Error t value  Pr(>|t|)    
# (Intercept)   -57.9877   8.6382     -6.713  2.75e-07 ***
#   Girth       4.7082     0.2643     17.816   < 2e-16 ***
#   Height      0.3393     0.1302      2.607    0.0145 *  

#예측치 : predict()
predict( Volume_model, trees )
# 예측값 - 실제값 : residuals()
residuals( Volume_model )



# 문2)
# mtcars 데이터셋에서 다른 변수들을 이용하여 연비(mpg)를 예측하는 다중 회귀모델을 만드시오.
mt <- mtcars
mt
# (1) 전체 변수를 이용하여 연비(mpg)를 예측하는 회귀모델을 만들고 회귀식을 나타내시오.
mtc <- lm( mpg ~ ., data = mt )

coef(mtc)
# (Intercept)         cyl        disp          hp        drat          wt        qsec  vs          am        gear 
# 12.30337416 -0.11144048  0.01333524 -0.02148212  0.78711097 -3.71530393  0.82104075  0.31776281  2.52022689  0.65541302 
# carb 
# -0.19941925

# 회귀식 : mpg = 12.30337416 -0.11144048*mt$cyl + 0.01333524*mt$disp
#                -0.02148212*mt$hp + 0.78711097*mt$drat -3.71530393*mt$wt
#                + 0.82104075*mt$qsec + 0.31776281*mt$vs + 2.52022689*mt$am
#                + 0.65541302*mt$gear - 0.19941925*mt$carb


# (2) 연비(mpg)를 예측하는 데 도움이 되는 변수들만 사용하여 예측하는 회귀모델을 만들고 회귀식을 나타내시오.
library( MASS )
mtc2 <- stepAIC( mtc )
mtc2
# (Intercept)     wt         qsec           am  
#   9.618       -3.917      1.226        2.936 

#회귀식 : mpg = 9.618 - 3.917*mt$wt + 1.226*mt$qsec + 2.936*mt$am


# (3) (1), (2)에서 만든 예측모델의 설명력(Adjusted R-squared)을 비교하시오.
summary( mtc )
# Adjusted R-squared:  0.8066
summary( mtc2 )
# Adjusted R-squared:  0.8336 

# mtc2의 설명력이 더 좋아졌다.
 
# 문3) 
# UCLA 대학원의 입학 데이터를 불러와서 mydata에 저장한 후 다음 물음에 답하시오.
 
mydata <- read.csv( "https://stats.idre.ucla.edu/stat/data/binary.csv" )
head(mydata)

# (1) gre, gpa, rank를 이용해 합격 여부(admit)를 예측하는 로지스틱 모델을 만드시오(0: 불합격, 1:합격).
m_model <- glm(admit ~ ., data = mydata )
coef(m_model)
# (Intercept)           gre           gpa          rank 
# -0.1824126752  0.0004424258  0.1510402328 -0.1095019242 
mpred <- predict( m_model, mydata)
mpred <- round(mpred)


# (2) mydata에서 합격 여부(admit)를 제외한 데이터를 예측 대상 데이터로 하여 (1)에서 만든 모델에 입력하여 
# 합격 여부를 예측하고 실제값과 예측값을 나타내시오.

md <- mydata[,-1]
head(md)

predm <- predict( m_model, md)
predm

predm<-round(predm, 0)
predm

# 
# (3) 만들어진 모델의 예측 정확도를 나타내시오.
answer <- mydata$admit
predm == answer
acc <- mean( predm == answer )
acc #  예측 성공률

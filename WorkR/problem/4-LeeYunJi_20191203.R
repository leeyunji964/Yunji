# 이름 : 이윤지
# 작성일 : 2019. 12. 03
# 제출일 : 2019. 12. 03
#
#문1)
#다음은 직장인 10명의 수입과 교육받은 기간을 조사한 자료이다.
#산점도와 상관계수를 구하고, 수입과 교육기간 사이에 어떤 상관관계가 있는지 설명하시오.

#수입 	 121 99 41 35 40 29 35 24 50 60
#교육기간 19 20 16 16 18 12 14 12 16 17

income <- c(121, 99, 41, 35, 40, 29, 35, 24, 50, 60)
edu <- c(19, 20, 16, 16, 18, 12, 14, 12, 16, 17)

inc.edu <- data.frame( income, edu)
inc.edu

class(inc.edu)
str(inc.edu)

plot(edu ~ income, col = "red", pch = 19)     # 산점도
#plot( income ~ edu, col = "blue", pch= 19)

res_edu <- lm( edu ~ income, data = inc.edu)  # 회귀식 도출
res_edu                                       # 회귀식 :  y = 0.06725x + 12.40872
abline(res_edu)                               # 회귀선 그리기 

cor(inc.edu[ ,1:2])                           # 이변량 변수 상관계수 구하기 : 0.7929108
cor(income, edu)

# 수입과 교육기간 사이의 상관계수는 0.79로 수입이 많아질수록, 교육시간 또한 길어짐을 도출할 수 있다.



#------------------------------------------------------------------------------------------

#문2)
#다음은 대학생 10명의 성적과 주당 TV 시청시간을 조사한 자료이다. 산점도와 상관계수를 구하고, 
#성적과 TV 시청시간 사이에 어떤 상관관계가 있는지 설명하시오.

#성적 	 77.5 60 50 95 55 85 72.5 80 92.5 87.5
#시청시간 14   10 20  7 25  9 15   13  4   21

score <- c(77.5, 60, 50, 95, 55, 85, 72.5, 80, 92.5, 87.5)
watch <- c(14, 10, 20, 7, 25, 9, 15, 13, 4, 21)

sw <- data.frame( score, watch )
class(sw);          str(sw);      dim(sw)

plot( score ~ watch, data = sw, col = "blue", pch = 19 )      # 산점도

res_sw <- lm( score ~ watch, data = sw )
res_sw                                                        # 기울기 : -1.494, x절편 : 96.117
abline(res_sw)

cor( sw[ , 1:2 ] )                                            # 상관계수 : -0.6283671
cor( score, watch)

# 결과 : 시청시간과 성적간의 상관계수는 -0.63으로, 음의 상관관계를 띈다.
#        따라서 시청시간이 길어질수록 성적은 떨어지는 것을 알 수 있다.


#------------------------------------------------------------------------------------------

#문3) 
#R에서 제공하는 mtcars 데이터셋에서 mpg와 다른 변수들 간의 상관계수를 구하시오.
#어느 변수가 mpg와 가장 상관성이 높은지 산점도와 함께 설명하시오.		

data(mtcars)
mtcars
#mt <- data.frame(mtcars[-1])
#mt

pairs(mtcars[,-c(7:10)])

#cor( mtcars[,-c(7:10)])

cor( mtcars )
cor( mtcars )[1,2:length(mtcars)]


# mpg와 cyl 상관계수 : -0.852,                mpg와 disp 상관계수 : -0.847
# mpg와 hp  상관계수 : -0.78,                mpg와 drat 상관계수 :  0.68
# mpg와 wt  상관계수 : -0.87,                mpg와 carb 상관계수 : -0.55
# qsec : 0.42     # vs : 0.66       # am : 0.60   # gear : 0.48

# 결과 : mpg와 가장 상관성이 높은 것은 양(+) : drat(0.68), 음(-) : wt(-0.87)



#------------------------------------------------------------------------------------------

#문4)
#다음은 2015년부터 2026년도까지의 예상 인구수 추계자료이다.
#연도를 x축으로 하여 선그래프를 작성하시오.

#연도		총인구 (천명)		연도		총인구 (천명)
#2015		51014				2021		52123
#2016		51245				2022		52261
#2017		51446				2023		52388
#2018		51635				2024		52504
#2019		51811				2025		52609
#2020		51973				2026		52704

year <- c( 2015:2026 )
people <- c( 51014, 51245, 51446, 51635, 51811, 51973, 52123, 52261, 52388, 52504, 52609, 52704 )

exp <- data.frame( year, people );          exp

plot( people ~ year, data = exp, col="purple", pch = 19)            # 산점도
#plot( year, people, type = 'l', main = "인구수 추계")

res_exp <- lm( people ~ year, data = exp )                          # 회귀식 도출
res_exp
abline(res_exp)                                                     # 회귀선

cor( exp[,1:2])                                                     # 상관계수 : 0.99


#------------------------------------------------------------------------------------------

#문5)
#R에서 제공하는 trees 데이터셋에 대해 다음 문제를 해결하기 위한 R 코드를 작성하시오.

#(1) 나무의 지름(Girth)과 높이(Height)에 대해 산점도와 상관계수를 보이시오.
trees

class( trees )
dim( trees )
str( trees )
head( trees )
tail( trees )


plot( Height ~ Girth, data = trees, col = "green", pch = 19)        # 산점도
#tbl <- data.frame( trees$Girth, trees$Height );    tbl
#lot( trees$Girth, trees$Height )

res_tree <- lm( Height ~ Girth, data = trees )                      # 회귀식 도출
res_tree
abline(res_tree)                                                    # 회귀선

# [ 강사님 ]
# plot( trees.Girth~trees.Height, data = tbl )
# res <- lm( trees.Girth~trees.Height, data = tbl )
# abline( res )

cor(trees[,1:2])
#cor( trees$Girth, trees$Height )

# 상관계수 : 0.52 (= 0.5192801 )

#(2) trees 데이터셋에 존재하는 3개 변수 간의 산점도와 상관계수를 보이시오.

# plot( Height ~ Girth+Volume, data = trees)
plot( trees )   # 산점도
pairs( trees )  # 산점도
cor(trees )     # 상관계수

#           Girth    Height    Volume
# Girth  1.0000000 0.5192801 0.9671194
# Height 0.5192801 1.0000000 0.5982497
# Volume 0.9671194 0.5982497 1.0000000





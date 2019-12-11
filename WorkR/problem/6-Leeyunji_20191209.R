# 이름 : 이윤지
# 작성일 : 2019. 12. 09
# 제출일 : 2019. 12. 10

# 문1)
# R에서 제공하는 mtcars 데이터셋에서 gear(기어의 수)에 대해 ggplot으로 막대그래프를 작성하시오.
# 단, 제목과 x축 레이블은 ‘기어의 수’, y축 레이블은 ‘빈도수’로 나타내시오.
# bar = 범주형
head(mtcars)
str(mtcars)

ggplot( data = mtcars ) +
    geom_bar( aes( x = gear )) +
    ggtitle("기어의 수") + 
    labs( x = "기어의 수", y = "빈도수")

# 문2)
# R에서 제공하는 mtcars 데이터셋에서 cyl(실린더의 수)에 대해 막대 색이
# 초록색인 막대그래프를 ggplot으로 작성하시오.

ggplot( data = mtcars ) +
    geom_bar( aes( x = cyl), fill = "green")


# 문3) 
# R에서 제공하는 mtcars 데이터셋에서 mpg(연비)에 대해 구간 간격이 5.0인 히스토그램을 ggplot으로 작성하시오.
ggplot( data = mtcars ) +
    geom_histogram( aes(x = mpg), binwidth = 5.0)


# 문4) R에서 제공하는 trees 데이터셋의 Girth(나무 둘레)에 대해 ggplot으로 히스토그램을 작성하시오.
# 여기에서는 히스토그램의 제목, x축 레이블, y축 레이블을 한글로 표시하시오.
# (구간 간격은 3.0, 막대의 색은 steelblue로 한다.)

ggplot( trees, aes( x = Girth) ) +
    geom_histogram(binwidth = 3.0,
                   fill = "steelblue") +
    ggtitle("나무 둘레별 개수") + 
    labs(x = "나무 둘레", y = "개수" )

# 문5) R에서 제공하는 mtcars 데이터셋에서 mpg(연비)를 x축으로 하고,
# wt(중량)를 y축으로 하는 산점도를 ggplot으로 작성하시오.
# (단, 점의 색은 gear의 수에 따라 다르게 표시한다.)

gr <- as.factor(mtcars$gear)
ggplot( mtcars, aes( x = mpg, y = wt, color = gr) ) +
    geom_point()

 
# 문6)
# R에서 제공하는 mtcars 데이터셋에서 mpg(연비)에 대해 ggplot으로 상자그림을 작성하되,
# cyl(실린더 수)에 따라 그룹을 나누어 작성하시오.
ggplot( mtcars, aes( y = mpg, group = cyl, fill = factor( mtcars$cyl ) ) )+
  geom_boxplot() +
  guides( fill = guide_legend( title = "실린더수" ) ) # <- 범례 : 이거 할 거면  fill 해야 함.


# 문7) 
# 다음은 2015년부터 2026년도까지의 예상 인구수 추계 자료이다.
# 연도를 x축으로 하여 ggplot으로 선그래프를 작성하시오.
# 
# 연도		총인구 (천명)		연도		총인구 (천명)
# 2015		51014				2021		52123
# 2016		51245				2022		52261
# 2017		51446				2023		52388
# 2018		51635				2024		52504
# 2019		51811				2025		52609
# 2020		51973				2026		52704

year <- 2015:2026
pop <- c(51014,51245,51446,51635,51811,51973,52123,52261,52388,52504,52609,52704)

expect <- data.frame( year, pop)
class(expect)
   
ggplot( expect, aes( x = year, y = pop )) +
    geom_line()


# 문8) 다음과 같이 데이터셋 us를 생성한 후 물음에 답하시오.
# 여기서 state.x77은 미국 50개 주의 통계정보가, state.division은 미국 50개 주의 지역 구분
# (예: 북부, 중부, 남부……) 정보가 저장된 데이터셋이다.
 
us <- data.frame(state.x77, state.division)
 
# (1) 미국 50개 주에 대해 각각의 주들이 지역구분별로 묶인 트리맵을 작성하시오.
# 또한, 타일의 면적은 Population(인구수), 타일의 색은 Income(소득)으로 나타내고,
# 각각의 타일에는 주의 이름을 표시하시오. 마지막으로 이 트리맵에서 관찰할 수 있는 것이 무엇인지 설명하시오

install.packages("treemap")
library(treemap)

us <- data.frame( us, usname = rownames( us ) )
str(us)

treemap( us, index = c("state.division","usname"),
         vSize = "Population",
         vColor = "Income",
         type = "value",
         bg.labels = "white",
         title = "US")


#관찰할 수 있는 것 : 사각형이 클 수록 인구수가 많고, 색이 진할 수록 소득이 높다는 것을 알 수 있다.


# (2) 미국 50개 주에 대해 각각의 주들이 지역구분별로 묶인 트리맵을 작성하시오.
# 또한, 타일의 면적은 HS.Grad(고등학교 졸업률), 타일의 색은 Murder(범죄률)로 나타내고,
# 각각의 타일에는 주의 이름을 표시하시오.
# 마지막으로 이 트리맵에서 관찰할 수 있는 것이 무엇인지 설명하시오.

treemap( us, index = c("state.division","usname"),
         vSize = "HS.Grad",
         vColor = "Murder",
         type = "value",
         title = "US")

# 관찰할 수 있는 것: 사각형이 클수록 해당 지역의 고등학교 졸업률이 높으며,
# 타일의 색이 짙을수록 범죄률이 높다는 것을 알 수 있다.


# (3) us 데이터셋에 대해 x축은 Income(소득), y축은 Illiteracy(문맹률), 원의 크기는 Population(인구수),
# 원의 색은 green(초록색), 원 내부에는 주의 이름을 표시한 버블차트를 작성하시오.
# 또한 이 버블차트에서 관찰할 수 있는 것이 무엇인지 설명하시오.

symbols( us$Income, us$Illiteracy,
         circles = us$Population,
         inches = 0.3,
         fg = 0.2,
         bg = "green",
         xlab = "소득",
         ylab = "문맹률")
text( us$Income, us$Illiteracy,
      rownames(us))

# 관찰할 수 있는 것 : 인구수와 소득과 문맹률 사이의 관계에서 나타나는 변화양상을 알 수 있다.


# (4) us 데이터셋에 대해 x축은 Illiteracy(문맹률), y축은 Murder(범죄률), 원의 크기는 Area(면적),
# 원의 색은 green(초록색), 원 내부에는 주의 이름을 표시한 버블차트를 작성하시오.
# 또한 이 버블차트에서 관찰할 수 있는 것이 무엇인지 설명하시오.

symbols( us$Illiteracy, us$Murder,
         circles = us$Area,
         inches = 0.5,
         bg = "green",
         xlab = "문맹률",
         ylab = "범죄률")
text( us$Illiteracy, us$Murder,
      rownames(us))
# 관찰할 수 있는 것 : 문맹률과 범죄률, 면적 간의 관계에서 나타나는 변화양상을 알 수 있다.












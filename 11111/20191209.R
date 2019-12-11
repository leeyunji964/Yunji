# 2019년 12월 09일
# 10일차

install.packages("tidyverse")
library( tidyverse ) # 관련있는 패키지를 한 번에 전부 load함.

# tibble  : data.frame과 유사한데 좀 더 개선된 형태.

dim( mpg )
str( mpg )
head( mpg )
View( mpg )

ggplot( data = mpg ) +
    geom_point( mapping = aes( x = displ, y = hwy ) ) # geom_x()에다가 mapping을 줘도 되고

# ggplot : 기본함수 - data.frame이 들어감
# + : 함수 연결
# geom :  실제 그래프 모양을 그리는 함수

# 기본 형식 : ggplot + geom_xx( )

month <- c(1,2,3,4,5,6)
rain <- c(55,50,45,50,60,70)
df <- data.frame( month, rain )
df

ggplot( df, aes ( x = month , y = rain ) ) +    # ggplot()에다가 mapping(x,y값 설정)을 써도 됨.
    geom_bar( stat = "identity",                # y 값을 가지고 그래프를 만들어라
              width = 0.7,                      # 폭
              fill = "steelblue")               # 색상



ggplot( df, aes(x=month, y= rain) ) +
    geom_bar( stat = "identity",
              width = 0.7,
              fill = "steelblue") +
ggtitle("월별 강수량") +
theme( plot.title = element_text( size = 25,
                                  face = "bold",
                                  colour = "steelblue") ) +
labs( x = "월", y = "강수량") +                 # x lable, y lable 지정
    coord_flip()                                # x축과 y축의 구성을 뒤집어 표현하라.(그래프를 가로로 그려라)


# hist 그리기 : 연속형 변수에 대한 빈도 체크
ggplot( iris, aes( x = Petal.Length ) ) +
    geom_histogram( binwidth = 0.5)             # Petal.Length를 0.5 단위로 카운트 해라.

ggplot( iris, aes( x = Sepal.Width, fill = Species,         # fill : 막대를 채우는 색. Species = 3가지 범주형 자료. -> 1,2,3으로 들어가고 그걸 색깔 변수로 씀.
                   color = Species ) ) +                    # 막대의 경계선을 채우는 색
    geom_histogram( binwidth = 0.5, position = "dodge") +   # position : 품종별로 각각 그래프를 그려라
    theme( legend.position = "top")                         # 범례를 위(top)에다가 표시하라.


#ggplot2 Scatter chart
ggplot( data = iris, mapping = aes( x= Petal.Length,
                                    y= Petal.Width) ) +
    geom_point()

# ggplot( data = iris ) +
#     geom_point( mapping = aes( x= Petal.Length,
#                                y = Petal.Width) )         # 위의 ggplot()+geom_point의 결과값과 같음
# ggplot 쓸 때 x와 y는 필수요소 => aes


ggplot( data = iris, mapping = aes( x= Petal.Length,
                               y = Petal.Width,
                               color = Species,
                               shape = Species) ) +
    geom_point( size = 3 ) +
    ggtitle( "꽃잎의 길이와 폭" ) +
    theme( plot.title = element_text( size =25,
                                     face = "bold",
                                     colour = "red") )

# ggplot, Box plot
ggplot( data = iris, mapping = aes(y= Petal.Length) ) +
    geom_boxplot( fill = "yellow" ) 

head(iris)

ggplot( data = iris, mapping = aes(y= Petal.Length,
        fill = Species)) +
    geom_boxplot() 


# ggplot, line chart : 선 그래프
year <- 1937:1960
cnt <- as.vector( airmiles )
df <- data.frame( year, cnt )
head(df)

ggplot( df, aes( x = year, y =  cnt )) +
    geom_line( col = "red")

# ggplot 작성 graph 꾸미기 ( 공통 )
str( economics)

# 사선 - 기울기와  y값 넣어줘야 함 : 회귀식에서 도출
ggplot( economics, aes( x = date, y = psavert)) +
    geom_line() +
    geom_abline( intercept = 12.18671,
                  slope = -0.0005444)
    # intercept : y 절편값
    # slope : 기울기

# 평행선
ggplot( economics, aes( x = date, y = psavert)) +
    geom_line() +
    geom_hline( yintercept = mean(economics$psavert))

# 수직선
x_inter <- filter( economics,
                   psavert == min( economics$psavert) )$date
ggplot( economics, aes( x = date, y = psavert)) +
    geom_line() +
    geom_vline( xintercept = x_inter)


# 텍스트 추가
ggplot( airquality, aes( x= Day, y = Temp ) ) +
    geom_point() +
    geom_text( aes( label = Temp, #출력할 값 데이터 : Temp
                    vjust = 0,    # 글씨가 출력될 위치 -> 0 이면  point의 상단우측
                    hjust = 0 ) ) # vjust = -1 : 하단 좌측,  ...


# 영역 지정 및 화살표 표시 

ggplot( mtcars, aes( x= wt, y = mpg ) )+
    geom_point() +
    annotate( "rect",                           # 모양 지정 -> 사각형 : rectangle
              xmin = 3,                         # x는 3부터
              xmax = 4,                         # 4까지
              ymin = 12,                        # y는 12부터
              ymax = 21,                        # 21까지
              alpha = 0.5,                      # 0.1 ~ 1 사이 지정, 1에 가까울 수록 불투명, 0.1에 가까울 수록 투명.
              fill = "yellowgreen") +          # 영역 지정한 곳 색 채우기
    annotate( "segment", x = 2.5, xend = 3.7,
              y = 10, yend = 17, color = "red",
              arrow = arrow() ) +               # x좌표 2.5부터 3.7, y좌표 10부터 17까지 화살표 그리기.
    annotate( "text", x = 2.5, y = 10,          # 글씨 시작 위치 : x - 2.5, y - 10
              label = "point" )                 # label = "표시 될 내용"


# Tree Map : 특정 데이터셋을 기준에 의해 정리해서 전체로 보여주고 싶을 때 사용.
install.packages("treemap")
library(treemap)

data( GNI2014 )
dim( GNI2014 )
str( GNI2014 )
head( GNI2014 )
View( GNI2014 )

treemap( GNI2014,
         index = c("continent","iso3"),   # 계층구조 : continent(대륙) 밑에 iso3(국가)로 계층화
         vSize = "population",            # 타일크기 : population(인구) 수로 타일 크기 결정
         vColor = "GNI",                  # 타일컬러 : 색상은 GNI로 결정 - 짙으면 높고, 연하면 낮은 거
         type = "value",                  # 타일 컬러링 방법 : 값에 의해 결정
         bg.labels = "red",               # 레이블 배경색 : 글씨(continent) 배경색
         title = "World's GNI")           # 제목 

st <- data.frame(state.x77)
st <- data.frame( st, stname = rownames( st ) )

head(st)
treemap( st,
         index = c("stname"),
         vSize = "Area",
         vColor = "Income",
         type = "value",
         title = "미국 주별 수입" )


# 산점도에 Bubble 추가( Bubble chart ) : 값의 크기에 맞게 버블 크기를 달리함
# ggplot으로도 나타낼 수 있음 <- 품질이 좀 더 높을 수 있음음

symbols( st$Illiteracy, st$Murder,          # 원의 x,y 좌표
         circles = st$Population,           # 원의 반지름
         inches = 0.3,                      # 원 크기 조절 값 
         fg = "white",                      # 원 테두리 색 
         bg = "lightgray",                  # 원 바탕색 
         lwd = 1.5,                         # 원 테두리선 두께 
         xlab = "rate of Illiteracy",
         ylab = "crime(murder) rate",
         main = "Illiteracy and Crime" )

text(st$Illiteracy, st$Murder,              # 텍스트 출력 x,y 좌표 
     rownames( st ),                        # 출력할  text 
     cex = 0.6,                             # 폰트크기
     col = "brown" )                        # 폰트컬러 


# ggplot()
install.packages("plotly")
install.packages("viridis")
install.packages("hrbrthemes")


# Libraries
library(ggplot2)
library(dplyr)
library(plotly)
library(viridis)
library(hrbrthemes)

# The dataset is provided in the gapminder library
install.packages("gapminder")
library(gapminder)
data <- gapminder %>% filter(year=="2007") %>% dplyr::select(-year)

# Interactive version
p <- data %>%
    mutate(gdpPercap=round(gdpPercap,0)) %>%
    mutate(pop=round(pop/1000000,2)) %>%
    mutate(lifeExp=round(lifeExp,1)) %>%
    
# Reorder countries to having big bubbles on top
arrange(desc(pop)) %>%
mutate(country = factor(country, country)) %>%
    
# prepare text for tooltip
mutate(text = paste("Country: ", country, "\nPopulation (M): ", pop, "\nLife Expectancy: ", lifeExp, "\nGdp per capita: ", gdpPercap, sep="")) %>%
    
# Classic ggplot
ggplot( aes(x=gdpPercap, y=lifeExp, size = pop, color = continent, text=text)) +
    geom_point(alpha=0.7) +
    scale_size(range = c(1.4, 19), name="Population (M)") +
    scale_color_viridis(discrete=TRUE, guide=FALSE) +
    theme_ipsum() +
    theme(legend.position="none")

# turn ggplot interactive with plotly
pp <- ggplotly(p, tooltip="text")
pp

# save the widget
# library(htmlwidgets)
# saveWidget(pp, file=paste0( getwd(), "/HtmlWidget/ggplotlyBubblechart.html"))

















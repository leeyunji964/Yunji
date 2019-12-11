# 11일차

# mosaic plot
# 다중변수 범주형 데이터에 대한 각 변수의 그룹 별 비율을 면적으로 표시

str( mtcars )
head( mtcars )
mosaicplot( ~gear + vs, # 대상변수 : ~다음이 x축, + 다음이 y축 (즉, x축 = gear, y축 = vs)
            data = mtcars, # 데이터셋
            color = TRUE, # y축 변수의 그룹별 '음영' 다르게 표시
            main = "Gear and Vs") #제목/

# mosaic : 다중변수 범주형 데이터에 대한 전체적인, 상대와의 비율 확인

mosaicplot( ~ gear + vs,data = mtcars,
            color = c("yellowgreen","skyblue"),
            main = "Gear and Vs" )

# 교차표
tbl <- table( mtcars$gear, mtcars$vs )
class(tbl)

mosaicplot( tbl, color = T, main = "Gear and Vs" )
# 데이터셋 자체가 교차표 셋(table)이라서 따로 변수명을 지정할 필요가 없다.
# 3차원을 넘어가면 이해하기가 어려워서 '차원 축소'가 필요함... 
# -> 데이터 손실이 발생할 가능성이 있다. (당연히)

#
# 차원 축소 (dimension reduction)
#
install.packages("Rtsne")
library(Rtsne)
library(ggplot2)

ds <- iris[,-5] # 변수 4개 = 4차원
ds

# 차원 축소
# 1. 중복 데이터 제거
dup = which( duplicated( ds ) ) # 중복 데이터 검사
dup                             # 중복 데이터 : 143개

ds <- ds[-dup, ]                # ds에서 중복 데이터 제거
ds.y <- iris$Species[ -dup ]    # 품종 데이터만 ds.y에 담음 - 나중에 색깔 지정용으로 쓰기 위함

# 차원 축소 수행 : t-sne 함수 실행
tsne <- Rtsne( ds, #차원 축소 대상 데이터 셋
               dim = 2, # 축소할 차원 2 / 3차원 -> dim = 2 : 2차원으로 축소하겠다.
               perplexity = 10 ) # 차원 축소 과정에서 데이터 샘플링을 수행하는데 샘플의 갯수
                                 # (대상 데이터 수) / 3 보다 작게 지정
                                 # perplexity = 10 : 샘플링을 10번 했다.
tsne

# 차원축소 결과 시각화
df.tens <- data.frame( tsne$Y )
head(df.tens)

ggplot( df.tens, aes( x = X1, y = X2, color = ds.y ) )+
    geom_point( size = 2 )
# 변수가 4개니까 상관관계를 파악하기 쉽지 않다.
# 그저 이렇게 군집화가 된다. 라는 것만 해석할 수 있음.


# 3차원으로 그리기
install.packages( c("rgl","car" ) )
library( rgl )
library( car )
library( mgcv )

tsne <- Rtsne( ds, dims = 3, perplexity = 10 )
df.tsne <- data.frame( tsne$Y )
head( df.tsne )

scatter3d( x = df.tsne$X1, y= df.tsne$X2, z = df.tsne$X3 )
# 산점도를 3차원으로 그려주는 함수 : scatter3d()

#회귀면 없애기
points <- as.integer( ds.y ) # iris 데이터
color <- c('red','green','blue')
scatter3d( x = df.tsne$X1, y = df.tsne$X2,
           z = df.tsne$X3,
           point.col = color[ points ],
           surface = FALSE ) # surface = true 하면 회귀면 나옴.
# 해당하는 데이터의 분포를 알 수 있다. -> 품종별로 군집화가 이렇게 되어있다.




# 공간 시각화
#
# google map 사용
#
# 절차
# 1. R 최신버전 설치
# 2. ggplot2 최신버전 설치
# 3. ggmap 설치
# 4. 구글맵을 사용하기 위한 API Key 획득
# 5. 구글맵을 이용한 공간 시각화 수행

install.packages("ggmap")
library(ggmap)
register_google( key = 'AIzaSyDy5TVxSMCwjSz-3HjwO6bZDdQxt6klZ84' )

gc <- geocode( enc2utf8( "제주" ) ) # 한글 - > utf-8
gc
# geocode() : 어느 특정 지점의 위도와 경도를 알아와 주는 함수

class(gc) # data type = tibble = data.frame : 실제로 직접 못 씀 -> 숫자로 바꿔야 함.

cen <- as.numeric( gc ) # 경도/위도를 숫자로 변환
cen # class(cen) : numeric

# 지도 표시

map <- get_googlemap( center = cen ) # 지도 중심점 좌표
ggmap( map )


gc <- geocode( enc2utf8("한라산") )
cen <- as.numeric( gc ) # 제주의 위도와 경도를 숫자형으로 바꿔서 입력
map <- get_googlemap( center = cen,          # 지도 중심점 좌표
                      zoom = 10,             # 지도 확대 정도
                      size = c( 640, 640 ),  # 지도 크기
                      maptype = "roadmap")   # 지도 유형
ggmap( map )



cen <- c( 126.561099, 33.253077 )            # 경도, 위도 ( * 구글 맵에는 위도, 경도 순으로 나옴)
map <- get_googlemap( center = cen,
                      zoom = 18,
                      maptype = "roadmap" )
ggmap( map )

# 지도 위 마커 표시
gc <- geocode( enc2utf8("제주") )
cen <- as.numeric( gc )
map <- get_googlemap( center = cen,
                      maptype = "roadmap",
                      marker = gc,
                      zoom = 18)
ggmap( map )


names <- c( "용두암","성산일출봉","정방폭포",
            "중문관광단지","한라산1100고지","차귀도" ) # 출력할 대상

addr <- c( "제주시 용두암길 15",
           "서귀포시 성산읍 성산리",
           "서귀포시 동홍동 299-3",
           "서귀포시 중문동 2624-1",
           "서귀포시 색달동 산1-2",
           "제주시 한경면 고산리 125")                 # 출력할 대상의 실제 주소
gc <- geocode( enc2utf8( addr ) )                      # 주소들의 경도, 위도 찾기
gc


# 관광지 명칭과 좌표값으로 Data Frame 생성
df <- data.frame( name = names, lon = gc$lon,
                  lat = gc$lat )
df

cen <- c( mean( df$lon ), mean( df$lat) )

map <- get_googlemap( center = cen,
                      maptype = "roadmap",
                      zoom = 10,
                      size = c( 640, 640 ),
                      marker = gc )
ggmap( map )


# 지도에 관광지 이름 추가
gmap <- ggmap( map )
gmap +
    geom_text( data = df,               # 데이터 셋
               aes( x = lon, y = lat ), # 텍스트 위치
               size = 5,                # 텍스트 크기
               label = df$name )        # 텍스트 이름

# 지도에 데이터 표시
dim(wind)
str(wind)

sp <- sample(1:nrow(wind),50)
sp

df <- wind[sp,]
head(df)

cen <- c(mean(df$lon), mean(df$lat))
gc <- data.frame(lon = df$lon, lat = df$lat )
head(gc)
class(gc)

# 지도에 마커 표시
map <- get_googlemap( center = cen,
                      maptype = "roadmap",
                      zoom = 6,
                      marker = gc )
ggmap(map)

#지도에 풍속을 원의 크기로 표시
map <- get_googlemap( center = cen,
                      maptype = "roadmap",
                      zoom = 6)
gmap <- ggmap( map )
gmap +
    geom_point( data = df,
                aes( x = lon, y = lat, size = spd ),
                alpha = 0.5, col = "blue" ) + # alpha : 투명도
    scale_size_continuous( range = c(1,14))   #원 크기 조절



# 단계 구분도
install.packages( "ggiraphExtra" )
library(ggiraphExtra)

dim( USArrests )
str( USArrests )
head( USArrests )

library( tibble )
crime <- rownames_to_column( USArrests, var = "state" )
# 행이름을 열(값)으로 만들기. 열 이름은 state로 해서.
crime$state <- tolower( crime$state )
str(crime)

library(ggplot2)
install.packages("mapproj")
library( mapproj )

state_map <- map_data( "state" )
str( state_map )

ggChoropleth( data = crime,
              aes( fill = Murder,
                   map_id = state),
              map = state_map )

#---------------------------------------------------------- 한국 지도

install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")
devtools::install_github("cardiomoon/moonBook2")

library(kormaps2014)
library(moonBook2)

areacode
str(areacode)

library(ggplot2)
theme_set(theme_gray(base_family="NanumGothic"))

# korpop1 - 시도별
ggplot( korpop1, aes(map_id=code,fill=총인구_명) )+
    geom_map( map=kormap1, colour="black",size=0.1 )+
    expand_limits( x=kormap1$long, y=kormap1$lat )+
    scale_fill_gradientn( colours = c('white','orange','red') )+
    ggtitle("2015년도 시도별 인구분포도")+
    coord_map()

# korpop2 - 시군구
ggplot( korpop2, aes(map_id=code,fill=총인구_명) )+
    geom_map( map=kormap2, colour="black",size=0.1 )+
    expand_limits( x=kormap2$long, y=kormap2$lat )+
    scale_fill_gradientn( colours = c('white','orange','red') )+
    ggtitle("2015년도 시군구별 인구분포도")+
    coord_map()


# korpop3 - 읍면동
ggplot( korpop3, aes(map_id=code,fill=총인구_명) )+
    geom_map( map=kormap3, colour="black",size=0.1 )+
    expand_limits( x=kormap3$long, y=kormap3$lat )+
    scale_fill_gradientn( colours = c('white','orange','red') )+
    ggtitle("2015년도 읍면동별 인구분포도")+
    coord_map()



ggChoropleth(korpop2,kormap2,fillvar="남자_명")
ggChoropleth(korpop3,kormap3,fillvar="주택_계_호")














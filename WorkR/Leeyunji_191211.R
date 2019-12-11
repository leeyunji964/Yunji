# 이름 : 이윤지
# 작성일 : 2019. 12. 10
# 제출일 : 2019. 12. 11
#
#
# 
# 문1) R에서 제공하는 state.x77 데이터셋을 차원 축소하여 2차원 산점도와 3차원 산점도를 작성하시오.
# (state.x77은 매트릭스 타입이기 때문에 데이터프레임으로 변환하여 실습한다.)
state <- data.frame( state.x77 )
str(state)

# install.packages("Rtsne")
# library(Rtsne)
# library(ggplot2)

du <- which( duplicated( state ))
du # 중복데이터 없음

# 2차원 산점도 그리기
stsne <- Rtsne( state, dim = 2, perplexity = 10)
stsne

df.stsne <- data.frame(stsne$Y)
head(df.stsne)

ggplot( df.stsne, aes(x = X1, y = X2) ) +
    geom_point( size = 3)


# 3차원 산점도 그리기

# install.packages( c("rgl","car" ) )
# library( rgl )
# library( car )
# library( mgcv )

stsne3d <- Rtsne( state, dim = 3, perplexity = 10)
stsne3d

df.stsne3d <- data.frame( stsne3d$Y )
head( df.stsne3d )

scatter3d( x = df.stsne3d$X1, y = df.stsne3d$X2, z = df.stsne3d$X3)


# 문2) R에서 제공하는 swiss 데이터셋을 차원 축소하여 2차원 산점도와 3차원 산점도를 작성하시오.

str(swiss)

dim(swiss)
du_sw <- which( duplicated(swiss) )
du_sw # 중복데이터 없음

# 2차원 산점도 그리기
s_tsne <- Rtsne( swiss, dim = 2, perplexity = 10 )
s_tsne

df.s_tsne <- data.frame( s_tsne$Y )
head(df.s_tsne)

ggplot( df.s_tsne, aes( x = X1, y = X2) )+
    geom_point( size = 2)

# 3차원 산점도 그리기
s3_tsne <- Rtsne( swiss, dim = 3, perplexity = 10 )
head(s3_tsne)

df.s3_tsne <- data.frame( s3_tsne$Y )
head(df.s3_tsne)

scatter3d( x = df.s3_tsne$X1, y = df.s3_tsne$X2, z = df.s3_tsne$X3 )



# 문3) R을 이용하여 지도를 출력하시오.
# (1) 서울시청을 중심으로 지도 크기는 600x600, 지도 유형은 roadmap인 지도를 출력하시오.

# install.packages("ggmap")
# library(ggmap)
register_google( key = 'AIzaSyDy5TVxSMCwjSz-3HjwO6bZDdQxt6klZ84' )

seoul <- geocode( enc2utf8("서울특별시청"))
seoul

cen.seoul <- as.numeric( seoul )
cen.seoul

map <- get_googlemap( center = cen.seoul,
                      zoom = 18,
                      size = c(600,600),
                      maptype = "roadmap")
ggmap(map)


# (2) 금강산 지역을 근방으로 지도 크기는 500x500, 지도 유형은 hybrid, zoom은 8인 지도를 출력하시오.

geomgang <- geocode( enc2utf8("금강산") )
geomgang

cen.geomgang <- as.numeric( geomgang )

map_g <- get_googlemap( center = cen.geomgang,
                        size = c(500, 500),
                        maptype = "hybrid",
                        zoom = 8 )
ggmap(map_g)


# (3) 강남역 근방으로 지도 크기는 640x640, 지도 유형은 roadmap, zoom은 16인 지도를 출력하시오.

gangnam <- geocode( enc2utf8("강남역") )
gangnam

cen.gangnam <- as.numeric( gangnam )
cen.gangnam

mpg_gn <- get_googlemap( center = cen.gangnam,
                         size = c( 640, 640),
                         maptype = "roadmap",
                         zoom = 16)
ggmap(mpg_gn)


# (4) 지도 유형은 roadmap, zoom은 9인 경도 127.397692, 위도 36.337058 지역의 지도를 출력하시오.
lon <- 127.397692
lat <- 36.337058

region <- as.numeric(data.frame( lon, lat))
region

mpg_rg <- get_googlemap( center = region)
ggmap(mpg_rg)

# (5) 지도 유형은 roadmap, zoom은 10인 경도 135.502330, 위도 34.693594 지역의 지도를 출력하시오.
lon <- 135.502330
lat <- 34.693594

rg <- as.numeric(data.frame( lon, lat ))
rg

mpg_rg2 <- get_googlemap( center = rg,
                          maptype = "roadmap",
                          zoom = 10)
ggmap(mpg_rg2)


# 문4) R을 이용하여 서울시 한강 이남의 구청들의 위치에 마커와 구청 이름을
# 지도 위에 표시하시오.

office <- c("강서구청","구로구청","금천구청","동작구청",
            "서초구청","강남구청","송파구청","강동구청")
o_addr <- c("서울특별시 강서구 화곡6동 화곡로 302",
            "서울특별시 구로구 구로동 가마산로 245",
            "서울특별시 금천구 시흥1동 시흥대로73길 70",
            "서울특별시 동작구 노량진2동 장승배기로 161",
            "서울특별시 서초구 서초2동 남부순환로 2584",
            "서울특별시 강남구 삼성2동 학동로 426",
            "서울특별시 송파구 잠실6동 올림픽로 326",
            "서울특별시 강동구 성내동 성내로 25")

gcode <- geocode( enc2utf8( o_addr ) )
gcode

office_ad <- data.frame( name = office, lon = gcode$lon, lat = gcode$lat )
head(office_ad)

cen.of <- c( mean(office_ad$lon), mean(office_ad$lat) )
head(cen.of)

map_of <- get_googlemap( center = cen.of, maptype = "roadmap", zoom = 12,
                         marker = office_ad[,-1])
umap <- ggmap(map_of)

umap +
    geom_text( data = office_ad,
               aes( x= lon, y = lat),
               size = 5,
               label = office_ad$name)


# 문5) R을 이용하여 대한민국의 광역시를 지도 위에 출력하시오.
# 단, 마커와 광역시 이름을 함께 표시하시오.

gwang <- c("광주광역시","부산광역시","대전광역시",
           "인천광역시","울산광역시","대구광역시")

gc <- geocode( gwang )
gc

city <- data.frame( name = gwang, lon = gc$lon, lat = gc$lat )
city

cen.city <- c( mean(city$lon), mean(city$lat))

map_gwang <- get_googlemap( center = cen.city, maptype = "roadmap",
                            zoom = 6, marker = city[,-1])
gw_map <- ggmap(map_gwang)
gw_map +
    geom_text( data = city,
               aes( x = lon, y = lat),
               size = 5,
               label = city$name)


# 문6) R을 이용하여 서울, 경기, 강원 지역의 국립공원 위치를 지도 상에 마커로
# 표시하되 국립공원의 이름을 함께 표시하시오.

park <- c("북한산국립공원","연인산도립공원","머내생태공원",
          "오대산국립공원","치악산국립공원","태백산국립공원")
park_add <- c("서울특별시 성북구 정릉동 보국문로 262",
              "경기도 가평군 가평읍 승안리 308",
              "경기도 수원시 영통구 매탄동 1318",
              "강원도 평창군 진부면 오대산로 2",
              "강원도 원주시 소초면 무쇠점2길 26",
              "강원도 태백시 혈동 태백산로 4778")

gcp <- geocode( park_add )
gcp

npark <- data.frame( name = park, lon = gcp$lon, lat = gcp$lat )
npark

cen.park <- c( mean(npark$lon), mean(npark$lat) )

map_park <- get_googlemap( center = cen.park,
                           maptype = "roadmap",
                           marker = npark[,-1],
                           zoom = 8)
park_map <- ggmap(map_park)

park_map + 
    geom_text( data = npark,
               aes( x = lon, y = lat),
               label = npark$name )

# 문7) ‘2018년도 시군구별 월별 교통사고 자료’로부터
# 서울시의 각 구별 1년 교통사고 발생건수를 지도상에 원의 크기로 나타내시오.
library(ggmap)

traffic <- read.csv("D:/윤지workR/traffic.csv")
str(traffic)

st <- as.character(traffic$names)
cnt <- traffic$cntc

gct <- geocode( enc2utf8(st) )
gct

seoul_t <- data.frame( name = st, lon = gct$lon, lat = gct$lat )
seoul_t

cen.st <- c( mean( seoul_t$lon ), mean( seoul_t$lat) );         cen.st

map_st <- get_googlemap( center = cen.st,
                         maptype ="roadmap",
                         marker = seoul_t[,-1])
ggmap(map_st)

stmap <- ggmap(map_st)

stmap +
    geom_point( data = traffic,
                aes( x = lon, y = lat, size = cnt),
                alpha = 0.5, col = "blue")



# 문8)
# 7번과 동일한 자료를 이용하여 제주시 1년 교통사고 발생건수를 지도상에 원의 크기로 나타내시오.


























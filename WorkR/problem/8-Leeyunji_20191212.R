# 
# 이름 : 이윤지
# 작성일 : 2019. 12. 11 
# 제출일 : 2019. 12. 12

# 워드 클라우드( Word Cloud ) 순서
#
# 한글 워드클라우드 설치
# 1. java 실행환경 구축
# 2. 자료 수집( text 자료 )
#   2.1 text file 형태로 수집
#   2.2 web scrapping을 이용하여 수집
# 3. 명사 추출
# 4. 추출된 단어( 주로 명사 )에 대한 빈도수 계산 및 시각화
# 5. word cloud 작성
# 6. 전처리 과정 수행
#   6.1 생략된 단어를 사전에 등재
#   6.2 불필요한 단어 삭제
# 7. 다시 wordcloud 실행


# Sys.setenv( JAVA_HOME = "C:/Program Files/Java/jre1.8.0_231")
# #필요시 설치
# install.packages("wordcloud")       # word cloud
# install.packages("wordcloud2")      # word cloud
# install.packages("KoNLP")           # 한국어 처리 <- 한국어 처리시 반드시 필요
# install.packages("RColorBrewer")    # 색상 선택
# library( wordcloud )
# library( wordcloud2 )
# library( KoNLP )
# library( RColorBrewer )
# 
# library( dplyr )
# library( ggplot2 )


#
# 문1)
# 20대 국회 개원 여·야 3당 대표 국회연설문에 대해 각각 워드클라우드를 작성하시오.
# 예제소스 파일은 ‘ex_10-1.txt’, ‘ex_10-2.txt’, ‘ex_10-3.txt’이다.

buildDictionary( ext_dic = "woorimalsam")

# ex_10-1.txt
chu <- readLines("ex_10-1.txt", encoding = 'UTF-8')
chu.noun <- sapply( chu, extractNoun, USE.NAMES = F)
class(chu.noun)

# 리스트를 vector 형으로 변환
chu.n <- unlist( chu.noun ); chu.n
cwordcount <- table( chu.n ); cwordcount
sort.chu <- sort( cwordcount, decreasing = T )
sort.chu <- sort.chu[-1]
head(sort.chu)

# 불필요한 단어 삭제
chu.n <- chu.n[ nchar(chu.n) > 1 ]
chu.n <- gsub('◇','',chu.n)
chu.n <- gsub('년','',chu.n)
chu.n <- gsub('되','',chu.n)
chu.n <- gsub('드','',chu.n)
chu.n <- gsub('명','',chu.n)
chu.n <- gsub('만','',chu.n)
chu.n <- gsub('아','',chu.n)
chu.n <- gsub('오','',chu.n)
chu.n <- gsub('조','',chu.n)
chu.n <- gsub('중','',chu.n)
chu.n <- gsub('지','',chu.n)
chu.n <- gsub('패착입니다','패착',chu.n)
chu.n <- gsub('때문','',chu.n)

cwordcount <- table(chu.n)
cwordcount


pal2 <- brewer.pal( 6, 'Dark2' )
wordcloud( names(cwordcount),
           freq = cwordcount,
           scale = c( 8, 0.5 ),
           min.freq = 3,
           random.order = F,
           rot.per = 0.1,
           colors = pal2)

wordcloud2( cwordcount, size = 2 )


# ex_10-2.txt
lee <- readLines("ex_10-2.txt", encoding = 'UTF-8')
lee.noun <- sapply( lee, extractNoun, USE.NAMES = F)
head(lee.noun)
lee.n <- unlist( lee.noun ); lee.n
lwordcount <- table(lee.n)
lwordcount
sort.lee <- sort(lwordcount, decreasing = T )
sort.lee <- sort.lee[-1]

# 불필요한 단어 삭제
lee.n <- lee.n[ nchar(lee.n) > 1 ]
lee.n <- gsub('것','',lee.n)
lee.n <- gsub('되','',lee.n)
lee.n <- gsub('저','',lee.n)
lee.n <- gsub('수','',lee.n)
lee.n <- gsub('하','',lee.n)
lee.n <- gsub('등','',lee.n)
lee.n <- gsub('년','',lee.n)
lee.n <- gsub('번','',lee.n)
lee.n <- gsub('중','',lee.n)
lee.n <- gsub('거','',lee.n)
lee.n <- gsub('고','',lee.n)
lee.n <- gsub('그','',lee.n)
lee.n <- gsub('금','',lee.n)
lee.n <- gsub('긍','',lee.n)
lee.n <- gsub('라','',lee.n)
lee.n <- gsub('내','',lee.n)
lee.n <- gsub('보','',lee.n)
lee.n <- gsub('시','',lee.n)
lee.n <- gsub('중','',lee.n)
lee.n <- gsub('해왔던국회개혁과','국회개혁',lee.n)

lwordcount <- table(lee.n)
lwordcount

pal3 <- brewer.pal( 9, 'Blues')[5:9]
wordcloud( names(lwordcount), freq = lwordcount,
           scale = c(8,1), # 최대, 최소
           min.freq = 4,
           random.order = F, rot.per = .1, colors = pal3)

wordcloud2( lwordcount, size = 2 )

# ex_10-3.txt
park <- readLines("ex_10-3.txt", encoding = 'UTF-8')
park.noun <- sapply( park, extractNoun, USE.NAMES = F)
head(park.noun)
park.n <- unlist( park.noun ); park.n
pwordcount <- table( park.n )
sort.park <- sort( pwordcount, decreasing = T )
sort.park <- sort.park[-1]
sort.park

# 불필요한 단어 삭제
park.n <- park.n[ nchar(park.n) > 1 ]
park.n <- gsub('하','',park.n)
park.n <- gsub('것','',park.n)
park.n <- gsub('수','',park.n)
park.n <- gsub('한','',park.n)
park.n <- gsub('드','',park.n)
park.n <- gsub('저','',park.n)
park.n <- gsub('년','',park.n)
park.n <- gsub('대','',park.n)
park.n <- gsub('원','',park.n)
park.n <- gsub('하','',park.n)
park.n <- gsub('◇','',park.n)
park.n <- gsub('만','',park.n)
park.n <- gsub('때문','',park.n)
park.n <- gsub('등','',park.n)
park.n <- gsub('주도하','주도',park.n)
park.n <- gsub("'국민",'국민',park.n)
park.n <- gsub("'대통령",'대통령',park.n)
park.n <- gsub('40kg에','40kg',park.n)
park.n <- gsub('국민여러분께서는','국민여러분',park.n)
park.n <- gsub('더불어민주당에게도','더불어민주당',park.n)
park.n <- gsub('통령의','통령',park.n)

pwordcount <- table(park.n)
pwordcount 


wordcloud( names(pwordcount), freq = pwordcount,
           scale = c( 8, 1), min.freq = 5,
           random.order = F, rot.per = 0.1, colors = pal2)

wordcloud2( pwordcount, size = 3, shape = 'star' )


# 문2)
# 스티브 잡스의 스탠포드 대학 졸업식 연설문에 대해 워드클라우드를 작성하시오.

steve <- readLines("ex_10-4.txt", encoding = 'UTF-8')
steve

steve.noun <- sapply( steve, extractNoun, USE.NAMES = F )
head(steve.noun)
sn <- unlist( steve.noun ); sn
swordcount <- table(sn)
sort.sn <- sort( swordcount, decreasing = T )
sort.sn <- sort.sn[-3]
sort.sn

# swordcount <- table(sort.sn)
# swordcount

wordcloud( names( sort.sn ), freq = sort.sn,
           scale = c( 8, 1), min.freq = 3,
           random.order = F, rot.per = 0.1, colors = pal2)

wordcloud2( swordcount, size = 3 )


# 문3) 
# 오바마 대통령의 데통령 당선 연설문에 대해 워드클라우드를 작성하시오
# Tip. 예제소스 파일은 ‘ex_10-5.txt’이다.

obama <- readLines("ex_10-5.txt", encoding = 'UTF-8' )
obama.noun <- sapply( obama, extractNoun, USE.NAMES = F )
head(obama.noun)
on <- unlist(obama.noun); on
owordcount <- table(on)
sort.obama <- sort( owordcount, decreasing = T )
sort.obama <- sort.obama[-1]
sort.obama

sort.obama <- sort.obama[ nchar(sort.obama) > 1 ]
sort.obama <- gsub('것','',sort.obama)
sort.obama <- gsub('저','',sort.obama)
sort.obama <- gsub('들','',sort.obama)
sort.obama <- gsub('수','',sort.obama)
sort.obama <- gsub('한','',sort.obama)
sort.obama <- gsub('시','',sort.obama)
sort.obama <- gsub('년','',sort.obama)
sort.obama <- gsub('되','',sort.obama)

wordcloud( names(sort.obama), freq = sort.obama,
           min.freq = 3, scale = c( 9, 0.7 ),
           random.order = F, rot.per = 0.2, colors = pal2)
wordcloud2( owordcount, color = 'random-light',
            backgroundColor = 'black',
            size = 2 )



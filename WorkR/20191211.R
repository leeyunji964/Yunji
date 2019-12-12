# 12일차
# Data Mining, Text Mining
#
# 워드 클라우드( Word Cloud )
#
# 한글 워드클라우드 설치
# 1. java 실행환경 구축
# 2. 자료 수집( text 자료 )
#   2.1 text file 형태로 수집
#   2.2 web scrapping을 이용하여 수집
# 3. 명사 추출
Sys.setenv( JAVA_HOME = "C:/Program Files/Java/jre1.8.0_231")

#필요시 설치
install.packages("wordcloud")       # word cloud
install.packages("wordcloud2")      # word cloud
install.packages("KoNLP")           # 한국어 처리 <- 한국어 처리시 반드시 필요
install.packages("RColorBrewer")    # 색상 선택
library( wordcloud )
library( wordcloud2 )
library( KoNLP )
library( RColorBrewer )

library( dplyr )
library( ggplot2 )

setwd('D:/Yunji/WorkR')
text <- readLines( 'mis_document.txt', encoding = 'UTF-8')
# readLines : txt 파일을 한 줄 씩 읽어와라
text # 비정형 데이터

buildDictionary( ext_dic = 'woorimalsam' ) # '우리말씀' 한글사전 로딩
pal2 <- brewer.pal( 8, 'Dark2' ) # 색상 팔레트 생성
noun <- sapply( text, extractNoun, USE.NAMES = F ) # 명사 추출
noun
# class(noun) : list

# 4. 추출된 단어( 주로 명사 )에 대한 빈도수 계산 및 시각화
noun2 <- unlist( noun ) # list -> vector로 변환
wordcount <- table( noun2 ) 
wordcount
sort.noun <- sort( wordcount, decreasing = T )[1:10]
# 빈도가 높은 순으로 정렬, 데이터가 많으니까 데이터 셋에서 10개만 추출
sort.noun
sort.noun <- sort.noun[-1] # 의미없는 공백 제거
barplot( sort.noun, names.arg = names( sort.noun ),
         col = 'steelblue', main = '빈도수 높은 단어',
         ylab = '단어 빈도수')

df <- as.data.frame( sort.noun )
df

ggplot( df, aes( x = df$noun2, y = df$Freq ) )+
    geom_bar( stat = 'identity',
              width = 0.7,
              fill = 'steelblue') +
    ggtitle('빈도수 높은 단어') +
    theme( plot.title = element_text( size = 25,
                                      face = 'bold',
                                      colour = 'steelblue',
                                      hjust = 0,
                                      vjust = 1 ) ) +
    labs( x = '명사', y = '단어 빈도수' )+
    geom_text( aes( label = df$Freq ), hjust = -0.3 ) +  #빈도 표시
    coord_flip()

# 5. word cloud 작성
pal3 <- brewer.pal( 9, 'Blues')[5:9] # 한 가지 색으로만 색 지정
wordcloud( names( wordcount ),   # 단어
           freq = wordcount,     # 단어 빈도
           scale = c(6, 0.7),    # 단어 폰트 크기(최대, 최소)
           min.freq = 3,         # 단어 최소 빈도 : 빈도가 3 이상인 것들만 출력하라.
           random.order = F,     # 단어 출력 위치 : T로 나오면 무작위, F면 빈도가 높은 게 가운데 지정.
           rot.per = .1,         # 90도 회전 단어비율 : .1 = 0.1 = 10%
           colors = pal3)        # 단어 색


# 6. 전처리 과정 수행
#   6.2 생략된 단어를 사전에 등재
buildDictionary( ext_dic = 'woorimalsam',
                 user_dic = data.frame('정치','ncn'), # ncn = 명사
                 replace_usr_dic = T )
noun <- sapply( text, extractNoun, USE.NAMES = F )
noun2 <- unlist( noun )

#   6.1 불필요한 단어 삭제
noun2 <- noun2[ nchar(noun2) > 1 ]
noun2 <- gsub('하지', '', noun2) # 하지 -> 공백으로 바꿔라
noun2 <- gsub('때문', '', noun2) # 때문 -> 공백으로 바꿔라
noun2 <- gsub('들이', '', noun2)
wordcount <- table( noun2 )
wordcount

# 다시 wordcloud 실행
pal3 <- brewer.pal( 9, 'Blues')[5:9] # 한 가지 색으로만 색 
wordcloud( names( wordcount ),
           freq = wordcount,
           scale = c(6, 0.7),
           min.freq = 3,
           random.order = F,
           rot.per = .1,
           colors = pal2)


# 애국가 형태소 분석
library( KoNLP )
useSystemDic()
useSejongDic()
useNIADic()

#
# 애국가 가사 :
# https://mois.go.kr/frt/sub/a06/b08/nationalIcon_3/screen.do
#
# 1. 사전 설정 : 이게 있어야 단어 추출 가능
useSejongDic()

# 2. 텍스트 데이터 가져오기
word_data <- readLines('애국가(가사).txt')
word_data

# 3. 명사 추출
word_data2 <- sapply( word_data, extractNoun, USE.NAMES = F )
word_data2 # 확인 결과, 공백(띄어쓰기)을 기준으로 해서 단어 구분 -> 정확하게 명사로 추출 X

# 3.1 제대로 추출되지 않은 단어를 사용자 사전에 등록
add_words <- c('백두산','남산','철갑','가을','하늘','달')
buildDictionary( user_dic = data.frame( add_words,
                            rep( 'ncn', length( add_words ) ) ),
                 replace_usr_dic = T )
#했는데도 안되면, 데이터 리스트에 가서 직접 바꾸는 수 밖에 없음.. 자동 추출이라서..


# 3.2 단어 추가(3.1) 후 다시 명사 추출
word_data2 <- sapply( word_data, extractNoun, USE.NAMES = F )
word_data2

# 4. 행렬을 벡터로 변환
undata <- unlist( word_data2 )
undata

# 5. 사용 빈도 확인 : table()
word_table <- table( undata )
word_table

# 6. filtering : 두 글자 이상 단어만 선별, 공백이나 한 자리 문자를 걸러냄
undata2 <- undata[ nchar( undata ) >=2 ]
undata2
word_table2 <- table( undata2 )
word_table2

# 7. 데이터 정렬
sort( word_table2, decreasing = T )

# 애국가 형태 분석 완료
# 가장 기본적인 전처리만 수행, 100% 정확한 데이터라 볼 수 없음.


# 8. word cloud 작성 후 분석
wordcloud2( word_table2 )

# 8.1 배경 및 색상 변경
wordcloud2( word_table2,
            color = 'random-light',
            backgroundColor = 'black')

# 8.2 모양 변경
wordcloud2( word_table2,
            fontFamily = '맑은고딕',
            size = 1.2, color = 'random-light',
            backgroundColor = 'black',
            shape = 'star')

# 8.3 선택 색상 반복
wordcloud2( word_table2, size = 1.6,
            color = rep_len( c('red','blue'),
                             nrow( word_table2)))

wordcloud2( demoFreq, size = 1.6,
            color = rep_len( c('yellowgreen','skyblue'),
                             nrow( word_table2)))

# 8.4 일정 방향 정렬
wordcloud2( word_table2,
            minRotation = -pi / 6,
            maxRotation = -pi / 6,
            rotateRatio = 1 )

wordcloud2( demoFreq,
            minRotation = -pi / 6,
            maxRotation = -pi / 6,
            rotateRatio = 1 )
# 시각화는 결과일 뿐, 시각화에 치중하기 보다는 데이터 분석을 잘하자... 전처리를 잘하자..
# 전처리를 못하면 시각화도 별로라는 것..











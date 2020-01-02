INSERT INTO goods VALUES(1,'냉장고',2,850000);
INSERT INTO goods VALUES(2,'세탁기',3,550000);
INSERT INTO goods VALUES(3,'전자레인지',2,350000);
INSERT INTO goods VALUES(4,'HDTV',3,1500000);

#name = not null : name 속성이 없으면 데이터 생성 X
#INSERT INTO goods(CODE, su, dan) VALUES(4,3,1500000); <- name이 없어서 생성 X
# primary key = code : 기본값이 0 -> 한 번은 들어가는데 그 이후부터는 안 들어감(primary key = 중복 X)
#INSERT INTO goods(NAME, su, dan) VALUES("py", 3, 1500000);


SELECT * FROM goods;

INSERT INTO goods(CODE, NAME, su) VALUES(5,'드론', 1);
UPDATE goods SET dan = 1000000 WHERE CODE = 5 # 중복없이 데이터 입력

DELETE FROM goods WHERE CODE = 5;
INSERT INTO goods VALUES(5, 'VR기기', 2, 1440000); # goods 속성들 안 쓰면 values에 전부 다 써줘야하고 
INSERT INTO goods VALUES(6, 'Drone', 1, 890000);
INSERT INTO goods(CODE, NAME, su) VALUES(7, '고성능컴퓨터',3); # goods 속성들을 쓸 경우, 원하는 값만 넣을 수 있음. 단 code,name은 필수

# 이름이 냉장고이고 단가가 75000 이상인 데이터 출력
SELECT * FROM goods WHERE NAME='냉장고' AND dan>=75000;
# 단가가 75000이하인 제품 출력
SELECT * FROM goods WHERE dan <= 75000;
# 단가가 50000이상이고 1200000이하인 제품 출력
SELECT * FROM goods WHERE dan BETWEEN 50000 AND 1200000;
# 판매 수량이 3개 이상인 제품명과 단가의 출력
SELECT NAME, dan FROM goods WHERE su>= 3;

INSERT INTO student2 VALUES(20120001, '고길동','m',27,'선박','seoul','010-000-4512', 5000);
INSERT INTO student2 VALUES(20120002, '최둘리','m',22,'역사','pusan','010-999-9999', 4500);
INSERT INTO student2 VALUES(20120003, '도우너','w',15,'역사','daegu','010-555-5555', 6500);
INSERT INTO student2 VALUES(20120004, '김만덕','w',15,'유아','mokpo','010-555-7777', 7000);
INSERT INTO student2 VALUES(20120005, '류현진','m',22,'컴퓨터공학','seoul','010-122-2222', 8000);
INSERT INTO student2 VALUES(20120006, '손흥민','m',22,'컴퓨터공학','seoul','010-984-6514', 9000);

# 직업별로 급여의 합계를 내시오.
SELECT major,SUM(money) FROM student2 GROUP BY major;
SELECT major, COUNT(*) FROM student2 GROUP BY major;

# '최'로 시작하는 사람을 출력하시오.
SELECT * FROM student2 WHERE NAME LIKE '최%';

# 주소가 '서울'이거나 고씨인 사람을 출력하시오.
SELECT * FROM student2 WHERE addr='seoul' OR NAME LIKE '최%';

SELECT COUNT(*) "전체 행수", COUNT(money) "급여건수", MAX(money) "최대급여", MIN(money) "최소급여", ROUND(AVG(money),2) 평균  FROM student2;

SELECT MAX(money) - MIN(money) AS 급여구간 FROM student2;

# money에 대해서 min-max 정규화를 실행하시오. : 값을 0~1 사이로 만들어라.
# SELECT (money - MIN(money)) / (MAX(money)-MIN(money)) AS 정규화 FROM students2;
# ↑ 그룹함수이기 때문에 그룹값을 상수화해서 정상적으로 계산됨

#프로그램으로 변경 (사용자 변수 : @  ( * @@ : 시스템변수) )
SELECT (money) INTO @minvalue FROM student2;
SELECT @minvalue;

SELECT max(money) - MIN(money) INTO @rangevalue FROM student2;
SELECT @rangevalue

SELECT (money-@minvalue) / @rangevalue AS 정규화값 FROM student2;








student_before_insertstudent_before_insert

INSERT INTO school(schoolname, addr, schoolcode, studentcount) VALUES("충주여자고등학교", "충주시", "CH00000001",300);
INSERT INTO school(schoolname, addr, schoolcode, studentcount) VALUES("신성여자고등학교", "제주시", "IC00000001", 560);
INSERT INTO school(schoolname, addr, schoolcode, studentcount) VALUES("종로여자고등학교", "종로구", "JR00000001", 300);
INSERT INTO school(schoolname, addr, schoolcode, studentcount) VALUES("제주여자고등학교", "서울시", "SE00000001", 300);

INSERT INTO student(NAME, kor, math, eng, schoolcode) VALUES("전공인",81,81,81,"SE00000001");
INSERT INTO student(NAME, kor, math, eng, schoolcode) VALUES("전공이",81,81,81,"SE00000001");
INSERT INTO student(NAME, kor, math, eng, schoolcode) VALUES("전공삼",91,100,100,"CH00000001");
INSERT INTO student(NAME, kor, math, eng, schoolcode) VALUES("전공사",100,100,100,"CH00000001");
INSERT INTO student(NAME, kor, math, eng, schoolcode) VALUES("고려인",100,100,100,"CH00000001");
INSERT INTO student(NAME, kor, math, eng, schoolcode) VALUES("종로구",100,81,71,"IC00000001");
INSERT INTO student(NAME, kor, math, eng, schoolcode) VALUES("김만덕",100,81,71,"IC00000001");

SELECT * FROM school;
SELECT * FROM student;

SELECT * FROM school WHERE schoolcode = 'CH00000001';
SELECT * FROM student WHERE NAME = '고려인';
SELECT NAME, kor, math, eng FROM student WHERE NAME = '전공인';
select NAME AS '이름', kor AS '국어', math AS '수학', eng AS '영어' FROM student WHERE NAME = '전공이';

# 서브 쿼리
SELECT NAME, kor, math, eng FROM student WHERE schoolcode IN (SELECT schoolcode FROM school WHERE schoolname = '신성여자고등학교');
SELECT NAME, kor, math, eng FROM student WHERE NAME LIKE '전공%';
SELECT NAME, kor, math, eng FROM student WHERE NAME LIKE '%공%'; # 이름 가운데에 '공'이 들어가는 데이터 출력
SELECT NAME, kor, math, eng FROM student WHERE NAME LIKE '_려_'; # 위랑 같음

SELECT * FROM student WHERE kor>90 AND math>90 AND eng>90;
SELECT * FROM student WHERE kor>90 OR math>90 OR eng>90;
SELECT * FROM student WHERE kor>80 AND kor<90;
SELECT * FROM student WHERE kor BETWEEN 80 AND 100;

# group by, having, order by, limit
SELECT * FROM student LIMIT 1; # 전체를 갖고오는데 딱 하나만 갖고와라! => 맨 앞에 있는 데이터만 출력

SELECT * FROM student ORDER BY NAME DESC; # 내림차순
SELECT * FROM student ORDER BY NAME ASC; # ascending : 오름차순

SELECT sc.schoolname, sc.schoolcode, st.name, st.average FROM student st INNER JOIN school sc ON st.schoolcode = sc.schoolcode
# 두 개의 조건이 모두 만족하는 데이터만 출력
 
# outer join :  

SELECT NAME AS '이름', kor AS '국어', math AS '수학', eng AS '영어' FROM student WHERE NAME = '전공이';
SELECT CONCAT(NAME,'님') AS '이름', kor AS '국어', math AS '수학', eng AS '영어' FROM student WHERE NAME = '전공인'; # concat : 문자열 결합
SELECT CONCAT(NAME,'님') AS '이름', LPAD(kor, 10, '*') AS '국어', math AS '수학', eng as '영어' FROM student WHERE NAME='전공삼';
#LPAD : left padding ? : 왼쪽(앞쪽)에 *로 10칸 표시하고 국어점수 표시
SELECT REPLACE(CONCAT(NAME,'님'),'님','형') AS '이름', LPAD(kor, 10,'*') AS '국어', math AS '수학', eng AS '영어' FROM student WHERE NAME = '전공삼';
# replace : '님'을 다시 '형'으로 출력하라
SELECT SUBSTR(REPLACE(CONCAT(NAME,'님'),'님','형'),1,2) AS '이름', LPAD(kor,10,'*') AS '국어', math AS '수학', eng AS '영어' FROM student WHERE NAME='전공삼';
# substr : 문자열 일부 추출
SELECT LENGTH(SUBSTR(REPLACE(CONCAT(NAME,'님'),'님','형'),1,2)) AS '이름', LPAD(kor,10,'*') AS '국어', math AS '수학', eng AS '영어'
	FROM student WHERE NAME="전공이"; # length : 길이값 출력...
	
# 문제) 
-- 전공인의 국어: 80, 영어 : 90으로 변경하고 합계와 평균 그리고 grade를 수정하라. * 계산은 수동으로 하고 변화만 적용하시오.
# insert trigger
UPDATE student SET kor=80, eng=90 WHERE NAME='전공인';
UPDATE student SET total=80+81+90, average=ROUND((80+81+90)/3,2), grade='B' WHERE NAME ='전공인';

UPDATE student SET total = kor+math+eng, average = ROUND((kor+math+eng)/3,2)
	grade =
	case when average>= 90 then 'A학점'
	when (average>=80 AND average<90) then 'B학점'
	when (average>=70 AND average<80) then 'C학점'
	when (average>=60 AND average<70) then 'D학점'
	ELSE 'F학점'
END) WHERE NAME="전공인";



SELECT * FROM student;

-- student 중 kor, math 점수만 출력하시오.
SELECT kor, math FROM student;

-- students 중 average가 90 이상인 사람의 name, schoolname(school)을 출력하시오.
#SELECT NAME, average, schoolname FROM students, school WHERE average >= 90;
SELECT NAME, schoolname FROM students, school WHERE average >= 90;
SELECT st.name, sc.schoolname FROM student AS st INNER JOIN school sc ON st.average >=90 AND st.schoolcode = sc.schoolcode;

-- student 중 eng 점수를 출력하되 그 이름을 "영어"로 하시오.
SELECT eng '영어' FROM student;

-- 이름 가운데 자가 "공"인 사람을 모두 출력하시오.
SELECT * FROM student WHERE NAME LIKE '%공%';

-- 학교 이름이 충주여자고등학교인 사람의 name과 total을 출력하시오.
#SELECT NAME, total, schoolname FROM student, school WHERE schoolname = '충주여자고등학교';
#SELECT NAME, total FROM student, school WHERE schoolname = '충주여자고등학교';
SELECT st.name, st.total FROM student AS st INNER JOIN school AS sc ON sc.schoolname="충주여자고등학교" AND st.schoolcode = sc.schoolcode;

-- student에서 total을 이용하여 정렬하고 상위 두 사람만 출력하시오.
SELECT * FROM student ORDER BY total DESC LIMIT 2;

# 저장프로시저 연습(서버 측에서 테스트 하는 것)
CALL student_select(); # student_select() = SELECT * FROM student;

CALL student_insert("제주도",100,100,100,'IC00000001',@result);
SELECT @result;

# 문제
# 이름을 변경하는 프로시저를 작성하시오.
SELECT * FROM student;
call student_updatename("전공이이이","전공인",@res);
SELECT @res

CALL student_sum();

CALL student_updateone();
SELECT * FROM student;


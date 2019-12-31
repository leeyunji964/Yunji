CREATE TABLE authors (
	name VARCHAR(50) NULL DEFAULT NULL,
	address VARCHAR(50) NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

# CRUD( insert into, select, update, delete )문 사용
INSERT INTO authors(NAME, address) VALUES("대한이","서울시");
INSERT INTO authors(NAME, address) VALUES("민국이","대전시");
INSERT INTO authors(NAME, address) VALUES("만세","충주시");

# 데이터베이스(외부접속단위), 테이블, 필드, 레코드
# * : 모두 다
SELECT * FROM authors;
SELECT * FROM authors WHERE NAME = "대한이"; # ==을 쓰지 않음! =만 씀
SELECT address FROM authors WHERE NAME = "만세"; # 명령문에서 대소문자 구분 X, 그렇지만 " " 안에서는 구분 O

# update set
UPDATE authors SET NAME = "대한민국" WHERE NAME = "대한이";

# delete 
DELETE FROM authors WHERE NAME="만세"; # 조건에 맞는 행(레코드) 전부 삭제

# 문제) 3인분의 성적을 students 테이블에 입력하고 출력해보시오.
# 이름 국어 영어 수학 총점 평균
# 대한이, 90,90,90
# 민국이, 80,80,81
# 만세, 100,100,100
CREATE TABLE students (
	name varchar(11) NULL DEFAULT NULL,
	kor INT(11) NULL DEFAULT NULL,
	eng INT(11) NULL DEFAULT NULL,
	math INT(11) NULL DEFAULT NULL,
	total INT(11) NULL DEFAULT NULL,
	average INT(11) NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

INSERT INTO students(NAME,kor,eng,math,total,average) VALUES("대한이",90,90,90,270,90);
INSERT INTO students(NAME,kor,eng,math,total,average) VALUES("민국이",80,80,80,240,80);
INSERT INTO students(NAME,kor,eng,math,total,average) VALUES("만세",100,100,100,300,100);

SELECT * FROM students;
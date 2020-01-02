INSERT INTO user VALUES('BBK','바비킴',1973,'서울','010','0000000',176,'2013-05-05');
INSERT INTO user VALUES('EJW','은지원',1972,'경북','011','8888888',174,'2014-03-03');
INSERT INTO user VALUES('JKW','조관우',1965,'경기','018','9999999',172,'2010-10-10');
INSERT INTO user VALUES('JYP','조용필',1950,'경기','011','4444444',166,'2009-04-04');
INSERT INTO user VALUES('KBS','김범수',1979,'경남','011','2222222',173,'2012-04-04');
INSERT INTO user VALUES('KKH','김경호',1971,'전남','019','3333333',177,'2007-07-07');
INSERT INTO user VALUES('LJB','임재범',1963,'서울','016','6666666',182,'2008-08-08');
INSERT INTO user VALUES('LSG','이승기',1987,'서울','011','1111111',182,'2008-08-08');
INSERT INTO user(userID, NAME, birthYear, addr, height, mDate) VALUES('SSK','성시경',1979,'서울',186,'2013-12-12');
INSERT INTO user(userID, NAME, birthYear, addr, height, mDate) VALUES('YJS','윤종신',1969,'경남',170,'2005-05-05');

INSERT INTO purchase VALUES(1,'KBS','운동화','전자',30,2);
INSERT INTO purchase VALUES(2,'KBS','노트북','전자',1000,1);
INSERT INTO purchase VALUES(3,'JYP','모니터','전자',200,1);
INSERT INTO purchase VALUES(4,'BBK','모니터','전자',200,5);
INSERT INTO purchase VALUES(5,'KBS','청바지','의류',50,3);
INSERT INTO purchase VALUES(6,'BBK','메모리','전자',80,10);
INSERT INTO purchase VALUES(7,'SSK','책','서적',15,5);
INSERT INTO purchase VALUES(8,'EJW','책','서적',15,2);
INSERT INTO purchase VALUES(9,'EJW','청바지','의류',50,1);
INSERT INTO purchase VALUES(10,'BBK','운동화','전자',30,2);
INSERT INTO purchase VALUES(11,'EJW','책','서적',15,1);
INSERT INTO purchase VALUES(12,'BBK','운동화','서적',30,2);

# 1) BBK가 구매한 데이터를 출력하시오
SELECT * FROM purchase WHERE userID='BBK';

# 2) 김씨인 사람 중 이름과 키를 기준으로 이름, 키, 주소를 내림차순으로 출력하시오(이름 뒤에는 '님'을 붙여서 출력)
SELECT concat(NAME,'님') AS 이름, height AS 키, addr AS 주소 FROM user WHERE NAME LIKE '김%' ORDER BY NAME desc, height DESC;

# 3) user를 출생년도별 오름차순으로 이름, 주소, 키, 출생년도를 출력하시오 (이름은 성을 빼고 출력)
SELECT substr(NAME,2) AS name, addr, height, birthYear FROM user ORDER BY birthYear;

# 4) 모바일 번호가 011로 시작하는 사람이 몇 명인지 출력하시오
SELECT COUNT(*) FROM user WHERE mobile1='011';

# 5) 출생년도가 1960에서 1979년까지 태어난 사람들이 구매한 품목을 출력하시오
SELECT prodName FROM purchase inner join user on user.userID = purchase.userID and birthYear BETWEEN 1960 AND 1979;
#SELECT distinct(prodName) FROM purchase inner join user on user.userID = purchase.userID and birthYear BETWEEN 1960 AND 1979;

# 6) UserID별로 구매한 price,amount 합계를 출력하시오 (이 때 userID는 name으로 출력하시오)
SELECT userID as NAME, SUM(price), sum(amount) AS 총액  FROM purchase GROUP BY UserID;

# 7) 주소가 서울인 사람이 구매한 총액을 구하시오
SELECT SUM(price*amount) AS '총액' FROM purchase inner join user on user.userID=purchase.userID and addr='서울';

# 8) 품목별 판매 총액을 출력하시오
SELECT prodName, SUM(price*amount) AS '판매 총액' FROM purchase GROUP BY prodName;

# 9) 출생년도가 1970년도 이상인 사람들을 대상으로 구매한 갯수가 2개 이상인 것의 판매 총합계를 구하시오
SELECT SUM(p.amount*p.price) AS '판매 총합계'  FROM purchase AS p INNER JOIN user AS u ON u.userID=p.userID AND u.birthYear>=1970 AND p.amount>=2; 

# 10) 모든 유저를 출력하시오(이름 중에 김씨와 조씨는 모두 컬씨로 바꾸어 출력)
select (case when NAME LIKE '김%' OR NAME LIKE '조%' then CONCAT('컬',SUBSTR(NAME,2)) ELSE NAME END) AS NAME FROM user;

# 11) 책을 구매한 사람의 이름과 출생년도, 주소를 출력하시오.
select NAME, birthYear, addr FROM user AS u INNER JOIN purchase AS p ON u.userID=p.userID AND p.prodName='책';
#select distinct(NAME), birthYear, addr FROM user AS u INNER JOIN purchase AS p ON u.userID=p.userID AND p.prodName='책';
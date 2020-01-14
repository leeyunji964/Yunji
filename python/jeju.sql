-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.4.11-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- jeju 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `jeju` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `jeju`;

-- 테이블 jeju.authors 구조 내보내기
CREATE TABLE IF NOT EXISTS `authors` (
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.authors:~3 rows (대략적) 내보내기
DELETE FROM `authors`;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` (`name`, `address`) VALUES
	('대한민국', '서울시'),
	('민국이', '대전시'),
	('만세', '충주시');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;

-- 테이블 jeju.goods 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods` (
  `code` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `su` int(11) DEFAULT NULL,
  `dan` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='primary key :  중복이 불가능하고 외부에서 참조가 가능한 키\r\n';

-- 테이블 데이터 jeju.goods:~7 rows (대략적) 내보내기
DELETE FROM `goods`;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` (`code`, `name`, `su`, `dan`) VALUES
	(1, '냉장고', 2, 850000),
	(2, '세탁기', 3, 550000),
	(3, '전자레인지', 2, 350000),
	(4, 'HDTV', 3, 1500000),
	(5, 'VR기기', 2, 1440000),
	(6, 'Drone', 1, 890000),
	(7, '고성능컴퓨터', 3, NULL);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;

-- 테이블 jeju.purchase 구조 내보내기
CREATE TABLE IF NOT EXISTS `purchase` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `userID` varchar(30) NOT NULL DEFAULT '',
  `prodName` varchar(50) DEFAULT NULL,
  `groupName` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `userID` (`userID`),
  CONSTRAINT `FK_purchase_user` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.purchase:~12 rows (대략적) 내보내기
DELETE FROM `purchase`;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
INSERT INTO `purchase` (`num`, `userID`, `prodName`, `groupName`, `price`, `amount`) VALUES
	(1, 'KBS', '운동화', '전자', 30, 2),
	(2, 'KBS', '노트북', '전자', 1000, 1),
	(3, 'JYP', '모니터', '전자', 200, 1),
	(4, 'BBK', '모니터', '전자', 200, 5),
	(5, 'KBS', '청바지', '의류', 50, 3),
	(6, 'BBK', '메모리', '전자', 80, 10),
	(7, 'SSK', '책', '서적', 15, 5),
	(8, 'EJW', '책', '서적', 15, 2),
	(9, 'EJW', '청바지', '의류', 50, 1),
	(10, 'BBK', '운동화', '전자', 30, 2),
	(11, 'EJW', '책', '서적', 15, 1),
	(12, 'BBK', '운동화', '서적', 30, 2);
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;

-- 테이블 jeju.school 구조 내보내기
CREATE TABLE IF NOT EXISTS `school` (
  `number` int(11) NOT NULL AUTO_INCREMENT,
  `schoolname` varchar(20) DEFAULT NULL,
  `addr` varchar(50) DEFAULT NULL,
  `schoolcode` char(10) NOT NULL,
  `studentcount` int(11) DEFAULT NULL,
  PRIMARY KEY (`schoolcode`),
  KEY `number` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='auto_increment : 값을 직접 지정하지 않고, 자동으로 지정됨.\r\nkey 지정 : 값이 중복되지 않게.';

-- 테이블 데이터 jeju.school:~4 rows (대략적) 내보내기
DELETE FROM `school`;
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
INSERT INTO `school` (`number`, `schoolname`, `addr`, `schoolcode`, `studentcount`) VALUES
	(1, '충주여자고등학교', '충주시', 'CH00000001', 300),
	(2, '신성여자고등학교', '제주시', 'IC00000001', 560),
	(3, '종로여자고등학교', '종로구', 'JR00000001', 300),
	(6, '제주여자고등학교', '서울시', 'SE00000001', 300);
/*!40000 ALTER TABLE `school` ENABLE KEYS */;

-- 테이블 jeju.student 구조 내보내기
CREATE TABLE IF NOT EXISTS `student` (
  `bunho` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `kor` tinyint(4) DEFAULT NULL,
  `math` tinyint(4) DEFAULT NULL,
  `eng` tinyint(4) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `average` float DEFAULT NULL,
  `grade` char(2) DEFAULT NULL,
  `schoolcode` char(10) DEFAULT NULL,
  PRIMARY KEY (`bunho`),
  KEY `schoolcode` (`schoolcode`),
  CONSTRAINT `FK_school` FOREIGN KEY (`schoolcode`) REFERENCES `school` (`schoolcode`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.student:~8 rows (대략적) 내보내기
DELETE FROM `student`;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` (`bunho`, `name`, `kor`, `math`, `eng`, `total`, `average`, `grade`, `schoolcode`) VALUES
	(1, '전공인', 81, 82, 91, 254, 84.67, 'B', 'SE00000001'),
	(2, '전공이', 82, 82, 82, 246, 82, 'B', 'SE00000001'),
	(3, '전공삼', 92, 101, 101, 294, 98, 'A', 'CH00000001'),
	(4, '전공사', 101, 101, 101, 303, 101, 'A', 'CH00000001'),
	(5, '고려인', 101, 101, 101, 303, 101, 'A', 'CH00000001'),
	(6, '종로구', 101, 82, 72, 255, 85, 'B', 'IC00000001'),
	(7, '김만덕', 101, 82, 72, 255, 85, 'B', 'IC00000001'),
	(8, '제주민', 101, 101, 101, 303, 101, 'A', 'IC00000001');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;

-- 테이블 jeju.student2 구조 내보내기
CREATE TABLE IF NOT EXISTS `student2` (
  `num` int(11) NOT NULL,
  `name` varchar(12) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `major` varchar(20) DEFAULT NULL,
  `addr` varchar(15) DEFAULT NULL,
  `tel` varchar(15) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.student2:~6 rows (대략적) 내보내기
DELETE FROM `student2`;
/*!40000 ALTER TABLE `student2` DISABLE KEYS */;
INSERT INTO `student2` (`num`, `name`, `sex`, `age`, `major`, `addr`, `tel`, `money`) VALUES
	(20120001, '고길동', 'm', 27, '선박', 'seoul', '010-000-4512', 5000),
	(20120002, '최둘리', 'm', 22, '역사', 'pusan', '010-999-9999', 4500),
	(20120003, '도우너', 'w', 15, '역사', 'daegu', '010-555-5555', 6500),
	(20120004, '김만덕', 'w', 15, '유아', 'mokpo', '010-555-7777', 7000),
	(20120005, '류현진', 'm', 22, '컴퓨터공학', 'seoul', '010-122-2222', 8000),
	(20120006, '손흥민', 'm', 22, '컴퓨터공학', 'seoul', '010-984-6514', 9000);
/*!40000 ALTER TABLE `student2` ENABLE KEYS */;

-- 테이블 jeju.students 구조 내보내기
CREATE TABLE IF NOT EXISTS `students` (
  `name` varchar(50) DEFAULT NULL,
  `kor` int(11) DEFAULT NULL,
  `eng` int(11) DEFAULT NULL,
  `math` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `average` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.students:~3 rows (대략적) 내보내기
DELETE FROM `students`;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` (`name`, `kor`, `eng`, `math`, `total`, `average`) VALUES
	('대한이', 90, 90, 90, 270, 90),
	('민국이', 80, 80, 80, 240, 80),
	('만세', 100, 100, 100, 300, 100);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;

-- 프로시저 jeju.student_insert 구조 내보내기
DELIMITER //
CREATE PROCEDURE `student_insert`(
	IN `name` VARCHAR(50),
	IN `kor` INT,
	IN `math` INT,
	IN `eng` INT,
	IN `schoolcode` CHAR(10),
	OUT `result` INT
)
BEGIN
	DECLARE exit handler FOR sqlexception
	begin
		ROLLBACK; # commit, savepoint
		SET result = -1;
	END;
	START TRANSACTION;
		INSERT INTO student(NAME, kor, math, eng, schoolcode)
		VALUES(NAME, kor, math, eng, schoolcode);
	COMMIT;
	SET result = 0;
END//
DELIMITER ;

-- 프로시저 jeju.student_select 구조 내보내기
DELIMITER //
CREATE PROCEDURE `student_select`()
BEGIN
	SELECT * FROM student;
END//
DELIMITER ;

-- 프로시저 jeju.student_sum 구조 내보내기
DELIMITER //
CREATE PROCEDURE `student_sum`()
BEGIN
	DROP TABLE if EXISTS sungjuk_hap;
	CREATE TABLE sungjuk_hap(korhap FLOAT, mathhap FLOAT, enghap FLOAT) AS SELECT SUM(kor) AS korhap, SUM(math) AS mathhap, SUM(eng) AS enghap FROM student;
	INSERT INTO sungjuk_hap (korhap, mathhap, enghap)
		SELECT ROUND(AVG(kor),2) , ROUND(AVG(math),2), ROUND(AVG(eng),2) FROM student;
		SELECT * FROM sungjuk_hap;
END//
DELIMITER ;

-- 프로시저 jeju.student_updatename 구조 내보내기
DELIMITER //
CREATE PROCEDURE `student_updatename`(
	IN `oldname` VARCHAR(50),
	IN `newname` VARCHAR(50),
	OUT `result` VARCHAR(50)
)
BEGIN
	DECLARE cnt INT DEFAULT 0; # cnt = 0
	SELECT COUNT(*) INTO cnt FROM student WHERE NAME = oldname;
	
	if cnt>0 then
			UPDATE student SET NAME=newname WHERE NAME=oldname;
			set result := 0;
		
	ELSE SET result := -1;
	END if;
	
END//
DELIMITER ;

-- 프로시저 jeju.student_updateone 구조 내보내기
DELIMITER //
CREATE PROCEDURE `student_updateone`()
BEGIN -- 모든 데이터에 1점씩 추가
	DECLARE _done INT DEFAULT FALSE; # 무한루프의 종료조건 지정
	DECLARE name_var VARCHAR(20);  # 각 데이터를 하나씩 처리하기 위해서 변수 지정.
	DECLARE kor_var INT;
	DECLARE math_var INT;
	DECLARE eng_var INT;
	
	DECLARE CURSOR_STUDENT CURSOR FOR SELECT NAME, kor, math, eng FROM student;
	# 커서는 => 스튜던트로부터 커서를 만들면 student에 있는 모든 데이터를 갖고와서,,  "데이터를 가리키는 위치"
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET _done = TRUE;
	# 컨티뉴 핸들러 : 종료변수(_done)가 true인 걸 더 이상 찾을 수 없을 때..? 
	
	OPEN CURSOR_STUDENT; # 오픈해서 데이터를 갖고 옴. (오픈해야만 데이터 갖고올 수 있음)
	REPEAT
		fetch CURSOR_STUDENT INTO name_var, kor_var, math_var, eng_var; # 데이터를 한 개씩 패치함.
		if NOT _done then # not _done = TRUE
			UPDATE student SET kor = kor_var+1, math = math_var+1, eng = eng_var+1 WHERE NAME = name_var;
			SET _done = FALSE;
		END if;
	until _done # _done(종료조건)이 TRUE가 될 때까지 무한루프 실행.
	END repeat;
	close CURSOR_STUDENT;
END//
DELIMITER ;

-- 테이블 jeju.sungjuk_hap 구조 내보내기
CREATE TABLE IF NOT EXISTS `sungjuk_hap` (
  `korhap` float DEFAULT NULL,
  `mathhap` float DEFAULT NULL,
  `enghap` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.sungjuk_hap:~2 rows (대략적) 내보내기
DELETE FROM `sungjuk_hap`;
/*!40000 ALTER TABLE `sungjuk_hap` DISABLE KEYS */;
INSERT INTO `sungjuk_hap` (`korhap`, `mathhap`, `enghap`) VALUES
	(760, 732, 721),
	(95, 91.5, 90.13);
/*!40000 ALTER TABLE `sungjuk_hap` ENABLE KEYS */;

-- 테이블 jeju.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `userID` varchar(10) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `birthYear` int(11) DEFAULT NULL,
  `addr` varchar(30) DEFAULT NULL,
  `mobile1` varchar(20) DEFAULT NULL,
  `mobile2` varchar(20) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `mDate` date DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.user:~10 rows (대략적) 내보내기
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`userID`, `name`, `birthYear`, `addr`, `mobile1`, `mobile2`, `height`, `mDate`) VALUES
	('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-05-05'),
	('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-03-03'),
	('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10'),
	('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-04-04'),
	('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-04-04'),
	('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-07-07'),
	('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2008-08-08'),
	('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-08-08'),
	('SSK', '성시경', 1979, '서울', NULL, NULL, 186, '2013-12-12'),
	('YJS', '윤종신', 1969, '경남', NULL, NULL, 170, '2005-05-05');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- 트리거 jeju.student_before_insert 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `student_before_insert` BEFORE INSERT ON `student` FOR EACH ROW BEGIN -- OLD : 입력된 값, NEW : 새롭게 만들어질 데이터
	SET NEW.total = NEW.kor + NEW.math + NEW.eng;
	-- 변수에 값을 대입할 때 set 몀령어 사용
	-- NEW.total = new,       new.kor, new.math, new.eng = old ?
	SET NEW.average = ROUND(NEW.total/3,2);
	
	if NEW.average >= 90 then SET NEW.grade = 'A';
	ELSEIF NEW.average >= 80 then SET NEW.grade='B';
	ELSEIF NEW.average >= 70 then SET NEW.grade='c';
	ELSEIF NEW.average >= 60 then SET NEW.grade='D';
	ELSE SET NEW.grade='F';
	END if;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 트리거 jeju.student_before_update 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `student_before_update` BEFORE UPDATE ON `student` FOR EACH ROW BEGIN
	SET NEW.total = NEW.kor + NEW.math + NEW.eng;
	-- 변수에 값을 대입할 때 set 몀령어 사용
	-- NEW.total = new,       new.kor, new.math, new.eng = old ?
	SET NEW.average = ROUND(NEW.total/3,2);
	
	if NEW.average >= 90 then SET NEW.grade = 'A';
	ELSEIF NEW.average >= 80 then SET NEW.grade='B';
	ELSEIF NEW.average >= 70 then SET NEW.grade='c';
	ELSEIF NEW.average >= 60 then SET NEW.grade='D';
	ELSE SET NEW.grade='F';
	END if;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

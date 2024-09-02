CREATE TABLE hm (
no number(3) PRIMARY KEY,
name VARCHAR2(10) NOT NULL,
point NUMBER(5) DEFAULT 0,
addr VARCHAR2(20),
indate TIMESTAMP DEFAULT sysdate
);

INSERT INTO hm VALUES (1,'홍길동',45,'서울시',default);
INSERT INTO hm VALUES (2,'일지매',50,'수원시',default);
INSERT INTO hm VALUES (3,'이지매',43,'서울시',default);

SELECT * FROM hm;
SELECT no,name FROM hm;
SELECT COUNT(*) FROM hm;

-- 문제1 : 모든 사람의 이름과 점수만 출력하시오.
SELECT no,name FROM hm;
-- 문제2 : 점수가 50점 미만인 사람의 이름과 점수를 출력하시오.
SELECT name,point FROM hm WHERE point<50;
-- 문제3 : 점수가 50점 미만인 사람은 모두 몇명인지 출력하시오.
SELECT COUNT(*) FROM hm WHERE point<50;
-- 문제4 : 홍길동의 점수는 몇점인지 출력하시오.
SELECT name,point FROM hm WHERE name='홍길동';
-- 문제5 : 일지매의 모든 정보를 출력하시오.
SELECT * FROM hm WHERE name='일지매';

-- 컬럼명을 한글로 바꾸기(컬럼 별칭 지정)
SELECT name 이름, point 점수 FROM hm WHERE point<50;

-- 1. 모든 학생의 이름과 점수를 출력합니다. 이때, 포인트는 현재 포인트에서 10점 올려서 출력하시오.
SELECT name 이름, point+10 점수 FROM hm;
-- 2. 모든 학생의 이름과 점수를 출력합니다. 이때, 출력할 형태는 이름/현재점수/가산점수
-- 이름은 학생이름, 현재점수는 저장된 점수, 가산점수는 +10점 올린 점수
SELECT name 이름, point 현재점수, point+10 가산점수 FROM hm;

SELECT * FROM hm;
-- 갱신(Update), WHERE이 없다면 모든 튜플 변경
UPDATE hm SET name='이학생', point=100 WHERE name='이지매';
SELECT * FROM hm;
-- 삭제(Delete), WHERE이 없다면 모든 튜플 삭제
DELETE FROM hm WHERE name='이학생';
SELECT * FROM hm;

SELECT sysdate FROM dual;
SELECT concat('누구','님') 이름 FROM dual;

-- 1. 모든 사람의 이름과 점수를 출력합니다. 이때, 이름 뒤에 '님'을 붙여 출력하시오.
SELECT concat(name, '님') 이름, point 점수 FROM hm;
-- 2. 모든 사람의 이름, 점수, 등록일을 출력합니다. 이때, 가입 순서에 따라 출력합니다.
--    가장 나중에 가입한 사람이 제일 먼저 출력, 등록일=indate
SELECT name 이름, point 점수, indate 등록일 FROM hm ORDER BY indate DESC;
-- 3. 점수가 50이상인 사람의 이름과 정보를 출력합니다.
--    이때, 정보는 번호,이름,점수가 합쳐진 문자열로 출력한다.
SELECT name 이름, concat(concat(no,name),point) 정보 FROM hm WHERE point>=50;
-- 또는
SELECT name 이름, no || name || point 정보 FROM hm WHERE point>=50;
-- 4. 기준이 되는 점수는 60이다. 모든 회원이 기준 점수를 맞추기 위해 부족한 점수를 출력하시오.
--    출력은 이름, 현재점수, 부족한점수
SELECT name 이름, point 현재점수, 60-point 부족한점수 FROM hm;

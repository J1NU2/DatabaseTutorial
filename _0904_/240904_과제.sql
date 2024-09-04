-- 테스트 전 존재할 수 있는 테이블 삭제
DROP TABLE users;
DROP TABLE carinfo;

-- 테이블 생성
-- id:번호 / name:회원이름 / addr:주소
CREATE TABLE users (
id VARCHAR2(8),
name VARCHAR2(10),
addr VARCHAR2(10));

-- c_num:자동차번호 / c_name:자동차종류 / id:번호
CREATE TABLE carinfo (
c_num VARCHAR2(4),
c_name VARCHAR2(10),
id VARCHAR2(8));

-- 튜플 생성
INSERT INTO users VALUES ('1111','kim','수원');
INSERT INTO users VALUES ('2222','lee','서울');
INSERT INTO users VALUES ('3333','park','대전');
INSERT INTO users VALUES ('4444','choi','대전');

INSERT INTO carinfo VALUES ('1234','중형','1111');
INSERT INTO carinfo VALUES ('3344','소형','1111');
INSERT INTO carinfo VALUES ('5566','중형','3333');
INSERT INTO carinfo VALUES ('6677','중형','3333');
INSERT INTO carinfo VALUES ('7788','중형','4444');
INSERT INTO carinfo VALUES ('8888','중형','5555');

COMMIT;

-- 튜플(값) 추가하고 항상 확인하기
SELECT * FROM users;
SELECT * FROM carinfo;


-- 문제1. 회원의 이름과 주소를 출력하시오.
SELECT name 이름, addr 주소 FROM users;

-- 문제2. 회원의 이름과 소유한 자동차 번호를 출력하시오.
SELECT u.name 회원이름, c.c_num 자동차번호
FROM users u
INNER JOIN carinfo c
ON u.id=c.id;

-- 문제3. 자동차 번호가 7788인 소유자의 이름과 주소를 출력하시오.
SELECT u.name 회원이름, u.addr 주소
FROM users u
INNER JOIN carinfo c
ON u.id=c.id AND c.c_num='7788';

-- 문제4. 자동차를 소유하지 않은 사람의 이름과 주소를 출력하시오.
SELECT u.name 회원이름, u.addr 주소
FROM users u
LEFT OUTER JOIN carinfo c
ON u.id=c.id
WHERE c.id IS NULL;

-- 문제5. 회원별 등록한 자동차 수를 출력하시오.
SELECT u.id 회원번호, COUNT(c.id) "자동차 수"
FROM users u
INNER JOIN carinfo c
ON u.id=c.id
GROUP BY u.id
ORDER BY u.id;
-- 정렬(ORDER BY절)은 굳이 사용하지 않아도 된다.

-- 문제6. 2대 이상을 소유한 회원의 이름과 소유한 자동차 수를 출력하시오.
SELECT u.name 회원이름, COUNT(c.id) "자동차 수"
FROM users u
INNER JOIN carinfo c
ON u.id=c.id
GROUP BY u.name HAVING COUNT(c.id)>=2;

-- 문제7. 자동차는 등록되어 있는데, 소유자가 없는 자동차 번호를 출력하시오.
SELECT c.c_num 자동차번호
FROM carinfo c
LEFT OUTER JOIN users u
ON u.id=c.id
WHERE u.name IS NULL;
-- 또는
SELECT c.c_num 자동차번호
FROM users u
RIGHT OUTER JOIN carinfo c
ON u.id=c.id
WHERE u.name IS NULL;

-- 다음부터는 3개의 테이블을 조인하는 문제이다.
-- 새로운 테이블 생성
-- c_num:자동차번호 / c_com:제조사 / c_name:자동차이름 / c_price:자동차가격
CREATE TABLE companycar (
c_num VARCHAR2(4),
c_com VARCHAR2(30),
c_name VARCHAR2(10),
c_price NUMBER);

-- 튜플 생성
INSERT INTO companycar VALUES ('1234','현다','소나타',1000);
INSERT INTO companycar VALUES ('3344','기와','축제',2000);
INSERT INTO companycar VALUES ('7788','기와','레2',800);
INSERT INTO companycar VALUES ('9900','현다','그랭저',2100);

COMMIT;

-- 튜플(값) 추가하고 항상 확인하기
SELECT * FROM companycar;


-- 문제8. 배정 자동차의 차번호, 제조사, 자동차명, 가격을 출력하시오.
SELECT cp.c_num 차번호, cp.c_com 제조사, cp.c_name 자동차명, cp.c_price 가격
FROM carinfo c
INNER JOIN companycar cp
ON c.c_num=cp.c_num;
-- 또는
SELECT cp.*
FROM carinfo c
INNER JOIN companycar cp
ON c.c_num=cp.c_num;
-- 위 방법은 컬럼명이 별칭으로 표기되지 않아 보는데 어려움이 있다.

-- 문제9. 회사에서 구매는 하였지만 배정되지 않은 자동차의 차번호, 제조사, 자동차이름을 출력하시오.
SELECT cp.c_num 차번호, cp.c_com 제조사, cp.c_name 자동차명, cp.c_price 가격
FROM carinfo c
RIGHT OUTER JOIN companycar cp
ON c.c_num=cp.c_num
WHERE c.c_num IS NULL;

-- 문제10. 자동차 가격이 1000만원 이상인 자동차의 자동차 번호를 출력하시오.
SELECT c_num 자동차번호
FROM companycar
WHERE c_price>=1000;

-- 문제11. 배정된 자동차 중에서 회사에서 구매한 자동차가 아닌 자동차 번호를 출력하시오.
SELECT c.c_num 자동차번호
FROM carinfo c
LEFT OUTER JOIN companycar cp
ON c.c_num=cp.c_num
WHERE cp.c_num IS NULL;

-- 문제12. 모든 사람의 정보를 출력하시오. (이름, 배정받은 자동차번호, 자동차이름)
SELECT u.name 회원이름, c.c_num "배정된 자동차번호", cp.c_name 자동차이름
FROM users u, carinfo c, companycar cp
WHERE u.id=c.id AND c.c_num=cp.c_num;

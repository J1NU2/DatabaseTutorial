-- 1. 테이블 만들기
CREATE TABLE users (
no INT PRIMARY KEY,
name VARCHAR2(10),
addr VARCHAR2(10),
point NUMBER,
grade VARCHAR2(1),
jumin VARCHAR2(8));

-- 2. 테이블에 튜플 삽입
INSERT INTO users VALUES (1,'kimsu','suwon',99.12,1,'820405-1');
INSERT INTO users VALUES (2,'leesu','suwon city',89.00,2,'970805-2');
INSERT INTO users VALUES (3,'choihee','seoul',88.21,1,'910204-2');
INSERT INTO users VALUES (4,'leesil','suwon',77.62,4,'850405-1');
INSERT INTO users VALUES (5,'james','seoul',60.22,1,'871105-1');
INSERT INTO users VALUES (6,'parksuji','suwon',90.12,3,'880405-2');
INSERT INTO users VALUES (7,'kimrae','yougin',89.96,3,'820105-1');
INSERT INTO users VALUES (8,'sangJin','youngin',99.31,3,'990420-2');
INSERT INTO users VALUES (9,'Leechan','incheon',79.12,2,'970605-2');
INSERT INTO users VALUES (10,'kimmi','incheon',79.92,1,'810505-1');
INSERT INTO users VALUES (11,'ryusu','seoul',85.32,4,'861205-2');
INSERT INTO users VALUES (12,'Gosu',null,82.13,4,'810715-1');
SELECT * FROM users;

-- 3. 문제 풀기
--    개인별로 먼저 문제를 풀고, 조별로 쿼리의 답을 맞춰본 뒤
--    본인이 이해한 만큼 답안을 작성하여 개인별로 제출합니다.

-- 1. 모든 사람들의 이름과 점수와 생년월일을 검색하시오.
SELECT name 이름, point 점수, SUBSTR(jumin,1,6) 생년월일 FROM users;
-- 2. 80점 이상의 사람의 이름과 주소, 점수를 검색하시오.
SELECT name 이름, addr 주소, point 점수 FROM users WHERE point>=80;
-- 3. 이름이 kim으로 시작되는 사람의 이름, 주소, 점수를 검색하시오.
SELECT name 이름, addr 주소, point 점수 FROM users WHERE SUBSTR(name,1,3)='kim';
-- 4. 현재 점수에서 +10으로 보정한 점수를 출력하시오. (원본 데이터에 반영되지 않습니다.)
SELECT name 이름, point 현재점수, point+10 보정점수 FROM users;
-- 5. 1학년의 점수를 +1점씩 올려서 출력하세요. (원본 데이터에 반영되지 않습니다.)
SELECT name 이름, grade 학년, point 점수, point+1 추가점수 FROM users WHERE grade=1;
-- 6. B등급을 획득한 사람의 이름, 주소, 점수를 출력하세요 (B등급은 80점이상 90점미만입니다.)
SELECT name 이름, addr 주소, point 점수 FROM users WHERE point>=80 AND point<90;
-- 7. 쿼리 결과 중 NULL은 실제 입력하지 않은 값입니다.
--    주소를 입력하지 않은 학생의 이름, 주소, 학년, 점수, 주민번호를 출력하세요.
SELECT * FROM users;
SELECT name 이름, addr 주소, grade 학년, point 점수, jumin 주민번호 FROM users WHERE addr IS NULL;
-- 8. 4학년의 점수를 10%로 올린 점수를 계산하세요.
SELECT name 이름, grade 학년, point 점수, point+(point*0.1) 추가점수 FROM users WHERE grade=4;
-- 9. 점수가 낮은 학생부터 출력하세요. (번호, 이름, 주소, 점수)
SELECT no 번호, name 이름, addr 주소, point 점수 FROM users ORDER BY point;
-- 10. 학년을 오름차순으로 정렬하시오. (번호, 이름, 학년, 점수)
--     단, 학년이 동일할 경우 포인트가 높은 사람이 먼저 출력됩니다.
SELECT no 번호, name 이름, grade 학년, point 점수 FROM users ORDER BY grade, point DESC;
-- 11. 현재 점수에서 -10을 보정한 결과를 반영하여, 80점 이상인 사람의 이름, 점수, 보정한 결과 점수를 출력하세요.
SELECT name 이름, point 점수, point-10 보정점수 FROM users WHERE point>=80;
-- 12. 2학년의 모든 학생을 출력하시오. 출력 컬럼명은 이름, 주소, 학년으로 출력하시오.
--     여기서 이름은 name컬럼, 주소는 addr컬럼, 학년은 grade컬럼을 의미한다.
SELECT name 이름, addr 주소, grade 학년 FROM users WHERE grade=2;

-- 추가 문제
-- 13. 학생은 총 몇명인가?
SELECT COUNT(*) "학생 수" FROM users;
-- 14. 1학년은 총 몇명인가?
SELECT COUNT(*) "1학년 학생 수" FROM users WHERE grade=1;
-- 15. 모든 학생의 이름과 학년을 출력하시오. 단, 이름은 모두 소문자로만 출력하시오.
SELECT LOWER(name) 이름, grade 학년 FROM users;
-- 16. 2학년 학생의 이름과 학년을 출력하시오. 보안을 위해 주소는 앞글자 2글자만 출력하시오.
SELECT name 이름, grade 학년, SUBSTR(addr,1,2) "주소(보안)" FROM users;
-- 17. 모든 학생의 점수의 일의 자리는 절삭하시오. (반올림하지 않으며, 원본 데이터에 반영되지 않습니다.)
SELECT name 이름, SUBSTR(point,2,LENGTH(point)) 점수 FROM users;
-- 18. 모든 학생의 점수를 반올림하여 출력하시오. (원본 데이터에 반영되지 않습니다.)
SELECT name 이름, ROUND(point,0) 점수 FROM users;
-- 19. 2학년은 모두 몇명인가?
SELECT COUNT(*) "2학년 학생 수" FROM users WHERE grade=2;
-- 20. 1학년 중 80점 이상은 몇명인가?
SELECT COUNT(*) "1학년 중 80점 이상 학생 수" FROM users WHERE grade=1 AND point>=80;
-- 21. 3학년의 평균은 몇점입니까?
SELECT AVG(point) "3학년 평균 점수" FROM users WHERE grade=3;
-- 22. 전체 학생 중 최고점은 몇점입니까?
SELECT MAX(point) 최고점수 FROM users;
-- 23. 2학년 중 가장 낮은 점수를 획득한 점수는 몇점입니까?
SELECT MIN(point) "2학년 중 최저점수" FROM users WHERE grade=2;

-- 추추가 문제
-- 24. 보안을 위해서 주소를 모두 출력하지 않고 앞의 두 글자만 출력하고 뒤에 *을 하나 붙인다.
--     단, 원본 데이터에 반영되지 않습니다. (예시 : suwon → su*)
SELECT name 이름, CONCAT(SUBSTR(addr,1,2),'*') FROM users;
-- 25. 이름의 맨 앞과 맨 뒤에 *을 붙여 출력한다. (단, 원본 데이터에 반영되지 않습니다.)
SELECT CONCAT('*',CONCAT(name,'*')) FROM users;
-- 또는
SELECT '*' || name || '*' FROM users;
-- 26. 생년월일을 그대로 출력하지 말고, xx년xx월xx일 형식으로 출력한다.
--     단, 성별은 무시하며 원본 데이터에 반영되지 않습니다.
SELECT name 이름, 
    SUBSTR(jumin,1,2) || '년' || 
    SUBSTR(jumin,3,2) || '월' || 
    SUBSTR(jumin,5,2) || '일' "생년월일"
FROM users;
-- 27. 이름, 점수, 학년, 생년월일, 성별을 추가한다.
--     성별은 생년월일로 판단하며 마지막 숫자가 1이면 남, 2이면 여라고 표시한다.
-- 27-1. DECODE 함수 사용
SELECT name 이름, point 점수, grade 학년, SUBSTR(jumin,1,6) 생년월일,
    DECODE(SUBSTR(jumin,-1),'1','남','여') "성별"
FROM users;
-- 27-2. CASE WHEN 표현식 사용
SELECT name 이름, point 점수, grade 학년, SUBSTR(jumin,1,6) 생년월일,
    CASE WHEN SUBSTR(jumin,-1)='1' THEN '남'
         ELSE '여'
    END "성별"
FROM users;

-- 사용된 WHERE절 조건 및 함수 정리
-- SUBSTR : 문자열을 자르고 자른 문자열을 리턴하는 함수 : (문자열or데이터타입이 문자열인 컬럼명,시작위치,길이)
-- WHERE절에서 사용하는 논리 연산자 (AND, OR, NOT)
-- > AND : 조건을 모두 만족하는 경우의 조건
-- > OR : 조건 중 하나라도 만족하는 경우의 조건
-- > NOT : 지정된 조건이 아닌 경우의 조건
-- WHERE절에서 NULL 여부에 따른 튜플의 값을 필터링 할 때 사용하는 조건
-- IS NULL : NULL일 경우의 조건
-- IS NOT NULL : NULL이 아닐 경우의 조건
-- ORDER BY : 기본 오름차순(ASC), DESC 사용 시 내림차순
-- COUNT : 튜플의 수를 집계해주는 함수 : (*:전체, 컬럼명:특정컬럼)
-- AVG : 평균을 계산하는 함수
-- MAX : 최대값을 구하는 함수
-- MIN : 최소값을 구하는 함수
-- CONCAT : 2개의 문자열을 합쳐서 출력 값을 리턴하는 함수 : 숫자+문자열의 형태도 가능하다.
-- > 문자열을 합칠 때, 함수를 사용 안하더라도 '||'를 사용하면 합치는 것이 가능하다.
-- DECODE : 조건에 맞는 원하는 출력 값을 리턴하는 함수 : 프로그래밍의 if문,if-else문과 비슷한 기능 수행
-- > (값or컬럼명,조건,결과,아닐경우의결과) 또는 (값or컬럼명,조건1,결과1,조건2,결과2, ... ,아닐경우의결과)
-- + DECODE 함수를 대체할 수 있는 CASE WHEN 표현식도 존재한다.
-- 형태 : CASE WHEN 조건 THEN 리턴값 ELSE 리턴값

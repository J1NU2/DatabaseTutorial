SELECT * FROM muser;

-- 수식/함수/서브쿼리 각 어떤 것으로 해결이 가능한지 판단
-- GROUP BY : 그룹의 정의, 그룹별 집계일 경우 사용한다.

-- 1. grade가 3인 사람은 모두 몇명인가?
SELECT COUNT(*)         -- 원하는 값은 인원수, 인원수는 컬럼으로 해결이 불가능하니 함수를 사용한다.
FROM muser 
WHERE grade=3;                -- 튜플이 3인 사람의 조건

-- 2. grade가 1,2,4인 사람들의 salary평균을 구하시오.
SELECT AVG(salary)      -- 원하는 값은 salary평균, 평균은 컬럼으로 해결이 불가능하니 함수를 사용한다.
FROM muser
--WHERE grade=1 OR grade=2 OR grade=4;
-- 리팩토링
WHERE grade IN (1,2,4); -- IN 연산자는 OR의 의미가 있다.

-- 3. salary가 20000미만인 사람은 총 몇명인가?
SELECT COUNT(*)
FROM muser
WHERE salary<20000;

-- 5. 77년생 중에서 salary가 가장 적은 사람의 이름, 나이, salary를 출력하시오.
SELECT          -- 이름,나이,salary
FROM muser
WHERE;           -- 77년생 중에서...
/* 77년생 쿼리 테스트 시작 */
SELECT SUBSTR(reg_num,1,2) FROM muser;      -- 중간 단계 점검
-- 본 쿼리에 적용
SELECT          -- 이름,나이,salary
FROM muser
WHERE SUBSTR(reg_num,1,2)='77';     -- 77년생 중에서...
/* 77년생 쿼리 테스트 종료 */
-- 77년생 중에서 가장 작은 salary를 조회한다.
SELECT MIN(salary)                  -- 이름,나이,salary
FROM muser
WHERE SUBSTR(reg_num,1,2)='77';     -- 77년생 중에서...
-- 위 쿼리에서 가장 작은 salary를 받는 사람을 찾고, 해당 조건으로 가장 작은 salary를 받는 사람의 튜플을 선정한다.
SELECT *
FROM muser
WHERE SUBSTR(reg_num,1,2)='77' AND salary=10000;
-- 10000은 상수로 지정하면 안되며, 수식,함수로 해결이 불가능하니 서브쿼리로 해결한다.
SELECT name 이름, reg_num 나이, salary 급여
FROM muser
WHERE SUBSTR(reg_num,1,2)='77' AND salary=(
    SELECT MIN(salary)
    FROM muser
    WHERE SUBSTR(reg_num,1,2)='77');
-- 위 쿼리문은 나이를 출력하지 않는다.
-- 나이는 수식과 함수로 해결이 가능하다.
SELECT 1900+SUBSTR(reg_num,1,2) FROM muser;
SELECT * FROM muser;
-- 상수로 1900을 보정하면 2000년 이후 출생자는 오류 데이터가 된다.
-- 조건에 따라 1900 또는 2000을 추가 해줘야하는데, 해당 조건은 DECODE함수를 사용하여 조건을 걸어주었다.
SELECT SUBSTR(reg_num,8,1) FROM muser;
SELECT SUBSTR(reg_num,8,1) "A", DECODE(SUBSTR(reg_num,8,1),'1',1900,'2',1900,2000) "B"
FROM muser;
SELECT SUBSTR(reg_num,8,1) "A", 
       DECODE(SUBSTR(reg_num,8,1),'1',1900,'2',1900,2000) "B",
       DECODE(SUBSTR(reg_num,8,1),'1',1900,'2',1900,2000)+SUBSTR(reg_num,1,2) "C"
FROM muser;
-- 최종 쿼리
-- EXTRACT : 날짜 정보 추출 함수 (년/월/일/시/분/초) (YEAR/MONTH/DAY/HOUR/MINUTE/SECOND)
SELECT name 이름, 
       (EXTRACT (YEAR FROM SYSDATE)) - 
       (DECODE(SUBSTR(reg_num,8,1),'1',1900,'2',1900,2000)+SUBSTR(reg_num,1,2)) 나이, 
       salary 급여
FROM muser
WHERE SUBSTR(reg_num,1,2)='77' AND salary=(
    SELECT MIN(salary)
    FROM muser
    WHERE SUBSTR(reg_num,1,2)='77');
-- 많이 실수하여 오류낼 수 있는 쿼리
SELECT name, MIN(salary)
FROM muser
WHERE SUBSTR(reg_num,1,2)='77';
-- 에러 원인 : name은 다중행, MIN(salary)는 단일행, MIN함수는 집계함수이기때문에

-- 7. 남자의 평균 급여를 구하시오.
SELECT AVG(salary)      -- salary 평균
FROM muser
WHERE SUBSTR(reg_num,8,1) IN ('1','3');     -- 남자 : 함수를 이용하여 조건을 분석한다.

-- 8. 전체 평균급여보다 높은 급여를 받는 사람의 이름과 급여를 출력하시오.
SELECT name, salary
FROM muser
WHERE salary>(
    SELECT AVG(salary) 
    FROM muser);

-- 9. 전체 평균급여보다 높은 급여를 받는 사람의 이름과 급여, 평균급여를 출력하시오.
SELECT name, salary,
    (SELECT AVG(salary) 
     FROM muser) 평균급여       -- 스칼라 서브쿼리
FROM muser
WHERE salary>(
    SELECT AVG(salary) 
    FROM muser);
-- 해당 쿼리문은 메인쿼리 SELECT에서 튜플을 하나씩 완성할 때마다 
-- 동일한 서브쿼리를 계속 반복하여 실행하기 때문에 성능은 좋지 않다. (스칼라 서브쿼리)
-- 해당 쿼리는 조인으로 해결할 수 있다고 한다.

-- 12. 그룹별 평균급여가 전체 평균보다 높은 그룹을 출력하시오.
SELECT grade, AVG(salary) 
FROM muser 
GROUP BY grade HAVING AVG(salary)>(SELECT AVG(salary) FROM muser);
-- 그룹별 평균을 구한다.
-- 각 그룹별로 전체 평균보다 높은 그룹을 선택한다. (조건 : GROUP에 대한 조건이니 HAVING절 사용)

-- 14. 직원들의 성별을 출력하시오. (출력 형태는 이름, 성별(성별은 남or여))
SELECT name 이름,
       DECODE(SUBSTR(reg_num,8,1),'1','남','3','남','여') 성별
FROM muser;
-- 성별을 출력하는 것이기 때문에 함수만 사용하여 출력한다.
-- DECODE함수를 사용하지 않고 다음 문법을 이용하여 조건을 처리할 수 있다.
-- 오라클에서 조건에 따라 처리하는 문법은 CASE WHEN THEN ELSE END
-- CASE WHEN THEN ELSE END의 구조를 분석
-- CASE
--      WHEN 조건1 THEN 조건1이 참일 경우 실행
--      WHEN 조건2 THEN 조건2가 참일 경우 실행
--      ELSE 어떤 조건도 참이 아닐 경우 실행(거짓일 경우 실행)
-- END
SELECT name 이름,
       CASE WHEN SUBSTR(reg_num,8,1) IN ('1','3') THEN '남'
            ELSE '여'
       END 성별
FROM muser;

-- 중복 제거
SELECT DISTINCT grade, salary FROM muser;
-- DISTINCT함수는 중복된 컬럼을 제거하고, SELECT절에서 한번만 사용이 가능하다.
-- 중복 제거 범위는 SELECT에서 지정한 전체 행의 중복이다.
-- #3 문제에서 연령별(time컬럼) 급여의 합, OVER()함수 이용 하는 문제에서 다음과 같이 사용한다.
SELECT time 연령, SUM(salary) OVER(PARTITION BY time) 총합
FROM muser;
-- 위 쿼리와 같이 사용하면 중복되는 값이 포함된 상태로 출력되므로 
-- 다음 쿼리문과 같이 DISTINCT함수를 사용하여 중복을 제거할 수 있다.
SELECT DISTINCT time 연령, SUM(salary) OVER(PARTITION BY time) 총합
FROM muser;

-- #2 문제
SELECT
    (SELECT TRUNC(SUM(MONTHS_BETWEEN(SYSDATE,SUBSTR(reg_num,1,6)))) 
     FROM muser WHERE time IN (30,31)) AS "30세~31세의 월수의 합", 
    (SELECT TRUNC(SUM(MONTHS_BETWEEN(SYSDATE,SUBSTR(reg_num,1,6))))
     FROM muser WHERE time>=32) AS "32세 이상인 사람의 월수의 합"
FROM dual;

SELECT * FROM users;
SELECT * FROM users ORDER BY grade;

-- 0. 학년을 기준으로 인원수를 출력한다.
SELECT grade 학년, COUNT(*) 인원수 FROM users GROUP BY grade;

-- 응용1. 그룹별 인원수를 출력하되 학년을 오름차순으로 정렬
SELECT grade 학년, COUNT(*) 인원수 FROM users GROUP BY grade ORDER BY grade;
-- 또는
SELECT grade 학년, COUNT(*) 인원수 FROM users GROUP BY grade ORDER BY grade ASC;

-- 응용2. 그룹별 최고점과 최저점을 출력하시오.
SELECT grade 학년, MAX(point) 최고점, MIN(point) 최저점 FROM users GROUP BY grade;

-- 응용3. 그룹별 최고점을 획득한 사람의 이름은?
SELECT grade 학년, name 이름, MAX(point) 최고점 FROM users GROUP BY grade;
-- → name(이름)은 그룹화가 되어있지 않기 때문에 에러가 발생한다.


-- 확인문제
-- 1. 3학년과 4학년 각각 그룹의 인원수를 출력하시오.
SELECT grade 학년, COUNT(*) 인원수 FROM users WHERE grade=3 OR grade=4 GROUP BY grade;

-- 2. 1학년과 2학년의 최고점과 최저점의 점수 차이를 출력하시오.
SELECT grade 학년, MAX(point) 최고점, MIN(point) 최저점, MAX(point)-MIN(point) 점수차이
FROM users WHERE grade=1 OR grade=2 GROUP BY grade;

-- 3. 주민번호 2자리는 태어난 년도이다. 같은 년도에 태어난 사람을 카운팅하시오.
--    이때 태어난 년도와 인원수로 출력한다.
SELECT SUBSTR(jumin,1,2) 출생년도, COUNT(*) FROM users GROUP BY SUBSTR(jumin,1,2);
-- 오름차순 정렬
SELECT SUBSTR(jumin,1,2) 출생년도, COUNT(*) FROM users GROUP BY SUBSTR(jumin,1,2) ORDER BY SUBSTR(jumin,1,2);
-- 또는
SELECT SUBSTR(jumin,1,2) 출생년도, COUNT(*) FROM users GROUP BY SUBSTR(jumin,1,2) ORDER BY SUBSTR(jumin,1,2) ASC;


-- 연구과제
--  그룹을 만들 때 그룹별 조건을 지정할 수 있다.
--  예를 들어, 그룹의 인원이 3명 이상인 그룹의 인원수를 출력하시오.
--  이 지시사항은 그룹별로 인원을 카운팅하고, 그룹중에 인원수가 3명 이상인 그룹만 선택하는 의미이다.
--  그룹에 조건을 지정하는 방법을 찾아보시오.
--  해당 방법을 이용하여 그룹의 인원이 3명 이상인 그룹의 인원수를 출력하는 쿼리문을 작성하시오.
SELECT grade 학년, COUNT(*) 인원수 FROM users
GROUP BY grade HAVING COUNT(*)>=3;
-- 그룹에 조건을 지정하는 방법은 HAVING절을 사용하면 된다.
-- 위 확인문제1의 WHERE절 대신 아래 쿼리문처럼 그룹에 대한 조건을 지정하기 위해 HAVING절을 사용하는 것이 좋다.
SELECT grade 학년, COUNT(*) 인원수 FROM users
GROUP BY grade HAVING grade=1 OR grade=4;
-- 문제를 보고 해당 문제의 주어진 조건이 그룹으로 주어졌는지 판단하여 WHERE절과 HAVING절을 상황에 맞게 사용하는 것이 좋다.

-- 서브쿼리(SubQuery)
-- 각 학년의 학년 평균이 전체 평균보다 높을 경우의 문제
SELECT grade 학년, AVG(point) 평균 FROM users
GROUP BY grade HAVING AVG(point)>=(SELECT AVG(point) FROM users);

-- 가장 높은 점수를 획득한 사람의 이름과 점수는?
SELECT name 이름, point 점수 FROM users
WHERE point=(SELECT MAX(point) FROM users);

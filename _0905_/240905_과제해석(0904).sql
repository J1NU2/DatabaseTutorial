-- 문제1. 회원의 이름과 주소를 출력하시오.
-- 이름과 주소는 users 테이블에 존재하므로, 조인이 필요없다.
SELECT name, addr FROM users;

-- 문제2. 회원의 이름과 소유한 자동차 번호를 출력하시오.
-- 회원의 이름은 users테이블에 자동차번호는 carinfo테이블에 있으므로, 조인이 필요하다.
-- 회원이 소유한 자동차번호를 출력해야하기 때문에 Inner Join을 사용한다.
SELECT u.name, c.c_num
FROM users u, carinfo c     -- 만약 여기까지만 적는다면 Full Join이 된다.
WHERE u.id=c.id;

-- 문제3. 자동차 번호가 7788인 소유자의 이름과 주소를 출력하시오.
-- 자동차 번호가 7788인 것을 찾으려면 조건으로 찾아야한다. WHERE절
-- 이름과 주소는 users테이블에 존재하지만, 자동차번호 7788은 carinfo테이블에 존재하므로 조인이 필요하다.
-- 3_1. 조인으로 찾기
SELECT u.name, u.addr
FROM users u, carinfo c
WHERE u.id=c.id AND c.c_num='7788';
-- 3_2. 서브쿼리로 찾기
SELECT id FROM carinfo WHERE c_num='7788';
SELECT name, addr
FROM users
WHERE id=(SELECT id FROM carinfo WHERE c_num='7788');

-- 문제4. 자동차를 소유하지 않은 사람의 이름과 주소를 출력하시오.
-- 이름과 주소는 users테이블에 존재하지만 자동차에 관련된 정보는 carinfo테이블에 있으므로, 조인을 사용해야한다.
-- 하지만, 자동차를 소유하지 않은 사람의 정보를 알아내야하는 조건이 있으므로 OUTER JOIN을 사용하여 튜플을 뽑아낸다
SELECT u.name, u.addr
FROM users u
LEFT OUTER JOIN carinfo c
ON u.id=c.id
WHERE c.id IS NULL;     -- 튜플의 값이 NULL로 존재하는 테이블만 출력하게 된다면 자동차를 소유하지 않은 사람을 알아낼 수 있다.
-- LEFT OUTER JOIN은 아래와 같은 형태로도 사용이 가능하다.
SELECT u.name, u.addr
FROM users u, carinfo c
WHERE u.id=c.id(+) AND c.id IS NULL;        -- 조건의 오른쪽에 (+)가 붙으면 LEFT OUTER JOIN, 왼쪽에 (+)가 붙으면 RIGHT OUTER JOIN 이다.

-- 문제5. 회원별 등록한 자동차 수를 출력하시오.
-- 회원은 users테이블이고 자동차는 carinfo테이블이다.
-- 회원별 자동차 수에 관련된 집계를 하기 위해선 두 테이블을 조인하여 집계 함수인 COUNT를 사용해야한다.
SELECT u.name, COUNT(*)
FROM users u, carinfo c
WHERE u.id=c.id
GROUP BY u.name;
-- 하지만 위 쿼리문과 같이 회원의 이름을 그룹으로 지정하면 동명이인을 구별할 수 없다.
SELECT u.name, COUNT(*)
FROM users u, carinfo c
WHERE u.id=c.id
GROUP BY u.id;
-- 위 쿼리문과 같이 그룹을 id로 나눠주는 것이 좋지만 u.name은 다중행이기 때문에 해당 쿼리문은 에러가 발생한다.
-- 그러므로, 아래 쿼리문과 같이 GROUP BY절을 복합속성으로 정의한다면 해결이 가능하다.
SELECT u.name, COUNT(*)
FROM users u, carinfo c
WHERE u.id=c.id
GROUP BY (u.id,u.name);

-- 문제6. 2대 이상을 소유한 회원의 이름과 소유한 자동차 수를 출력하시오.
-- 문제5번과 유사하지만 자동차 수가 2대 이상인 경우의 조건이 존재한다.
-- 회원에 대한 자동차 수를 알기 위해 회원을 그룹화 해줬기 때문에 WHERE절을 사용하는 것이 아닌
-- 그룹에 대한 조건을 걸어주는 HAVING절을 사용하는 것이 좋다고 생각된다.
SELECT u.name, COUNT(*)
FROM users u, carinfo c
WHERE u.id=c.id
GROUP BY (u.id,u.name) HAVING COUNT(*)>=2;

-- 문제7. 자동차는 등록되어 있는데, 소유자가 없는 자동차 번호를 출력하시오.
-- 소유자에 관련된 정보는 users테이블, 자동차의 정보는 carinfo테이블에 있다.
-- 이때, 소유자가 없는 자동차 번호를 출력할 것이기 때문에 OUTER JOIN이 필요하다고 생각할 수 있다.
-- OUTER JOIN을 사용하는데, 어떤 테이블을 먼저 보고 판단을 할 것인가?
-- users 테이블을 먼저 보고 판단
SELECT c.c_num
FROM users u
RIGHT OUTER JOIN carinfo c
ON u.id=c.id
WHERE u.id IS NULL;
-- carinfo 테이블을 먼저 보고 판단
SELECT c.c_num
FROM carinfo c
LEFT OUTER JOIN users u
ON c.id=u.id
WHERE u.id IS NULL;
-- 다음과 같은 형태로도 사용이 가능하다.
SELECT c.c_num
FROM users u, carinfo c
WHERE u.id(+)=c.id AND u.id IS NULL;    -- RIGHT JOIN

-- 문제8. 배정 자동차의 차번호, 제조사, 자동차명, 가격을 출력하시오.
-- 차번호,제조사,자동차명,가격은 companycar에서 확인이 가능하나, 배정 자동차의 정보를 알아내야하니 carinfo와 JOIN이 필요하다.
-- 배정된 자동차의 정보만이 필요한 것이기 때문에 INNER JOIN을 사용한다.
SELECT cc.c_num, cc.c_com, cc.c_name, cc.c_price
FROM carinfo c, companycar cc
WHERE c.c_num=cc.c_num;

-- 문제9. 회사에서 구매는 하였지만 배정되지 않은 자동차의 차번호, 제조사, 자동차이름을 출력하시오.
-- 문제8번과 마찬가지로 차번호,제조사,자동차명은 companycar에서 확인이 가능하나, 배정 자동차의 정보를 알아내야하니 carinfo와 JOIN이 필요하다.
-- 하지만, 배정되지 않은 자동차의 정보가 필요하므로 OUTER JOIN을 사용한다.
SELECT cc.c_num, cc.c_com, cc.c_name
FROM carinfo c
RIGHT OUTER JOIN companycar cc
ON c.c_num=cc.c_num
WHERE c.c_num IS NULL;
-- 또는
SELECT cc.c_num, cc.c_com, cc.c_name
FROM carinfo c, companycar cc
WHERE c.c_num(+)=cc.c_num AND c.c_num IS NULL;
-- 만약 companycar 테이블을 먼저 보고 판단한다면 아래 쿼리문과 같이 사용할 수 있다.
SELECT cc.c_num, cc.c_com, cc.c_name
FROM companycar cc
LEFT OUTER JOIN carinfo c
ON c.c_num=cc.c_num
WHERE c.c_num IS NULL;

-- 문제10. 자동차 가격이 1000만원 이상인 자동차의 자동차 번호를 출력하시오.
-- 자동차의 가격과 번호를 알아내는 것은 companycar테이블에서 해결을 할 수 있기 때문에 조인을 사용할 필요가 없다.
-- 자동차 가격이 1000만원 이상인 조건이 걸려있으므로 WHERE절을 사용한다.
SELECT c_num
FROM companycar
WHERE c_price>=1000;

-- 문제11. 배정된 자동차 중에서 회사에서 구매한 자동차가 아닌 자동차 번호를 출력하시오.
-- 배정된 자동차의 정보는 carinfo테이블에, 회사에서 구매한 자동차의 정보는 companycar테이블에 존재한다.
-- 두개의 테이블을 JOIN하는데, 회사에서 구매한 자동차가 아닌 것을 알아내야하기 때문에 OUTER JOIN을 사용한다.
SELECT c.c_num
FROM carinfo c
LEFT OUTER JOIN companycar cc
ON c.c_num=cc.c_num
WHERE cc.c_num IS NULL;

-- 문제12. 모든 사람의 정보를 출력하시오. (이름, 배정받은 자동차번호, 자동차이름)
-- 모든 사람의 정보를 출력할 때 이름은 users테이블, 배정받은 자동차번호는 carinfo테이블, 자동차이름은 companycar테이블에 존재한다.
-- 3개의 테이블을 조인해야하기 때문에 순서대로 2개의 테이블을 조인한 뒤 나온 논리적인 테이블을 나머지 테이블과 조인하는 형식으로 진행한다.
SELECT u.name, NVL(c.c_num,'없음'), NVL(cc.c_name,'없음')       -- NVL함수 : 만약 튜플의 값이 NULL이라면 다음 값으로 치환한다.
FROM users u
LEFT OUTER JOIN carinfo c
ON u.id=c.id                    -- 여기까지 users테이블과 carinfo테이블을 조인한 논리적인 테이블이 생성된다.
LEFT OUTER JOIN companycar cc
ON c.c_num=cc.c_num;            -- 위에 생성된 논리적인 테이블과 companycar테이블을 조인한다.

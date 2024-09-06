-- 문제12. 모든 사람의 정보를 출력하시오. (이름, 배정받은 자동차번호, 자동차이름)
-- 모든 사람의 정보를 출력할 때 이름은 users테이블, 배정받은 자동차번호는 carinfo테이블, 자동차이름은 companycar테이블에 존재한다.
-- 3개의 테이블을 조인해야하기 때문에 순서대로 2개의 테이블을 조인한 뒤 나온 논리적인 테이블을 나머지 테이블과 조인하는 형식으로 진행한다.
SELECT u.name, NVL(c.c_num,'없음'), NVL(cc.c_name,'없음')       -- NVL함수 : 만약 튜플의 값이 NULL이라면 다음 값으로 치환한다.
FROM users u
LEFT OUTER JOIN carinfo c
ON u.id=c.id                    -- 여기까지 users테이블과 carinfo테이블을 조인한 논리적인 테이블이 생성된다.
LEFT OUTER JOIN companycar cc
ON c.c_num=cc.c_num;            -- 위에 생성된 논리적인 테이블과 companycar테이블을 조인한다.


-- 위의 문제가 3개의 테이블을 이용하여 JOIN하는 문제이다.
/*
    테이블은 데이터 중복을 최소화하기 위해 정규화 되어야하고, 정규화는 테이블을 분리하는 의미가 있다.
    그런데, 서비스를 이용하는 고객 입장에서는 2개 이상의 테이블이 조인이 되어야하는 경우가 존재한다.
    위의 경우들은 생각하면 정규화는 설계자의 입장이고, 조인은 서비스를 제공하는 입장의 기술인데..
    2개 이상의 테이블이 조인되어야하는 서비스는 서비스가 이용될 때마다 DB는 조인 연산을 계속해야하기 때문에 쿼리가 복잡해진다.
    이러한 현상을 방지하여 간단하게 할 방법은 없을까?
    해결책은 물리적인 테이블은 유지하되, 조인 결과를 합친 논리적인 테이블을 만드는 것이다.
    논리적인 테이블은 물리적인 테이블의 데이터로 만들어져 있다.
    이런 논리적인 테이블을 뷰라고 한다.
*/

CREATE VIEW all_users AS (
SELECT u.name 회원명, NVL(c.c_num,'없음') 자동차번호, NVL(cc.c_name,'없음') 자동차이름
FROM users u
LEFT OUTER JOIN carinfo c
ON u.id=c.id
LEFT OUTER JOIN companycar cc
ON c.c_num=cc.c_num
);

SELECT * FROM all_users;        -- 생성시킨 VIEW의 이름으로 조회가 가능하다.
SELECT 회원명, 자동차번호, 자동차이름 FROM all_users;    -- 생성시킨 VIEW의 컬럼명으로도 조회가 가능하다.
-- all_users라는 이름을 지닌 VIEW 테이블의 컬럼명이 한글로 되어있으나, 한글이 아닌 다른 별칭을 사용하는 것이 좋아보인다.

/*
    뷰를 통해서 INSERT UPDATE DELETE가 이론적으로는 가능하지만 테이블의 무결성을 위배되지 않아야한다.
    이런 점을 통해 뷰는 조회 목적으로 많이 사용한다.
*/

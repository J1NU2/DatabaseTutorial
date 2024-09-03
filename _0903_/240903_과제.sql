-- id:아이디 / reg_num:주민번호 / name:이름 / grade:그룹 / salary:급여 / time:근무시간
CREATE TABLE muser (
id INT,
reg_num VARCHAR2(8) NOT NULL,
name VARCHAR2(10 CHAR),
grade INT,
salary INT,
time INT);

-- 시퀀스 : 10부터 시작하고, 1씩 증가한다.
CREATE SEQUENCE muser_no INCREMENT BY 1 START WITH 10;

INSERT INTO muser VALUES (muser_no.nextval,'870205-1','이승진',1,10000,34);
INSERT INTO muser VALUES (muser_no.nextval,'880405-1','박이진',2,20000,31);
INSERT INTO muser VALUES (muser_no.nextval,'770715-2','최이수',4,40000,32);
INSERT INTO muser VALUES (muser_no.nextval,'010205-3','류진아',1,10000,30);
INSERT INTO muser VALUES (muser_no.nextval,'810205-2','오현식',2,20000,34);
INSERT INTO muser VALUES (muser_no.nextval,'820219-2','정승우',3,30000,35);
INSERT INTO muser VALUES (muser_no.nextval,'020205-3','이재수',1,10000,30);
INSERT INTO muser VALUES (muser_no.nextval,'970214-2','박지영',2,20000,31);
INSERT INTO muser VALUES (muser_no.nextval,'040205-4','정은아',4,40000,31);
INSERT INTO muser VALUES (muser_no.nextval,'770225-1','정재영',5,50000,30);
INSERT INTO muser VALUES (muser_no.nextval,'770905-2','이신수',4,40000,34);
INSERT INTO muser VALUES (muser_no.nextval,'050208-3','이발끈',2,20000,30);
INSERT INTO muser VALUES (muser_no.nextval,'051205-4','이욱이',1,10000,34);
INSERT INTO muser VALUES (muser_no.nextval,'891215-1','지승아',3,30000,30);
INSERT INTO muser VALUES (muser_no.nextval,'670805-1','현진수',2,20000,34);
INSERT INTO muser VALUES (muser_no.nextval,'840207-1','최이런',1,10000,35);
INSERT INTO muser VALUES (muser_no.nextval,'770405-1','이천안',1,10000,31);

SELECT * FROM muser;

-- 1. grade가 3인 사람은 모두 몇명인가?
SELECT COUNT(*) FROM muser WHERE grade=3;

-- 2. grade가 1,2,4인 사람들의 salary의 평균을 구하시오.
SELECT AVG(salary) 평균 FROM muser WHERE grade!=3;
-- 각 평균이면
SELECT grade 학년, AVG(salary) 평균 FROM muser GROUP BY grade HAVING grade!=3;

-- 3. salary가 20000 미만인 사람은 총 몇명인가?
SELECT COUNT(*) FROM muser WHERE salary<20000;

-- 4. salary가 30000 이상인 사람의 salary 평균을 구하시오.
SELECT AVG(salary) FROM muser WHERE salary>=30000;

-- 5. 77년생 중에서 salary가 가장 적은 사람의 이름, 나이, salary를 출력하시오.
SELECT name 이름, 
    CASE WHEN TO_NUMBER(SUBSTR(reg_num,3,2)) >= TO_NUMBER(TO_CHAR(SYSDATE,'MM'))
              AND TO_NUMBER(SUBSTR(reg_num,5,2)) >= TO_NUMBER(TO_CHAR(SYSDATE,'DD'))
         THEN CASE WHEN TO_NUMBER(SUBSTR(reg_num,1,2)) <= TO_NUMBER(TO_CHAR(SYSDATE,'YY'))
                   THEN TO_NUMBER(TO_CHAR(SYSDATE,'YY')) - TO_NUMBER(SUBSTR(reg_num,1,2)) - 1
                   ELSE (100+TO_NUMBER(TO_CHAR(SYSDATE,'YY'))) - TO_NUMBER(SUBSTR(reg_num,1,2)) - 1
                   END
         ELSE CASE WHEN TO_NUMBER(SUBSTR(reg_num,1,2)) <= TO_NUMBER(TO_CHAR(SYSDATE,'YY'))
                   THEN TO_NUMBER(TO_CHAR(SYSDATE,'YY')) - TO_NUMBER(SUBSTR(reg_num,1,2))
                   ELSE (100+TO_NUMBER(TO_CHAR(SYSDATE,'YY'))) - TO_NUMBER(SUBSTR(reg_num,1,2))
                   END
    END "나이", salary 급여 FROM muser 
WHERE SUBSTR(reg_num,1,2)='77' AND salary=(SELECT max(salary) FROM muser);

-- 6. 모든 사람의 이름과 생일을 출력하시오. (생일은 월,일만 표기 ex)0205)
SELECT name 이름, SUBSTR(reg_num,3,4) "생일(월일)" FROM muser;

-- 7. 남자의 평균 급여를 구하시오.
SELECT AVG(salary) "평균 급여" FROM muser
GROUP BY MOD(SUBSTR(reg_num,-1),2) HAVING MOD(SUBSTR(reg_num,-1),2)=1;

-- 8. 전체 평균급여보다 높은 급여를 받는 사람의 이름과 급여를 출력하시오.
SELECT AVG(salary) FROM muser;
SELECT name 이름, salary 급여 FROM muser WHERE salary>(SELECT AVG(salary) FROM muser);

-- 9. 전체 평균급여보다 높은 급여를 받는 사람의 이름과 급여, 평균급여를 출력하시오.
SELECT name 이름, salary 급여, (SELECT AVG(salary) FROM muser) 평균급여 FROM muser 
WHERE salary>(SELECT AVG(salary) FROM muser);

-- 10. 여직원의 평균급여보다 높은 남자직원은 모두 몇명인가?
SELECT COUNT(*) "남자직원의 수" FROM muser 
WHERE MOD(SUBSTR(reg_num,-1),2)=1 
      AND salary>(SELECT AVG(salary) FROM muser WHERE MOD(SUBSTR(reg_num,-1),2)=0);

-- 11. grade별 평균 급여를 출력하시오.
SELECT grade 그룹, AVG(salary) 평균급여 FROM muser GROUP BY grade ORDER BY grade;

-- 12. 그룹별 평균급여가 전체 평균보다 높은 그룹을 출력하시오.
SELECT grade 그룹 FROM muser 
GROUP BY grade HAVING AVG(salary)>(SELECT AVG(salary) FROM muser) ORDER BY grade;

-- 13. 직원들의 월급 명세서를 출력하시오. (출력형태는 이름, 월급(grade*salary*time))
SELECT name 이름, (grade*salary*time) 월급 FROM muser;

-- 14. 직원들의 성별을 출력하시오. (출력 형태는 이름, 성별(성별은 남or여))
SELECT name 이름, 
    CASE WHEN MOD(SUBSTR(reg_num,-1),2)=1 THEN '남'
         ELSE '여'
    END "성별" 
FROM muser;

-- 15. 근무시간이 31이상인 사람의 이름을 출력하시오. (근무시간은 time)
SELECT name 이름 FROM muser WHERE time>=31;

-- 16. 짝수년도에 태어난 사람들의 이름을 모두 출력하시오.
SELECT name 이름 FROM muser WHERE MOD(SUBSTR(reg_num,1,2),2)=0;

-- 17. 직원들의 생년월일을 출력하시오. (출력형태는 이름, 생년월일(00년00월00일))
SELECT name 이름, 
       SUBSTR(reg_num,1,2) || '년' || 
       SUBSTR(reg_num,3,2) || '월' || 
       SUBSTR(reg_num,5,2) || '일' AS 생년월일
FROM muser;
-- 만약 970102일 경우, 97년1월2일로 출력하도록 설정
SELECT name 이름,
       SUBSTR(reg_num,1,2) || '년' || 
       CASE WHEN SUBSTR(reg_num,3,1)=0 THEN SUBSTR(reg_num,4,1)
            ELSE SUBSTR(reg_num,3,2)
       END || '월' || 
       CASE WHEN SUBSTR(reg_num,5,1)=0 THEN SUBSTR(reg_num,6,1)
            ELSE SUBSTR(reg_num,5,2)
       END || '일' AS 생년월일
FROM muser;

-- 18. 여직원들의 육아를 지원하기 위한 정책으로 time을 2시간 가산하기로 했다.
--     해당 결과를 출력하시오.
SELECT name 이름, 
       CASE WHEN MOD(SUBSTR(reg_num,-1),2)=0 THEN time+2
            ELSE time
       END "근무시간", 
       CASE WHEN MOD(SUBSTR(reg_num,-1),2)=0 THEN 'Y'
            ELSE 'N'
       END "가산여부"
FROM muser;

-- 19. 나이별 인원수는 몇명인가?
-- 만나이로 계산
SELECT CASE WHEN TO_NUMBER(SUBSTR(reg_num,3,2)) >= TO_NUMBER(TO_CHAR(SYSDATE,'MM'))
                 AND TO_NUMBER(SUBSTR(reg_num,5,2)) >= TO_NUMBER(TO_CHAR(SYSDATE,'DD'))
            THEN CASE WHEN TO_NUMBER(SUBSTR(reg_num,1,2)) <= TO_NUMBER(TO_CHAR(SYSDATE,'YY'))
                      THEN TO_NUMBER(TO_CHAR(SYSDATE,'YY')) - TO_NUMBER(SUBSTR(reg_num,1,2)) - 1
                      ELSE (100+TO_NUMBER(TO_CHAR(SYSDATE,'YY'))) - TO_NUMBER(SUBSTR(reg_num,1,2)) - 1
                      END
            ELSE CASE WHEN TO_NUMBER(SUBSTR(reg_num,1,2)) <= TO_NUMBER(TO_CHAR(SYSDATE,'YY'))
                      THEN TO_NUMBER(TO_CHAR(SYSDATE,'YY')) - TO_NUMBER(SUBSTR(reg_num,1,2))
                      ELSE (100+TO_NUMBER(TO_CHAR(SYSDATE,'YY'))) - TO_NUMBER(SUBSTR(reg_num,1,2))
                      END
       END "나이", COUNT(*) 인원수 FROM muser
GROUP BY CASE WHEN TO_NUMBER(SUBSTR(reg_num,3,2)) >= TO_NUMBER(TO_CHAR(SYSDATE,'MM'))
                   AND TO_NUMBER(SUBSTR(reg_num,5,2)) >= TO_NUMBER(TO_CHAR(SYSDATE,'DD'))
              THEN CASE WHEN TO_NUMBER(SUBSTR(reg_num,1,2)) <= TO_NUMBER(TO_CHAR(SYSDATE,'YY'))
                        THEN TO_NUMBER(TO_CHAR(SYSDATE,'YY')) - TO_NUMBER(SUBSTR(reg_num,1,2)) - 1
                        ELSE (100+TO_NUMBER(TO_CHAR(SYSDATE,'YY'))) - TO_NUMBER(SUBSTR(reg_num,1,2)) - 1
                        END
              ELSE CASE WHEN TO_NUMBER(SUBSTR(reg_num,1,2)) <= TO_NUMBER(TO_CHAR(SYSDATE,'YY'))
                        THEN TO_NUMBER(TO_CHAR(SYSDATE,'YY')) - TO_NUMBER(SUBSTR(reg_num,1,2))
                        ELSE (100+TO_NUMBER(TO_CHAR(SYSDATE,'YY'))) - TO_NUMBER(SUBSTR(reg_num,1,2))
                        END
         END
ORDER BY "나이";       
-- 연나이로 계산
SELECT CASE WHEN TO_NUMBER(SUBSTR(reg_num,1,2)) <= TO_NUMBER(TO_CHAR(SYSDATE,'YY'))
            THEN TO_NUMBER(TO_CHAR(SYSDATE,'YY')) - TO_NUMBER(SUBSTR(reg_num,1,2))
            ELSE (100+TO_NUMBER(TO_CHAR(SYSDATE,'YY'))) - TO_NUMBER(SUBSTR(reg_num,1,2))
       END "나이", COUNT(*) 인원수 FROM muser
GROUP BY CASE WHEN TO_NUMBER(SUBSTR(reg_num,1,2)) <= TO_NUMBER(TO_CHAR(SYSDATE,'YY'))
              THEN TO_NUMBER(TO_CHAR(SYSDATE,'YY')) - TO_NUMBER(SUBSTR(reg_num,1,2))
              ELSE (100+TO_NUMBER(TO_CHAR(SYSDATE,'YY'))) - TO_NUMBER(SUBSTR(reg_num,1,2))
         END
ORDER BY "나이";

-- 20. 2학년 그룹과 4학년 그룹은 모두 몇명인가?
SELECT grade 그룹, COUNT(*) 인원수 FROM muser
GROUP BY grade HAVING grade=2 OR grade=4;


-- 추가 문제
-- 1. 모든 사람이 태어난 후 오늘까지 몇달이 지났는지 출력하시오.
--    출력형태 : 이름, 주민번호, 지금까지 살아온 월수
SELECT name 이름, reg_num 주민번호, 
       CASE WHEN SUBSTR(reg_num,1,2) <= TO_CHAR(SYSDATE,'YY') 
            THEN CASE WHEN SUBSTR(reg_num,3,2) <= TO_CHAR(SYSDATE,'MM') 
                      THEN CASE WHEN SUBSTR(reg_num,5,2) < TO_CHAR(SYSDATE,'DD') 
                                THEN (12*(TO_CHAR(SYSDATE,'YY')-SUBSTR(reg_num,1,2)))+((12-SUBSTR(reg_num,3,2)-(12-TO_CHAR(SYSDATE,'MM'))))-1 
                                ELSE (12*(TO_CHAR(SYSDATE,'YY')-SUBSTR(reg_num,1,2)))+((12-SUBSTR(reg_num,3,2)-(12-TO_CHAR(SYSDATE,'MM')))) 
                           END
                      ELSE CASE WHEN SUBSTR(reg_num,5,2) < TO_CHAR(SYSDATE,'DD') 
                                THEN ((12*(TO_CHAR(SYSDATE,'YY')-SUBSTR(reg_num,1,2))-1))+((12-SUBSTR(reg_num,3,2)-(12-TO_CHAR(SYSDATE,'MM'))))-1 
                                ELSE ((12*(TO_CHAR(SYSDATE,'YY')-SUBSTR(reg_num,1,2))-1))+((12-SUBSTR(reg_num,3,2)-(12-TO_CHAR(SYSDATE,'MM')))) 
                           END
                 END
            ELSE CASE WHEN SUBSTR(reg_num,3,2) <= TO_CHAR(SYSDATE,'MM') 
                      THEN CASE WHEN SUBSTR(reg_num,5,2) < TO_CHAR(SYSDATE,'DD')
                                THEN (12*((100+TO_CHAR(SYSDATE,'YY'))-SUBSTR(reg_num,1,2)))+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))-1
                                ELSE (12*((100+TO_CHAR(SYSDATE,'YY'))-SUBSTR(reg_num,1,2)))+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))
                           END
                      ELSE CASE WHEN SUBSTR(reg_num,5,2) < TO_CHAR(SYSDATE,'DD') 
                                THEN (12*((100+TO_CHAR(SYSDATE,'YY'))-SUBSTR(reg_num,1,2))-1)+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))-1
                                ELSE (12*((100+TO_CHAR(SYSDATE,'YY'))-SUBSTR(reg_num,1,2))-1)+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))
                           END
                 END
       END "지금까지 살아온 개월 수"
FROM muser;

-- 2. time을 나이로 볼 때, 30~31세의 살아온 월수의 합, 32세 이상인 사람의 살아온 월수의 합 구하기
select name, reg_num,time from muser;

SELECT time 나이, SUM(
CASE WHEN SUBSTR(reg_num,3,2) <= TO_CHAR(SYSDATE,'MM')
     THEN CASE WHEN SUBSTR(reg_num,5,2) < TO_CHAR(SYSDATE,'DD')
               THEN (12*time)+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))-1
               ELSE (12*time)+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))
          END
     ELSE CASE WHEN SUBSTR(reg_num,5,2) < TO_CHAR(SYSDATE,'DD')
               THEN ((12*time)-1)+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))-1
               ELSE ((12*time)-1)+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))
          END
END) "지금까지 살아온 개월 수" FROM muser
GROUP BY time;

-- 3. 연령(time)별 급여의 합, OVER()함수 이용
SELECT DISTINCT time 나이, SUM(salary) OVER(PARTITION BY time ORDER BY time) AS 합계 FROM muser;

-- 4. 연령(time)별 인원수, OVER()함수 이용
SELECT DISTINCT time 나이, COUNT(*) OVER(PARTITION BY time) AS 인원수 FROM muser;

-- 5. 등급별 급여의 최고급여, OVER()함수 이용
SELECT DISTINCT grade 등급, MAX(salary) OVER(PARTITION BY grade ORDER BY salary) AS "최고 급여" FROM muser;

-- 6. 오라클 함수 정리(구글 검색 허용)

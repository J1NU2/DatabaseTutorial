-- id:���̵� / reg_num:�ֹι�ȣ / name:�̸� / grade:�׷� / salary:�޿� / time:�ٹ��ð�
CREATE TABLE muser (
id INT,
reg_num VARCHAR2(8) NOT NULL,
name VARCHAR2(10 CHAR),
grade INT,
salary INT,
time INT);

-- ������ : 10���� �����ϰ�, 1�� �����Ѵ�.
CREATE SEQUENCE muser_no INCREMENT BY 1 START WITH 10;

INSERT INTO muser VALUES (muser_no.nextval,'870205-1','�̽���',1,10000,34);
INSERT INTO muser VALUES (muser_no.nextval,'880405-1','������',2,20000,31);
INSERT INTO muser VALUES (muser_no.nextval,'770715-2','���̼�',4,40000,32);
INSERT INTO muser VALUES (muser_no.nextval,'010205-3','������',1,10000,30);
INSERT INTO muser VALUES (muser_no.nextval,'810205-2','������',2,20000,34);
INSERT INTO muser VALUES (muser_no.nextval,'820219-2','���¿�',3,30000,35);
INSERT INTO muser VALUES (muser_no.nextval,'020205-3','�����',1,10000,30);
INSERT INTO muser VALUES (muser_no.nextval,'970214-2','������',2,20000,31);
INSERT INTO muser VALUES (muser_no.nextval,'040205-4','������',4,40000,31);
INSERT INTO muser VALUES (muser_no.nextval,'770225-1','���翵',5,50000,30);
INSERT INTO muser VALUES (muser_no.nextval,'770905-2','�̽ż�',4,40000,34);
INSERT INTO muser VALUES (muser_no.nextval,'050208-3','�̹߲�',2,20000,30);
INSERT INTO muser VALUES (muser_no.nextval,'051205-4','�̿���',1,10000,34);
INSERT INTO muser VALUES (muser_no.nextval,'891215-1','���¾�',3,30000,30);
INSERT INTO muser VALUES (muser_no.nextval,'670805-1','������',2,20000,34);
INSERT INTO muser VALUES (muser_no.nextval,'840207-1','���̷�',1,10000,35);
INSERT INTO muser VALUES (muser_no.nextval,'770405-1','��õ��',1,10000,31);

SELECT * FROM muser;

-- 1. grade�� 3�� ����� ��� ����ΰ�?
SELECT COUNT(*) FROM muser WHERE grade=3;

-- 2. grade�� 1,2,4�� ������� salary�� ����� ���Ͻÿ�.
SELECT AVG(salary) ��� FROM muser WHERE grade!=3;
-- �� ����̸�
SELECT grade �г�, AVG(salary) ��� FROM muser GROUP BY grade HAVING grade!=3;

-- 3. salary�� 20000 �̸��� ����� �� ����ΰ�?
SELECT COUNT(*) FROM muser WHERE salary<20000;

-- 4. salary�� 30000 �̻��� ����� salary ����� ���Ͻÿ�.
SELECT AVG(salary) FROM muser WHERE salary>=30000;

-- 5. 77��� �߿��� salary�� ���� ���� ����� �̸�, ����, salary�� ����Ͻÿ�.
SELECT name �̸�, 
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
    END "����", salary �޿� FROM muser 
WHERE SUBSTR(reg_num,1,2)='77' AND salary=(SELECT max(salary) FROM muser);

-- 6. ��� ����� �̸��� ������ ����Ͻÿ�. (������ ��,�ϸ� ǥ�� ex)0205)
SELECT name �̸�, SUBSTR(reg_num,3,4) "����(����)" FROM muser;

-- 7. ������ ��� �޿��� ���Ͻÿ�.
SELECT AVG(salary) "��� �޿�" FROM muser
GROUP BY MOD(SUBSTR(reg_num,-1),2) HAVING MOD(SUBSTR(reg_num,-1),2)=1;

-- 8. ��ü ��ձ޿����� ���� �޿��� �޴� ����� �̸��� �޿��� ����Ͻÿ�.
SELECT AVG(salary) FROM muser;
SELECT name �̸�, salary �޿� FROM muser WHERE salary>(SELECT AVG(salary) FROM muser);

-- 9. ��ü ��ձ޿����� ���� �޿��� �޴� ����� �̸��� �޿�, ��ձ޿��� ����Ͻÿ�.
SELECT name �̸�, salary �޿�, (SELECT AVG(salary) FROM muser) ��ձ޿� FROM muser 
WHERE salary>(SELECT AVG(salary) FROM muser);

-- 10. �������� ��ձ޿����� ���� ���������� ��� ����ΰ�?
SELECT COUNT(*) "���������� ��" FROM muser 
WHERE MOD(SUBSTR(reg_num,-1),2)=1 
      AND salary>(SELECT AVG(salary) FROM muser WHERE MOD(SUBSTR(reg_num,-1),2)=0);

-- 11. grade�� ��� �޿��� ����Ͻÿ�.
SELECT grade �׷�, AVG(salary) ��ձ޿� FROM muser GROUP BY grade ORDER BY grade;

-- 12. �׷캰 ��ձ޿��� ��ü ��պ��� ���� �׷��� ����Ͻÿ�.
SELECT grade �׷� FROM muser 
GROUP BY grade HAVING AVG(salary)>(SELECT AVG(salary) FROM muser) ORDER BY grade;

-- 13. �������� ���� ������ ����Ͻÿ�. (������´� �̸�, ����(grade*salary*time))
SELECT name �̸�, (grade*salary*time) ���� FROM muser;

-- 14. �������� ������ ����Ͻÿ�. (��� ���´� �̸�, ����(������ ��or��))
SELECT name �̸�, 
    CASE WHEN MOD(SUBSTR(reg_num,-1),2)=1 THEN '��'
         ELSE '��'
    END "����" 
FROM muser;

-- 15. �ٹ��ð��� 31�̻��� ����� �̸��� ����Ͻÿ�. (�ٹ��ð��� time)
SELECT name �̸� FROM muser WHERE time>=31;

-- 16. ¦���⵵�� �¾ ������� �̸��� ��� ����Ͻÿ�.
SELECT name �̸� FROM muser WHERE MOD(SUBSTR(reg_num,1,2),2)=0;

-- 17. �������� ��������� ����Ͻÿ�. (������´� �̸�, �������(00��00��00��))
SELECT name �̸�, 
       SUBSTR(reg_num,1,2) || '��' || 
       SUBSTR(reg_num,3,2) || '��' || 
       SUBSTR(reg_num,5,2) || '��' AS �������
FROM muser;
-- ���� 970102�� ���, 97��1��2�Ϸ� ����ϵ��� ����
SELECT name �̸�,
       SUBSTR(reg_num,1,2) || '��' || 
       CASE WHEN SUBSTR(reg_num,3,1)=0 THEN SUBSTR(reg_num,4,1)
            ELSE SUBSTR(reg_num,3,2)
       END || '��' || 
       CASE WHEN SUBSTR(reg_num,5,1)=0 THEN SUBSTR(reg_num,6,1)
            ELSE SUBSTR(reg_num,5,2)
       END || '��' AS �������
FROM muser;

-- 18. ���������� ���Ƹ� �����ϱ� ���� ��å���� time�� 2�ð� �����ϱ�� �ߴ�.
--     �ش� ����� ����Ͻÿ�.
SELECT name �̸�, 
       CASE WHEN MOD(SUBSTR(reg_num,-1),2)=0 THEN time+2
            ELSE time
       END "�ٹ��ð�", 
       CASE WHEN MOD(SUBSTR(reg_num,-1),2)=0 THEN 'Y'
            ELSE 'N'
       END "���꿩��"
FROM muser;

-- 19. ���̺� �ο����� ����ΰ�?
-- �����̷� ���
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
       END "����", COUNT(*) �ο��� FROM muser
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
ORDER BY "����";       
-- �����̷� ���
SELECT CASE WHEN TO_NUMBER(SUBSTR(reg_num,1,2)) <= TO_NUMBER(TO_CHAR(SYSDATE,'YY'))
            THEN TO_NUMBER(TO_CHAR(SYSDATE,'YY')) - TO_NUMBER(SUBSTR(reg_num,1,2))
            ELSE (100+TO_NUMBER(TO_CHAR(SYSDATE,'YY'))) - TO_NUMBER(SUBSTR(reg_num,1,2))
       END "����", COUNT(*) �ο��� FROM muser
GROUP BY CASE WHEN TO_NUMBER(SUBSTR(reg_num,1,2)) <= TO_NUMBER(TO_CHAR(SYSDATE,'YY'))
              THEN TO_NUMBER(TO_CHAR(SYSDATE,'YY')) - TO_NUMBER(SUBSTR(reg_num,1,2))
              ELSE (100+TO_NUMBER(TO_CHAR(SYSDATE,'YY'))) - TO_NUMBER(SUBSTR(reg_num,1,2))
         END
ORDER BY "����";

-- 20. 2�г� �׷�� 4�г� �׷��� ��� ����ΰ�?
SELECT grade �׷�, COUNT(*) �ο��� FROM muser
GROUP BY grade HAVING grade=2 OR grade=4;


-- �߰� ����
-- 1. ��� ����� �¾ �� ���ñ��� ����� �������� ����Ͻÿ�.
--    ������� : �̸�, �ֹι�ȣ, ���ݱ��� ��ƿ� ����
SELECT name �̸�, reg_num �ֹι�ȣ, 
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
       END "���ݱ��� ��ƿ� ���� ��"
FROM muser;

-- 2. time�� ���̷� �� ��, 30~31���� ��ƿ� ������ ��, 32�� �̻��� ����� ��ƿ� ������ �� ���ϱ�
select name, reg_num,time from muser;

SELECT time ����, SUM(
CASE WHEN SUBSTR(reg_num,3,2) <= TO_CHAR(SYSDATE,'MM')
     THEN CASE WHEN SUBSTR(reg_num,5,2) < TO_CHAR(SYSDATE,'DD')
               THEN (12*time)+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))-1
               ELSE (12*time)+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))
          END
     ELSE CASE WHEN SUBSTR(reg_num,5,2) < TO_CHAR(SYSDATE,'DD')
               THEN ((12*time)-1)+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))-1
               ELSE ((12*time)-1)+((12-SUBSTR(reg_num,3,2))-(12-TO_CHAR(SYSDATE,'MM')))
          END
END) "���ݱ��� ��ƿ� ���� ��" FROM muser
GROUP BY time;

-- 3. ����(time)�� �޿��� ��, OVER()�Լ� �̿�
SELECT DISTINCT time ����, SUM(salary) OVER(PARTITION BY time ORDER BY time) AS �հ� FROM muser;

-- 4. ����(time)�� �ο���, OVER()�Լ� �̿�
SELECT DISTINCT time ����, COUNT(*) OVER(PARTITION BY time) AS �ο��� FROM muser;

-- 5. ��޺� �޿��� �ְ�޿�, OVER()�Լ� �̿�
SELECT DISTINCT grade ���, MAX(salary) OVER(PARTITION BY grade ORDER BY salary) AS "�ְ� �޿�" FROM muser;

-- 6. ����Ŭ �Լ� ����(���� �˻� ���)

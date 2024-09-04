SELECT * FROM muser;

-- ����/�Լ�/�������� �� � ������ �ذ��� �������� �Ǵ�
-- GROUP BY : �׷��� ����, �׷캰 ������ ��� ����Ѵ�.

-- 1. grade�� 3�� ����� ��� ����ΰ�?
SELECT COUNT(*)         -- ���ϴ� ���� �ο���, �ο����� �÷����� �ذ��� �Ұ����ϴ� �Լ��� ����Ѵ�.
FROM muser 
WHERE grade=3;                -- Ʃ���� 3�� ����� ����

-- 2. grade�� 1,2,4�� ������� salary����� ���Ͻÿ�.
SELECT AVG(salary)      -- ���ϴ� ���� salary���, ����� �÷����� �ذ��� �Ұ����ϴ� �Լ��� ����Ѵ�.
FROM muser
--WHERE grade=1 OR grade=2 OR grade=4;
-- �����丵
WHERE grade IN (1,2,4); -- IN �����ڴ� OR�� �ǹ̰� �ִ�.

-- 3. salary�� 20000�̸��� ����� �� ����ΰ�?
SELECT COUNT(*)
FROM muser
WHERE salary<20000;

-- 5. 77��� �߿��� salary�� ���� ���� ����� �̸�, ����, salary�� ����Ͻÿ�.
SELECT          -- �̸�,����,salary
FROM muser
WHERE;           -- 77��� �߿���...
/* 77��� ���� �׽�Ʈ ���� */
SELECT SUBSTR(reg_num,1,2) FROM muser;      -- �߰� �ܰ� ����
-- �� ������ ����
SELECT          -- �̸�,����,salary
FROM muser
WHERE SUBSTR(reg_num,1,2)='77';     -- 77��� �߿���...
/* 77��� ���� �׽�Ʈ ���� */
-- 77��� �߿��� ���� ���� salary�� ��ȸ�Ѵ�.
SELECT MIN(salary)                  -- �̸�,����,salary
FROM muser
WHERE SUBSTR(reg_num,1,2)='77';     -- 77��� �߿���...
-- �� �������� ���� ���� salary�� �޴� ����� ã��, �ش� �������� ���� ���� salary�� �޴� ����� Ʃ���� �����Ѵ�.
SELECT *
FROM muser
WHERE SUBSTR(reg_num,1,2)='77' AND salary=10000;
-- 10000�� ����� �����ϸ� �ȵǸ�, ����,�Լ��� �ذ��� �Ұ����ϴ� ���������� �ذ��Ѵ�.
SELECT name �̸�, reg_num ����, salary �޿�
FROM muser
WHERE SUBSTR(reg_num,1,2)='77' AND salary=(
    SELECT MIN(salary)
    FROM muser
    WHERE SUBSTR(reg_num,1,2)='77');
-- �� �������� ���̸� ������� �ʴ´�.
-- ���̴� ���İ� �Լ��� �ذ��� �����ϴ�.
SELECT 1900+SUBSTR(reg_num,1,2) FROM muser;
SELECT * FROM muser;
-- ����� 1900�� �����ϸ� 2000�� ���� ����ڴ� ���� �����Ͱ� �ȴ�.
-- ���ǿ� ���� 1900 �Ǵ� 2000�� �߰� ������ϴµ�, �ش� ������ DECODE�Լ��� ����Ͽ� ������ �ɾ��־���.
SELECT SUBSTR(reg_num,8,1) FROM muser;
SELECT SUBSTR(reg_num,8,1) "A", DECODE(SUBSTR(reg_num,8,1),'1',1900,'2',1900,2000) "B"
FROM muser;
SELECT SUBSTR(reg_num,8,1) "A", 
       DECODE(SUBSTR(reg_num,8,1),'1',1900,'2',1900,2000) "B",
       DECODE(SUBSTR(reg_num,8,1),'1',1900,'2',1900,2000)+SUBSTR(reg_num,1,2) "C"
FROM muser;
-- ���� ����
-- EXTRACT : ��¥ ���� ���� �Լ� (��/��/��/��/��/��) (YEAR/MONTH/DAY/HOUR/MINUTE/SECOND)
SELECT name �̸�, 
       (EXTRACT (YEAR FROM SYSDATE)) - 
       (DECODE(SUBSTR(reg_num,8,1),'1',1900,'2',1900,2000)+SUBSTR(reg_num,1,2)) ����, 
       salary �޿�
FROM muser
WHERE SUBSTR(reg_num,1,2)='77' AND salary=(
    SELECT MIN(salary)
    FROM muser
    WHERE SUBSTR(reg_num,1,2)='77');
-- ���� �Ǽ��Ͽ� ������ �� �ִ� ����
SELECT name, MIN(salary)
FROM muser
WHERE SUBSTR(reg_num,1,2)='77';
-- ���� ���� : name�� ������, MIN(salary)�� ������, MIN�Լ��� �����Լ��̱⶧����

-- 7. ������ ��� �޿��� ���Ͻÿ�.
SELECT AVG(salary)      -- salary ���
FROM muser
WHERE SUBSTR(reg_num,8,1) IN ('1','3');     -- ���� : �Լ��� �̿��Ͽ� ������ �м��Ѵ�.

-- 8. ��ü ��ձ޿����� ���� �޿��� �޴� ����� �̸��� �޿��� ����Ͻÿ�.
SELECT name, salary
FROM muser
WHERE salary>(
    SELECT AVG(salary) 
    FROM muser);

-- 9. ��ü ��ձ޿����� ���� �޿��� �޴� ����� �̸��� �޿�, ��ձ޿��� ����Ͻÿ�.
SELECT name, salary,
    (SELECT AVG(salary) 
     FROM muser) ��ձ޿�       -- ��Į�� ��������
FROM muser
WHERE salary>(
    SELECT AVG(salary) 
    FROM muser);
-- �ش� �������� �������� SELECT���� Ʃ���� �ϳ��� �ϼ��� ������ 
-- ������ ���������� ��� �ݺ��Ͽ� �����ϱ� ������ ������ ���� �ʴ�. (��Į�� ��������)
-- �ش� ������ �������� �ذ��� �� �ִٰ� �Ѵ�.

-- 12. �׷캰 ��ձ޿��� ��ü ��պ��� ���� �׷��� ����Ͻÿ�.
SELECT grade, AVG(salary) 
FROM muser 
GROUP BY grade HAVING AVG(salary)>(SELECT AVG(salary) FROM muser);
-- �׷캰 ����� ���Ѵ�.
-- �� �׷캰�� ��ü ��պ��� ���� �׷��� �����Ѵ�. (���� : GROUP�� ���� �����̴� HAVING�� ���)

-- 14. �������� ������ ����Ͻÿ�. (��� ���´� �̸�, ����(������ ��or��))
SELECT name �̸�,
       DECODE(SUBSTR(reg_num,8,1),'1','��','3','��','��') ����
FROM muser;
-- ������ ����ϴ� ���̱� ������ �Լ��� ����Ͽ� ����Ѵ�.
-- DECODE�Լ��� ������� �ʰ� ���� ������ �̿��Ͽ� ������ ó���� �� �ִ�.
-- ����Ŭ���� ���ǿ� ���� ó���ϴ� ������ CASE WHEN THEN ELSE END
-- CASE WHEN THEN ELSE END�� ������ �м�
-- CASE
--      WHEN ����1 THEN ����1�� ���� ��� ����
--      WHEN ����2 THEN ����2�� ���� ��� ����
--      ELSE � ���ǵ� ���� �ƴ� ��� ����(������ ��� ����)
-- END
SELECT name �̸�,
       CASE WHEN SUBSTR(reg_num,8,1) IN ('1','3') THEN '��'
            ELSE '��'
       END ����
FROM muser;

-- �ߺ� ����
SELECT DISTINCT grade, salary FROM muser;
-- DISTINCT�Լ��� �ߺ��� �÷��� �����ϰ�, SELECT������ �ѹ��� ����� �����ϴ�.
-- �ߺ� ���� ������ SELECT���� ������ ��ü ���� �ߺ��̴�.
-- #3 �������� ���ɺ�(time�÷�) �޿��� ��, OVER()�Լ� �̿� �ϴ� �������� ������ ���� ����Ѵ�.
SELECT time ����, SUM(salary) OVER(PARTITION BY time) ����
FROM muser;
-- �� ������ ���� ����ϸ� �ߺ��Ǵ� ���� ���Ե� ���·� ��µǹǷ� 
-- ���� �������� ���� DISTINCT�Լ��� ����Ͽ� �ߺ��� ������ �� �ִ�.
SELECT DISTINCT time ����, SUM(salary) OVER(PARTITION BY time) ����
FROM muser;

-- #2 ����
SELECT
    (SELECT TRUNC(SUM(MONTHS_BETWEEN(SYSDATE,SUBSTR(reg_num,1,6)))) 
     FROM muser WHERE time IN (30,31)) AS "30��~31���� ������ ��", 
    (SELECT TRUNC(SUM(MONTHS_BETWEEN(SYSDATE,SUBSTR(reg_num,1,6))))
     FROM muser WHERE time>=32) AS "32�� �̻��� ����� ������ ��"
FROM dual;

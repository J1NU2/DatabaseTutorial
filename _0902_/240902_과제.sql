-- 1. ���̺� �����
CREATE TABLE users (
no INT PRIMARY KEY,
name VARCHAR2(10),
addr VARCHAR2(10),
point NUMBER,
grade VARCHAR2(1),
jumin VARCHAR2(8));

-- 2. ���̺� Ʃ�� ����
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

-- 3. ���� Ǯ��
--    ���κ��� ���� ������ Ǯ��, ������ ������ ���� ���纻 ��
--    ������ ������ ��ŭ ����� �ۼ��Ͽ� ���κ��� �����մϴ�.

-- 1. ��� ������� �̸��� ������ ��������� �˻��Ͻÿ�.
SELECT name �̸�, point ����, SUBSTR(jumin,1,6) ������� FROM users;
-- 2. 80�� �̻��� ����� �̸��� �ּ�, ������ �˻��Ͻÿ�.
SELECT name �̸�, addr �ּ�, point ���� FROM users WHERE point>=80;
-- 3. �̸��� kim���� ���۵Ǵ� ����� �̸�, �ּ�, ������ �˻��Ͻÿ�.
SELECT name �̸�, addr �ּ�, point ���� FROM users WHERE SUBSTR(name,1,3)='kim';
-- 4. ���� �������� +10���� ������ ������ ����Ͻÿ�. (���� �����Ϳ� �ݿ����� �ʽ��ϴ�.)
SELECT name �̸�, point ��������, point+10 �������� FROM users;
-- 5. 1�г��� ������ +1���� �÷��� ����ϼ���. (���� �����Ϳ� �ݿ����� �ʽ��ϴ�.)
SELECT name �̸�, grade �г�, point ����, point+1 �߰����� FROM users WHERE grade=1;
-- 6. B����� ȹ���� ����� �̸�, �ּ�, ������ ����ϼ��� (B����� 80���̻� 90���̸��Դϴ�.)
SELECT name �̸�, addr �ּ�, point ���� FROM users WHERE point>=80 AND point<90;
-- 7. ���� ��� �� NULL�� ���� �Է����� ���� ���Դϴ�.
--    �ּҸ� �Է����� ���� �л��� �̸�, �ּ�, �г�, ����, �ֹι�ȣ�� ����ϼ���.
SELECT * FROM users;
SELECT name �̸�, addr �ּ�, grade �г�, point ����, jumin �ֹι�ȣ FROM users WHERE addr IS NULL;
-- 8. 4�г��� ������ 10%�� �ø� ������ ����ϼ���.
SELECT name �̸�, grade �г�, point ����, point+(point*0.1) �߰����� FROM users WHERE grade=4;
-- 9. ������ ���� �л����� ����ϼ���. (��ȣ, �̸�, �ּ�, ����)
SELECT no ��ȣ, name �̸�, addr �ּ�, point ���� FROM users ORDER BY point;
-- 10. �г��� ������������ �����Ͻÿ�. (��ȣ, �̸�, �г�, ����)
--     ��, �г��� ������ ��� ����Ʈ�� ���� ����� ���� ��µ˴ϴ�.
SELECT no ��ȣ, name �̸�, grade �г�, point ���� FROM users ORDER BY grade, point DESC;
-- 11. ���� �������� -10�� ������ ����� �ݿ��Ͽ�, 80�� �̻��� ����� �̸�, ����, ������ ��� ������ ����ϼ���.
SELECT name �̸�, point ����, point-10 �������� FROM users WHERE point>=80;
-- 12. 2�г��� ��� �л��� ����Ͻÿ�. ��� �÷����� �̸�, �ּ�, �г����� ����Ͻÿ�.
--     ���⼭ �̸��� name�÷�, �ּҴ� addr�÷�, �г��� grade�÷��� �ǹ��Ѵ�.
SELECT name �̸�, addr �ּ�, grade �г� FROM users WHERE grade=2;

-- �߰� ����
-- 13. �л��� �� ����ΰ�?
SELECT COUNT(*) "�л� ��" FROM users;
-- 14. 1�г��� �� ����ΰ�?
SELECT COUNT(*) "1�г� �л� ��" FROM users WHERE grade=1;
-- 15. ��� �л��� �̸��� �г��� ����Ͻÿ�. ��, �̸��� ��� �ҹ��ڷθ� ����Ͻÿ�.
SELECT LOWER(name) �̸�, grade �г� FROM users;
-- 16. 2�г� �л��� �̸��� �г��� ����Ͻÿ�. ������ ���� �ּҴ� �ձ��� 2���ڸ� ����Ͻÿ�.
SELECT name �̸�, grade �г�, SUBSTR(addr,1,2) "�ּ�(����)" FROM users;
-- 17. ��� �л��� ������ ���� �ڸ��� �����Ͻÿ�. (�ݿø����� ������, ���� �����Ϳ� �ݿ����� �ʽ��ϴ�.)
SELECT name �̸�, SUBSTR(point,2,LENGTH(point)) ���� FROM users;
-- 18. ��� �л��� ������ �ݿø��Ͽ� ����Ͻÿ�. (���� �����Ϳ� �ݿ����� �ʽ��ϴ�.)
SELECT name �̸�, ROUND(point,0) ���� FROM users;
-- 19. 2�г��� ��� ����ΰ�?
SELECT COUNT(*) "2�г� �л� ��" FROM users WHERE grade=2;
-- 20. 1�г� �� 80�� �̻��� ����ΰ�?
SELECT COUNT(*) "1�г� �� 80�� �̻� �л� ��" FROM users WHERE grade=1 AND point>=80;
-- 21. 3�г��� ����� �����Դϱ�?
SELECT AVG(point) "3�г� ��� ����" FROM users WHERE grade=3;
-- 22. ��ü �л� �� �ְ����� �����Դϱ�?
SELECT MAX(point) �ְ����� FROM users;
-- 23. 2�г� �� ���� ���� ������ ȹ���� ������ �����Դϱ�?
SELECT MIN(point) "2�г� �� ��������" FROM users WHERE grade=2;

-- ���߰� ����
-- 24. ������ ���ؼ� �ּҸ� ��� ������� �ʰ� ���� �� ���ڸ� ����ϰ� �ڿ� *�� �ϳ� ���δ�.
--     ��, ���� �����Ϳ� �ݿ����� �ʽ��ϴ�. (���� : suwon �� su*)
SELECT name �̸�, CONCAT(SUBSTR(addr,1,2),'*') FROM users;
-- 25. �̸��� �� �հ� �� �ڿ� *�� �ٿ� ����Ѵ�. (��, ���� �����Ϳ� �ݿ����� �ʽ��ϴ�.)
SELECT CONCAT('*',CONCAT(name,'*')) FROM users;
-- �Ǵ�
SELECT '*' || name || '*' FROM users;
-- 26. ��������� �״�� ������� ����, xx��xx��xx�� �������� ����Ѵ�.
--     ��, ������ �����ϸ� ���� �����Ϳ� �ݿ����� �ʽ��ϴ�.
SELECT name �̸�, 
    SUBSTR(jumin,1,2) || '��' || 
    SUBSTR(jumin,3,2) || '��' || 
    SUBSTR(jumin,5,2) || '��' "�������"
FROM users;
-- 27. �̸�, ����, �г�, �������, ������ �߰��Ѵ�.
--     ������ ������Ϸ� �Ǵ��ϸ� ������ ���ڰ� 1�̸� ��, 2�̸� ����� ǥ���Ѵ�.
-- 27-1. DECODE �Լ� ���
SELECT name �̸�, point ����, grade �г�, SUBSTR(jumin,1,6) �������,
    DECODE(SUBSTR(jumin,-1),'1','��','��') "����"
FROM users;
-- 27-2. CASE WHEN ǥ���� ���
SELECT name �̸�, point ����, grade �г�, SUBSTR(jumin,1,6) �������,
    CASE WHEN SUBSTR(jumin,-1)='1' THEN '��'
         ELSE '��'
    END "����"
FROM users;

-- ���� WHERE�� ���� �� �Լ� ����
-- SUBSTR : ���ڿ��� �ڸ��� �ڸ� ���ڿ��� �����ϴ� �Լ� : (���ڿ�or������Ÿ���� ���ڿ��� �÷���,������ġ,����)
-- WHERE������ ����ϴ� �� ������ (AND, OR, NOT)
-- > AND : ������ ��� �����ϴ� ����� ����
-- > OR : ���� �� �ϳ��� �����ϴ� ����� ����
-- > NOT : ������ ������ �ƴ� ����� ����
-- WHERE������ NULL ���ο� ���� Ʃ���� ���� ���͸� �� �� ����ϴ� ����
-- IS NULL : NULL�� ����� ����
-- IS NOT NULL : NULL�� �ƴ� ����� ����
-- ORDER BY : �⺻ ��������(ASC), DESC ��� �� ��������
-- COUNT : Ʃ���� ���� �������ִ� �Լ� : (*:��ü, �÷���:Ư���÷�)
-- AVG : ����� ����ϴ� �Լ�
-- MAX : �ִ밪�� ���ϴ� �Լ�
-- MIN : �ּҰ��� ���ϴ� �Լ�
-- CONCAT : 2���� ���ڿ��� ���ļ� ��� ���� �����ϴ� �Լ� : ����+���ڿ��� ���µ� �����ϴ�.
-- > ���ڿ��� ��ĥ ��, �Լ��� ��� ���ϴ��� '||'�� ����ϸ� ��ġ�� ���� �����ϴ�.
-- DECODE : ���ǿ� �´� ���ϴ� ��� ���� �����ϴ� �Լ� : ���α׷����� if��,if-else���� ����� ��� ����
-- > (��or�÷���,����,���,�ƴҰ���ǰ��) �Ǵ� (��or�÷���,����1,���1,����2,���2, ... ,�ƴҰ���ǰ��)
-- + DECODE �Լ��� ��ü�� �� �ִ� CASE WHEN ǥ���ĵ� �����Ѵ�.
-- ���� : CASE WHEN ���� THEN ���ϰ� ELSE ���ϰ�

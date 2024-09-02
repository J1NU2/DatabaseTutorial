CREATE TABLE hm (
no number(3) PRIMARY KEY,
name VARCHAR2(10) NOT NULL,
point NUMBER(5) DEFAULT 0,
addr VARCHAR2(20),
indate TIMESTAMP DEFAULT sysdate
);

INSERT INTO hm VALUES (1,'ȫ�浿',45,'�����',default);
INSERT INTO hm VALUES (2,'������',50,'������',default);
INSERT INTO hm VALUES (3,'������',43,'�����',default);

SELECT * FROM hm;
SELECT no,name FROM hm;
SELECT COUNT(*) FROM hm;

-- ����1 : ��� ����� �̸��� ������ ����Ͻÿ�.
SELECT no,name FROM hm;
-- ����2 : ������ 50�� �̸��� ����� �̸��� ������ ����Ͻÿ�.
SELECT name,point FROM hm WHERE point<50;
-- ����3 : ������ 50�� �̸��� ����� ��� ������� ����Ͻÿ�.
SELECT COUNT(*) FROM hm WHERE point<50;
-- ����4 : ȫ�浿�� ������ �������� ����Ͻÿ�.
SELECT name,point FROM hm WHERE name='ȫ�浿';
-- ����5 : �������� ��� ������ ����Ͻÿ�.
SELECT * FROM hm WHERE name='������';

-- �÷����� �ѱ۷� �ٲٱ�(�÷� ��Ī ����)
SELECT name �̸�, point ���� FROM hm WHERE point<50;

-- 1. ��� �л��� �̸��� ������ ����մϴ�. �̶�, ����Ʈ�� ���� ����Ʈ���� 10�� �÷��� ����Ͻÿ�.
SELECT name �̸�, point+10 ���� FROM hm;
-- 2. ��� �л��� �̸��� ������ ����մϴ�. �̶�, ����� ���´� �̸�/��������/��������
-- �̸��� �л��̸�, ���������� ����� ����, ���������� +10�� �ø� ����
SELECT name �̸�, point ��������, point+10 �������� FROM hm;

SELECT * FROM hm;
-- ����(Update), WHERE�� ���ٸ� ��� Ʃ�� ����
UPDATE hm SET name='���л�', point=100 WHERE name='������';
SELECT * FROM hm;
-- ����(Delete), WHERE�� ���ٸ� ��� Ʃ�� ����
DELETE FROM hm WHERE name='���л�';
SELECT * FROM hm;

SELECT sysdate FROM dual;
SELECT concat('����','��') �̸� FROM dual;

-- 1. ��� ����� �̸��� ������ ����մϴ�. �̶�, �̸� �ڿ� '��'�� �ٿ� ����Ͻÿ�.
SELECT concat(name, '��') �̸�, point ���� FROM hm;
-- 2. ��� ����� �̸�, ����, ������� ����մϴ�. �̶�, ���� ������ ���� ����մϴ�.
--    ���� ���߿� ������ ����� ���� ���� ���, �����=indate
SELECT name �̸�, point ����, indate ����� FROM hm ORDER BY indate DESC;
-- 3. ������ 50�̻��� ����� �̸��� ������ ����մϴ�.
--    �̶�, ������ ��ȣ,�̸�,������ ������ ���ڿ��� ����Ѵ�.
SELECT name �̸�, concat(concat(no,name),point) ���� FROM hm WHERE point>=50;
-- �Ǵ�
SELECT name �̸�, no || name || point ���� FROM hm WHERE point>=50;
-- 4. ������ �Ǵ� ������ 60�̴�. ��� ȸ���� ���� ������ ���߱� ���� ������ ������ ����Ͻÿ�.
--    ����� �̸�, ��������, ����������
SELECT name �̸�, point ��������, 60-point ���������� FROM hm;

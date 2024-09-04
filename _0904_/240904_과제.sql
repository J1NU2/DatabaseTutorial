-- �׽�Ʈ �� ������ �� �ִ� ���̺� ����
DROP TABLE users;
DROP TABLE carinfo;

-- ���̺� ����
-- id:��ȣ / name:ȸ���̸� / addr:�ּ�
CREATE TABLE users (
id VARCHAR2(8),
name VARCHAR2(10),
addr VARCHAR2(10));

-- c_num:�ڵ�����ȣ / c_name:�ڵ������� / id:��ȣ
CREATE TABLE carinfo (
c_num VARCHAR2(4),
c_name VARCHAR2(10),
id VARCHAR2(8));

-- Ʃ�� ����
INSERT INTO users VALUES ('1111','kim','����');
INSERT INTO users VALUES ('2222','lee','����');
INSERT INTO users VALUES ('3333','park','����');
INSERT INTO users VALUES ('4444','choi','����');

INSERT INTO carinfo VALUES ('1234','����','1111');
INSERT INTO carinfo VALUES ('3344','����','1111');
INSERT INTO carinfo VALUES ('5566','����','3333');
INSERT INTO carinfo VALUES ('6677','����','3333');
INSERT INTO carinfo VALUES ('7788','����','4444');
INSERT INTO carinfo VALUES ('8888','����','5555');

COMMIT;

-- Ʃ��(��) �߰��ϰ� �׻� Ȯ���ϱ�
SELECT * FROM users;
SELECT * FROM carinfo;


-- ����1. ȸ���� �̸��� �ּҸ� ����Ͻÿ�.
SELECT name �̸�, addr �ּ� FROM users;

-- ����2. ȸ���� �̸��� ������ �ڵ��� ��ȣ�� ����Ͻÿ�.
SELECT u.name ȸ���̸�, c.c_num �ڵ�����ȣ
FROM users u
INNER JOIN carinfo c
ON u.id=c.id;

-- ����3. �ڵ��� ��ȣ�� 7788�� �������� �̸��� �ּҸ� ����Ͻÿ�.
SELECT u.name ȸ���̸�, u.addr �ּ�
FROM users u
INNER JOIN carinfo c
ON u.id=c.id AND c.c_num='7788';

-- ����4. �ڵ����� �������� ���� ����� �̸��� �ּҸ� ����Ͻÿ�.
SELECT u.name ȸ���̸�, u.addr �ּ�
FROM users u
LEFT OUTER JOIN carinfo c
ON u.id=c.id
WHERE c.id IS NULL;

-- ����5. ȸ���� ����� �ڵ��� ���� ����Ͻÿ�.
SELECT u.id ȸ����ȣ, COUNT(c.id) "�ڵ��� ��"
FROM users u
INNER JOIN carinfo c
ON u.id=c.id
GROUP BY u.id
ORDER BY u.id;
-- ����(ORDER BY��)�� ���� ������� �ʾƵ� �ȴ�.

-- ����6. 2�� �̻��� ������ ȸ���� �̸��� ������ �ڵ��� ���� ����Ͻÿ�.
SELECT u.name ȸ���̸�, COUNT(c.id) "�ڵ��� ��"
FROM users u
INNER JOIN carinfo c
ON u.id=c.id
GROUP BY u.name HAVING COUNT(c.id)>=2;

-- ����7. �ڵ����� ��ϵǾ� �ִµ�, �����ڰ� ���� �ڵ��� ��ȣ�� ����Ͻÿ�.
SELECT c.c_num �ڵ�����ȣ
FROM carinfo c
LEFT OUTER JOIN users u
ON u.id=c.id
WHERE u.name IS NULL;
-- �Ǵ�
SELECT c.c_num �ڵ�����ȣ
FROM users u
RIGHT OUTER JOIN carinfo c
ON u.id=c.id
WHERE u.name IS NULL;

-- �������ʹ� 3���� ���̺��� �����ϴ� �����̴�.
-- ���ο� ���̺� ����
-- c_num:�ڵ�����ȣ / c_com:������ / c_name:�ڵ����̸� / c_price:�ڵ�������
CREATE TABLE companycar (
c_num VARCHAR2(4),
c_com VARCHAR2(30),
c_name VARCHAR2(10),
c_price NUMBER);

-- Ʃ�� ����
INSERT INTO companycar VALUES ('1234','����','�ҳ�Ÿ',1000);
INSERT INTO companycar VALUES ('3344','���','����',2000);
INSERT INTO companycar VALUES ('7788','���','��2',800);
INSERT INTO companycar VALUES ('9900','����','�׷���',2100);

COMMIT;

-- Ʃ��(��) �߰��ϰ� �׻� Ȯ���ϱ�
SELECT * FROM companycar;


-- ����8. ���� �ڵ����� ����ȣ, ������, �ڵ�����, ������ ����Ͻÿ�.
SELECT cp.c_num ����ȣ, cp.c_com ������, cp.c_name �ڵ�����, cp.c_price ����
FROM carinfo c
INNER JOIN companycar cp
ON c.c_num=cp.c_num;
-- �Ǵ�
SELECT cp.*
FROM carinfo c
INNER JOIN companycar cp
ON c.c_num=cp.c_num;
-- �� ����� �÷����� ��Ī���� ǥ����� �ʾ� ���µ� ������� �ִ�.

-- ����9. ȸ�翡�� ���Ŵ� �Ͽ����� �������� ���� �ڵ����� ����ȣ, ������, �ڵ����̸��� ����Ͻÿ�.
SELECT cp.c_num ����ȣ, cp.c_com ������, cp.c_name �ڵ�����, cp.c_price ����
FROM carinfo c
RIGHT OUTER JOIN companycar cp
ON c.c_num=cp.c_num
WHERE c.c_num IS NULL;

-- ����10. �ڵ��� ������ 1000���� �̻��� �ڵ����� �ڵ��� ��ȣ�� ����Ͻÿ�.
SELECT c_num �ڵ�����ȣ
FROM companycar
WHERE c_price>=1000;

-- ����11. ������ �ڵ��� �߿��� ȸ�翡�� ������ �ڵ����� �ƴ� �ڵ��� ��ȣ�� ����Ͻÿ�.
SELECT c.c_num �ڵ�����ȣ
FROM carinfo c
LEFT OUTER JOIN companycar cp
ON c.c_num=cp.c_num
WHERE cp.c_num IS NULL;

-- ����12. ��� ����� ������ ����Ͻÿ�. (�̸�, �������� �ڵ�����ȣ, �ڵ����̸�)
SELECT u.name ȸ���̸�, c.c_num "������ �ڵ�����ȣ", cp.c_name �ڵ����̸�
FROM users u, carinfo c, companycar cp
WHERE u.id=c.id AND c.c_num=cp.c_num;

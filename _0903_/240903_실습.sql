SELECT * FROM users;
SELECT * FROM users ORDER BY grade;

-- 0. �г��� �������� �ο����� ����Ѵ�.
SELECT grade �г�, COUNT(*) �ο��� FROM users GROUP BY grade;

-- ����1. �׷캰 �ο����� ����ϵ� �г��� ������������ ����
SELECT grade �г�, COUNT(*) �ο��� FROM users GROUP BY grade ORDER BY grade;
-- �Ǵ�
SELECT grade �г�, COUNT(*) �ο��� FROM users GROUP BY grade ORDER BY grade ASC;

-- ����2. �׷캰 �ְ����� �������� ����Ͻÿ�.
SELECT grade �г�, MAX(point) �ְ���, MIN(point) ������ FROM users GROUP BY grade;

-- ����3. �׷캰 �ְ����� ȹ���� ����� �̸���?
SELECT grade �г�, name �̸�, MAX(point) �ְ��� FROM users GROUP BY grade;
-- �� name(�̸�)�� �׷�ȭ�� �Ǿ����� �ʱ� ������ ������ �߻��Ѵ�.


-- Ȯ�ι���
-- 1. 3�г�� 4�г� ���� �׷��� �ο����� ����Ͻÿ�.
SELECT grade �г�, COUNT(*) �ο��� FROM users WHERE grade=3 OR grade=4 GROUP BY grade;

-- 2. 1�г�� 2�г��� �ְ����� �������� ���� ���̸� ����Ͻÿ�.
SELECT grade �г�, MAX(point) �ְ���, MIN(point) ������, MAX(point)-MIN(point) ��������
FROM users WHERE grade=1 OR grade=2 GROUP BY grade;

-- 3. �ֹι�ȣ 2�ڸ��� �¾ �⵵�̴�. ���� �⵵�� �¾ ����� ī�����Ͻÿ�.
--    �̶� �¾ �⵵�� �ο����� ����Ѵ�.
SELECT SUBSTR(jumin,1,2) ����⵵, COUNT(*) FROM users GROUP BY SUBSTR(jumin,1,2);
-- �������� ����
SELECT SUBSTR(jumin,1,2) ����⵵, COUNT(*) FROM users GROUP BY SUBSTR(jumin,1,2) ORDER BY SUBSTR(jumin,1,2);
-- �Ǵ�
SELECT SUBSTR(jumin,1,2) ����⵵, COUNT(*) FROM users GROUP BY SUBSTR(jumin,1,2) ORDER BY SUBSTR(jumin,1,2) ASC;


-- ��������
--  �׷��� ���� �� �׷캰 ������ ������ �� �ִ�.
--  ���� ���, �׷��� �ο��� 3�� �̻��� �׷��� �ο����� ����Ͻÿ�.
--  �� ���û����� �׷캰�� �ο��� ī�����ϰ�, �׷��߿� �ο����� 3�� �̻��� �׷츸 �����ϴ� �ǹ��̴�.
--  �׷쿡 ������ �����ϴ� ����� ã�ƺ��ÿ�.
--  �ش� ����� �̿��Ͽ� �׷��� �ο��� 3�� �̻��� �׷��� �ο����� ����ϴ� �������� �ۼ��Ͻÿ�.
SELECT grade �г�, COUNT(*) �ο��� FROM users
GROUP BY grade HAVING COUNT(*)>=3;
-- �׷쿡 ������ �����ϴ� ����� HAVING���� ����ϸ� �ȴ�.
-- �� Ȯ�ι���1�� WHERE�� ��� �Ʒ� ������ó�� �׷쿡 ���� ������ �����ϱ� ���� HAVING���� ����ϴ� ���� ����.
SELECT grade �г�, COUNT(*) �ο��� FROM users
GROUP BY grade HAVING grade=1 OR grade=4;
-- ������ ���� �ش� ������ �־��� ������ �׷����� �־������� �Ǵ��Ͽ� WHERE���� HAVING���� ��Ȳ�� �°� ����ϴ� ���� ����.

-- ��������(SubQuery)
-- �� �г��� �г� ����� ��ü ��պ��� ���� ����� ����
SELECT grade �г�, AVG(point) ��� FROM users
GROUP BY grade HAVING AVG(point)>=(SELECT AVG(point) FROM users);

-- ���� ���� ������ ȹ���� ����� �̸��� ������?
SELECT name �̸�, point ���� FROM users
WHERE point=(SELECT MAX(point) FROM users);

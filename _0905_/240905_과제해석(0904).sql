-- ����1. ȸ���� �̸��� �ּҸ� ����Ͻÿ�.
-- �̸��� �ּҴ� users ���̺� �����ϹǷ�, ������ �ʿ����.
SELECT name, addr FROM users;

-- ����2. ȸ���� �̸��� ������ �ڵ��� ��ȣ�� ����Ͻÿ�.
-- ȸ���� �̸��� users���̺� �ڵ�����ȣ�� carinfo���̺� �����Ƿ�, ������ �ʿ��ϴ�.
-- ȸ���� ������ �ڵ�����ȣ�� ����ؾ��ϱ� ������ Inner Join�� ����Ѵ�.
SELECT u.name, c.c_num
FROM users u, carinfo c     -- ���� ��������� ���´ٸ� Full Join�� �ȴ�.
WHERE u.id=c.id;

-- ����3. �ڵ��� ��ȣ�� 7788�� �������� �̸��� �ּҸ� ����Ͻÿ�.
-- �ڵ��� ��ȣ�� 7788�� ���� ã������ �������� ã�ƾ��Ѵ�. WHERE��
-- �̸��� �ּҴ� users���̺� ����������, �ڵ�����ȣ 7788�� carinfo���̺� �����ϹǷ� ������ �ʿ��ϴ�.
-- 3_1. �������� ã��
SELECT u.name, u.addr
FROM users u, carinfo c
WHERE u.id=c.id AND c.c_num='7788';
-- 3_2. ���������� ã��
SELECT id FROM carinfo WHERE c_num='7788';
SELECT name, addr
FROM users
WHERE id=(SELECT id FROM carinfo WHERE c_num='7788');

-- ����4. �ڵ����� �������� ���� ����� �̸��� �ּҸ� ����Ͻÿ�.
-- �̸��� �ּҴ� users���̺� ���������� �ڵ����� ���õ� ������ carinfo���̺� �����Ƿ�, ������ ����ؾ��Ѵ�.
-- ������, �ڵ����� �������� ���� ����� ������ �˾Ƴ����ϴ� ������ �����Ƿ� OUTER JOIN�� ����Ͽ� Ʃ���� �̾Ƴ���
SELECT u.name, u.addr
FROM users u
LEFT OUTER JOIN carinfo c
ON u.id=c.id
WHERE c.id IS NULL;     -- Ʃ���� ���� NULL�� �����ϴ� ���̺� ����ϰ� �ȴٸ� �ڵ����� �������� ���� ����� �˾Ƴ� �� �ִ�.
-- LEFT OUTER JOIN�� �Ʒ��� ���� ���·ε� ����� �����ϴ�.
SELECT u.name, u.addr
FROM users u, carinfo c
WHERE u.id=c.id(+) AND c.id IS NULL;        -- ������ �����ʿ� (+)�� ������ LEFT OUTER JOIN, ���ʿ� (+)�� ������ RIGHT OUTER JOIN �̴�.

-- ����5. ȸ���� ����� �ڵ��� ���� ����Ͻÿ�.
-- ȸ���� users���̺��̰� �ڵ����� carinfo���̺��̴�.
-- ȸ���� �ڵ��� ���� ���õ� ���踦 �ϱ� ���ؼ� �� ���̺��� �����Ͽ� ���� �Լ��� COUNT�� ����ؾ��Ѵ�.
SELECT u.name, COUNT(*)
FROM users u, carinfo c
WHERE u.id=c.id
GROUP BY u.name;
-- ������ �� �������� ���� ȸ���� �̸��� �׷����� �����ϸ� ���������� ������ �� ����.
SELECT u.name, COUNT(*)
FROM users u, carinfo c
WHERE u.id=c.id
GROUP BY u.id;
-- �� �������� ���� �׷��� id�� �����ִ� ���� ������ u.name�� �������̱� ������ �ش� �������� ������ �߻��Ѵ�.
-- �׷��Ƿ�, �Ʒ� �������� ���� GROUP BY���� ���ռӼ����� �����Ѵٸ� �ذ��� �����ϴ�.
SELECT u.name, COUNT(*)
FROM users u, carinfo c
WHERE u.id=c.id
GROUP BY (u.id,u.name);

-- ����6. 2�� �̻��� ������ ȸ���� �̸��� ������ �ڵ��� ���� ����Ͻÿ�.
-- ����5���� ���������� �ڵ��� ���� 2�� �̻��� ����� ������ �����Ѵ�.
-- ȸ���� ���� �ڵ��� ���� �˱� ���� ȸ���� �׷�ȭ ����� ������ WHERE���� ����ϴ� ���� �ƴ�
-- �׷쿡 ���� ������ �ɾ��ִ� HAVING���� ����ϴ� ���� ���ٰ� �����ȴ�.
SELECT u.name, COUNT(*)
FROM users u, carinfo c
WHERE u.id=c.id
GROUP BY (u.id,u.name) HAVING COUNT(*)>=2;

-- ����7. �ڵ����� ��ϵǾ� �ִµ�, �����ڰ� ���� �ڵ��� ��ȣ�� ����Ͻÿ�.
-- �����ڿ� ���õ� ������ users���̺�, �ڵ����� ������ carinfo���̺� �ִ�.
-- �̶�, �����ڰ� ���� �ڵ��� ��ȣ�� ����� ���̱� ������ OUTER JOIN�� �ʿ��ϴٰ� ������ �� �ִ�.
-- OUTER JOIN�� ����ϴµ�, � ���̺��� ���� ���� �Ǵ��� �� ���ΰ�?
-- users ���̺��� ���� ���� �Ǵ�
SELECT c.c_num
FROM users u
RIGHT OUTER JOIN carinfo c
ON u.id=c.id
WHERE u.id IS NULL;
-- carinfo ���̺��� ���� ���� �Ǵ�
SELECT c.c_num
FROM carinfo c
LEFT OUTER JOIN users u
ON c.id=u.id
WHERE u.id IS NULL;
-- ������ ���� ���·ε� ����� �����ϴ�.
SELECT c.c_num
FROM users u, carinfo c
WHERE u.id(+)=c.id AND u.id IS NULL;    -- RIGHT JOIN

-- ����8. ���� �ڵ����� ����ȣ, ������, �ڵ�����, ������ ����Ͻÿ�.
-- ����ȣ,������,�ڵ�����,������ companycar���� Ȯ���� �����ϳ�, ���� �ڵ����� ������ �˾Ƴ����ϴ� carinfo�� JOIN�� �ʿ��ϴ�.
-- ������ �ڵ����� �������� �ʿ��� ���̱� ������ INNER JOIN�� ����Ѵ�.
SELECT cc.c_num, cc.c_com, cc.c_name, cc.c_price
FROM carinfo c, companycar cc
WHERE c.c_num=cc.c_num;

-- ����9. ȸ�翡�� ���Ŵ� �Ͽ����� �������� ���� �ڵ����� ����ȣ, ������, �ڵ����̸��� ����Ͻÿ�.
-- ����8���� ���������� ����ȣ,������,�ڵ������� companycar���� Ȯ���� �����ϳ�, ���� �ڵ����� ������ �˾Ƴ����ϴ� carinfo�� JOIN�� �ʿ��ϴ�.
-- ������, �������� ���� �ڵ����� ������ �ʿ��ϹǷ� OUTER JOIN�� ����Ѵ�.
SELECT cc.c_num, cc.c_com, cc.c_name
FROM carinfo c
RIGHT OUTER JOIN companycar cc
ON c.c_num=cc.c_num
WHERE c.c_num IS NULL;
-- �Ǵ�
SELECT cc.c_num, cc.c_com, cc.c_name
FROM carinfo c, companycar cc
WHERE c.c_num(+)=cc.c_num AND c.c_num IS NULL;
-- ���� companycar ���̺��� ���� ���� �Ǵ��Ѵٸ� �Ʒ� �������� ���� ����� �� �ִ�.
SELECT cc.c_num, cc.c_com, cc.c_name
FROM companycar cc
LEFT OUTER JOIN carinfo c
ON c.c_num=cc.c_num
WHERE c.c_num IS NULL;

-- ����10. �ڵ��� ������ 1000���� �̻��� �ڵ����� �ڵ��� ��ȣ�� ����Ͻÿ�.
-- �ڵ����� ���ݰ� ��ȣ�� �˾Ƴ��� ���� companycar���̺��� �ذ��� �� �� �ֱ� ������ ������ ����� �ʿ䰡 ����.
-- �ڵ��� ������ 1000���� �̻��� ������ �ɷ������Ƿ� WHERE���� ����Ѵ�.
SELECT c_num
FROM companycar
WHERE c_price>=1000;

-- ����11. ������ �ڵ��� �߿��� ȸ�翡�� ������ �ڵ����� �ƴ� �ڵ��� ��ȣ�� ����Ͻÿ�.
-- ������ �ڵ����� ������ carinfo���̺�, ȸ�翡�� ������ �ڵ����� ������ companycar���̺� �����Ѵ�.
-- �ΰ��� ���̺��� JOIN�ϴµ�, ȸ�翡�� ������ �ڵ����� �ƴ� ���� �˾Ƴ����ϱ� ������ OUTER JOIN�� ����Ѵ�.
SELECT c.c_num
FROM carinfo c
LEFT OUTER JOIN companycar cc
ON c.c_num=cc.c_num
WHERE cc.c_num IS NULL;

-- ����12. ��� ����� ������ ����Ͻÿ�. (�̸�, �������� �ڵ�����ȣ, �ڵ����̸�)
-- ��� ����� ������ ����� �� �̸��� users���̺�, �������� �ڵ�����ȣ�� carinfo���̺�, �ڵ����̸��� companycar���̺� �����Ѵ�.
-- 3���� ���̺��� �����ؾ��ϱ� ������ ������� 2���� ���̺��� ������ �� ���� ������ ���̺��� ������ ���̺�� �����ϴ� �������� �����Ѵ�.
SELECT u.name, NVL(c.c_num,'����'), NVL(cc.c_name,'����')       -- NVL�Լ� : ���� Ʃ���� ���� NULL�̶�� ���� ������ ġȯ�Ѵ�.
FROM users u
LEFT OUTER JOIN carinfo c
ON u.id=c.id                    -- ������� users���̺�� carinfo���̺��� ������ ������ ���̺��� �����ȴ�.
LEFT OUTER JOIN companycar cc
ON c.c_num=cc.c_num;            -- ���� ������ ������ ���̺�� companycar���̺��� �����Ѵ�.

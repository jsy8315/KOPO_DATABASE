--JOIN ����




--primary key

DROP TABLE CUSTOMERUNI;

CREATE TABLE CUSTOMERPRI(
ID      VARCHAR2(8)                 CONSTRAINT CUSTOMERPRI_ID_PK PRIMARY KEY,
PWD     VARCHAR2(8)                 NOT NULL,
NAME    VARCHAR2(20),
SEX     CHAR(1)     DEFAULT 'M'     CONSTRAINT CUSTOMERPRI_SEX_CK CHECK(SEX IN ('M', 'F')),
MOBILE  VARCHAR2(14)                CONSTRAINT CUSTOMERPRI_MOBILE_UK UNIQUE,
AGE     NUMBER(3)   DEFAULT 18);

SELECT * FROM CUSTOMERPRI;

INSERT INTO CUSTOMERPRI(ID, PWD, NAME, MOBILE) VALUES('zman', 'ok', '�ѱ�', '011');

INSERT INTO CUSTOMERPRI(ID, PWD, NAME) VALUES('xman', 'ok', 'king');

INSERT INTO CUSTOMERPRI(ID, PWD, NAME) VALUES('xman', 'power', 'zzang');

INSERT INTO CUSTOMERPRI(ID, PWD, NAME) VALUES('Xman', 'korea', 'dbzzang');

INSERT INTO CUSTOMERPRI(ID, PWD, NAME) VALUES(lower('xMan'), 'ok', 'zzang');

INSERT INTO CUSTOMERPRI(PWD, NAME) VALUES('ok', 'kim');

UPDATE CUSTOMERPRI SET ID = NULL;
UPDATE CUSTOMERPRI SET ID = 'XMAN';

--FOREIGN KEY

CREATE TABLE �μ� (�μ���ȣ   VARCHAR2(2)     CONSTRAINT �μ�_�μ���ȣ_PK   PRIMARY KEY,
                  �μ���     VARCHAR(10)     CONSTRAINT �μ�_�μ���_NN     NOT NULL
                  );
                  
CREATE TABLE ��� (���      VARCHAR2(8)    PRIMARY KEY,
                  �̸�      VARCHAR2(10),
                  �μ���ȣ   VARCHAR2(2),
                  CONSTRAINT ���_�μ�_�μ���ȣ_FK FOREIGN KEY(�μ���ȣ)
                                    REFERENCES �μ�(�μ���ȣ));
SELECT * FROM �μ�;
SELECT * FROM ���;

DESC ���
SELECT 
CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME,SEARCH_CONDITION,R_CONSTRAINT_NAME,DELETE_RULE,STATUS
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('�μ�', '���');

INSERT INTO ���(���, �̸�, �μ���ȣ) VALUES ('XMAN', 'TUNER', '10');

INSERT INTO �μ�(�μ���ȣ, �μ���) VALUES('10', '����');
INSERT INTO �μ�(�μ���ȣ, �μ���) VALUES('20', '����');
INSERT INTO �μ�(�μ���ȣ, �μ���) VALUES('50', '����');

INSERT INTO ���(���, �̸�, �μ���ȣ) VALUES('YMAN', 'DBA', '20');

INSERT INTO ���(���, �̸�, �μ���ȣ) VALUES('ZMAN', 'DEVELOPER', 30);

DELETE FROM �μ� WHERE �μ���ȣ = 50;

DELETE FROM �μ� WHERE �μ���ȣ = 10;

SELECT * FROM ���;

UPDATE ��� SET �μ���ȣ = 20 WHERE �μ���ȣ = 10;
DELETE FROM �μ� WHERE �μ���ȣ = 10;
                 
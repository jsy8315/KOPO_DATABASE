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
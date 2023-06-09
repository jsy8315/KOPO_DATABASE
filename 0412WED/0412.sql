--0412 JOIN복습
SELECT D.DNAME, E.ENAME, E.JOB, E.SAL FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT DNAME, DEPTNO FROM DEPT;

SELECT ENAME, DEPTNO,  JOB, SAL FROM EMP;

SELECT D.DNAME, E.ENAME, E.JOB, E.SAL 
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO IN (10, 20) AND D.DNAME = 'RESEARCH';

--Non Equi JOIN
SELECT E.ENAME, E.JOB, S.GRADE FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

SELECT E.ENAME, E.JOB, E.SAL, S.GRADE FROM EMP E, SALGRADE S
WHERE E.SAL < S.LOSAL AND E.DEPTNO IN (10, 30)
ORDER BY E.ENAME;

--Outer JOIN
--JOIN 조건에 직접 만족되지 않는 정보도 조회
SELECT D.DNAME, E.ENAME, E.JOB, E.SAL FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY D.DNAME;

SELECT D.DNAME, NVL(E.ENAME, '비상근 부서'), E.JOB, E.SAL FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY D.DNAME;

SELECT D.DNAME, E.ENAME, E.JOB, E.SAL FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+)
ORDER BY D.DNAME;

SELECT * FROM EMP;

SELECT * FROM DEPT;

--Self Join 순환관계
SELECT E.ENAME||'"S MANAGER IS '||M.ENAME
FROM EMP E, EMP M
WHERE E.MGR = M.EMPNO
ORDER BY M.ENAME;

SELECT * FROM EMP;

--카티션곱
SELECT ENAME, JOB, DNAME FROM EMP,DEPT;

SELECT ENAME FROM EMP; --14개행
SELECT DNAME FROM DEPT; --4개행
SELECT ENAME, JOB, DNAME FROM EMP CROSS JOIN DEPT; --56개행

SELECT ENAME, JOB, DNAME FROM EMP, DEPT
WHERE EMP.SAL > 2000 OR DEPT.DEPTNO IN (10, 20);
--SAL > 2000인 행 6개,  뒤에 조건 만족 행 2개

SELECT E.ENAME, E.JOB, E.SAL, S.GRADE FROM EMP E, SALGRADE S
WHERE E.SAL < S.LOSAL AND E.DEPTNO IN (10, 30)
ORDER BY E.ENAME;

SELECT ENAME, SAL, DEPTNO FROM EMP;

SELECT LOSAL FROM SALGRADE;

CREATE TABLE CUSTOMER2(
    ID  VARCHAR2(8)   NOT NULL,
    PWD     VARCHAR2(8)   CONSTRAINT CUSTOMER_PWD_NN NOT NULL, --제약사항 이름 명시
    NAME    VARCHAR2(20), --이름
    SEX     CHAR(1),
    AGE     NUMBER(3) --나이
    );
DESC CUSTOMER;

SELECT * FROM CUSTOMER2;

--잘못된 양식으로 insert 해보기
INSERT INTO CUSTOMER2 (ID, PWD, NAME, SEX, AGE) VALUES('xman', 'ok', 'kang', 'M', 21);
INSERT INTO CUSTOMER2 (ID, PWD, NAME, SEX, AGE) VALUES('XMAN', 'no', 'kim', 'T', -20);

INSERT INTO CUSTOMER2 (ID, NAME, AGE) VALUES('zman', 'son', 99);
INSERT INTO CUSTOMER2 (ID, PWD, NAME, AGE) VALUES('rman', NULL, 'jjang', 24);
INSERT INTO CUSTOMER2 (ID, PWD, NAME, AGE) VALUES('', 'pwd', 'jjang', 24);

UPDATE CUSTOMER2 SET PWD = NULL WHERE ID = 'XMAN'; --ID가 XMAN인 ROW만 수정
SELECT * FROM CUSTOMER2;

--데이터딕셔너리에서 제약사항 확인하기
SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CUSTOMER2';

--데이터딕셔너리에서 제약사항 확인하기
SELECT TABLE_NAME, CONSTRAINT_NAME, POSITION, COLUMN_NAME
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'CUSTOMER2'
ORDER BY CONSTRAINT_NAME, POSITION;

SELECT * FROM CUSTOMER2;

--CHECK
ALTER TABLE CUSTOMER2 ADD CONSTRAINT CUSTOMER_SEX_CK CHECK (SEX IN ('M', 'F')); 

UPDATE CUSTOMER2 SET SEX = 'M' WHERE SEX = 'T';
COMMIT;
ALTER TABLE CUSTOMER2 ADD CONSTRAINT CUSTOMER2_SEX_CK CHECK (SEX IN ('M', 'F'));
SELECT * FROM CUSTOMER2;

--ID가 중복되지만 입력해부기
INSERT INTO CUSTOMER2(ID, PWD, NAME, SEX, AGE) VALUES ('xman', 'ok', 'kang', 'M', 21);
INSERT INTO CUSTOMER2 (ID, PWD, NAME, SEX, AGE) VALUES ('xman', 'ok', 'jjang', 'M', 20);
SELECT * FROM CUSTOMER2;

--NOT NULL 제약이 없는 성별 컬럼에 NULL 입력해보기
INSERT INTO CUSTOMER2(ID, PWD, NAME, AGE) VALUES('asura', 'ok', 'joo', 99);

--M, F외에는 이제 입력이 안됨
INSERT INTO CUSTOMER2 (ID, PWD, NAME, SEX, AGE) VALUES ('harisu', 'pk', 'susu', 'T', 33);

INSERT INTO CUSTOMER2 (ID, PWD, NAME, SEX, AGE) VALUES('shinsun', 'ok', '도사', 'M', 999);

UPDATE CUSTOMER2 SET AGE = AGE + 1;

--과제1
SELECT D.DNAME, E.ENAME, E.JOB, E.SAL FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY D.DNAME;

SELECT D.DNAME, E.ENAME, E.JOB, E.SAL FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DNAME;

SELECT ENAME, JOB, SAL, DEPTNO FROM EMP;
SELECT DNAME, DEPTNO FROM DEPT;


--Unique Key
DROP TABLE CUSTOMER2;
DROP TABLE CUSTOMERUNI;
CREATE TABLE CUSTOMERUNI (
ID  VARCHAR2(8)     NOT NULL CONSTRAINT CUSTOMERUNI_ID_UK UNIQUE,
PWD     VARCHAR2(8)  NOT NULL,
NAME    VARCHAR2(20),
SEX     CHAR(1)  DEFAULT 'M'
    CONSTRAINT CUSTOMERUNI_SEX_CK CHECK(SEX IN ('M', 'F')),
MOBILE    VARCHAR2(14)   UNIQUE,
AGE     NUMBER(3)     DEFAULT 18
);

ALTER TABLE CUSTOMERUNI ADD CONSTRAINT CUSTOMERUNI_SEX_CK2 CHECK (SEX IN ('M','F'));

SELECT * FROM CUSTOMERUNI;

INSERT INTO CUSTOMERUNI (ID, PWD, NAME, MOBILE, AGE) VALUES('xman', 'ok', 'kang', '011-3333', 21);

INSERT INTO CUSTOMERUNI (ID, PWD, NAME, MOBILE, AGE) VALUES ('XMAN', 'yes', 'kim', '011-3334', 33);

INSERT INTO CUSTOMERUNI (ID, PWD, NAME, MOBILE, AGE) VALUES('xman', 'yes', 'lee', '011-3335', -21);

INSERT INTO CUSTOMERUNI (ID, PWD, NAME, MOBILE, AGE) VALUES ('yman', 'yes', 'lee', '011-3333', 28);

INSERT INTO CUSTOMER(ID, PWD, NAME, MOBILE) VALUES ('무명인', 'yes', NULL, NULL);

INSERT INTO CUSTOMERUNI(ID, PWD, NAME, SEX) VALUES ('rman', 'yes', 'syo', 'M');

INSERT INTO CUSTOMERUNI(ID, PWD, NAME, SEX) VALUES ('Rman', 'yes', 'syo', 'F');

INSERT INTO CUSTOMERUNI (ID, PWD, NAME, SEX) VALUES ('RmaN', 'yes', 'syo', 'M');

SELECT * FROM CUSTOMERUNI;

ALTER TABLE CUSTOMERUNI ADD CONSTRAINT CUSTOMERUNI_NAME_SEX_UK UNIQUE(NAME, SEX);
ALTER TABLE CUSTOMER MODIFY(NAME NOT NULL);

SELECT INDEX_NAME, INDEX_TYPE, UNIQUENESS FROM USER_INDEXES
WHERE TABLE_NAME = 'CUSTOMER';

SELECT INDEX_NAME, COLUMN_POSITION, COLUMN_NAME FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'CUSTOMERUNI' 
ORDER BY INDEX_NAME, COLUMN_POSITION;
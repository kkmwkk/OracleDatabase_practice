-- 09_02 실습내용

-- 테이블 생성 후 제약조건 
CREATE table test_44(
empno number(4),
ename varchar(30) not null,
tel varchar2(30) default '010-777-7890',
sal number(5) default 450,
hiredate date default sysdate,
gender char(1)
constraint gender_check check(gender in('M', 'F')));

-- 테이블 생성 후 제약조건
create table test_55(
empno number(4),
ename varchar2(30) not null,
tel number(1)
constraint tel_check check(tel > 3));

-- 테이블 생성
create table parent(id number PRIMARY KEY);

-- id를 참조하는 foreign키 키 생성
create table child(
name varchar2(30) not null,
id number not null,
CONSTRAINT ID_FK FOREIGN KEY(ID) REFERENCES PARENT(ID));

-- parent 테이블에 데이터 insert
INSERT INTO parent VALUES(35);

-- parent 테이블 확인
select * from parent;

-- child 테이블에 데이터 insert(무결성 제약조건 위반)
INSERT INTO child(name, id) VALUES('korea', 88);

-- FOREIGN KEY인 35의 값만 가질 수 있다. (parent 테이블에는 35의 id값만 가지고 있기 떄문이다.)
INSERT INTO child(name, id) VALUES('korea', 35);

-- child 테이블 확인
select * from child;

-- 제약조건을 나중에 추가할 수 있음
ALTER TABLE 테이블명
MODIFY(제약조건);

ALTER TABLE TABLE_3
MODIFY(TEL UNIQUE);

ALTER TABLE TABLE_3
RENAME CONSTRAINT KO_LGNID_NN TO SS_LONID_NN;

-- 문제

CREATE TABLE emp_test(
id varchar2(20) PRIMARY KEY,
name varchar2(30) NOT NULL,
addr varchar2(50),
tel varchar2(15),
birth date DEFAULT sysdate,
kor number(7, 2) DEFAULT 0.0,
eng number(7, 2) DEFAULT 0.0,
math number(7, 2) DEFAULT 0.0);

desc emp_test;
select * from emp_test;

-- 확인
select CONSTRAINT_NAME, CONSTRAINT_TYPE, r_constraint_name, table_name
from USER_CONSTRAINTS 
where table_name = 'EMP_TEST';

CREATE TABLE emp_kor(
id varchar2(20),
total number(7, 2),
avg number(8, 3),
CONSTRAINT ID_FFKK FOREIGN KEY(ID) REFERENCES EMP_TEST(ID));

-- 확인
select CONSTRAINT_NAME, CONSTRAINT_TYPE, r_constraint_name, table_name
from USER_CONSTRAINTS
where table_name = 'EMP_KOR';

-- 삭제
ALTER TABLE EMP_KOR DROP CONSTRAINT ID_FFKK;

-- 시퀀스 실습
create sequence kor_seq
start with 30
increment by 5
maxvalue 150
cycle;

-- 시퀀스 실습(maxvalue = 150을 넘기니 1로 바뀌고 다시 5씩 커짐..! CYCLE의 개념)

select kor_seq.NEXTVAL
from dual;

-- 2번째 시퀀스 만들기
create sequence eng_seq
start with 50
increment by 20
maxvalue 250
nocycle;

-- 시퀀스 실습(maxvalue = 250을 넘기니 더 이상 넘어갈 수 없다며 오류메시지 출력 NOCYCLE의 개념)
select eng_seq.NEXTVAL
from dual;

-- 3번째 시퀀스 만들기
create sequence math_seq3
start with 1
increment by 5
maxvalue 110
cycle;

-- 실무 사용법(시퀀스를 활용해서 실무활용)
create sequence emp_seq
start with 1
increment by 1
maxvalue 10000
cycle;

create table emp_seq_1(
id varchar2(20) primary key,
name varchar2(20) not null,
num number(5) default 0,
addr varchar2(20));

INSERT INTO emp_seq_1(id,name,num,addr)
VALUES('king_5','sun_1',emp_seq.NEXTVAL,'서울');

select * from emp_seq_1;

-- cascade 실습 (cascade를 사용하면 자식이 데이터를 해도 부모 데이터가 날라감.) 원래는 부모먼저 삭제해주고 자식 삭제해줘야함.
CREATE TABLE emp_test2(
id varchar2(20) PRIMARY KEY,
name varchar2(30) NOT NULL,
kor number(7, 2) DEFAULT 0.0);

CREATE TABLE emp_kor2(
id varchar2(20),
total number(7, 2),
avg number(8, 3),
CONSTRAINT ID_FFKK_TEST FOREIGN KEY(ID) REFERENCES EMP_TEST2(ID) ON DELETE CASCADE);

CREATE TABLE emp_kor4(
id varchar2(20),
total number(7, 2),
avg number(8, 3),
CONSTRAINT ID_FFKK_TEST2 FOREIGN KEY(ID) REFERENCES EMP_TEST2(ID) ON DELETE CASCADE);


-- king_1 ~ king_5
insert into emp_test2 values('king_5','수선화',56);
insert into emp_kor4 values('king_4',567.67,343.44);

select * from emp_test2 order by ID;
select * from emp_kor4;

-- 부모(emp_test2)에서 지우면 자식(emp_kor2)도 같이 삭제됨.(CASCADE)
delete from emp_test2 where id = 'king_4';


-- emp_kor2 삭제
drop table emp_kor2 purge;



-- emp_total 생성
CREATE TABLE emp_total(
id VARCHAR(20) PRIMARY KEY,
ename VARCHAR2(30) NOT NULL,
idnum NUMBER(5),
birth date DEFAULT SYSDATE,
total NUMBER(7, 2) DEFAULT 0.0,
avg NUMBER(5, 2) DEFAULT 0.0);

-- emp_kor_1
CREATE TABLE emp_kor_1(
id VARCHAR(20),
ename VARCHAR2(30) NOT NULL,
kor NUMBER(3) DEFAULT 0,
eng NUMBER(3) DEFAULT 0,
math NUMBER(3) DEFAULT 0,
CONSTRAINT ID_TEST_PRA FOREIGN KEY(ID) REFERENCES EMP_TOTAL(ID) ON DELETE CASCADE);

-- emp_eng_1
CREATE TABLE emp_eng_1(
id VARCHAR(20),
ename VARCHAR2(30) NOT NULL,
kor NUMBER(3) DEFAULT 0,
eng NUMBER(3) DEFAULT 0,
math NUMBER(3) DEFAULT 0,
CONSTRAINT ID_TEST_PRA2 FOREIGN KEY(ID) REFERENCES EMP_TOTAL(ID) ON DELETE CASCADE);

-- 시퀀스 생성
CREATE SEQUENCE SEQ_TOTAL_SEQ
INCREMENT BY 1
START WITH 1
MAXVALUE 99
MINVALUE 1
nocycle
nocache;

-- 테이블에 데이터 넣기
INSERT INTO emp_total(id, ename, idnum, birth, total, avg) VALUES('5','민우',SEQ_TOTAL_SEQ.NEXTVAL,sysdate,20,10);
INSERT INTO emp_kor_1(id, ename, kor, eng, math) VALUES('5','건',20,10,30);
INSERT INTO emp_eng_1(id, ename, kor, eng, math) VALUES('5','승필',20,10,50);

-- 테이블 확인
select * from emp_total;
select * from emp_kor_1;
select * from emp_eng_1;

-- 데이터 삭제 CASCADE 때문에 다 삭제됨 부모에서 지우면.
delete from emp_total where id = 5;


INSERT INTO TABLE1(id) values('1');
select * from table1;

-- 시퀀스의 마지막값을 알아보는거

SELECT LAST_NUMBER
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'SEQ_TOTAL_SEQ';


SELECT * FROM EMPLOYEES;

ALTER TABLE EMPLOYEES RENAME COLUMN HIREDATE TO HIRE_DATE;
COMMIT;
ROLLBACK;

/*
    테이블명 : T_BOARD
    글번호 NO NUMBER(3) = 999까지만 쓴다는 뜻
    제목 TITLE VARCHAR2(200) 
    작성자 WRITER VARCHAR2(30)
    등록일 REG_DATE
    내용 CONTENT
*/

--학생번호, 이름, 생년월일, 휴대폰, 주소
CREATE TABLE T_BOARD(
    NO NUMBER(5)
    , TITLE VARCHAR2(200)
    , WRITER VARCHAR2(30)
    , REG_DATE DATE
);


SELECT * FROM T_BOARD;

DESCRIBE T_BOARD;
DESC T_BOARD;

DROP TABLE T_BOARD;

DELETE FROM T_BOARD;
COMMIT;

CREATE SEQUENCE SEQ_T_BOARD_NO;

ALTER SEQUENCE SEQ_T_BOARD_NO
    INCREMENT BY 1 NOCACHE;
    
SELECT SEQ_T_BOARD_NO.NEXTVAL FROM DUAL;

/*
    테이블명 : T_BOARD
    글번호 NO NUMBER(3) = 999까지만 쓴다는 뜻
    제목 TITLE VARCHAR2(200) 
    작성자 WRITER VARCHAR2(30)
    등록일 REG_DATE
    내용 CONTENT
*/
CREATE TABLE T_BOARD(

    NO NUMBER(5)PRIMARY KEY --UNIQUE + NOT NULL
    , TITLE VARCHAR2(200) NOT NULL
    , WRITER VARCHAR2(30) NOT NULL
    , REG_DATE DATE DEFAULT SYSDATE
);

ALTER TABLE T_BOARD ADD CONTENT VARCHAR2(4000);

ALTER TABLE T_BOARD ADD VIEW_CNT CHAR(3);

ALTER TABLE T_BOARD MODIFY VIEW_CNT NUMBER(5) DEFAULT 0;

SELECT * FROM T_BOARD;

INSERT INTO T_BOARD(NO, TITLE, WRITER, REG_DATE, CONTENT, VIEW_CNT)
            VALUES(1, '제목이지롱', '백청현', SYSDATE, '내용이지롱', 0);

--모든 컬럼에 데이터 입력시에는 컬럼명 생략가능. 단 순차입력.            
INSERT INTO T_BOARD
            VALUES(2, '제목이지롱', '백청현', SYSDATE, '내용이지롱', 0);
            
--기본값DEFAULT이 있는 컬럼은 VALUES 생략 가능.            
INSERT INTO T_BOARD(NO, TITLE, WRITER, CONTENT)
            VALUES(3, '제목이지롱', '백청현', '내용이지롱');

UPDATE T_BOARD SET VIEW_CNT = 10 WHERE NO = 3;

COMMIT;


SELECT * FROM EMPLOYEES;

--입사년도가 2001, 2002, 2003년인 사원 조회
SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS 입사년도 FROM EMPLOYEES;

SELECT TO_CHAR(HIRE_DATE, 'YYYY') 입사년도, e.*
  FROM EMPLOYEES e
WHERE TO_CHAR(HIRE_DATE, 'YYYY') IN (2001, 2002, 2003);


--커미션(commission_pct)이 없는 사원목록 조회
--NULL의 경우 비교연산자를 사용해서 쓸 수 없고
--SELECT * FROM EMPLOYEES
--    WHERE COMMISSION_PCT = NULL;
--이렇게 써야 함
SELECT * FROM EMPLOYEES
    WHERE COMMISSION_PCT IS NULL;


--전체사원목록을 조회, 단 COMMISSION_PCT가 NULL인 경우, 0으로 변환하고 싶을 때
--연산이 필요한 경우 NULL을 제외시키므로 0으로 변경하면 포함연산이 가능!add_job_history
SELECT EMPLOYEE_ID, FIRST_NAME, NVL(COMMISSION_PCT, 0) AS COMMISSION_PCT FROM EMPLOYEES;


--사원ID, 사원이름, 매니저ID 조회
--단, 매니저ID가 없는 경우 MANAGER 없음이라고 출력하고 싶을 때.
--기존의 MANAGER_ID가 숫자형이므로 '매니저없음'이라는 문자열과 불일치!
--그러니 잠깐만 TO_CHAR 형태로 변경해주면? 된다!
SELECT EMPLOYEE_ID, FIRST_NAME, NVL(TO_CHAR(MANAGER_ID), '매니저없음') AS MANAGER_ID FROM EMPLOYEES;


--집계함수, 집합함수, 그룹핑
--부서번호가 80인 사원수 조회
--이렇게 집계함수를 쓸 때에는 FIRST_NAME과 같은 개별컬럼을 쓸 수 없음
SELECT COUNT(*) 사원수
FROM EMPLOYEES e
WHERE DEPARTMENT_ID=80;

--단 GROUP BY로 묶은 경우 해당 그룹의 이름을 출력하는 것은 가능!
SELECT DEPARTMENT_ID 부서코드, COUNT(*) 소속사원수
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;
/*
    salary(연봉) 20000  이상 '고액연봉자'
                10000~20000 '평균연봉자'
                10000   미만 '최저연봉자'
*/
SELECT EMPLOYEE_ID, SALARY
    , CASE WHEN SALARY >= 20000 THEN '고액'
           WHEN SALARY >= 10000 THEN '평균'
           ELSE '최저'
      END 연봉타입
    FROM EMPLOYEES;


--적은 수로는 가능
SELECT ROWNUM, EMPLOYEE_ID
    FROM EMPLOYEES
    WHERE ROWNUM <= 5;

--하지만 X보다 큰 수, 또는 X와 Y사이의 수로는 불가.
--그래서 이렇게 서브쿼리(인라인뷰?)를 통해 FROM절에서 ROWNUM을 먼저 인식하게 해줘야 함.
SELECT e.*
    FROM (SELECT ROWNUM AS RNUM, EMPLOYEE_ID FROM EMPLOYEES) e
    WHERE e.RNUM BETWEEN 5 AND 10;

/*
    EMPLOYEE 번호(ID), 이름(FIRST_NAME), 전화번호와 지역을 ID 순으로 오름차순 조회
    지역은 전화번호의 앞자리로 구분
    515 => 서울
    590 => 대전
    650 => 광주
    603 => 부산
    그외의 경우 기타
*/
--LIKE와 %와일드카드를 이용한 방법
--단 %a%같이 앞뒤로 쓰는 경우 인덱싱이 안됨;; 그래서 효율적 검색이 어려움.
--게시판의 경우 글번호PK 검색은 빠르지만 제목/글쓴이 검색은 인덱스를 생성해줘야 빠르게 됨.
SELECT *
    FROM (
    SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER
    , CASE WHEN PHONE_NUMBER LIKE '515%' THEN '서울'
           WHEN PHONE_NUMBER LIKE '590%' THEN '대전'
           WHEN PHONE_NUMBER LIKE '650%' THEN '광주'
           WHEN PHONE_NUMBER LIKE '603%' THEN '부산'
           ELSE '기타'
           END AS 지역
    FROM EMPLOYEES);


--교수님 풀이
--SUBSTR을 이용해 문자열의 첫 3자리를 뽑아낸 방법
SELECT *
    FROM ;
    
    
SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER
    , CASE SUBSTR(PHONE_NUMBER, 1, 3)
           WHEN '515' THEN '서울'
           WHEN '590' THEN '대전'
           WHEN '650' THEN '광주'
           WHEN '603' THEN '부산'
           ELSE '기타'
           END 지역
    FROM EMPLOYEES
    ORDER BY 1 ASC;



--시퀀스
CREATE SEQUENCE SEQ_01;
CREATE SEQUENCE SEQ_02 START WITH 20230001;
CREATE SEQUENCE SEQ_03 START WITH 10
INCREMENT BY 10;

SELECT SEQ_01.NEXTVAL FROM DUAL;
SELECT SEQ_02.NEXTVAL FROM DUAL;
SELECT SEQ_03.NEXTVAL FROM DUAL;








-- 230724
-- 회원테이블

CREATE TABLE T_MEMBER(
    ID VARCHAR2(30) PRIMARY KEY
    , PASSWORD VARCHAR2(30) NOT NULL
    , NAME VARCHAR2(20) NOT NULL
    , TYPE CHAR(1) DEFAULT 'U' --일반유저:U, 관리자:SUPER의 'S'를 쓸 것임
);
COMMIT;

INSERT INTO T_MEMBER VALUES('admin', '1234', '관리자', 'S');
INSERT INTO T_MEMBER VALUES('user', '1234', '백청현', 'U');

SELECT * FROM T_MEMBER;



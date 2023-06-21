SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS CURRENT_DATE_TIME FROM dual;

SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS CURRENT_DATE_TIME FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS CURRENT_DATE_TIME FROM dual;

SELECT * FROM B_USER_INFO;
COMMIT;

SELECT * FROM B_USER_ADDRESS;

CREATE SEQUENCE SEQ_USER_;

--임의등록
INSERT INTO B_USER_INFO(USER_ID, USER_PASSWORD, KOR_NAME, BIRTHDATE, GENDER, TELECOM, PHONE_NO, EMAIL, SIGNUP_TYPE, REG_DATE)
                VALUES('aaaa', '1111', '김테스트', '901208', '2', 'SKT', '01083499438', 'aaaa@naver.com', 'web', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));

--임의등록
SELECT * FROM MEMBER;
            
--중복검사 로직                
SELECT COUNT(*) FROM B_USER_INFO WHERE USER_ID='aaaa';
--로그인 정보 확인
SELECT * FROM B_USER_INFO WHERE USER_ID = 'test' AND USER_PASSWORD = '1111'; 

--회원정보 찾기
SELECT * FROM B_USER_INFO WHERE USER_ID = 'test';

--삭제
DELETE B_USER_INFO WHERE USER_ID='test2';
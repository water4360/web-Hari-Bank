SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS CURRENT_DATE_TIME FROM dual;

SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS CURRENT_DATE_TIME FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS CURRENT_DATE_TIME FROM dual;

CREATE SEQUENCE SEQ_BOOKLIST_NO START WITH 230001 NOCACHE;
INSERT INTO BOOKLIST(NO, TITLE, AUTHOR, PUBLISHER, STOCK)
            VALUES(SEQ_BOOKLIST_NO.NEXTVAL, '어떤 책이 가장 읽기 좋을까?', '김작가', '민음사', 2);



CREATE SEQUENCE SEQ_NOTICE_NO NOCACHE;
CREATE SEQUENCE SEQ_QNA_NO NOCACHE;
CREATE SEQUENCE SEQ_FNQ_NO NOCACHE;

--임의등록
--회원
INSERT INTO B_USER_INFO(USER_ID, USER_PASSWORD, KOR_NAME, BIRTHDATE, GENDER, TELECOM, PHONE_NO, EMAIL, SIGNUP_TYPE, REG_DATE)
                VALUES('aaaa', '1111', '김테스트', '901208', '2', 'SKT', '01083499438', 'aaaa@naver.com', 'web', TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
--QNA                
INSERT INTO B_QNA(Q_NO, USER_ID, Q_TITLE, Q_CONTENTS) VALUES(SEQ_QNA_NO.NEXTVAL, 'aaaa', '제목자리', '내용자리');

--상품신규
INSERT INTO B_DEPOSIT(D_CODE, D_NAME, D_INTEREST, D_SALE_STATUS, D_DETAIL) VALUES('S1', 'HR하리사랑통장', 0.5, 'Y', '출금·이체수수료 횟수제한 없이 면제!');

--계좌신규
--INSERT INTO B_USER_ACCOUNT(ACCOUNT_NO, LASTNAME, FIRSTNAME, ACCOUNT_PASSWORD, TOTAL_BALANCE_BENEFIT_CODE, ACCOUNT_NICKNAME, TRANSFER_ONCE_LIMIT, TRANSFER_DAY_LIMIT, S_CODE, USER_ID, OP_BANK_CODE)
--                    VALUES(계좌번호 시퀀스);


--조회용
SELECT * FROM MEMBER;
SELECT * FROM B_QNA ORDER BY Q_NO DESC;
SELECT * FROM B_USER_INFO;
SELECT * FROM B_DEPOSIT;
SELECT * FROM B_USER_ACCOUNT;
SELECT * FROM B_USER_ADDRESS;
COMMIT;

--중복검사 로직                
SELECT COUNT(*) FROM B_USER_INFO WHERE USER_ID='aaaa';

--로그인 정보 확인
SELECT * FROM B_USER_INFO WHERE USER_ID = 'test' AND USER_PASSWORD = '1111';

--로그인 정보로 권한코드까지
SELECT * 
FROM B_USER_INFO
LEFT JOIN B_USER_AUTHORITY 
ON B_USER_INFO.USER_ID = B_USER_AUTHORITY.USER_ID
WHERE B_USER_INFO.USER_ID = 'aaaa';

--회원정보 찾기
SELECT * FROM B_USER_INFO WHERE USER_ID = 'test';

--삭제
DELETE B_USER_INFO WHERE USER_ID='test2';
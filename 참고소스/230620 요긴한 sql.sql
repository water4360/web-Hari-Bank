SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS CURRENT_DATE_TIME FROM dual;

SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS CURRENT_DATE_TIME FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS CURRENT_DATE_TIME FROM dual;

CREATE SEQUENCE SEQ_BOOKLIST_NO START WITH 230001 NOCACHE;
INSERT INTO BOOKLIST(NO, TITLE, AUTHOR, PUBLISHER, STOCK)
            VALUES(SEQ_BOOKLIST_NO.NEXTVAL, '어떤 책이 가장 읽기 좋을까?', '김작가', '민음사', 2);



CREATE SEQUENCE SEQ_NOTICE_NO NOCACHE;
CREATE SEQUENCE SEQ_QNA_NO NOCACHE;
CREATE SEQUENCE SEQ_FNQ_NO NOCACHE;

--계좌번호 단순생성용
SELECT '0758-' || LPAD(DBMS_RANDOM.VALUE(10000000, 99999999), 8, '0') AS account_number
FROM dual;


--계좌번호 중복방지 생성용
--프로시저 저장용
CREATE OR REPLACE PROCEDURE PRCD_GENERATE_UNIQUE_ACCOUNT_NO(
  v_account_no OUT VARCHAR2
) AS
  v_duplicate_count NUMBER;
BEGIN
  LOOP
    v_account_no := '0758-' || LPAD(TO_CHAR(FLOOR(DBMS_RANDOM.VALUE(10000000, 99999999))), 8, '0');

    SELECT COUNT(*)
    INTO v_duplicate_count
    FROM B_USER_ACCOUNT -- 생성된 계좌번호를 비교할 테이블명
    WHERE ACCOUNT_NO = v_account_no;

    EXIT WHEN v_duplicate_count = 0;
  END LOOP;
  
  -- Only return the account number, do not insert it here
  -- INSERT INTO B_USER_ACCOUNT(ACCOUNT_NO) VALUES(v_account_no);
  -- COMMIT;
  
END;
/

COMMIT;




--조회용
SELECT * FROM B_BOARD ORDER BY P_NO DESC;
SELECT * FROM B_USER_INFO;
SELECT * FROM B_USER_AUTHORITY;
SELECT * FROM B_DEPOSIT;
SELECT * FROM B_USER_ACCOUNT;
SELECT * FROM B_BANK_INFO;
SELECT * FROM B_USER_ADDRESS;


--정렬된 것 중의 첫번째
SELECT * FROM (SELECT * FROM B_USER_ACCOUNT WHERE USER_ID='aaaa' ORDER BY CREATED_DATE DESC)
  WHERE ROWNUM = 1;

SELECT * FROM (SELECT * FROM B_USER_INFO ORDER BY REG_DATETIME DESC)
  WHERE ROWNUM = 1;

--은행코드로 은행명.
SELECT UA.*, BI.B_BANK_NAME
FROM B_USER_ACCOUNT UA
INNER JOIN B_BANK_INFO BI ON UA.B_BANK_CODE = BI.B_BANK_CODE
WHERE UA.USER_ID = 'aaaa';

--은행코드로 은행명, 계좌 상품코드로 상품명까지.
SELECT UA.*, BI.B_BANK_NAME, BD.D_PRODUCT_NAME
FROM B_USER_ACCOUNT UA
INNER JOIN B_BANK_INFO BI ON UA.B_BANK_CODE = BI.B_BANK_CODE
INNER JOIN B_DEPOSIT BD ON UA.D_PRODUCT_CODE = BD.D_PRODUCT_CODE
WHERE UA.USER_ID = 'aaaa';




COMMIT;




--권한 우선 등록
INSERT INTO B_USER_AUTHORITY(ROLE_CODE, ROLE_NAME) VALUES('A758', '관리자');
INSERT INTO B_USER_AUTHORITY(ROLE_CODE, ROLE_NAME) VALUES('H1', '골드');
INSERT INTO B_USER_AUTHORITY(ROLE_CODE, ROLE_NAME) VALUES('H2', '실버');
INSERT INTO B_USER_AUTHORITY(ROLE_CODE, ROLE_NAME) VALUES('H3', '브론즈');

--은행정보 우선 등록
INSERT INTO B_BANK_INFO(B_BANK_CODE, B_BANK_NAME) VALUES('0758', '하리은행');

--예금상품정보 우선 등록
INSERT INTO B_DEPOSIT(D_PRODUCT_CODE, D_PRODUCT_NAME, D_INTEREST, D_SALE_STATUS, D_DETAIL)
              VALUES('D-202301', 'HR하리사랑통장', 0.1, 'Y', '출금·이체수수료 횟수제한 없이 면제!');

--계좌정보 우선 등록
INSERT INTO B_USER_ACCOUNT(ACCOUNT_NO, ACCOUNT_PASSWORD, TOTAL_BALANCE, ACCOUNT_NICKNAME, D_PRODUCT_CODE, USER_ID, B_BANK_CODE)
VALUES('0758-' || LPAD(DBMS_RANDOM.VALUE(1000000, 99999999), 8, '0'), '1111', 5000000, '', 'D-202301', 'aaaa', '0758');

SELECT * FROM B_USER_ACCOUNT;
--TRUNCATE TABLE B_USER_ACCOUNT;

COMMIT;

--회원
INSERT ALL
  INTO B_USER_INFO(USER_ID, USER_PASSWORD, KOR_NAME, BIRTHDATE, GENDER, TELECOM, PHONE_NO, EMAIL, SIGNUP_TYPE, ROLE_CODE)
                VALUES('aaaa', '1111', '백청현', '901208', '1', 'SKT', '01033338888', 'aaaa@naver.com', 'web', 'H3')
  INTO B_USER_ADDRESS(USER_ID, ADDRESS_TYPE, POSTCODE, ROAD_ADDRESS, DETAIL_ADDRESS)
          VALUES('aaaa', '자택', '13073', '경기도 성남시 수정로', '한울관B309')
SELECT 1 FROM DUAL;


--QNA                
INSERT INTO B_BOARD(P_NO, P_WRITER, P_TITLE, P_CONTENTS) VALUES(SEQ_QNA_NO.NEXTVAL, 'aaaa', '문의합니다', '내용이 많습니다');
COMMIT;


--계좌신규
--INSERT INTO B_USER_ACCOUNT(ACCOUNT_NO, LASTNAME, FIRSTNAME, ACCOUNT_PASSWORD, TOTAL_BALANCE_BENEFIT_CODE, ACCOUNT_NICKNAME, TRANSFER_ONCE_LIMIT, TRANSFER_DAY_LIMIT, S_CODE, USER_ID, OP_BANK_CODE)
--                    VALUES(계좌번호 시퀀스);


--중복검사 로직                
SELECT COUNT(*) FROM B_USER_INFO WHERE USER_ID='aaaa';

--로그인 정보 확인
SELECT * FROM B_USER_INFO UI
  LEFT JOIN B_USER_AUTHORITY UA ON UI.ROLE_CODE = UA.ROLE_CODE
  WHERE UI.USER_ID = 'aaaa';

--회원 전체 정보까지.
SELECT UI.USER_ID, UI.USER_PASSWORD, UI.KOR_NAME, UI.BIRTHDATE, UI.GENDER, UI.TELECOM, UI.PHONE_NO, UI.EMAIL,
       UA.POSTCODE, UA.ROAD_ADDRESS, UA.DETAIL_ADDRESS
FROM B_USER_INFO UI
LEFT JOIN B_USER_ADDRESS UA ON UI.USER_ID = UA.USER_ID
WHERE UI.USER_ID = 'aaaa';


--회원정보 찾기
SELECT * FROM B_USER_INFO WHERE USER_ID = 'aaaa';

--삭제
DELETE B_USER_INFO WHERE USER_ID='test2';

--상품명 포함 모든 계좌정보
SELECT UA.*, BI.B_BANK_NAME, BD.D_PRODUCT_NAME
FROM B_USER_ACCOUNT UA
JOIN B_DEPOSIT BD
ON UA.D_PRODUCT_CODE = BD.D_PRODUCT_CODE
JOIN B_BANK_INFO BI 
ON UA.B_BANK_CODE = BI.B_BANK_CODE
WHERE UA.USER_ID = 'aaaa';

--은행추가
INSERT INTO B_BANK_INFO(B_BANK_CODE, B_BANK_NAME) VALUES('3333', '다다은행');




--거래번호/날짜/시각 생성
CREATE SEQUENCE SEQ_TRANSACTION_NO NOCACHE;
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') AS T_DATE FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH24MISS') AS T_TIME FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') ||'-'|| LPAD(seq_transaction_no.nextval, 3, '0') AS TRANSACTION_NO FROM dual;


--테스트 해보려고 했찌
INSERT INTO B_TRANSFER(T_TRANSACTION_NO, ACCOUNT_NO, T_AMOUNT, T_RECEIVER_ACCOUNT, T_DATE, T_TIME, T_PREVIOUS_BALANCE, T_TO_RECEIVER, T_FROM_MEMO)
        VALUES('1111', '1111', 50000, '받는계좌', '날짜', '시각', '직전잔고', '받는메모', '내통장메모');


SELECT * FROM B_USER_ACCOUNT WHERE B_BANK_CODE='0758' AND ACCOUNT_NO='0758-53920545';




--이체 함수 테스트 실행용
BEGIN
  TRANSFER('0758-53920545', '0758-12976295', 100000);
  COMMIT;
END;
/

























--당행 이체용 함수
CREATE OR REPLACE PROCEDURE TRANSFER (
  SENDER_ACCOUNT_NO IN B_USER_ACCOUNT.ACCOUNT_NO%TYPE, --보내는계좌를 B_USER_ACCOUNT테이블의.ACCOUNT_NO와 같은 형식으로 지정.
  RECIVER_ACCOUNT_NO IN B_USER_ACCOUNT.ACCOUNT_NO%TYPE,
  TRANSFER_AMOUNT IN NUMBER) AS --TRANSFER_AMOUNT의 파라미터타입은 NUMBER숫자
  SENDER_BALANCE NUMBER; --보내는 계좌의 잔액 저장
  RECEIVER_BALANCE NUMBER; --받는 계좌의 잔액 저장
BEGIN
  -- 보내는 계좌의 잔액 확인
  SELECT TOTAL_BALANCE INTO SENDER_BALANCE --보내는 계좌의 잔액 저장
  FROM B_USER_ACCOUNT
  WHERE ACCOUNT_NO = SENDER_ACCOUNT_NO; --ACCOUNT_NO를 보내는 계좌번호로 저장
  
  -- 받는 계좌의 잔액 확인
  SELECT TOTAL_BALANCE INTO RECEIVER_BALANCE 
  FROM B_USER_ACCOUNT 
  WHERE ACCOUNT_NO = RECIVER_ACCOUNT_NO;
  
  -- 보내는 계좌의 잔액이 충분하면
  IF SENDER_BALANCE >= TRANSFER_AMOUNT THEN
    -- 보내는 계좌에서 돈을 빼고
    UPDATE B_USER_ACCOUNT
    SET TOTAL_BALANCE = TOTAL_BALANCE - TRANSFER_AMOUNT
    WHERE ACCOUNT_NO = SENDER_ACCOUNT_NO;
    
    -- 받는 계좌에 돈을 추가
    UPDATE B_USER_ACCOUNT
    SET TOTAL_BALANCE = TOTAL_BALANCE + TRANSFER_AMOUNT
    WHERE ACCOUNT_NO = RECIVER_ACCOUNT_NO;
  ELSE
    RAISE_APPLICATION_ERROR(-20001, '(SQL)잔액이 부족합니다');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/





SELECT * FROM B_TRANSACTION;
INSERT INTO B_TRANSACTION (T_TRANSACTION_NO, B_BANK_CODE, T_ACCOUNT_NO, T_RECEIVER_ACCOUNT, 
T_AMOUNT, T_TYPE, T_TO_RECEIVER, T_FROM_MEMO, T_STATUS)
     VALUES('2222', '0758', '0758-53920545', '0758-12976295', 5000000, '당행이체', '백청현', '내통장메모', '이체완료');
COMMIT;
ROLLBACK;

--특정 계좌의 입금 또는 출금내역 가져오기.
SELECT * FROM B_TRANSACTION WHERE T_SENDER_ACCOUNT_NO = '0758-53920545' OR T_RECEIVER_ACCOUNT_NO ='0758-53920545'
ORDER BY T_DATE DESC, T_TIME DESC;


--계좌내역의 아이디를 통해 유저의 이름 가져오기
SELECT UI.KOR_NAME, UA.ACCOUNT_NO
FROM B_USER_ACCOUNT UA
JOIN B_USER_INFO UI ON UA.USER_ID = UI.USER_ID
WHERE ACCOUNT_NO = '0758-53920545';

-----------------------------------------------2조은행
--지현은행
CREATE DATABASE LINK JHBank
 CONNECT TO hr
 IDENTIFIED BY hr
 USING
'(DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 172.31.9.167)(PORT = 1521))
)';
SELECT * FROM BANK_ACCOUNT @JHBank;
SELECT * FROM BANK_USER @JHBank;
SELECT * FROM BANK_HISTORY @JHBank;

--계좌번호를 통해서 NAME 가져오기
SELECT BA.ACCOUNT_NO, BU.USER_NAME
FROM BANK_ACCOUNT@JHBank BA
JOIN BANK_USER@JHBank BU ON BA.USER_ID = BU.USER_ID
WHERE BA.ACCOUNT_NO = 2256968375;


--하리은행->지현은행 이체용 함수
CREATE OR REPLACE PROCEDURE TRANSFER_TO_JHBANK (
  SENDER_ACCOUNT_NO IN B_USER_ACCOUNT.ACCOUNT_NO%TYPE,
  RECEIVER_ACCOUNT_NO IN BANK_ACCOUNT.ACCOUNT_NO @JHBANK%TYPE,
  TRANSFER_AMOUNT IN NUMBER
) AS
  SENDER_BALANCE NUMBER;
  RECEIVER_BALANCE NUMBER;
BEGIN
  -- 보내는 계좌의 잔액 확인
  SELECT TOTAL_BALANCE INTO SENDER_BALANCE
  FROM B_USER_ACCOUNT
  WHERE ACCOUNT_NO = SENDER_ACCOUNT_NO;
  
  -- 받는 계좌의 잔액 확인
  SELECT BALANCE INTO RECEIVER_BALANCE 
  FROM BANK_ACCOUNT @JHBANK
  WHERE ACCOUNT_NO = RECEIVER_ACCOUNT_NO;
  
  -- 보내는 계좌의 잔액이 충분하면
  IF SENDER_BALANCE >= TRANSFER_AMOUNT THEN
    -- 보내는 계좌에서 돈을 빼고
    UPDATE B_USER_ACCOUNT
    SET TOTAL_BALANCE = TOTAL_BALANCE - TRANSFER_AMOUNT
    WHERE ACCOUNT_NO = SENDER_ACCOUNT_NO;
    
    -- 받는 계좌에 돈을 추가
    UPDATE BANK_ACCOUNT @JHBANK
    SET BALANCE = BALANCE + TRANSFER_AMOUNT
    WHERE ACCOUNT_NO = RECEIVER_ACCOUNT_NO;
  ELSE
    RAISE_APPLICATION_ERROR(-20001, '잔액이 부족합니다');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/




















--거니은행
CREATE DATABASE LINK BGHBank
 CONNECT TO hr
 IDENTIFIED BY hr
 USING
'(DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 172.31.9.184)(PORT = 1521))
)';
SELECT * FROM B_ACCOUNT @BGHBank;
SELECT * FROM B_USER @BGHBank;
--계좌번호를 통해서 NAME 가져오기
SELECT ACCOUNT_NO, USER_NAME FROM B_ACCOUNT @BGHBank
WHERE ACCOUNT_NO = '8097-53946-64';


--하리은행->거니은행 이체용 함수
CREATE OR REPLACE PROCEDURE TRANSFER_TO_BGHBANK (
  SENDER_ACCOUNT_NO IN B_USER_ACCOUNT.ACCOUNT_NO%TYPE,
  RECEIVER_ACCOUNT_NO IN B_ACCOUNT.ACCOUNT_NO @BGHBANK%TYPE,
  TRANSFER_AMOUNT IN NUMBER
) AS
  SENDER_BALANCE NUMBER;
  RECEIVER_BALANCE NUMBER;
BEGIN
  -- 보내는 계좌의 잔액 확인
  SELECT TOTAL_BALANCE INTO SENDER_BALANCE
  FROM B_USER_ACCOUNT
  WHERE ACCOUNT_NO = SENDER_ACCOUNT_NO;
  
  -- 받는 계좌의 잔액 확인
  SELECT ACCOUNT_BALANCE INTO RECEIVER_BALANCE 
  FROM B_ACCOUNT @BGHBANK
  WHERE ACCOUNT_NO = RECEIVER_ACCOUNT_NO;
  
  -- 보내는 계좌의 잔액이 충분하면
  IF SENDER_BALANCE >= TRANSFER_AMOUNT THEN
    -- 보내는 계좌에서 돈을 빼고
    UPDATE B_USER_ACCOUNT
    SET TOTAL_BALANCE = TOTAL_BALANCE - TRANSFER_AMOUNT
    WHERE ACCOUNT_NO = SENDER_ACCOUNT_NO;
    
    -- 받는 계좌에 돈을 추가
    UPDATE B_ACCOUNT @BGHBANK
    SET ACCOUNT_BALANCE = ACCOUNT_BALANCE + TRANSFER_AMOUNT
    WHERE ACCOUNT_NO = RECEIVER_ACCOUNT_NO;
  ELSE
    RAISE_APPLICATION_ERROR(-20001, '잔액이 부족합니다');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/





























--종이은행
CREATE DATABASE LINK HJBank
 CONNECT TO hr
 IDENTIFIED BY hr
 USING
'(DESCRIPTION =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 172.31.9.186)(PORT = 1521))
)';
SELECT * FROM B_ACCOUNT @HJBank;
SELECT * FROM B_MEMBER @HJBank;

--계좌번호로 이름가져오기
SELECT BA.ACCOUNT_NO, BM.USERNAME
FROM B_ACCOUNT @HJBank BA
JOIN B_MEMBER @HJBank BM ON BA.MEMBERID = BM.MEMBERID
WHERE BA.ACCOUNT_NO = 32563435;



--하리은행->종이은행 이체용 함수




















--삽입구문
INSERT INTO BANK_HISTORY @JHBank (H_NO) VALUES(55);
ROLLBACK;



--
	SELECT 
	  UA.*, 
	  BI.B_BANK_NAME,
	  BD.D_PRODUCT_NAME
	FROM B_USER_ACCOUNT UA
	JOIN B_DEPOSIT BD
	ON UA.D_PRODUCT_CODE = BD.D_PRODUCT_CODE
	JOIN B_BANK_INFO BI 
	ON UA.B_BANK_CODE = BI.B_BANK_CODE
	WHERE UA.USER_ID = 'aaaa';


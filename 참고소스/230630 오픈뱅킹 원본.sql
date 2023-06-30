create or replace NONEDITIONABLE PROCEDURE P_BANK_TRANSFER(
       FROM_ACCOUNT_NO IN VARCHAR2,
       FROM_BANK_CD IN VARCHAR2,
       FROM_NM IN VARCHAR2,
       TO_ACCOUNT_NO IN VARCHAR2,
       TO_BANK_CD IN CHAR,
       TO_NM IN VARCHAR2,
       H_MOUNT IN NUMBER,
       v_result OUT NUMBER
) AS
    from_balance NUMBER;
    to_balance NUMBER;
BEGIN

       CASE FROM_BANK_CD
       --출금 은행이 JH 뱅크일때
       WHEN 'JH' THEN
           -- 출금 계좌의 잔액 확인
           SELECT balance INTO from_balance
           FROM BANK_ACCOUNT
           WHERE ACCOUNT_NO = FROM_ACCOUNT_NO;

           -- 이체 금액이 출금 계좌 잔액보다 큰지 확인
           IF H_MOUNT > from_balance THEN
               RAISE_APPLICATION_ERROR(-20001, '잔액이 부족합니다.');
           END IF;

           -- 출금 계좌 잔액 업데이트
           UPDATE BANK_ACCOUNT
           SET balance = balance - H_MOUNT
           WHERE account_NO = FROM_ACCOUNT_NO;

           -- 로그 테이블에 출금 기록 추가
           INSERT INTO BANK_HISTORY (FROM_ACCOUNT_NO, FROM_BANK_CD, FROM_NM, TO_ACCOUNT_NO, TO_BANK_CD, TO_NM, H_MOUNT, H_CLASS, H_BALANCE)
           VALUES (FROM_ACCOUNT_NO, FROM_BANK_CD, FROM_NM, TO_ACCOUNT_NO, TO_BANK_CD, TO_NM, H_MOUNT, '1', (SELECT BALANCE FROM BANK_ACCOUNT WHERE ACCOUNT_NO = FROM_ACCOUNT_NO));    

       --출금 은행이 HJ 뱅크일때 
       WHEN 'H.J' THEN    
           -- 출금 계좌의 잔액 확인
           SELECT MONEY INTO from_balance
           FROM B_ACCOUNT@HJ
           WHERE ACCOUNT_NO = FROM_ACCOUNT_NO;

           -- 이체 금액이 출금 계좌 잔액보다 큰지 확인
           IF H_MOUNT > from_balance THEN
               RAISE_APPLICATION_ERROR(-20001, '잔액이 부족합니다.');
           END IF;

           -- 출금 계좌 잔액 업데이트
           UPDATE B_ACCOUNT@HJ
           SET MONEY = MONEY - H_MOUNT
           WHERE ACCOUNT_NO = FROM_ACCOUNT_NO;

            -- 로그 테이블에 출금 기록 추가
           INSERT INTO B_TRANSACTION@HJ (TRANSACTIONID, ACCOUNT_NO, ACCOUNTNUMBER2, TRANSACTIONTYPE, AMOUNT, BANKNAME, BANKNAME_RECEIVE)
           VALUES (( SELECT NVL(MAX(TRANSACTIONID), 0) + 1 FROM B_TRANSACTION@HJ), FROM_ACCOUNT_NO, TO_ACCOUNT_NO, '-', H_MOUNT, (SELECT BANK_NAME FROM B_INFO@HJ WHERE BANK_CODE = FROM_BANK_CD), (SELECT BANK_NAME FROM B_INFO@HJ WHERE BANK_CODE = TO_BANK_CD));

       --출금 은행이 GH 뱅크일때 
       WHEN 'BGH' THEN    
           -- 출금 계좌의 잔액 확인
           SELECT ACCOUNT_BALANCE INTO from_balance
           FROM B_ACCOUNT@GH
           WHERE ACCOUNT_NO = FROM_ACCOUNT_NO;

           -- 이체 금액이 출금 계좌 잔액보다 큰지 확인
           IF H_MOUNT > from_balance THEN
               RAISE_APPLICATION_ERROR(-20001, '잔액이 부족합니다.');
           END IF;

           -- 출금 계좌 잔액 업데이트
           UPDATE B_ACCOUNT@GH
           SET ACCOUNT_BALANCE = ACCOUNT_BALANCE - H_MOUNT
           WHERE ACCOUNT_NO = FROM_ACCOUNT_NO;

            -- 로그 테이블에 출금 기록 추가
           INSERT INTO B_TRANSFER@GH (TRANSFER_NO, MYACCOUNT_NO, MYBANK_CODE, YOURACCOUNT_NO, YOURBANK_CODE, TRANSFER_DETAIL, TRANSFER_AMOUNT)
           VALUES (( SELECT NVL(MAX(TRANSFER_NO), 0) + 1 FROM B_TRANSFER@GH), FROM_ACCOUNT_NO, FROM_BANK_CD, TO_ACCOUNT_NO, TO_BANK_CD, '출금', H_MOUNT);


       --출금 은행이 SB 뱅크일때 
       WHEN '0758' THEN    
           -- 출금 계좌의 잔액 확인
           SELECT TOTAL_BALANCE INTO from_balance
           FROM B_USER_ACCOUNT@SB
           WHERE ACCOUNT_NO = FROM_ACCOUNT_NO;

           -- 이체 금액이 출금 계좌 잔액보다 큰지 확인
           IF H_MOUNT > from_balance THEN
               RAISE_APPLICATION_ERROR(-20001, '잔액이 부족합니다.');
           END IF;

           -- 출금 계좌 잔액 업데이트
           UPDATE B_USER_ACCOUNT@SB
           SET TOTAL_BALANCE = TOTAL_BALANCE - H_MOUNT
           WHERE ACCOUNT_NO = FROM_ACCOUNT_NO;

           -- 로그 테이블에 출금 기록 추가
           INSERT INTO B_TRANSACTION@SB(T_SENDER_BANK_CODE, T_SENDER_ACCOUNT_NO, T_RECEIVER_BANK_CODE, T_RECEIVER_ACCOUNT_NO, T_AMOUNT, T_TYPE, T_TO_MEMO, T_FROM_MEMO, T_STATUS, T_PREVIOUS_BALANCE, T_IN_OUT)
           VALUES ('0758', FROM_ACCOUNT_NO, TO_BANK_CD, TO_ACCOUNT_NO, H_MOUNT, CASE FROM_BANK_CD WHEN TO_BANK_CD THEN '당행이체' ELSE '타행이체' END, TO_NM, FROM_NM, '이체완료', (SELECT TOTAL_BALANCE FROM B_USER_ACCOUNT@SB WHERE ACCOUNT_NO = FROM_ACCOUNT_NO), '출금');    

       END CASE;

       CASE TO_BANK_CD
       --입금 은행이 JH 뱅크일때 
       WHEN 'JH' THEN
           -- 입금 계좌의 잔액 확인
           SELECT balance INTO to_balance
           FROM BANK_ACCOUNT
           WHERE account_NO = TO_ACCOUNT_NO;

           -- 입금 계좌 잔액 업데이트
           UPDATE BANK_ACCOUNT
           SET balance = balance + H_MOUNT
           WHERE account_NO = TO_ACCOUNT_NO;

           -- 로그 테이블에 입금 기록 추가
           INSERT INTO BANK_HISTORY (FROM_ACCOUNT_NO, FROM_BANK_CD, FROM_NM, TO_ACCOUNT_NO, TO_BANK_CD, TO_NM, H_MOUNT, H_CLASS, H_BALANCE)
           VALUES (TO_ACCOUNT_NO, TO_BANK_CD, TO_NM, FROM_ACCOUNT_NO, FROM_BANK_CD, FROM_NM,  H_MOUNT, '2', (SELECT BALANCE FROM BANK_ACCOUNT WHERE ACCOUNT_NO = TO_ACCOUNT_NO));


       --입금 은행이 HJ 뱅크일때 
       WHEN 'H.J' THEN    
           -- 입금 계좌의 잔액 확인
           SELECT MONEY INTO to_balance
           FROM B_ACCOUNT@HJ
           WHERE account_NO = TO_ACCOUNT_NO;

           -- 입금 계좌 잔액 업데이트
           UPDATE B_ACCOUNT@HJ
           SET MONEY = MONEY + H_MOUNT
           WHERE account_NO = TO_ACCOUNT_NO;

           -- 로그 테이블에 입금 기록 추가
           INSERT INTO B_TRANSACTION@HJ (TRANSACTIONID, ACCOUNT_NO, ACCOUNTNUMBER2, TRANSACTIONTYPE, AMOUNT, BANKNAME, BANKNAME_RECEIVE)
           VALUES (( SELECT NVL(MAX(TRANSACTIONID), 0) + 1 FROM B_TRANSACTION@HJ), TO_ACCOUNT_NO, FROM_ACCOUNT_NO, '+', H_MOUNT, (SELECT BANK_NAME FROM B_INFO@HJ WHERE BANK_CODE = TO_BANK_CD), (SELECT BANK_NAME FROM B_INFO@HJ WHERE BANK_CODE = FROM_BANK_CD));

       --입금 은행이 BGH 뱅크일때 
       WHEN 'BGH' THEN           
           -- 입금 계좌의 잔액 확인
           SELECT ACCOUNT_BALANCE INTO to_balance
           FROM B_ACCOUNT@GH
           WHERE account_NO = TO_ACCOUNT_NO;

           -- 입금 계좌 잔액 업데이트
           UPDATE B_ACCOUNT@GH
           SET ACCOUNT_BALANCE = ACCOUNT_BALANCE + H_MOUNT
           WHERE account_NO = TO_ACCOUNT_NO;


            -- 로그 테이블에 출금 기록 추가
           INSERT INTO B_TRANSFER@GH (TRANSFER_NO, MYACCOUNT_NO, MYBANK_CODE, YOURACCOUNT_NO, YOURBANK_CODE, TRANSFER_DETAIL, TRANSFER_AMOUNT)
           VALUES (( SELECT NVL(MAX(TRANSFER_NO), 0) + 1 FROM B_TRANSFER@GH), TO_ACCOUNT_NO, TO_BANK_CD, FROM_ACCOUNT_NO, FROM_BANK_CD, '입금', H_MOUNT);

       --입금 은행이 SB 뱅크일때 
       WHEN '0758' THEN
           -- 입금 계좌의 잔액 확인
           SELECT TOTAL_BALANCE INTO to_balance
           FROM B_USER_ACCOUNT@SB
           WHERE ACCOUNT_NO = TO_ACCOUNT_NO;

           -- 입금 계좌 잔액 업데이트
           UPDATE B_USER_ACCOUNT@SB
           SET TOTAL_BALANCE = TOTAL_BALANCE + H_MOUNT
           WHERE ACCOUNT_NO = TO_ACCOUNT_NO;

           -- 로그 테이블에 입금 기록 추가
           INSERT INTO B_TRANSACTION@SB (T_SENDER_BANK_CODE, T_SENDER_ACCOUNT_NO, T_RECEIVER_BANK_CODE, T_RECEIVER_ACCOUNT_NO, T_AMOUNT, T_TYPE, T_TO_MEMO, T_FROM_MEMO, T_STATUS, T_PREVIOUS_BALANCE, T_IN_OUT)
           VALUES ('0758', TO_ACCOUNT_NO, FROM_BANK_CD, FROM_ACCOUNT_NO, H_MOUNT, CASE FROM_BANK_CD WHEN TO_BANK_CD THEN '당행이체' ELSE '타행이체' END, FROM_NM, TO_NM, '이체완료', (SELECT TOTAL_BALANCE FROM B_USER_ACCOUNT@SB WHERE ACCOUNT_NO = TO_ACCOUNT_NO), '입금');
       END CASE;


    v_result := 1;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        v_result := 0;
        RAISE;
END;
--------------------------------------------------------
--  파일이 생성됨 - 토요일-6월-24-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence DEPARTMENTS_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "HR"."DEPARTMENTS_SEQ"  MINVALUE 1 MAXVALUE 9990 INCREMENT BY 10 START WITH 280 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence EMPLOYEES_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "HR"."EMPLOYEES_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 207 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence LOCATIONS_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "HR"."LOCATIONS_SEQ"  MINVALUE 1 MAXVALUE 9900 INCREMENT BY 100 START WITH 3300 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Table B_BANK_INFO
--------------------------------------------------------

  CREATE TABLE "HR"."B_BANK_INFO" 
   (	"B_BANK_CODE" VARCHAR2(200 BYTE), 
	"B_BANK_NAME" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table B_BOARD
--------------------------------------------------------

  CREATE TABLE "HR"."B_BOARD" 
   (	"P_NO" NUMBER, 
	"P_WRITER" VARCHAR2(200 BYTE), 
	"P_TITLE" VARCHAR2(200 BYTE), 
	"P_CONTENTS" CLOB, 
	"P_REG_DATE" VARCHAR2(200 BYTE) DEFAULT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 
	"P_HIT" NUMBER DEFAULT 0, 
	"P_CATEGORY" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" 
 LOB ("P_CONTENTS") STORE AS SECUREFILE (
  TABLESPACE "USERS" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ;

   COMMENT ON COLUMN "HR"."B_BOARD"."P_CATEGORY" IS '공지, F, Q';
--------------------------------------------------------
--  DDL for Table B_BOARD_IMG
--------------------------------------------------------

  CREATE TABLE "HR"."B_BOARD_IMG" 
   (	"파일번호" NUMBER, 
	"P_NO" NUMBER, 
	"파일명" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table B_COMMENT
--------------------------------------------------------

  CREATE TABLE "HR"."B_COMMENT" 
   (	"C_NO" NUMBER, 
	"COMMENTS" VARCHAR2(1800 BYTE), 
	"REG_DATE" VARCHAR2(200 BYTE) DEFAULT TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 
	"Q_ID" VARCHAR2(200 BYTE), 
	"P_NO" NUMBER, 
	"USER_ID" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table B_DEPOSIT
--------------------------------------------------------

  CREATE TABLE "HR"."B_DEPOSIT" 
   (	"D_PRODUCT_CODE" VARCHAR2(200 BYTE), 
	"D_PRODUCT_NAME" VARCHAR2(200 BYTE), 
	"D_INTEREST" NUMBER(3,1), 
	"D_SALE_STATUS" VARCHAR2(100 BYTE) DEFAULT 'Y', 
	"D_DETAIL" CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 LOB ("D_DETAIL") STORE AS SECUREFILE (
  TABLESPACE "USERS" ENABLE STORAGE IN ROW 4000 CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 262144 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;
--------------------------------------------------------
--  DDL for Table B_TRANSFER
--------------------------------------------------------

  CREATE TABLE "HR"."B_TRANSFER" 
   (	"T_TRANSACTION_NO" NUMBER, 
	"ACCOUNT_NO" VARCHAR2(200 BYTE), 
	"T_AMOUNT" NUMBER, 
	"T_RECEIVER_ACCOUNT" VARCHAR2(200 BYTE), 
	"T_DATE" VARCHAR2(200 BYTE) DEFAULT TO_CHAR(SYSDATE, 'YYYY.MM.DD'), 
	"T_TIME" VARCHAR2(200 BYTE) DEFAULT TO_CHAR(SYSDATE, 'HH24:MI:SS'), 
	"T_TYPE" NUMBER, 
	"T_PREVIOUS_BALANCE" NUMBER, 
	"T_TO_RECEIVER" VARCHAR2(45 BYTE), 
	"T_FROM_MEMO" VARCHAR2(45 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "HR"."B_TRANSFER"."T_TYPE" IS '오픈뱅킹/당행/타행';
   COMMENT ON COLUMN "HR"."B_TRANSFER"."T_TO_RECEIVER" IS '7자이내';
   COMMENT ON COLUMN "HR"."B_TRANSFER"."T_FROM_MEMO" IS '7자이내';
--------------------------------------------------------
--  DDL for Table B_USER_ACCOUNT
--------------------------------------------------------

  CREATE TABLE "HR"."B_USER_ACCOUNT" 
   (	"ACCOUNT_NO" VARCHAR2(200 BYTE), 
	"CREATED_DATE" DATE DEFAULT SYSDATE, 
	"ACCOUNT_PASSWORD" NUMBER(*,0), 
	"TOTAL_BALANCE" NUMBER, 
	"ACCOUNT_NICKNAME" VARCHAR2(200 BYTE), 
	"D_PRODUCT_CODE" VARCHAR2(200 BYTE), 
	"USER_ID" VARCHAR2(200 BYTE), 
	"B_BANK_CODE" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "HR"."B_USER_ACCOUNT"."ACCOUNT_PASSWORD" IS '숫자4자리';
--------------------------------------------------------
--  DDL for Table B_USER_ADDRESS
--------------------------------------------------------

  CREATE TABLE "HR"."B_USER_ADDRESS" 
   (	"USER_ID" VARCHAR2(200 BYTE), 
	"ADDRESS_TYPE" VARCHAR2(200 BYTE), 
	"POSTCODE" NUMBER(5,0), 
	"ROAD_ADDRESS" VARCHAR2(200 BYTE), 
	"DETAIL_ADDRESS" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "HR"."B_USER_ADDRESS"."ADDRESS_TYPE" IS '자택/직장';
--------------------------------------------------------
--  DDL for Table B_USER_AUTHORITY
--------------------------------------------------------

  CREATE TABLE "HR"."B_USER_AUTHORITY" 
   (	"ROLE_CODE" VARCHAR2(100 BYTE), 
	"ROLE_NAME" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "HR"."B_USER_AUTHORITY"."ROLE_CODE" IS 'A758, H1, H2, H3';
   COMMENT ON COLUMN "HR"."B_USER_AUTHORITY"."ROLE_NAME" IS '관리자, 골드, 실버, 브론즈';
--------------------------------------------------------
--  DDL for Table B_USER_INFO
--------------------------------------------------------

  CREATE TABLE "HR"."B_USER_INFO" 
   (	"USER_ID" VARCHAR2(200 BYTE), 
	"USER_PASSWORD" VARCHAR2(200 BYTE), 
	"KOR_NAME" VARCHAR2(200 BYTE), 
	"BIRTHDATE" VARCHAR2(200 BYTE), 
	"GENDER" VARCHAR2(200 BYTE), 
	"TELECOM" VARCHAR2(200 BYTE), 
	"PHONE_NO" VARCHAR2(200 BYTE), 
	"EMAIL" VARCHAR2(200 BYTE), 
	"SIGNUP_TYPE" VARCHAR2(200 BYTE), 
	"REG_DATETIME" VARCHAR2(200 BYTE) DEFAULT TO_CHAR(SYSDATE, 'YYYY.MM.DD HH24:MI:SS'), 
	"ROLE_CODE" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "HR"."B_USER_INFO"."GENDER" IS '1~9';
   COMMENT ON COLUMN "HR"."B_USER_INFO"."SIGNUP_TYPE" IS '웹/카카오';
   COMMENT ON COLUMN "HR"."B_USER_INFO"."ROLE_CODE" IS 'A758, H1, H2, H3';
--------------------------------------------------------
--  DDL for View EMP_DETAILS_VIEW
--------------------------------------------------------

  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "HR"."EMP_DETAILS_VIEW" ("EMPLOYEE_ID", "JOB_ID", "MANAGER_ID", "DEPARTMENT_ID", "LOCATION_ID", "COUNTRY_ID", "FIRST_NAME", "LAST_NAME", "SALARY", "COMMISSION_PCT", "DEPARTMENT_NAME", "JOB_TITLE", "CITY", "STATE_PROVINCE", "COUNTRY_NAME", "REGION_NAME") AS 
  SELECT
  e.employee_id,
  e.job_id,
  e.manager_id,
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id
WITH READ ONLY;
REM INSERTING into HR.B_BANK_INFO
SET DEFINE OFF;
Insert into HR.B_BANK_INFO (B_BANK_CODE,B_BANK_NAME) values ('0758','하리은행');
commit;
REM INSERTING into HR.B_BOARD
SET DEFINE OFF;
REM INSERTING into HR.B_BOARD_IMG
SET DEFINE OFF;
REM INSERTING into HR.B_COMMENT
SET DEFINE OFF;
REM INSERTING into HR.B_DEPOSIT
SET DEFINE OFF;
Insert into HR.B_DEPOSIT (D_PRODUCT_CODE,D_PRODUCT_NAME,D_INTEREST,D_SALE_STATUS) values ('D-202301','HR하리사랑통장',0.1,'Y');
commit;
REM INSERTING into HR.B_TRANSFER
SET DEFINE OFF;
REM INSERTING into HR.B_USER_ACCOUNT
SET DEFINE OFF;
REM INSERTING into HR.B_USER_ADDRESS
SET DEFINE OFF;
Insert into HR.B_USER_ADDRESS (USER_ID,ADDRESS_TYPE,POSTCODE,ROAD_ADDRESS,DETAIL_ADDRESS) values ('aaaa','자택',13122,'경기 성남시 수정구 수정로 398 (산성동)','한울관');
Insert into HR.B_USER_ADDRESS (USER_ID,ADDRESS_TYPE,POSTCODE,ROAD_ADDRESS,DETAIL_ADDRESS) values ('bbbb','자택',15616,'경기 안산시 단원구 첨단로 7 (성곡동)','2003-1107');
Insert into HR.B_USER_ADDRESS (USER_ID,ADDRESS_TYPE,POSTCODE,ROAD_ADDRESS,DETAIL_ADDRESS) values ('admin','자택',13122,'경기 성남시 수정구 수정로 398 (산성동)','aaaa');
commit;
REM INSERTING into HR.B_USER_AUTHORITY
SET DEFINE OFF;
Insert into HR.B_USER_AUTHORITY (ROLE_CODE,ROLE_NAME) values ('H1','골드');
Insert into HR.B_USER_AUTHORITY (ROLE_CODE,ROLE_NAME) values ('H2','실버');
Insert into HR.B_USER_AUTHORITY (ROLE_CODE,ROLE_NAME) values ('A758','관리자');
Insert into HR.B_USER_AUTHORITY (ROLE_CODE,ROLE_NAME) values ('H3','브론즈');
commit;
REM INSERTING into HR.B_USER_INFO
SET DEFINE OFF;
Insert into HR.B_USER_INFO (USER_ID,USER_PASSWORD,KOR_NAME,BIRTHDATE,GENDER,TELECOM,PHONE_NO,EMAIL,SIGNUP_TYPE,REG_DATETIME,ROLE_CODE) values ('aaaa','1111','정수빈','901208','2','LGU','01022223333','water4360@naver.com','web','2023.06.24 16:18:50','H3');
Insert into HR.B_USER_INFO (USER_ID,USER_PASSWORD,KOR_NAME,BIRTHDATE,GENDER,TELECOM,PHONE_NO,EMAIL,SIGNUP_TYPE,REG_DATETIME,ROLE_CODE) values ('bbbb','2222','박선우','901208','1','KT','01022222222','water4360@daum.net','web','2023.06.24 16:53:05','H3');
Insert into HR.B_USER_INFO (USER_ID,USER_PASSWORD,KOR_NAME,BIRTHDATE,GENDER,TELECOM,PHONE_NO,EMAIL,SIGNUP_TYPE,REG_DATETIME,ROLE_CODE) values ('admin','1111','관리자','901208','2','KT','1083499438','water4360@naver.com','web','2023.06.24 18:03:08','H3');
commit;
--------------------------------------------------------
--  DDL for Index PK_B_BANK_INFO
--------------------------------------------------------

  CREATE UNIQUE INDEX "HR"."PK_B_BANK_INFO" ON "HR"."B_BANK_INFO" ("B_BANK_CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_B_BOARD
--------------------------------------------------------

  CREATE UNIQUE INDEX "HR"."PK_B_BOARD" ON "HR"."B_BOARD" ("P_NO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_B_BOARD_IMG
--------------------------------------------------------

  CREATE UNIQUE INDEX "HR"."PK_B_BOARD_IMG" ON "HR"."B_BOARD_IMG" ("파일번호", "P_NO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_B_COMMENT
--------------------------------------------------------

  CREATE UNIQUE INDEX "HR"."PK_B_COMMENT" ON "HR"."B_COMMENT" ("C_NO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_B_DEPOSIT
--------------------------------------------------------

  CREATE UNIQUE INDEX "HR"."PK_B_DEPOSIT" ON "HR"."B_DEPOSIT" ("D_PRODUCT_CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_B_TRANSFER
--------------------------------------------------------

  CREATE UNIQUE INDEX "HR"."PK_B_TRANSFER" ON "HR"."B_TRANSFER" ("T_TRANSACTION_NO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_B_USER_ACCOUNT
--------------------------------------------------------

  CREATE UNIQUE INDEX "HR"."PK_B_USER_ACCOUNT" ON "HR"."B_USER_ACCOUNT" ("ACCOUNT_NO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_B_USER_ADDRESS
--------------------------------------------------------

  CREATE UNIQUE INDEX "HR"."PK_B_USER_ADDRESS" ON "HR"."B_USER_ADDRESS" ("USER_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_B_USER_AUTHORITY
--------------------------------------------------------

  CREATE UNIQUE INDEX "HR"."PK_B_USER_AUTHORITY" ON "HR"."B_USER_AUTHORITY" ("ROLE_CODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_B_USER_INFO
--------------------------------------------------------

  CREATE UNIQUE INDEX "HR"."PK_B_USER_INFO" ON "HR"."B_USER_INFO" ("USER_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table B_BANK_INFO
--------------------------------------------------------

  ALTER TABLE "HR"."B_BANK_INFO" MODIFY ("B_BANK_CODE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_BANK_INFO" MODIFY ("B_BANK_NAME" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_BANK_INFO" ADD CONSTRAINT "PK_B_BANK_INFO" PRIMARY KEY ("B_BANK_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table B_BOARD
--------------------------------------------------------

  ALTER TABLE "HR"."B_BOARD" MODIFY ("P_NO" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_BOARD" MODIFY ("P_WRITER" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_BOARD" MODIFY ("P_TITLE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_BOARD" MODIFY ("P_CONTENTS" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_BOARD" MODIFY ("P_REG_DATE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_BOARD" MODIFY ("P_HIT" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_BOARD" ADD CONSTRAINT "PK_B_BOARD" PRIMARY KEY ("P_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table B_BOARD_IMG
--------------------------------------------------------

  ALTER TABLE "HR"."B_BOARD_IMG" MODIFY ("파일번호" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_BOARD_IMG" MODIFY ("P_NO" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_BOARD_IMG" ADD CONSTRAINT "PK_B_BOARD_IMG" PRIMARY KEY ("파일번호", "P_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table B_COMMENT
--------------------------------------------------------

  ALTER TABLE "HR"."B_COMMENT" MODIFY ("C_NO" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_COMMENT" MODIFY ("REG_DATE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_COMMENT" MODIFY ("Q_ID" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_COMMENT" MODIFY ("P_NO" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_COMMENT" MODIFY ("USER_ID" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_COMMENT" ADD CONSTRAINT "PK_B_COMMENT" PRIMARY KEY ("C_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table B_DEPOSIT
--------------------------------------------------------

  ALTER TABLE "HR"."B_DEPOSIT" MODIFY ("D_PRODUCT_CODE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_DEPOSIT" MODIFY ("D_PRODUCT_NAME" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_DEPOSIT" MODIFY ("D_INTEREST" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_DEPOSIT" MODIFY ("D_SALE_STATUS" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_DEPOSIT" MODIFY ("D_DETAIL" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_DEPOSIT" ADD CONSTRAINT "PK_B_DEPOSIT" PRIMARY KEY ("D_PRODUCT_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table B_TRANSFER
--------------------------------------------------------

  ALTER TABLE "HR"."B_TRANSFER" MODIFY ("T_TRANSACTION_NO" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_TRANSFER" MODIFY ("ACCOUNT_NO" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_TRANSFER" MODIFY ("T_AMOUNT" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_TRANSFER" MODIFY ("T_RECEIVER_ACCOUNT" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_TRANSFER" MODIFY ("T_DATE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_TRANSFER" MODIFY ("T_TIME" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_TRANSFER" MODIFY ("T_PREVIOUS_BALANCE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_TRANSFER" ADD CONSTRAINT "PK_B_TRANSFER" PRIMARY KEY ("T_TRANSACTION_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table B_USER_ACCOUNT
--------------------------------------------------------

  ALTER TABLE "HR"."B_USER_ACCOUNT" MODIFY ("ACCOUNT_NO" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_ACCOUNT" MODIFY ("CREATED_DATE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_ACCOUNT" MODIFY ("ACCOUNT_PASSWORD" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_ACCOUNT" MODIFY ("TOTAL_BALANCE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_ACCOUNT" MODIFY ("D_PRODUCT_CODE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_ACCOUNT" MODIFY ("USER_ID" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_ACCOUNT" MODIFY ("B_BANK_CODE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_ACCOUNT" ADD CONSTRAINT "PK_B_USER_ACCOUNT" PRIMARY KEY ("ACCOUNT_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table B_USER_ADDRESS
--------------------------------------------------------

  ALTER TABLE "HR"."B_USER_ADDRESS" MODIFY ("USER_ID" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_ADDRESS" MODIFY ("ADDRESS_TYPE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_ADDRESS" MODIFY ("POSTCODE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_ADDRESS" ADD CONSTRAINT "PK_B_USER_ADDRESS" PRIMARY KEY ("USER_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table B_USER_AUTHORITY
--------------------------------------------------------

  ALTER TABLE "HR"."B_USER_AUTHORITY" MODIFY ("ROLE_CODE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_AUTHORITY" MODIFY ("ROLE_NAME" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_AUTHORITY" ADD CONSTRAINT "PK_B_USER_AUTHORITY" PRIMARY KEY ("ROLE_CODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table B_USER_INFO
--------------------------------------------------------

  ALTER TABLE "HR"."B_USER_INFO" MODIFY ("USER_ID" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_INFO" MODIFY ("USER_PASSWORD" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_INFO" MODIFY ("KOR_NAME" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_INFO" MODIFY ("BIRTHDATE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_INFO" MODIFY ("GENDER" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_INFO" MODIFY ("TELECOM" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_INFO" MODIFY ("PHONE_NO" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_INFO" MODIFY ("EMAIL" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_INFO" MODIFY ("SIGNUP_TYPE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_INFO" MODIFY ("REG_DATETIME" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_INFO" MODIFY ("ROLE_CODE" NOT NULL ENABLE);
  ALTER TABLE "HR"."B_USER_INFO" ADD CONSTRAINT "PK_B_USER_INFO" PRIMARY KEY ("USER_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table B_BOARD
--------------------------------------------------------

  ALTER TABLE "HR"."B_BOARD" ADD CONSTRAINT "FK_B_USER_INFO_TO_B_BOARD_1" FOREIGN KEY ("P_WRITER")
	  REFERENCES "HR"."B_USER_INFO" ("USER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table B_BOARD_IMG
--------------------------------------------------------

  ALTER TABLE "HR"."B_BOARD_IMG" ADD CONSTRAINT "FK_B_BOARD_TO_B_BOARD_IMG_1" FOREIGN KEY ("P_NO")
	  REFERENCES "HR"."B_BOARD" ("P_NO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table B_COMMENT
--------------------------------------------------------

  ALTER TABLE "HR"."B_COMMENT" ADD CONSTRAINT "FK_B_BOARD_TO_B_COMMENT_1" FOREIGN KEY ("P_NO")
	  REFERENCES "HR"."B_BOARD" ("P_NO") ENABLE;
  ALTER TABLE "HR"."B_COMMENT" ADD CONSTRAINT "FK_B_USER_INFO_TO_B_COMMENT_1" FOREIGN KEY ("USER_ID")
	  REFERENCES "HR"."B_USER_INFO" ("USER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table B_TRANSFER
--------------------------------------------------------

  ALTER TABLE "HR"."B_TRANSFER" ADD CONSTRAINT "FK_B_USER_ACCOUNT_TO_B_TRANSFER_1" FOREIGN KEY ("ACCOUNT_NO")
	  REFERENCES "HR"."B_USER_ACCOUNT" ("ACCOUNT_NO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table B_USER_ACCOUNT
--------------------------------------------------------

  ALTER TABLE "HR"."B_USER_ACCOUNT" ADD CONSTRAINT "FK_B_DEPOSIT_TO_B_USER_ACCOUNT_1" FOREIGN KEY ("D_PRODUCT_CODE")
	  REFERENCES "HR"."B_DEPOSIT" ("D_PRODUCT_CODE") ENABLE;
  ALTER TABLE "HR"."B_USER_ACCOUNT" ADD CONSTRAINT "FK_B_USER_INFO_TO_B_USER_ACCOUNT_1" FOREIGN KEY ("USER_ID")
	  REFERENCES "HR"."B_USER_INFO" ("USER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table B_USER_ADDRESS
--------------------------------------------------------

  ALTER TABLE "HR"."B_USER_ADDRESS" ADD CONSTRAINT "FK_B_USER_INFO_TO_B_USER_ADDRESS_1" FOREIGN KEY ("USER_ID")
	  REFERENCES "HR"."B_USER_INFO" ("USER_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table B_USER_INFO
--------------------------------------------------------

  ALTER TABLE "HR"."B_USER_INFO" ADD CONSTRAINT "FK_B_USER_AUTHORITY_TO_B_USER_INFO_1" FOREIGN KEY ("ROLE_CODE")
	  REFERENCES "HR"."B_USER_AUTHORITY" ("ROLE_CODE") ENABLE;
--------------------------------------------------------
--  DDL for Procedure ADD_JOB_HISTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "HR"."ADD_JOB_HISTORY" 
  (  p_emp_id          job_history.employee_id%type
   , p_start_date      job_history.start_date%type
   , p_end_date        job_history.end_date%type
   , p_job_id          job_history.job_id%type
   , p_department_id   job_history.department_id%type
   )
IS
BEGIN
  INSERT INTO job_history (employee_id, start_date, end_date,
                           job_id, department_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;

/
--------------------------------------------------------
--  DDL for Procedure SECURE_DML
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "HR"."SECURE_DML" 
IS
BEGIN
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'
        OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
	RAISE_APPLICATION_ERROR (-20205,
		'You may only make changes during normal office hours');
  END IF;
END secure_dml;

/

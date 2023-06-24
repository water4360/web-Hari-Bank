--DROP TABLE "B_USER_INFO" CASCADE CONSTRAINTS;
--DROP TABLE "B_DEPOSIT" CASCADE CONSTRAINTS;
--DROP TABLE "B_TRANSFER" CASCADE CONSTRAINTS;
--DROP TABLE "B_USER_AUTHORITY" CASCADE CONSTRAINTS;
--DROP TABLE "B_USER_ACCOUNT" CASCADE CONSTRAINTS;
--DROP TABLE "B_COMMENT" CASCADE CONSTRAINTS;
--DROP TABLE "B_BOARD" CASCADE CONSTRAINTS;
--DROP TABLE "B_USER_ADDRESS" CASCADE CONSTRAINTS;
--DROP TABLE "B_BOARD_IMG" CASCADE CONSTRAINTS;
--DROP TABLE "B_BANK_INFO" CASCADE CONSTRAINTS;


SELECT * FROM B_USER_INFO;
SELECT * FROM B_USER_ADDRESS;
SELECT * FROM B_USER_AUTHORITY;


COMMIT;

DROP TABLE "B_USER_INFO";

CREATE TABLE "B_USER_INFO" (
	"USER_ID"	VARCHAR2(200)		NOT NULL,
	"USER_PASSWORD"	VARCHAR2(200)		NOT NULL,
	"KOR_NAME"	VARCHAR2(200)		NOT NULL,
	"BIRTHDATE"	VARCHAR2(200)		NOT NULL,
	"GENDER"	VARCHAR2(200)		NOT NULL,
	"TELECOM"	VARCHAR2(200)		NOT NULL,
	"PHONE_NO"	VARCHAR2(200)		NOT NULL,
	"EMAIL"	VARCHAR2(200)		NOT NULL,
	"SIGNUP_TYPE"	VARCHAR2(200)		NOT NULL,
	"REG_DATETIME"	VARCHAR2(200)	DEFAULT TO_CHAR(SYSDATE, 'YYYY.MM.DD HH24:MI:SS')	NOT NULL,
	"ROLE_CODE"	VARCHAR2(100)		NOT NULL
);

COMMENT ON COLUMN "B_USER_INFO"."GENDER" IS '1~9';

COMMENT ON COLUMN "B_USER_INFO"."SIGNUP_TYPE" IS '웹/카카오';

COMMENT ON COLUMN "B_USER_INFO"."ROLE_CODE" IS 'A758, H1, H2, H3';

ALTER TABLE "B_USER_INFO" ADD CONSTRAINT "PK_B_USER_INFO" PRIMARY KEY (
	"USER_ID"
);

DROP TABLE "B_DEPOSIT";

CREATE TABLE "B_DEPOSIT" (
	"D_PRODUCT_CODE"	VARCHAR2(200)		NOT NULL,
	"D_PRODUCT_NAME"	VARCHAR2(200)		NOT NULL,
	"D_INTEREST"	NUMBER(3,1)		NOT NULL,
	"D_SALE_STATUS"	VARCHAR2(100)	DEFAULT 'Y'	NOT NULL,
	"D_DETAIL"	CLOB		NOT NULL
);

DROP TABLE "B_TRANSFER";

CREATE TABLE "B_TRANSFER" (
	"T_TRANSACTION_NO"	NUMBER		NOT NULL,
	"ACCOUNT_NO"	VARCHAR2(200)		NOT NULL,
	"T_AMOUNT"	NUMBER		NOT NULL,
	"T_RECEIVER_ACCOUNT"	VARCHAR2(200)		NOT NULL,
	"T_DATE"	VARCHAR2(200)	DEFAULT TO_CHAR(SYSDATE, 'YYYY.MM.DD')	NOT NULL,
	"T_TIME"	VARCHAR2(200)	DEFAULT TO_CHAR(SYSDATE, 'HH24:MI:SS')	NOT NULL,
	"T_TYPE"	NUMBER		NULL,
	"T_PREVIOUS_BALANCE"	NUMBER		NOT NULL,
	"T_TO_RECEIVER"	VARCHAR2(45)		NULL,
	"T_FROM_MEMO"	VARCHAR2(45)		NULL
);

COMMENT ON COLUMN "B_TRANSFER"."T_TYPE" IS '오픈뱅킹/당행/타행';

COMMENT ON COLUMN "B_TRANSFER"."T_TO_RECEIVER" IS '7자이내';

COMMENT ON COLUMN "B_TRANSFER"."T_FROM_MEMO" IS '7자이내';

DROP TABLE "B_USER_AUTHORITY";

CREATE TABLE "B_USER_AUTHORITY" (
	"ROLE_CODE"	VARCHAR2(100)		NOT NULL,
	"ROLE_NAME"	VARCHAR2(100)		NOT NULL
);

COMMENT ON COLUMN "B_USER_AUTHORITY"."ROLE_CODE" IS 'A758, H1, H2, H3';

COMMENT ON COLUMN "B_USER_AUTHORITY"."ROLE_NAME" IS '관리자, 골드, 실버, 브론즈';

DROP TABLE "B_USER_ACCOUNT";

CREATE TABLE "B_USER_ACCOUNT" (
	"ACCOUNT_NO"	VARCHAR2(200)		NOT NULL,
	"CREATED_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"ACCOUNT_PASSWORD"	INTEGER		NOT NULL,
	"TOTAL_BALANCE"	NUMBER		NOT NULL,
	"ACCOUNT_NICKNAME"	VARCHAR2(200)		NULL,
	"D_PRODUCT_CODE"	VARCHAR2(200)		NOT NULL,
	"USER_ID"	VARCHAR2(200)		NOT NULL,
	"B_BANK_CODE"	VARCHAR2(200)		NOT NULL
);

COMMENT ON COLUMN "B_USER_ACCOUNT"."ACCOUNT_PASSWORD" IS '숫자4자리';

DROP TABLE "B_COMMENT";

CREATE TABLE "B_COMMENT" (
	"C_NO"	NUMBER		NOT NULL,
	"COMMENTS"	VARCHAR2(1800)		NULL,
	"REG_DATE"	VARCHAR2(200)	DEFAULT TO_CHAR(SYSDATE, 'YYYY-MM-DD')	NOT NULL,
	"Q_ID"	VARCHAR2(200)		NOT NULL,
	"P_NO"	NUMBER		NOT NULL,
	"USER_ID"	VARCHAR2(200)		NOT NULL
);

DROP TABLE "B_BOARD";

CREATE TABLE "B_BOARD" (
	"P_NO"	NUMBER		NOT NULL,
	"P_WRITER"	VARCHAR2(200)		NOT NULL,
	"P_TITLE"	VARCHAR2(200)		NOT NULL,
	"P_CONTENTS"	CLOB		NOT NULL,
	"P_REG_DATE"	VARCHAR2(200)	DEFAULT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')	NOT NULL,
	"P_HIT"	NUMBER	DEFAULT 0	NOT NULL,
	"P_CATEGORY"	VARCHAR2(200)		NULL
);

COMMENT ON COLUMN "B_BOARD"."P_CATEGORY" IS '공지, F&Q, Q&A';

DROP TABLE "B_USER_ADDRESS";

CREATE TABLE "B_USER_ADDRESS" (
	"USER_ID"	VARCHAR2(200)		NOT NULL,
	"ADDRESS_TYPE"	VARCHAR2(200)		NOT NULL,
	"POSTCODE"	NUMBER(5)		NOT NULL,
	"ROAD_ADDRESS"	VARCHAR2(200)		NULL,
	"DETAIL_ADDRESS"	VARCHAR2(200)		NULL
);

COMMENT ON COLUMN "B_USER_ADDRESS"."ADDRESS_TYPE" IS '자택/직장';

DROP TABLE "B_BOARD_IMG";

CREATE TABLE "B_BOARD_IMG" (
	"파일번호"	NUMBER		NOT NULL,
	"P_NO"	NUMBER		NOT NULL,
	"파일명"	VARCHAR2(200)		NULL
);

DROP TABLE "B_BANK_INFO";

CREATE TABLE "B_BANK_INFO" (
	"B_BANK_CODE"	VARCHAR2(200)		NOT NULL,
	"B_BANK_NAME"	VARCHAR2(200)		NOT NULL
);

ALTER TABLE "B_USER_INFO" ADD CONSTRAINT "PK_B_USER_INFO" PRIMARY KEY (
	"USER_ID"
);

ALTER TABLE "B_DEPOSIT" ADD CONSTRAINT "PK_B_DEPOSIT" PRIMARY KEY (
	"D_PRODUCT_CODE"
);

ALTER TABLE "B_TRANSFER" ADD CONSTRAINT "PK_B_TRANSFER" PRIMARY KEY (
	"T_TRANSACTION_NO"
);

ALTER TABLE "B_USER_AUTHORITY" ADD CONSTRAINT "PK_B_USER_AUTHORITY" PRIMARY KEY (
	"ROLE_CODE"
);

ALTER TABLE "B_USER_ACCOUNT" ADD CONSTRAINT "PK_B_USER_ACCOUNT" PRIMARY KEY (
	"ACCOUNT_NO"
);

ALTER TABLE "B_COMMENT" ADD CONSTRAINT "PK_B_COMMENT" PRIMARY KEY (
	"C_NO"
);

ALTER TABLE "B_BOARD" ADD CONSTRAINT "PK_B_BOARD" PRIMARY KEY (
	"P_NO"
);

ALTER TABLE "B_USER_ADDRESS" ADD CONSTRAINT "PK_B_USER_ADDRESS" PRIMARY KEY (
	"USER_ID"
);

ALTER TABLE "B_BOARD_IMG" ADD CONSTRAINT "PK_B_BOARD_IMG" PRIMARY KEY (
	"파일번호",
	"P_NO"
);

ALTER TABLE "B_BANK_INFO" ADD CONSTRAINT "PK_B_BANK_INFO" PRIMARY KEY (
	"B_BANK_CODE"
);

ALTER TABLE "B_USER_INFO" ADD CONSTRAINT "FK_B_USER_AUTHORITY_TO_B_USER_INFO_1" FOREIGN KEY (
	"ROLE_CODE"
)
REFERENCES "B_USER_AUTHORITY" (
	"ROLE_CODE"
);

ALTER TABLE "B_USER_INFO" ADD CONSTRAINT "FK_B_BANK_INFO_TO_B_USER_INFO_1" FOREIGN KEY (
	"B_BANK_CODE"
)
REFERENCES "B_BANK_INFO" (
	"B_BANK_CODE"
);

ALTER TABLE "B_TRANSFER" ADD CONSTRAINT "FK_B_USER_ACCOUNT_TO_B_TRANSFER_1" FOREIGN KEY (
	"ACCOUNT_NO"
)
REFERENCES "B_USER_ACCOUNT" (
	"ACCOUNT_NO"
);

ALTER TABLE "B_USER_ACCOUNT" ADD CONSTRAINT "FK_B_DEPOSIT_TO_B_USER_ACCOUNT_1" FOREIGN KEY (
	"D_PRODUCT_CODE"
)
REFERENCES "B_DEPOSIT" (
	"D_PRODUCT_CODE"
);

ALTER TABLE "B_USER_ACCOUNT" ADD CONSTRAINT "FK_B_USER_INFO_TO_B_USER_ACCOUNT_1" FOREIGN KEY (
	"USER_ID"
)
REFERENCES "B_USER_INFO" (
	"USER_ID"
);

ALTER TABLE "B_USER_ACCOUNT" ADD CONSTRAINT "FK_B_BANK_INFO_TO_B_USER_ACCOUNT_1" FOREIGN KEY (
	"B_BANK_CODE"
)
REFERENCES "B_BANK_INFO" (
	"B_BANK_CODE"
);

ALTER TABLE "B_COMMENT" ADD CONSTRAINT "FK_B_BOARD_TO_B_COMMENT_1" FOREIGN KEY (
	"P_NO"
)
REFERENCES "B_BOARD" (
	"P_NO"
);

ALTER TABLE "B_COMMENT" ADD CONSTRAINT "FK_B_USER_INFO_TO_B_COMMENT_1" FOREIGN KEY (
	"USER_ID"
)
REFERENCES "B_USER_INFO" (
	"USER_ID"
);

ALTER TABLE "B_BOARD" ADD CONSTRAINT "FK_B_USER_INFO_TO_B_BOARD_1" FOREIGN KEY (
	"P_WRITER"
)
REFERENCES "B_USER_INFO" (
	"USER_ID"
);

ALTER TABLE "B_USER_ADDRESS" ADD CONSTRAINT "FK_B_USER_INFO_TO_B_USER_ADDRESS_1" FOREIGN KEY (
	"USER_ID"
)
REFERENCES "B_USER_INFO" (
	"USER_ID"
);

ALTER TABLE "B_BOARD_IMG" ADD CONSTRAINT "FK_B_BOARD_TO_B_BOARD_IMG_1" FOREIGN KEY (
	"P_NO"
)
REFERENCES "B_BOARD" (
	"P_NO"
);


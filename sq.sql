CREATE TABLE "JS_SYS_OFFICE" 
(
  "OFFICE_CODE" VARCHAR2(64) NOT NULL ENABLE,
   "PARENT_CODE" VARCHAR2(64) NOT NULL ENABLE,
   "PARENT_CODES" VARCHAR2(1000) NOT NULL ENABLE,
   "TREE_SORT" NUMBER(10, 0) NOT NULL ENABLE,
   "TREE_SORTS" VARCHAR2(1000) NOT NULL ENABLE,
   "TREE_LEAF" CHAR(1) NOT NULL ENABLE,
   "TREE_LEVEL" NUMBER(4, 0) NOT NULL ENABLE,
   "TREE_NAMES" VARCHAR2(1000) NOT NULL ENABLE,
   "VIEW_CODE" VARCHAR2(100) NOT NULL ENABLE,
   "OFFICE_NAME" NVARCHAR2(100) NOT NULL ENABLE,
   "FULL_NAME" VARCHAR2(200) NOT NULL ENABLE,
   "OFFICE_TYPE" CHAR(1) NOT NULL ENABLE,
   "LEADER" VARCHAR2(100),
   "PHONE" VARCHAR2(100),
   "ADDRESS" VARCHAR2(255),
   "ZIP_CODE" VARCHAR2(100),
   "EMAIL" VARCHAR2(300),
   "STATUS" CHAR(1) NOT NULL ENABLE,
   "CREATE_BY" VARCHAR2(64) NOT NULL ENABLE,
   "CREATE_DATE" TIMESTAMP (6) NOT NULL ENABLE,
   "UPDATE_BY" VARCHAR2(64) NOT NULL ENABLE,
   "UPDATE_DATE" TIMESTAMP (6) NOT NULL ENABLE,
   "REMARKS" NVARCHAR2(500),
   "CORP_CODE" VARCHAR2(64) NOT NULL ENABLE,
   "CORP_NAME" NVARCHAR2(100) NOT NULL ENABLE,
   "EXTEND_S1" NVARCHAR2(500),
   "EXTEND_S2" NVARCHAR2(500),
   "EXTEND_S3" NVARCHAR2(500),
   "EXTEND_S4" NVARCHAR2(500),
   "EXTEND_S5" NVARCHAR2(500),
   "EXTEND_S6" NVARCHAR2(500),
   "EXTEND_S7" NVARCHAR2(500),
   "EXTEND_S8" NVARCHAR2(500),
   "EXTEND_I1" NUMBER(19, 0),
   "EXTEND_I2" NUMBER(19, 0),
   "EXTEND_I3" NUMBER(19, 0),
   "EXTEND_I4" NUMBER(19, 0),
   "EXTEND_F1" NUMBER(19, 4),
   "EXTEND_F2" NUMBER(19, 4),
   "EXTEND_F3" NUMBER(19, 4),
   "EXTEND_F4" NUMBER(19, 4),
   "EXTEND_D1" TIMESTAMP (6),
   "EXTEND_D2" TIMESTAMP (6),
   "EXTEND_D3" TIMESTAMP (6),
   "EXTEND_D4" TIMESTAMP (6)
)  
  PCTFREE 10 
  PCTUSED 40 
  INITRANS 1 
  MAXTRANS 255
   STORAGE(
  INITIAL 524288 
  NEXT 1048576 
  MINEXTENTS 1 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT) 
TABLESPACE "USERS" LOGGING NOCOMPRESS
/

COMMENT ON TABLE "JS_SYS_OFFICE" IS 
'��֯������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."OFFICE_CODE" IS 
'��������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."PARENT_CODE" IS 
'�������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."PARENT_CODES" IS 
'���и������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."TREE_SORT" IS 
'��������ţ�����'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."TREE_SORTS" IS 
'���м��������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."TREE_LEAF" IS 
'�Ƿ���ĩ��'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."TREE_LEVEL" IS 
'��μ���'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."TREE_NAMES" IS 
'ȫ�ڵ���'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."VIEW_CODE" IS 
'��������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."OFFICE_NAME" IS 
'��������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."FULL_NAME" IS 
'����ȫ��'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."OFFICE_TYPE" IS 
'��������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."LEADER" IS 
'������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."PHONE" IS 
'�칫�绰'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."ADDRESS" IS 
'��ϵ��ַ'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."ZIP_CODE" IS 
'��������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EMAIL" IS 
'��������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."STATUS" IS 
'״̬��0���� 1ɾ�� 2ͣ�ã�'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."CREATE_BY" IS 
'������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."CREATE_DATE" IS 
'����ʱ��'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."UPDATE_BY" IS 
'������'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."UPDATE_DATE" IS 
'����ʱ��'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."REMARKS" IS 
'��ע��Ϣ'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."CORP_CODE" IS 
'�⻧����'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."CORP_NAME" IS 
'�⻧����'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_S1" IS 
'��չ String 1'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_S2" IS 
'��չ String 2'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_S3" IS 
'��չ String 3'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_S4" IS 
'��չ String 4'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_S5" IS 
'��չ String 5'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_S6" IS 
'��չ String 6'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_S7" IS 
'��չ String 7'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_S8" IS 
'��չ String 8'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_I1" IS 
'��չ Integer 1'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_I2" IS 
'��չ Integer 2'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_I3" IS 
'��չ Integer 3'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_I4" IS 
'��չ Integer 4'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_F1" IS 
'��չ Float 1'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_F2" IS 
'��չ Float 2'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_F3" IS 
'��չ Float 3'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_F4" IS 
'��չ Float 4'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_D1" IS 
'��չ Date 1'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_D2" IS 
'��չ Date 2'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_D3" IS 
'��չ Date 3'
/
COMMENT ON COLUMN "JS_SYS_OFFICE"."EXTEND_D4" IS 
'��չ Date 4'
/
ALTER TABLE "JS_SYS_OFFICE" MODIFY ("STATUS" DEFAULT '0' )
/
ALTER TABLE "JS_SYS_OFFICE" MODIFY ("CORP_CODE" DEFAULT '0' )
/
ALTER TABLE "JS_SYS_OFFICE" MODIFY ("CORP_NAME" DEFAULT 'JeeSite' )
/
ALTER TABLE "JS_SYS_OFFICE"
 ADD  PRIMARY KEY 
(
  "OFFICE_CODE"
) USING INDEX 
  PCTFREE 10 
  INITRANS 2 
  MAXTRANS 255
   STORAGE(
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT)
 TABLESPACE "USERS"
 LOGGING ENABLE
/

CREATE INDEX "IDX_SYS_OFFICE_CC1"
 ON "JS_SYS_OFFICE" 
(
  "CORP_CODE" 
)  
  PCTFREE 10 
  INITRANS 2 
  MAXTRANS 255
   STORAGE(
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT) 
TABLESPACE "USERS" LOGGING
/

/* Formatted on 2020/6/30 14:32:28 (QP5 v5.360) */
BEGIN
    DBMS_STATS.SET_INDEX_STATS (NULL,
                                '"IDX_SYS_OFFICE_CC1"',
                                NULL,
                                NULL,
                                NULL,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0);
END;
/
CREATE INDEX "IDX_SYS_OFFICE_OT2"
 ON "JS_SYS_OFFICE" 
(
  "OFFICE_TYPE" 
)  
  PCTFREE 10 
  INITRANS 2 
  MAXTRANS 255
   STORAGE(
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT) 
TABLESPACE "USERS" LOGGING
/

/* Formatted on 2020/6/30 14:32:28 (QP5 v5.360) */
BEGIN
    DBMS_STATS.SET_INDEX_STATS (NULL,
                                '"IDX_SYS_OFFICE_OT2"',
                                NULL,
                                NULL,
                                NULL,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0);
END;
/
CREATE INDEX "IDX_SYS_OFFICE_PC3"
 ON "JS_SYS_OFFICE" 
(
  "PARENT_CODE" 
)  
  PCTFREE 10 
  INITRANS 2 
  MAXTRANS 255
   STORAGE(
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT) 
TABLESPACE "USERS" LOGGING
/

/* Formatted on 2020/6/30 14:32:28 (QP5 v5.360) */
BEGIN
    DBMS_STATS.SET_INDEX_STATS (NULL,
                                '"IDX_SYS_OFFICE_PC3"',
                                NULL,
                                NULL,
                                NULL,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0);
END;
/
CREATE INDEX "IDX_SYS_OFFICE_PCS4"
 ON "JS_SYS_OFFICE" 
(
  "PARENT_CODES" 
)  
  PCTFREE 10 
  INITRANS 2 
  MAXTRANS 255
   STORAGE(
  INITIAL 131072 
  NEXT 1048576 
  MINEXTENTS 1 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT) 
TABLESPACE "USERS" LOGGING
/

/* Formatted on 2020/6/30 14:32:28 (QP5 v5.360) */
BEGIN
    DBMS_STATS.SET_INDEX_STATS (NULL,
                                '"IDX_SYS_OFFICE_PCS4"',
                                NULL,
                                NULL,
                                NULL,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0);
END;
/
CREATE INDEX "IDX_SYS_OFFICE_STATUS5"
 ON "JS_SYS_OFFICE" 
(
  "STATUS" 
)  
  PCTFREE 10 
  INITRANS 2 
  MAXTRANS 255
   STORAGE(
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT) 
TABLESPACE "USERS" LOGGING
/

/* Formatted on 2020/6/30 14:32:28 (QP5 v5.360) */
BEGIN
    DBMS_STATS.SET_INDEX_STATS (NULL,
                                '"IDX_SYS_OFFICE_STATUS5"',
                                NULL,
                                NULL,
                                NULL,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0);
END;
/
CREATE INDEX "IDX_SYS_OFFICE_TS6"
 ON "JS_SYS_OFFICE" 
(
  "TREE_SORT" 
)  
  PCTFREE 10 
  INITRANS 2 
  MAXTRANS 255
   STORAGE(
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT) 
TABLESPACE "USERS" LOGGING
/

/* Formatted on 2020/6/30 14:32:28 (QP5 v5.360) */
BEGIN
    DBMS_STATS.SET_INDEX_STATS (NULL,
                                '"IDX_SYS_OFFICE_TS6"',
                                NULL,
                                NULL,
                                NULL,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0);
END;
/
CREATE INDEX "IDX_SYS_OFFICE_TSS7"
 ON "JS_SYS_OFFICE" 
(
  "TREE_SORTS" 
)  
  PCTFREE 10 
  INITRANS 2 
  MAXTRANS 255
   STORAGE(
  INITIAL 131072 
  NEXT 1048576 
  MINEXTENTS 1 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT) 
TABLESPACE "USERS" LOGGING
/

/* Formatted on 2020/6/30 14:32:28 (QP5 v5.360) */
BEGIN
    DBMS_STATS.SET_INDEX_STATS (NULL,
                                '"IDX_SYS_OFFICE_TSS7"',
                                NULL,
                                NULL,
                                NULL,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0);
END;
/
CREATE INDEX "IDX_SYS_OFFICE_VC8"
 ON "JS_SYS_OFFICE" 
(
  "VIEW_CODE" 
)  
  PCTFREE 10 
  INITRANS 2 
  MAXTRANS 255
   STORAGE(
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  FREELISTS 1 
  FREELIST GROUPS 1 
  BUFFER_POOL DEFAULT) 
TABLESPACE "USERS" LOGGING
/

/* Formatted on 2020/6/30 14:32:28 (QP5 v5.360) */
BEGIN
    DBMS_STATS.SET_INDEX_STATS (NULL,
                                '"IDX_SYS_OFFICE_VC8"',
                                NULL,
                                NULL,
                                NULL,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                0);
END;
/

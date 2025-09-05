--------------------------------------------------------
--  File created - Saturday-September-06-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type PG_DOC_TAG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "PG_DOC_TAG" AS TABLE OF VARCHAR2(200);
--------------------------------------------------------
--  DDL for Sequence DBTOOLS$EXECUTION_HISTORY_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DBTOOLS$EXECUTION_HISTORY_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence PG1_SEQ_DEPARTMENT_MASTER
--------------------------------------------------------

   CREATE SEQUENCE  "PG1_SEQ_DEPARTMENT_MASTER"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence PG1_SEQ_DESIGNATION_MASTER
--------------------------------------------------------

   CREATE SEQUENCE  "PG1_SEQ_DESIGNATION_MASTER"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence PG1_SEQ_EMPLOYEE_EDUCATION
--------------------------------------------------------

   CREATE SEQUENCE  "PG1_SEQ_EMPLOYEE_EDUCATION"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 101 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence PG1_SEQ_EMPLOYEE_EXPERIENCE
--------------------------------------------------------

   CREATE SEQUENCE  "PG1_SEQ_EMPLOYEE_EXPERIENCE"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 101 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence PG1_SEQ_EMPLOYEE_MASTER
--------------------------------------------------------

   CREATE SEQUENCE  "PG1_SEQ_EMPLOYEE_MASTER"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence PG1_SEQ_LOOKUP_VALUES
--------------------------------------------------------

   CREATE SEQUENCE  "PG1_SEQ_LOOKUP_VALUES"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Table DBTOOLS$EXECUTION_HISTORY
--------------------------------------------------------

  CREATE TABLE "DBTOOLS$EXECUTION_HISTORY" ("ID" NUMBER, "HASH" CLOB, "CREATED_BY" VARCHAR2(255), "CREATED_ON" TIMESTAMP (6) WITH TIME ZONE, "UPDATED_BY" VARCHAR2(255), "UPDATED_ON" TIMESTAMP (6) WITH TIME ZONE, "STATEMENT" CLOB, "TIMES" NUMBER)
--------------------------------------------------------
--  DDL for Table PG1_DEPARTMENT_MASTER
--------------------------------------------------------

  CREATE TABLE "PG1_DEPARTMENT_MASTER" ("DEPT_ID" NUMBER, "DEPT_CODE" VARCHAR2(20), "DEPT_NAME" VARCHAR2(100), "DEPT_HEAD" VARCHAR2(100), "IS_ACTIVE" CHAR(1) DEFAULT 'Y', "CREATED_DATE" DATE DEFAULT SYSDATE)
--------------------------------------------------------
--  DDL for Table PG1_DESIGNATION_MASTER
--------------------------------------------------------

  CREATE TABLE "PG1_DESIGNATION_MASTER" ("DESIG_ID" NUMBER, "DESIG_CODE" VARCHAR2(20), "DESIG_NAME" VARCHAR2(100), "DEPT_ID" NUMBER, "IS_ACTIVE" CHAR(1) DEFAULT 'Y', "CREATED_DATE" DATE DEFAULT SYSDATE)
--------------------------------------------------------
--  DDL for Table PG1_EMPLOYEE_EDUCATION
--------------------------------------------------------

  CREATE TABLE "PG1_EMPLOYEE_EDUCATION" ("EDU_ID" NUMBER, "EMP_ID" NUMBER, "DEGREE_TYPE" VARCHAR2(50), "DEGREE_TITLE" VARCHAR2(100), "INSTITUTION_NAME" VARCHAR2(200), "PASSING_YEAR" NUMBER(4,0), "RESULT_TYPE" VARCHAR2(20), "RESULT_VALUE" VARCHAR2(20), "DURATION_YEARS" NUMBER(2,0), "MAJOR_SUBJECT" VARCHAR2(100), "IS_CURRENT" CHAR(1) DEFAULT 'N', "CREATED_DATE" DATE DEFAULT SYSDATE, "CREATED_BY" VARCHAR2(100) DEFAULT USER, "MODIFIED_DATE" DATE, "MODIFIED_BY" VARCHAR2(100))
--------------------------------------------------------
--  DDL for Table PG1_EMPLOYEE_EXPERIENCE
--------------------------------------------------------

  CREATE TABLE "PG1_EMPLOYEE_EXPERIENCE" ("EXP_ID" NUMBER, "EMP_ID" NUMBER, "COMPANY_NAME" VARCHAR2(200), "DESIGNATION" VARCHAR2(100), "DEPARTMENT" VARCHAR2(100), "START_DATE" DATE, "END_DATE" DATE, "IS_CURRENT" CHAR(1) DEFAULT 'N', "JOB_RESPONSIBILITIES" CLOB, "SALARY_RANGE" VARCHAR2(50), "REASON_FOR_LEAVING" VARCHAR2(200), "SUPERVISOR_NAME" VARCHAR2(100), "SUPERVISOR_CONTACT" VARCHAR2(50), "LOCATION" VARCHAR2(100), "EMPLOYMENT_TYPE" VARCHAR2(30), "CREATED_DATE" DATE DEFAULT SYSDATE, "CREATED_BY" VARCHAR2(100) DEFAULT USER, "MODIFIED_DATE" DATE, "MODIFIED_BY" VARCHAR2(100))
--------------------------------------------------------
--  DDL for Table PG1_EMPLOYEE_MASTER
--------------------------------------------------------

  CREATE TABLE "PG1_EMPLOYEE_MASTER" ("EMP_ID" NUMBER, "EMP_CODE" VARCHAR2(20), "FIRST_NAME" VARCHAR2(50), "LAST_NAME" VARCHAR2(50), "FULL_NAME" VARCHAR2(101) GENERATED ALWAYS AS ("FIRST_NAME"||' '||"LAST_NAME") VIRTUAL , "EMAIL" VARCHAR2(100), "PHONE" VARCHAR2(20), "MOBILE" VARCHAR2(20), "NID" VARCHAR2(17), "DATE_OF_BIRTH" DATE, "GENDER" VARCHAR2(20), "BLOOD_GROUP" VARCHAR2(10), "RELIGION" VARCHAR2(50), "DEPARTMENT_ID" NUMBER, "DEPARTMENT_NAME" VARCHAR2(100), "DESIGNATION_ID" NUMBER, "DESIGNATION_NAME" VARCHAR2(100), "JOIN_DATE" DATE DEFAULT SYSDATE, "SALARY" NUMBER(12,2), "ADDRESS_PRESENT" VARCHAR2(500), "ADDRESS_PERMANENT" VARCHAR2(500), "EMERGENCY_CONTACT_NAME" VARCHAR2(100), "EMERGENCY_CONTACT_PHONE" VARCHAR2(20), "MARITAL_STATUS" VARCHAR2(20), "SKILLS" VARCHAR2(4000), "PHOTO" BLOB, "PHOTO_FILENAME" VARCHAR2(255), "PHOTO_MIME_TYPE" VARCHAR2(100), "IS_ACTIVE" CHAR(1) DEFAULT 'Y', "CREATED_DATE" DATE DEFAULT SYSDATE, "CREATED_BY" VARCHAR2(100) DEFAULT USER, "MODIFIED_DATE" DATE, "MODIFIED_BY" VARCHAR2(100))
--------------------------------------------------------
--  DDL for Table PG1_LOOKUP_VALUES
--------------------------------------------------------

  CREATE TABLE "PG1_LOOKUP_VALUES" ("LOOKUP_ID" NUMBER, "LOOKUP_TYPE" VARCHAR2(50), "LOOKUP_CODE" VARCHAR2(20), "LOOKUP_VALUE" VARCHAR2(100), "DISPLAY_ORDER" NUMBER DEFAULT 0, "IS_ACTIVE" CHAR(1) DEFAULT 'Y', "CREATED_DATE" DATE DEFAULT SYSDATE)
--------------------------------------------------------
--  DDL for Table PG_DOCS
--------------------------------------------------------

  CREATE TABLE "PG_DOCS" ("ID" NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , "PG_CODE" VARCHAR2(20), "APP_ID" NUMBER, "PAGE_ID" NUMBER, "HEADING" VARCHAR2(200), "DESCRIPTION" VARCHAR2(500), "LINK" VARCHAR2(500), "CODE_FILE" VARCHAR2(500), "LANGUAGE" VARCHAR2(50), "CLASS_NAME" VARCHAR2(100), "TAGS" "PG_DOC_TAG" )  NESTED TABLE "TAGS" STORE AS "PG_DOCS_TAGS"RETURN AS VALUE

   COMMENT ON COLUMN "PG_DOCS"."TAGS" IS 'Nested table column storing multiple tags for the document. 
Example insert: pg_doc_tag(''JavaScript'', ''REST API'', ''ORDS'', ''curl'')'
--------------------------------------------------------
--  DDL for View PG1_VW_EMPLOYEE_COMPLETE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "PG1_VW_EMPLOYEE_COMPLETE" ("EMP_ID", "EMP_CODE", "FIRST_NAME", "LAST_NAME", "FULL_NAME", "EMAIL", "PHONE", "MOBILE", "NID", "DATE_OF_BIRTH", "GENDER", "BLOOD_GROUP", "RELIGION", "DEPARTMENT_ID", "DEPARTMENT_NAME", "DESIGNATION_ID", "DESIGNATION_NAME", "JOIN_DATE", "SALARY", "ADDRESS_PRESENT", "ADDRESS_PERMANENT", "EMERGENCY_CONTACT_NAME", "EMERGENCY_CONTACT_PHONE", "MARITAL_STATUS", "SKILLS", "PHOTO_FILENAME", "EXPERIENCE_YEARS", "EDUCATION_COUNT", "EXPERIENCE_COUNT", "IS_ACTIVE", "CREATED_DATE", "CREATED_BY", "MODIFIED_DATE", "MODIFIED_BY") AS SELECT 
    e.EMP_ID,
    e.EMP_CODE,
    e.FIRST_NAME,
    e.LAST_NAME,
    e.FULL_NAME,
    e.EMAIL,
    e.PHONE,
    e.MOBILE,
    e.NID,
    e.DATE_OF_BIRTH,
    e.GENDER,
    e.BLOOD_GROUP,
    e.RELIGION,
    e.DEPARTMENT_ID,
    e.DEPARTMENT_NAME,
    e.DESIGNATION_ID,
    e.DESIGNATION_NAME,
    e.JOIN_DATE,
    e.SALARY,
    e.ADDRESS_PRESENT,
    e.ADDRESS_PERMANENT,
    e.EMERGENCY_CONTACT_NAME,
    e.EMERGENCY_CONTACT_PHONE,
    e.MARITAL_STATUS,
    e.SKILLS,
    e.PHOTO_FILENAME,
    -- Calculate experience in years
    ROUND(MONTHS_BETWEEN(SYSDATE, e.JOIN_DATE) / 12, 1) AS EXPERIENCE_YEARS,
    -- Count education records
    (SELECT COUNT(*) FROM PG1_EMPLOYEE_EDUCATION edu WHERE edu.EMP_ID = e.EMP_ID) AS EDUCATION_COUNT,
    -- Count experience records
    (SELECT COUNT(*) FROM PG1_EMPLOYEE_EXPERIENCE exp WHERE exp.EMP_ID = e.EMP_ID) AS EXPERIENCE_COUNT,
    -- System fields
    e.IS_ACTIVE,
    e.CREATED_DATE,
    e.CREATED_BY,
    e.MODIFIED_DATE,
    e.MODIFIED_BY
FROM PG1_EMPLOYEE_MASTER e
WHERE e.IS_ACTIVE = 'Y'
--------------------------------------------------------
--  DDL for View PG1_VW_EMPLOYEE_COMPLETE_WITH_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "PG1_VW_EMPLOYEE_COMPLETE_WITH_DETAILS" ("EMPID", "EMPCODE", "FIRSTNAME", "LASTNAME", "FULLNAME", "EMAIL", "PHONE", "MOBILE", "NID", "DATEOFBIRTH", "GENDER", "BLOODGROUP", "RELIGION", "DEPARTMENTID", "DEPARTMENTNAME", "DESIGNATIONID", "DESIGNATIONNAME", "JOINDATE", "SALARY", "ADDRESSPRESENT", "ADDRESSPERMANENT", "EMERGENCYCONTACTNAME", "EMERGENCYCONTACTPHONE", "MARITALSTATUS", "SKILLS", "PHOTOFILENAME", "EXPERIENCEYEARS", "EDUCATION_COUNT", "EDUCATION", "EXPERIENCE_COUNT", "EXPERIENCE", "ISACTIVE", "CREATEDDATE", "CREATEDBY", "MODIFIEDDATE", "MODIFIEDBY") AS SELECT 
    e.EMP_ID AS empId,
    e.EMP_CODE AS empCode,
    e.FIRST_NAME AS firstName,
    e.LAST_NAME AS lastName,
    e.FULL_NAME AS fullName,
    e.EMAIL AS email,
    e.PHONE AS phone,
    e.MOBILE AS mobile,
    e.NID AS nid,
    e.DATE_OF_BIRTH AS dateOfBirth,
    e.GENDER AS gender,
    e.BLOOD_GROUP AS bloodGroup,
    e.RELIGION AS religion,
    e.DEPARTMENT_ID AS departmentId,
    e.DEPARTMENT_NAME AS departmentName,
    e.DESIGNATION_ID AS designationId,
    e.DESIGNATION_NAME AS designationName,
    e.JOIN_DATE AS joinDate,
    e.SALARY AS salary,
    e.ADDRESS_PRESENT AS addressPresent,
    e.ADDRESS_PERMANENT AS addressPermanent,
    e.EMERGENCY_CONTACT_NAME AS emergencyContactName,
    e.EMERGENCY_CONTACT_PHONE AS emergencyContactPhone,
    e.MARITAL_STATUS AS maritalStatus,
    e.SKILLS AS skills,
    e.PHOTO_FILENAME AS photoFileName,
    ROUND(MONTHS_BETWEEN(SYSDATE, e.JOIN_DATE) / 12, 1) AS experienceYears,
    edu.education_count,
    edu.education,
    exp.experience_count,
    exp.experience,
    e.IS_ACTIVE AS isActive,
    e.CREATED_DATE AS createdDate,
    e.CREATED_BY AS createdBy,
    e.MODIFIED_DATE AS modifiedDate,
    e.MODIFIED_BY AS modifiedBy
FROM PG1_EMPLOYEE_MASTER e

-- JSON EDUCATION using OUTER APPLY
OUTER APPLY (
    SELECT COUNT(*) AS EDUCATION_COUNT,
        JSON_ARRAYAGG(
             JSON_OBJECT(
                 'id' VALUE edu.EDU_ID,
                 'degreeType' VALUE edu.DEGREE_TYPE,
                 'degreeTitle' VALUE edu.DEGREE_TITLE,
                 'institutionName' VALUE edu.INSTITUTION_NAME,
                 'passingYear' VALUE edu.PASSING_YEAR,
                 'resultType' VALUE edu.RESULT_TYPE,
                 'resultValue' VALUE edu.RESULT_VALUE,
                 'duration' VALUE edu.DURATION_YEARS,
                 'majorSubject' VALUE edu.MAJOR_SUBJECT,
                 'isCurrent' VALUE edu.IS_CURRENT
             )
           ) AS education
    FROM PG1_EMPLOYEE_EDUCATION edu
    WHERE edu.EMP_ID = e.EMP_ID
) edu

-- JSON EXPERIENCE using OUTER APPLY
OUTER APPLY (
     SELECT COUNT(*) AS EXPERIENCE_COUNT,
        JSON_ARRAYAGG(
             JSON_OBJECT(
                 'id' VALUE exp.EXP_ID,
                 'companyName' VALUE exp.COMPANY_NAME,
                 'designation' VALUE exp.DESIGNATION,
                 'department' VALUE exp.DEPARTMENT,
                 'employmentType' VALUE exp.EMPLOYMENT_TYPE,
                 'startDate' VALUE exp.START_DATE,
                 'endDate' VALUE exp.END_DATE,
                 'location' VALUE exp.LOCATION,
                 'salaryRange' VALUE exp.SALARY_RANGE,
                 'supervisorName' VALUE exp.SUPERVISOR_NAME,
                 'supervisorContact' VALUE exp.SUPERVISOR_CONTACT,
                 'jobResponsibilities' VALUE exp.JOB_RESPONSIBILITIES,
                 'reasonForLeaving' VALUE exp.REASON_FOR_LEAVING,
                 'isCurrent' VALUE exp.IS_CURRENT
             )
           ) AS experience
    FROM PG1_EMPLOYEE_EXPERIENCE exp
    WHERE exp.EMP_ID = e.EMP_ID
) exp

WHERE e.IS_ACTIVE = 'Y'
--------------------------------------------------------
--  DDL for View PG1_VW_EMPLOYEE_LIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "PG1_VW_EMPLOYEE_LIST" ("EMP_ID", "EMP_CODE", "FULL_NAME", "EMAIL", "PRIMARY_PHONE", "DEPARTMENT_NAME", "DESIGNATION_NAME", "JOIN_DATE_FORMATTED", "PHOTO_AVAILABLE", "IS_ACTIVE") AS SELECT 
    e.EMP_ID,
    e.EMP_CODE,
    e.FULL_NAME,
    e.EMAIL,
    NVL(e.MOBILE, e.PHONE) AS PRIMARY_PHONE,
    e.DEPARTMENT_NAME,
    e.DESIGNATION_NAME,
    TO_CHAR(e.JOIN_DATE, 'DD-MON-YYYY') AS JOIN_DATE_FORMATTED,
    CASE WHEN e.PHOTO IS NOT NULL THEN 'Y' ELSE 'N' END AS PHOTO_AVAILABLE,
    e.IS_ACTIVE
FROM PG1_EMPLOYEE_MASTER e
WHERE e.IS_ACTIVE = 'Y'
ORDER BY e.EMP_CODE
--------------------------------------------------------
--  DDL for Index PG1_IDX_DESIG_SEARCH
--------------------------------------------------------

  CREATE INDEX "PG1_IDX_DESIG_SEARCH" ON "PG1_DESIGNATION_MASTER" (UPPER("DESIG_NAME"), UPPER("DESIG_CODE"))
--------------------------------------------------------
--  DDL for Index PG1_IDX_DEPT_SEARCH
--------------------------------------------------------

  CREATE INDEX "PG1_IDX_DEPT_SEARCH" ON "PG1_DEPARTMENT_MASTER" (UPPER("DEPT_NAME"), UPPER("DEPT_CODE"))
--------------------------------------------------------
--  DDL for Index PG1_IDX_EXP_EMP
--------------------------------------------------------

  CREATE INDEX "PG1_IDX_EXP_EMP" ON "PG1_EMPLOYEE_EXPERIENCE" ("EMP_ID")
--------------------------------------------------------
--  DDL for Index PG1_IDX_EMP_DEPT
--------------------------------------------------------

  CREATE INDEX "PG1_IDX_EMP_DEPT" ON "PG1_EMPLOYEE_MASTER" ("DEPARTMENT_ID")
--------------------------------------------------------
--  DDL for Index PG1_IDX_EMP_SEARCH
--------------------------------------------------------

  CREATE INDEX "PG1_IDX_EMP_SEARCH" ON "PG1_EMPLOYEE_MASTER" (UPPER("FIRST_NAME"), UPPER("LAST_NAME"), "EMP_CODE")
--------------------------------------------------------
--  DDL for Index SYS_FK0000079996N00011$
--------------------------------------------------------

  CREATE INDEX "SYS_FK0000079996N00011$" ON "PG_DOCS_TAGS" ("NESTED_TABLE_ID")
--------------------------------------------------------
--  DDL for Index DBTOOLS$EXECUTION_HISTORY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DBTOOLS$EXECUTION_HISTORY_PK" ON "DBTOOLS$EXECUTION_HISTORY" ("ID")
--------------------------------------------------------
--  DDL for Index PG1_IDX_EDU_EMP
--------------------------------------------------------

  CREATE INDEX "PG1_IDX_EDU_EMP" ON "PG1_EMPLOYEE_EDUCATION" ("EMP_ID")
--------------------------------------------------------
--  DDL for Index PG1_IDX_LOOKUP_TYPE
--------------------------------------------------------

  CREATE INDEX "PG1_IDX_LOOKUP_TYPE" ON "PG1_LOOKUP_VALUES" ("LOOKUP_TYPE", "IS_ACTIVE")
--------------------------------------------------------
--  DDL for Index PG1_UK_LOOKUP_TYPE_CODE
--------------------------------------------------------

  CREATE UNIQUE INDEX "PG1_UK_LOOKUP_TYPE_CODE" ON "PG1_LOOKUP_VALUES" ("LOOKUP_TYPE", "LOOKUP_CODE")
--------------------------------------------------------
--  DDL for Index PG1_IDX_EMP_DESIG
--------------------------------------------------------

  CREATE INDEX "PG1_IDX_EMP_DESIG" ON "PG1_EMPLOYEE_MASTER" ("DESIGNATION_ID")
--------------------------------------------------------
--  DDL for Trigger PG1_TRG_EMPLOYEE_EDUCATION_BI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PG1_TRG_EMPLOYEE_EDUCATION_BI" 
    BEFORE INSERT ON PG1_EMPLOYEE_EDUCATION
    FOR EACH ROW
BEGIN
    IF :NEW.EDU_ID IS NULL THEN
        :NEW.EDU_ID := PG1_SEQ_EMPLOYEE_EDUCATION.NEXTVAL;
    END IF;
END;
ALTER TRIGGER "PG1_TRG_EMPLOYEE_EDUCATION_BI" ENABLE
--------------------------------------------------------
--  DDL for Trigger PG1_TRG_EMPLOYEE_EXPERIENCE_BI
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PG1_TRG_EMPLOYEE_EXPERIENCE_BI" 
    BEFORE INSERT ON PG1_EMPLOYEE_EXPERIENCE
    FOR EACH ROW
BEGIN
    IF :NEW.EXP_ID IS NULL THEN
        :NEW.EXP_ID := PG1_SEQ_EMPLOYEE_EXPERIENCE.NEXTVAL;
    END IF;
END;
ALTER TRIGGER "PG1_TRG_EMPLOYEE_EXPERIENCE_BI" ENABLE
--------------------------------------------------------
--  DDL for Trigger PG1_TRG_EMPLOYEE_MASTER_BIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PG1_TRG_EMPLOYEE_MASTER_BIU" 
    BEFORE INSERT OR UPDATE ON PG1_EMPLOYEE_MASTER
    FOR EACH ROW
DECLARE
    v_max_code NUMBER;
BEGIN
    -- Auto-generate employee code on INSERT
    IF INSERTING AND :NEW.EMP_CODE IS NULL THEN
        SELECT NVL(MAX(TO_NUMBER(REGEXP_SUBSTR(EMP_CODE, '[0-9]+$'))), 0) + 1
        INTO v_max_code
        FROM PG1_EMPLOYEE_MASTER
        WHERE REGEXP_LIKE(EMP_CODE, '^EMP[0-9]+$');

        :NEW.EMP_CODE := 'EMP' || LPAD(v_max_code, 5, '0');
    END IF;

    -- Auto-assign primary key
    IF INSERTING AND :NEW.EMP_ID IS NULL THEN
        :NEW.EMP_ID := PG1_SEQ_EMPLOYEE_MASTER.NEXTVAL;
    END IF;

    -- Sync denormalized department name
    IF :NEW.DEPARTMENT_ID IS NOT NULL AND (:OLD.DEPARTMENT_ID IS NULL OR :OLD.DEPARTMENT_ID != :NEW.DEPARTMENT_ID) THEN
        SELECT DEPT_NAME INTO :NEW.DEPARTMENT_NAME 
        FROM PG1_DEPARTMENT_MASTER 
        WHERE DEPT_ID = :NEW.DEPARTMENT_ID AND IS_ACTIVE = 'Y';
    END IF;

    -- Sync denormalized designation name
    IF :NEW.DESIGNATION_ID IS NOT NULL AND (:OLD.DESIGNATION_ID IS NULL OR :OLD.DESIGNATION_ID != :NEW.DESIGNATION_ID) THEN
        SELECT DESIG_NAME INTO :NEW.DESIGNATION_NAME 
        FROM PG1_DESIGNATION_MASTER 
        WHERE DESIG_ID = :NEW.DESIGNATION_ID AND IS_ACTIVE = 'Y';
    END IF;

    -- Audit trail
    IF UPDATING THEN
        :NEW.MODIFIED_DATE := SYSDATE;
        :NEW.MODIFIED_BY := NVL(V('APP_USER'), USER);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle cases where department or designation is not found
        NULL;
END;
ALTER TRIGGER "PG1_TRG_EMPLOYEE_MASTER_BIU" ENABLE
--------------------------------------------------------
--  DDL for Procedure PG1_API_GET_DEPARTMENT_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PG1_API_GET_DEPARTMENT_LIST" ( 
    p_dept_id    IN NUMBER   DEFAULT NULL,
    p_dept_name  IN VARCHAR2 DEFAULT NULL,
    p_result    OUT CLOB
) AS
    v_errmsg  VARCHAR2(4000);
    v_errcode NUMBER;
BEGIN
    BEGIN
        -- Main query using CTE to build JSON array
        WITH filtered_departments AS (
            SELECT dept.*
            FROM pg1_department_master dept
            WHERE (p_dept_id IS NULL OR dept.dept_id = p_dept_id)
              AND (p_dept_name IS NULL 
                   OR UPPER(dept.dept_name) LIKE UPPER('%' || p_dept_name || '%') 
                   OR UPPER(dept.dept_code) LIKE UPPER('%' || p_dept_name || '%'))
        ),
        department_json_data AS (
            SELECT JSON_ARRAYAGG(
                       JSON_OBJECT(
                           'dept_id'   VALUE dept.dept_id,
                           'dept_name' VALUE dept.dept_name
                       )
                     RETURNING CLOB) AS data_json
            FROM filtered_departments dept
        )
        SELECT CASE 
                 WHEN data_json IS NULL THEN 
                   JSON_OBJECT(
                       'status' VALUE 'error',
                       'statusCode' VALUE 404,
                       'message' VALUE 'No department found'
                   RETURNING CLOB)
                 ELSE 
                   JSON_OBJECT(
                       'status' VALUE 'success',
                       'statusCode' VALUE 200,
                       'data' VALUE data_json
                   RETURNING CLOB)
               END
        INTO p_result
        FROM department_json_data;

    EXCEPTION
        WHEN OTHERS THEN
            v_errmsg  := SQLERRM;
            v_errcode := SQLCODE;
            SELECT JSON_OBJECT(
                       'status' VALUE 'error',
                       'statusCode' VALUE 500,
                       'message' VALUE v_errmsg,
                       'oracleCode' VALUE v_errcode
                   RETURNING CLOB)
            INTO p_result
            FROM dual;
    END;
END;
--------------------------------------------------------
--  DDL for Procedure PG1_API_GET_DESIGNATION_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PG1_API_GET_DESIGNATION_LIST" ( 
    p_desig_id    IN NUMBER   DEFAULT NULL,
    p_desig_name  IN VARCHAR2 DEFAULT NULL,
    p_result    OUT CLOB
) AS
    v_errmsg  VARCHAR2(4000);
    v_errcode NUMBER;
BEGIN
    BEGIN
        -- Main query using CTE to build JSON array
        WITH filtered_designations AS (
            SELECT des.*
            FROM pg1_designation_master des
            WHERE (p_desig_id IS NULL OR des.desig_id = p_desig_id)
              AND (p_desig_name IS NULL 
                   OR UPPER(des.desig_name) LIKE UPPER('%' || p_desig_name || '%')
                   OR UPPER(des.desig_code) LIKE UPPER('%' || p_desig_name || '%'))
        ),
        designation_json_data AS (
            SELECT JSON_ARRAYAGG(
                       JSON_OBJECT(
                           'desig_id'   VALUE des.desig_id,
                           'desig_name' VALUE des.desig_name
                       )
                     RETURNING CLOB) AS data_json
            FROM filtered_designations des
        )
        SELECT CASE 
                 WHEN data_json IS NULL THEN 
                   JSON_OBJECT(
                       'status' VALUE 'error',
                       'statusCode' VALUE 404,
                       'message' VALUE 'No designation found'
                   RETURNING CLOB)
                 ELSE 
                   JSON_OBJECT(
                       'status' VALUE 'success',
                       'statusCode' VALUE 200,
                       'data' VALUE data_json
                   RETURNING CLOB)
               END
        INTO p_result
        FROM designation_json_data;

    EXCEPTION
        WHEN OTHERS THEN
            v_errmsg  := SQLERRM;
            v_errcode := SQLCODE;
            SELECT JSON_OBJECT(
                       'status' VALUE 'error',
                       'statusCode' VALUE 500,
                       'message' VALUE v_errmsg,
                       'oracleCode' VALUE v_errcode
                   RETURNING CLOB)
            INTO p_result
            FROM dual;
    END;
END;
--------------------------------------------------------
--  DDL for Procedure PG1_API_GET_EMPLOYEE_FULL_JSON
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PG1_API_GET_EMPLOYEE_FULL_JSON" ( 
    p_emp_id    IN NUMBER   DEFAULT NULL,
    p_emp_name  IN VARCHAR2 DEFAULT NULL,
    p_result    OUT CLOB
) AS
    v_errmsg   VARCHAR2(4000);
    v_errcode  NUMBER;
BEGIN
    BEGIN
        -- Main query using CTEs to build JSON array
        WITH filtered_employees AS (
            SELECT e.*
            FROM pg1_employee_master e
            WHERE (p_emp_id IS NULL OR e.emp_id = p_emp_id)
              AND (p_emp_name IS NULL 
                   OR UPPER(e.first_name || ' ' || e.last_name) LIKE UPPER('%' || p_emp_name || '%'))
        ),
        employee_education AS (
            SELECT 
                edu.emp_id,
                JSON_ARRAYAGG(
                    JSON_OBJECT(
                        'id' VALUE edu.edu_id,
                        'degreeType' VALUE edu.degree_type,
                        'degreeTitle' VALUE edu.degree_title,
                        'institutionName' VALUE edu.institution_name,
                        'passingYear' VALUE edu.passing_year,
                        'resultType' VALUE edu.result_type,
                        'resultValue' VALUE edu.result_value,
                        'duration' VALUE edu.duration_years,
                        'majorSubject' VALUE edu.major_subject,
                        'isCurrent' VALUE edu.is_current
                    RETURNING CLOB)
                  RETURNING CLOB) AS education_json
            FROM pg1_employee_education edu
            WHERE edu.emp_id IN (SELECT emp_id FROM filtered_employees)
            GROUP BY edu.emp_id
        ),
        employee_experience AS (
            SELECT 
                exp.emp_id,
                JSON_ARRAYAGG(
                    JSON_OBJECT(
                        'id' VALUE exp.exp_id,
                        'companyName' VALUE exp.company_name,
                        'designation' VALUE exp.designation,
                        'department' VALUE exp.department,
                        'employmentType' VALUE exp.employment_type,
                        'startDate' VALUE TO_CHAR(exp.start_date, 'YYYY-MM-DD'),
                        'endDate' VALUE TO_CHAR(exp.end_date, 'YYYY-MM-DD'),
                        'location' VALUE exp.location,
                        'salaryRange' VALUE exp.salary_range,
                        'supervisorName' VALUE exp.supervisor_name,
                        'jobResponsibilities' VALUE exp.job_responsibilities,
                        'reasonForLeaving' VALUE exp.reason_for_leaving,
                        'isCurrent' VALUE exp.is_current
                    RETURNING CLOB)
                  RETURNING CLOB) AS experience_json
            FROM pg1_employee_experience exp
            WHERE exp.emp_id IN (SELECT emp_id FROM filtered_employees)
            GROUP BY exp.emp_id
        ),
        employee_full_data AS (
            SELECT JSON_ARRAYAGG(
                       JSON_OBJECT(
                           'empId' VALUE e.emp_id,
                           'firstName' VALUE e.first_name,
                           'lastName' VALUE e.last_name,
                           'email' VALUE e.email,
                           'phone' VALUE e.phone,
                           'mobile' VALUE e.mobile,
                           'nid' VALUE e.nid,
                           'dateOfBirth' VALUE TO_CHAR(e.date_of_birth, 'YYYY-MM-DD'),
                           'gender' VALUE e.gender,
                           'bloodGroup' VALUE e.blood_group,
                           'religion' VALUE e.religion,
                           'departmentId' VALUE e.department_id,
                           'designationId' VALUE e.designation_id,
                           'joinDate' VALUE TO_CHAR(e.join_date, 'YYYY-MM-DD'),
                           'salary' VALUE e.salary,
                           'addressPresent' VALUE e.address_present,
                           'addressPermanent' VALUE e.address_permanent,
                           'emergencyContactName' VALUE e.emergency_contact_name,
                           'emergencyContactPhone' VALUE e.emergency_contact_phone,
                           'maritalStatus' VALUE e.marital_status,
                           'skills' VALUE e.skills FORMAT JSON,
                           'education' VALUE edu.education_json FORMAT JSON,
                           'experience' VALUE exp.experience_json FORMAT JSON
                       RETURNING CLOB)
                     RETURNING CLOB) AS data_json
            FROM filtered_employees e
            LEFT JOIN employee_education edu ON e.emp_id = edu.emp_id
            LEFT JOIN employee_experience exp ON e.emp_id = exp.emp_id
        )
        SELECT CASE 
                 WHEN data_json IS NULL THEN 
                   JSON_OBJECT(
                       'status' VALUE 'error',
                       'statusCode' VALUE 404,
                       'message' VALUE 'No employee found'
                   RETURNING CLOB)
                 ELSE 
                   JSON_OBJECT(
                       'status' VALUE 'success',
                       'statusCode' VALUE 200,
                       'data' VALUE data_json
                   RETURNING CLOB)
               END
        INTO p_result
        FROM employee_full_data;

    EXCEPTION
        WHEN OTHERS THEN
            v_errmsg  := SQLERRM;
            v_errcode := SQLCODE;
            SELECT JSON_OBJECT(
                       'status' VALUE 'error',
                       'statusCode' VALUE 500,
                       'message' VALUE v_errmsg,
                       'oracleCode' VALUE v_errcode
                   RETURNING CLOB)
            INTO p_result
            FROM dual;
    END;
END;
--------------------------------------------------------
--  DDL for Procedure PG1_PROC_GET_CV_DATA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PG1_PROC_GET_CV_DATA" AS
    v_emp_id NUMBER;
    v_result CLOB;
BEGIN
    v_emp_id := TO_NUMBER(APEX_APPLICATION.G_x01);

    v_result := PG1_PKG_EMPLOYEE_MGMT.PG1_GET_EMPLOYEE_CV_DATA(v_emp_id);

    OWA_UTIL.MIME_HEADER('application/json', FALSE);
    HTP.P(v_result);

EXCEPTION
    WHEN OTHERS THEN
        HTP.P('{"status":"error","message":"' || REPLACE(SQLERRM, '"', '\"') || '"}');
END PG1_PROC_GET_CV_DATA;
--------------------------------------------------------
--  DDL for Procedure PG1_PROC_GET_EMPLOYEE_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PG1_PROC_GET_EMPLOYEE_LIST" AS
    v_search_term VARCHAR2(200);
    v_dept_id NUMBER;
    v_page_size NUMBER;
    v_page_number NUMBER;
    v_result CLOB;
BEGIN
    -- Get parameters from APEX
    v_search_term := APEX_APPLICATION.G_x01;
    v_dept_id := TO_NUMBER(APEX_APPLICATION.G_x02);
    v_page_size := NVL(TO_NUMBER(APEX_APPLICATION.G_x03), 20);
    v_page_number := NVL(TO_NUMBER(APEX_APPLICATION.G_x04), 1);

    -- Get employee list
    v_result := PG1_PKG_EMPLOYEE_MGMT.PG1_GET_EMPLOYEE_LIST(
        p_search_term => v_search_term,
        p_dept_id => v_dept_id,
        p_page_size => v_page_size,
        p_page_number => v_page_number
    );

    -- Set content type and return JSON
    OWA_UTIL.MIME_HEADER('application/json', FALSE);
    HTP.P(v_result);

EXCEPTION
    WHEN OTHERS THEN
        HTP.P('{"status":"error","message":"' || REPLACE(SQLERRM, '"', '\"') || '"}');
END PG1_PROC_GET_EMPLOYEE_LIST;
--------------------------------------------------------
--  DDL for Procedure PG1_PROC_GET_LOOKUP_DATA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PG1_PROC_GET_LOOKUP_DATA" AS
    v_lookup_type VARCHAR2(50);
    v_search_term VARCHAR2(200);
    v_dept_id NUMBER;
    v_result VARCHAR2(4000);
BEGIN
    v_lookup_type := UPPER(APEX_APPLICATION.G_x01);
    v_search_term := APEX_APPLICATION.G_x02;
    v_dept_id := TO_NUMBER(APEX_APPLICATION.G_x03);

    CASE v_lookup_type
        WHEN 'GENDER' THEN
            v_result := PG1_PKG_EMPLOYEE_MGMT.PG1_GET_GENDER_OPTIONS;
        WHEN 'BLOOD_GROUP' THEN
            v_result := PG1_PKG_EMPLOYEE_MGMT.PG1_GET_BLOOD_GROUP_OPTIONS;
        WHEN 'RELIGION' THEN
            v_result := PG1_PKG_EMPLOYEE_MGMT.PG1_GET_RELIGION_OPTIONS;
        WHEN 'DEPARTMENT' THEN
            v_result := PG1_PKG_EMPLOYEE_MGMT.PG1_GET_DEPARTMENT_OPTIONS(v_search_term);
        WHEN 'DESIGNATION' THEN
            v_result := PG1_PKG_EMPLOYEE_MGMT.PG1_GET_DESIGNATION_OPTIONS(v_dept_id, v_search_term);
        ELSE
            v_result := '[]';
    END CASE;

    OWA_UTIL.MIME_HEADER('application/json', FALSE);
    HTP.P(v_result);

EXCEPTION
    WHEN OTHERS THEN
        HTP.P('{"status":"error","message":"' || REPLACE(SQLERRM, '"', '\"') || '"}');
END PG1_PROC_GET_LOOKUP_DATA;
--------------------------------------------------------
--  DDL for Procedure PG1_PROC_SAVE_EMPLOYEE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PG1_PROC_SAVE_EMPLOYEE" (
    p_employee_data IN CLOB DEFAULT NULL
) AS
    v_employee_data CLOB := p_employee_data;
    v_emp_id NUMBER;
    v_result VARCHAR2(4000);
BEGIN
    -- Get JSON data from APEX item or request body
    IF v_employee_data IS NULL THEN
        v_employee_data := APEX_APPLICATION.G_x01; -- Or use apex_application.g_clob_01 for large data
    END IF;

    IF v_employee_data IS NULL THEN
        v_employee_data := apex_application.g_clob_01;
    END IF;

 -- Sample CLOB JSON Data ------------------------------------------------------------------
 /*
 v_employee_data := 
 '
 {
      "emp_id": null,
      "first_name": "John",
      "last_name": "Doe",
      "email": "john.doe@example.com",
      "phone": "0123456789",
      "mobile": "01987654321",
      "nid": "1234567890123",
      "date_of_birth": "1990-05-15",
      "gender": "M",
      "blood_group": "O+",
      "religion": "Islam",
      "department_id": 10,
      "designation_id": 5,
      "join_date": "2023-01-10",
      "salary": 55000,
      "address_present": "123 Street, Dhaka",
      "address_permanent": "Village Home, Cumilla",
      "emergency_contact_name": "Jane Doe",
      "emergency_contact_phone": "01812345678",
      "marital_status": "Married",
      "skills": ["Oracle", "PLSQL", "APEX"],
      "education": [
        {
          "edu_id": null,
          "degree_type": "Bachelor",
          "degree_title": "BSc in CSE",
          "institution_name": "Dhaka University",
          "passing_year": 2012,
          "result_type": "CGPA",
          "result_value": "3.75",
          "duration_years": 4,
          "major_subject": "Computer Science",
          "is_current": "N"
        },
        {
          "edu_id": null,
          "degree_type": "Masters",
          "degree_title": "MSc in Software Engineering",
          "institution_name": "BUET",
          "passing_year": 2015,
          "result_type": "CGPA",
          "result_value": "3.90",
          "duration_years": 2,
          "major_subject": "Software Engineering",
          "is_current": "N"
        }
      ],
      "experience": [
        {
          "exp_id": null,
          "company_name": "ABC Ltd.",
          "designation": "Software Engineer",
          "department": "IT",
          "start_date": "2015-06-01",
          "end_date": "2018-12-31",
          "is_current": "N",
          "job_responsibilities": "Developed enterprise applications",
          "salary_range": "30000-40000",
          "reason_for_leaving": "Better opportunity",
          "supervisor_name": "Mr. Rahman",
          "supervisor_contact": "01711111111",
          "location": "Dhaka",
          "employment_type": "Full-time"
        },
        {
          "exp_id": null,
          "company_name": "XYZ Solutions",
          "designation": "Senior Software Engineer",
          "department": "Development",
          "start_date": "2019-01-01",
          "end_date": null,
          "is_current": "Y",
          "job_responsibilities": "Leading a team of developers",
          "salary_range": "50000-60000",
          "reason_for_leaving": null,
          "supervisor_name": "Ms. Akter",
          "supervisor_contact": "01722222222",
          "location": "Dhaka",
          "employment_type": "Full-time"
        }
      ]
    }
'
 */
--------------------------------------------------------------------------------------------------

    -- Save complete employee data
    v_emp_id := PG1_PKG_EMPLOYEE_MGMT.PG1_SAVE_COMPLETE_EMPLOYEE(v_employee_data);

    -- Return success response
    HTP.P('{"status":"success","statusCode": 200 ,"emp_id":' || v_emp_id || ',"message":"Employee saved successfully"}');

EXCEPTION
    WHEN OTHERS THEN
        HTP.P('{"status":"error","statusCode": 404 ,"message":"' || REPLACE(SQLERRM, '"', '\"') || '"}');
END PG1_PROC_SAVE_EMPLOYEE;
--------------------------------------------------------
--  DDL for Procedure PG1_PROC_VALIDATE_FIELD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PG1_PROC_VALIDATE_FIELD" AS
    v_field_type VARCHAR2(50);
    v_field_value VARCHAR2(200);
    v_emp_id NUMBER;
    v_result VARCHAR2(1000);
BEGIN
    v_field_type := UPPER(APEX_APPLICATION.G_x01);
    v_field_value := APEX_APPLICATION.G_x02;
    v_emp_id := TO_NUMBER(APEX_APPLICATION.G_x03);

    CASE v_field_type
        WHEN 'EMAIL' THEN
            v_result := PG1_PKG_EMPLOYEE_MGMT.PG1_VALIDATE_EMAIL(v_field_value, v_emp_id);
        WHEN 'NID' THEN
            v_result := PG1_PKG_EMPLOYEE_MGMT.PG1_VALIDATE_NID(v_field_value, v_emp_id);
        ELSE
            v_result := 'Invalid field type';
    END CASE;

    IF v_result IS NULL THEN
        HTP.P('{"status":"valid","message":"Field is valid"}');
    ELSE
        HTP.P('{"status":"invalid","message":"' || REPLACE(v_result, '"', '\"') || '"}');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        HTP.P('{"status":"error","message":"' || REPLACE(SQLERRM, '"', '\"') || '"}');
END PG1_PROC_VALIDATE_FIELD;
--------------------------------------------------------
--  DDL for Package PG1_PKG_EMPLOYEE_MGMT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PG1_PKG_EMPLOYEE_MGMT" AS
    
    -- Core CRUD Operations for PG1_EMPLOYEE_MASTER
    FUNCTION PG1_SAVE_EMPLOYEE_MASTER(
        p_emp_id IN NUMBER DEFAULT NULL, -- NULL for INSERT, value for UPDATE
        p_first_name IN VARCHAR2,
        p_last_name IN VARCHAR2,
        p_email IN VARCHAR2,
        p_phone IN VARCHAR2 DEFAULT NULL,
        p_mobile IN VARCHAR2 DEFAULT NULL,
        p_nid IN VARCHAR2,
        p_date_of_birth IN DATE DEFAULT NULL,
        p_gender IN VARCHAR2 DEFAULT NULL,
        p_blood_group IN VARCHAR2 DEFAULT NULL,
        p_religion IN VARCHAR2 DEFAULT NULL,
        p_department_id IN NUMBER DEFAULT NULL,
        p_designation_id IN NUMBER DEFAULT NULL,
        p_join_date IN DATE DEFAULT SYSDATE,
        p_salary IN NUMBER DEFAULT NULL,
        p_address_present IN CLOB DEFAULT NULL,
        p_address_permanent IN CLOB DEFAULT NULL,
        p_emergency_contact_name IN VARCHAR2 DEFAULT NULL,
        p_emergency_contact_phone IN VARCHAR2 DEFAULT NULL,
        p_marital_status IN VARCHAR2 DEFAULT NULL,
        p_skills IN VARCHAR2 DEFAULT NULL, -- JSON format
        p_commit IN VARCHAR2 DEFAULT 'Y'
    ) RETURN NUMBER;

    -- Bulk operations for PG1_EMPLOYEE_EDUCATION (Multiple rows)
    PROCEDURE PG1_SAVE_EMPLOYEE_EDUCATION(
        p_emp_id IN NUMBER,
        p_education_json IN VARCHAR2, -- Array of education records
        p_commit IN VARCHAR2 DEFAULT 'Y'
    );

    -- Bulk operations for PG1_EMPLOYEE_EXPERIENCE (Multiple rows)  
    PROCEDURE PG1_SAVE_EMPLOYEE_EXPERIENCE(
        p_emp_id IN NUMBER,
        p_experience_json IN VARCHAR2, -- Array of experience records
        p_commit IN VARCHAR2 DEFAULT 'Y'
    );

    -- Complete employee save (Master + Education + Experience)
    FUNCTION PG1_SAVE_COMPLETE_EMPLOYEE(p_employee_data IN CLOB) RETURN NUMBER;

    -- Validation Functions
    FUNCTION PG1_VALIDATE_EMAIL(p_email IN VARCHAR2, p_emp_id IN NUMBER DEFAULT NULL) RETURN VARCHAR2;
    FUNCTION PG1_VALIDATE_NID(p_nid IN VARCHAR2, p_emp_id IN NUMBER DEFAULT NULL, p_insert_or_update IN VARCHAR2 DEFAULT 'INSERT') RETURN VARCHAR2;

    -- Data Retrieval for Employee List Page
    FUNCTION PG1_GET_EMPLOYEE_LIST(
        p_search_term IN VARCHAR2 DEFAULT NULL,
        p_dept_id IN NUMBER DEFAULT NULL,
        p_desig_id IN NUMBER DEFAULT NULL,
        p_page_size IN NUMBER DEFAULT 50,
        p_page_number IN NUMBER DEFAULT 1
    ) RETURN CLOB;

    -- Data Retrieval for CV Generation
    FUNCTION PG1_GET_EMPLOYEE_CV_DATA(p_emp_id IN NUMBER) RETURN CLOB;

    -- Complete employee details
    FUNCTION PG1_GET_EMPLOYEE_COMPLETE(p_emp_id IN NUMBER) RETURN CLOB;

    -- Lookup Data Functions (for dynamic dropdowns)
    FUNCTION PG1_GET_GENDER_OPTIONS RETURN VARCHAR2;
    FUNCTION PG1_GET_BLOOD_GROUP_OPTIONS RETURN VARCHAR2;
    FUNCTION PG1_GET_RELIGION_OPTIONS RETURN VARCHAR2;
    FUNCTION PG1_GET_DEPARTMENT_OPTIONS(p_search_term IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;
    FUNCTION PG1_GET_DESIGNATION_OPTIONS(p_dept_id IN NUMBER DEFAULT NULL, p_search_term IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;

    -- Photo Management
    PROCEDURE PG1_SAVE_EMPLOYEE_PHOTO(p_emp_id IN NUMBER, p_photo_blob IN BLOB, p_filename IN VARCHAR2, p_mime_type IN VARCHAR2);
    FUNCTION PG1_GET_EMPLOYEE_PHOTO(p_emp_id IN NUMBER) RETURN BLOB;

    -- Delete Operations
    FUNCTION PG1_DELETE_EMPLOYEE(p_emp_id IN NUMBER, p_response OUT VARCHAR2) RETURN VARCHAR2;

END PG1_PKG_EMPLOYEE_MGMT;
--------------------------------------------------------
--  DDL for Package Body PG1_PKG_EMPLOYEE_MGMT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PG1_PKG_EMPLOYEE_MGMT" AS

    FUNCTION PG1_SAVE_EMPLOYEE_MASTER(
        p_emp_id IN NUMBER DEFAULT NULL,
        p_first_name IN VARCHAR2,
        p_last_name IN VARCHAR2,
        p_email IN VARCHAR2,
        p_phone IN VARCHAR2 DEFAULT NULL,
        p_mobile IN VARCHAR2 DEFAULT NULL,
        p_nid IN VARCHAR2,
        p_date_of_birth IN DATE DEFAULT NULL,
        p_gender IN VARCHAR2 DEFAULT NULL,
        p_blood_group IN VARCHAR2 DEFAULT NULL,
        p_religion IN VARCHAR2 DEFAULT NULL,
        p_department_id IN NUMBER DEFAULT NULL,
        p_designation_id IN NUMBER DEFAULT NULL,
        p_join_date IN DATE DEFAULT SYSDATE,
        p_salary IN NUMBER DEFAULT NULL,
        p_address_present IN CLOB DEFAULT NULL,
        p_address_permanent IN CLOB DEFAULT NULL,
        p_emergency_contact_name IN VARCHAR2 DEFAULT NULL,
        p_emergency_contact_phone IN VARCHAR2 DEFAULT NULL,
        p_marital_status IN VARCHAR2 DEFAULT NULL,
        p_skills IN VARCHAR2 DEFAULT NULL,
        p_commit IN VARCHAR2 DEFAULT 'Y'
    ) RETURN NUMBER IS
        v_emp_id NUMBER := p_emp_id;
        v_error_msg VARCHAR2(1000);
        p_insert_or_update VARCHAR2(20);
    BEGIN
        -- Validate email
        v_error_msg := PG1_VALIDATE_EMAIL(p_email, p_emp_id);
        IF v_error_msg IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20001, v_error_msg);
        END IF;

        -- Validate NID
        IF p_emp_id IS NULL THEN p_insert_or_update := 'INSERT' ;
        ELSIF p_emp_id IS NOT NULL THEN p_insert_or_update := 'UPDATE' ;
        END IF; 
        
        v_error_msg := PG1_VALIDATE_NID(p_nid, p_emp_id, p_insert_or_update);
        IF v_error_msg IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20002, v_error_msg);
        END IF;

        IF p_emp_id IS NULL THEN
            -- INSERT new employee into PG1_EMPLOYEE_MASTER
            INSERT INTO PG1_EMPLOYEE_MASTER (
                FIRST_NAME, LAST_NAME, EMAIL, PHONE, MOBILE, NID,
                DATE_OF_BIRTH, GENDER, BLOOD_GROUP, RELIGION,
                DEPARTMENT_ID, DESIGNATION_ID, JOIN_DATE, SALARY,
                ADDRESS_PRESENT, ADDRESS_PERMANENT,
                EMERGENCY_CONTACT_NAME, EMERGENCY_CONTACT_PHONE,
                MARITAL_STATUS, SKILLS
            ) VALUES (
                TRIM(p_first_name), TRIM(p_last_name), LOWER(TRIM(p_email)), 
                p_phone, p_mobile, p_nid, p_date_of_birth, p_gender, 
                p_blood_group, p_religion, p_department_id, p_designation_id, 
                NVL(p_join_date, SYSDATE), p_salary, p_address_present, 
                p_address_permanent, p_emergency_contact_name, 
                p_emergency_contact_phone, p_marital_status, p_skills
            ) RETURNING EMP_ID INTO v_emp_id;
        ELSE
            -- UPDATE existing employee in PG1_EMPLOYEE_MASTER
            UPDATE PG1_EMPLOYEE_MASTER SET
                FIRST_NAME = TRIM(p_first_name),
                LAST_NAME = TRIM(p_last_name),
                EMAIL = LOWER(TRIM(p_email)),
                PHONE = p_phone,
                MOBILE = p_mobile,
                NID = p_nid,
                DATE_OF_BIRTH = p_date_of_birth,
                GENDER = p_gender,
                BLOOD_GROUP = p_blood_group,
                RELIGION = p_religion,
                DEPARTMENT_ID = p_department_id,
                DESIGNATION_ID = p_designation_id,
                SALARY = p_salary,
                ADDRESS_PRESENT = p_address_present,
                ADDRESS_PERMANENT = p_address_permanent,
                EMERGENCY_CONTACT_NAME = p_emergency_contact_name,
                EMERGENCY_CONTACT_PHONE = p_emergency_contact_phone,
                MARITAL_STATUS = p_marital_status,
                SKILLS = p_skills
            WHERE EMP_ID = p_emp_id;
        END IF;
        IF p_commit = 'Y' THEN
            COMMIT;
        ELSE 
            NULL;
        END IF;
        RETURN v_emp_id;

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            --ROLLBACK;
            IF p_commit = 'Y' THEN
                ROLLBACK;
            ELSE 
                NULL;
            END IF;
            
            IF INSTR(SQLERRM, 'EMAIL') > 0 THEN
                RAISE_APPLICATION_ERROR(-20003, 'Email address already exists');
            ELSIF INSTR(SQLERRM, 'NID') > 0 THEN
                RAISE_APPLICATION_ERROR(-20004, 'NID already exists');
            ELSE
                RAISE_APPLICATION_ERROR(-20005, 'Duplicate value: ' || SQLERRM);
            END IF;
        WHEN OTHERS THEN
            --ROLLBACK;
            IF p_commit = 'Y' THEN
                ROLLBACK;
            ELSE 
                NULL;
            END IF;
            RAISE_APPLICATION_ERROR(-20006, 'Error saving employee: ' || SQLERRM);
    END PG1_SAVE_EMPLOYEE_MASTER;

    PROCEDURE PG1_SAVE_EMPLOYEE_EDUCATION(
        p_emp_id IN NUMBER,
        p_education_json IN VARCHAR2,
        p_commit IN VARCHAR2 DEFAULT 'Y'
    ) IS
        v_count NUMBER := 0;
    BEGIN
        -- Delete old records
        DELETE FROM PG1_EMPLOYEE_EDUCATION WHERE EMP_ID = p_emp_id;

        -- Parse JSON and insert
        FOR rec IN (
            SELECT 
                degree_type,
                degree_title,
                institution_name,
                passing_year,
                result_type,
                result_value,
                duration_years,
                major_subject,
                is_current
            FROM JSON_TABLE(
                p_education_json, '$[*]'
                COLUMNS (
                    degree_type       VARCHAR2(100) PATH '$.degree_type',
                    degree_title      VARCHAR2(200) PATH '$.degree_title',
                    institution_name  VARCHAR2(200) PATH '$.institution_name',
                    passing_year      NUMBER        PATH '$.passing_year',
                    result_type       VARCHAR2(50)  PATH '$.result_type',
                    result_value      VARCHAR2(50)  PATH '$.result_value',
                    duration_years    NUMBER        PATH '$.duration_years',
                    major_subject     VARCHAR2(200) PATH '$.major_subject',
                    is_current        VARCHAR2(1)   PATH '$.is_current' DEFAULT 'N' ON EMPTY
                )
            )
        ) LOOP
            INSERT INTO PG1_EMPLOYEE_EDUCATION (
                EMP_ID, DEGREE_TYPE, DEGREE_TITLE, INSTITUTION_NAME,
                PASSING_YEAR, RESULT_TYPE, RESULT_VALUE, DURATION_YEARS,
                MAJOR_SUBJECT, IS_CURRENT, CREATED_BY
            ) VALUES (
                p_emp_id, rec.degree_type, rec.degree_title, rec.institution_name,
                rec.passing_year, rec.result_type, rec.result_value, rec.duration_years,
                rec.major_subject, NVL(rec.is_current, 'N'), NVL(V('APP_USER'), USER)
            );
            v_count := v_count + 1;
        END LOOP;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            --ROLLBACK;
            IF p_commit = 'Y' THEN
                ROLLBACK;
            ELSE 
                NULL;
            END IF;
            RAISE_APPLICATION_ERROR(-20010, 'Error saving education data: ' || SQLERRM);
    END PG1_SAVE_EMPLOYEE_EDUCATION;

    PROCEDURE PG1_SAVE_EMPLOYEE_EXPERIENCE(
        p_emp_id IN NUMBER,
        p_experience_json IN VARCHAR2,
        p_commit IN VARCHAR2 DEFAULT 'Y'
    ) IS
        v_count NUMBER := 0;
    BEGIN
        -- First delete existing experience records
        DELETE FROM PG1_EMPLOYEE_EXPERIENCE WHERE EMP_ID = p_emp_id;

        -- Parse JSON and insert new records
        FOR rec IN (
            SELECT 
                company_name,
                designation,
                department,
                start_date,
                end_date,
                is_current,
                job_responsibilities,
                salary_range,
                reason_for_leaving,
                supervisor_name,
                supervisor_contact,
                location,
                employment_type
            FROM JSON_TABLE(
                p_experience_json, '$[*]'
                COLUMNS (
                    company_name         VARCHAR2(200) PATH '$.company_name',
                    designation          VARCHAR2(200) PATH '$.designation',
                    department           VARCHAR2(200) PATH '$.department',
                    start_date           DATE          PATH '$.start_date' ERROR ON ERROR,
                    end_date             DATE          PATH '$.end_date'   ERROR ON ERROR,
                    is_current           VARCHAR2(1)   PATH '$.is_current' DEFAULT 'N' ON EMPTY,
                    job_responsibilities VARCHAR2(4000) PATH '$.job_responsibilities',
                    salary_range         VARCHAR2(100) PATH '$.salary_range',
                    reason_for_leaving   VARCHAR2(500) PATH '$.reason_for_leaving',
                    supervisor_name      VARCHAR2(200) PATH '$.supervisor_name',
                    supervisor_contact   VARCHAR2(100) PATH '$.supervisor_contact',
                    location             VARCHAR2(200) PATH '$.location',
                    employment_type      VARCHAR2(100) PATH '$.employment_type'
                )
            )
        ) LOOP
            INSERT INTO PG1_EMPLOYEE_EXPERIENCE (
                EMP_ID, COMPANY_NAME, DESIGNATION, DEPARTMENT,
                START_DATE, END_DATE, IS_CURRENT, JOB_RESPONSIBILITIES,
                SALARY_RANGE, REASON_FOR_LEAVING, SUPERVISOR_NAME,
                SUPERVISOR_CONTACT, LOCATION, EMPLOYMENT_TYPE, CREATED_BY
            ) VALUES (
                p_emp_id, rec.company_name, rec.designation, rec.department,
                rec.start_date, rec.end_date, rec.is_current, rec.job_responsibilities,
                rec.salary_range, rec.reason_for_leaving, rec.supervisor_name,
                rec.supervisor_contact, rec.location, rec.employment_type,
                NVL(V('APP_USER'), USER)
            );
            v_count := v_count + 1;
        END LOOP;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- ROLLBACK;
            IF p_commit = 'Y' THEN
                ROLLBACK;
            ELSE 
                NULL;
            END IF;
            RAISE_APPLICATION_ERROR(-20011, 'Error saving experience data: ' || SQLERRM);
    END PG1_SAVE_EMPLOYEE_EXPERIENCE;


    FUNCTION PG1_SAVE_COMPLETE_EMPLOYEE(p_employee_data IN CLOB) RETURN NUMBER IS
        v_emp_id NUMBER;
        v_education_json VARCHAR2(4000);
        v_experience_json VARCHAR2(4000);
    BEGIN
        -- Extract master data and save to PG1_EMPLOYEE_MASTER
        v_emp_id := PG1_SAVE_EMPLOYEE_MASTER(
            p_emp_id => TO_NUMBER(JSON_VALUE(p_employee_data, '$.emp_id')),
            p_first_name => JSON_VALUE(p_employee_data, '$.first_name'),
            p_last_name => JSON_VALUE(p_employee_data, '$.last_name'),
            p_email => JSON_VALUE(p_employee_data, '$.email'),
            p_phone => JSON_VALUE(p_employee_data, '$.phone'),
            p_mobile => JSON_VALUE(p_employee_data, '$.mobile'),
            p_nid => JSON_VALUE(p_employee_data, '$.nid'),
            p_date_of_birth => TO_DATE(JSON_VALUE(p_employee_data, '$.date_of_birth'), 'YYYY-MM-DD'),
            p_gender => JSON_VALUE(p_employee_data, '$.gender'),
            p_blood_group => JSON_VALUE(p_employee_data, '$.blood_group'),
            p_religion => JSON_VALUE(p_employee_data, '$.religion'),
            p_department_id => TO_NUMBER(JSON_VALUE(p_employee_data, '$.department_id')),
            p_designation_id => TO_NUMBER(JSON_VALUE(p_employee_data, '$.designation_id')),
            p_join_date => TO_DATE(JSON_VALUE(p_employee_data, '$.join_date'), 'YYYY-MM-DD'),
            p_salary => TO_NUMBER(JSON_VALUE(p_employee_data, '$.salary')),
            p_address_present => JSON_VALUE(p_employee_data, '$.address_present'),
            p_address_permanent => JSON_VALUE(p_employee_data, '$.address_permanent'),
            p_emergency_contact_name => JSON_VALUE(p_employee_data, '$.emergency_contact_name'),
            p_emergency_contact_phone => JSON_VALUE(p_employee_data, '$.emergency_contact_phone'),
            p_marital_status => JSON_VALUE(p_employee_data, '$.marital_status'),
            p_skills => JSON_QUERY(p_employee_data, '$.skills' RETURNING VARCHAR2(4000)),
            p_commit => 'N'
        );

        -- Extract and save education data
        v_education_json := JSON_QUERY(p_employee_data, '$.education' RETURNING VARCHAR2(4000));
        IF v_education_json IS NOT NULL AND v_education_json != '[]' THEN
            BEGIN
                PG1_SAVE_EMPLOYEE_EDUCATION(v_emp_id, v_education_json);
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    RAISE_APPLICATION_ERROR(-20021,
                        'Error saving employee education: ' || SQLERRM);
            END;
        END IF;
    
        -- Extract and save experience data
        v_experience_json := JSON_QUERY(p_employee_data, '$.experience' RETURNING VARCHAR2(4000));
        IF v_experience_json IS NOT NULL AND v_experience_json != '[]' THEN
            BEGIN
                PG1_SAVE_EMPLOYEE_EXPERIENCE(v_emp_id, v_experience_json);
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    RAISE_APPLICATION_ERROR(-20022,
                        'Error saving employee experience: ' || SQLERRM);
            END;
        END IF;
    
        RETURN v_emp_id;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20020,
                'Error saving complete employee: ' || SQLERRM);
    END PG1_SAVE_COMPLETE_EMPLOYEE;

    FUNCTION PG1_VALIDATE_EMAIL(
        p_email  IN VARCHAR2,
        p_emp_id IN NUMBER DEFAULT NULL
    ) RETURN VARCHAR2 IS
        v_count NUMBER;
        --v_email VARCHAR2(320); -- RFC 5321 max email length
    BEGIN
        -- Format validation (original)
        
        IF p_email IS NULL 
        OR NOT REGEXP_LIKE(LOWER(TRIM(p_email)), '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$') THEN
            RETURN 'Invalid email format -'|| p_email;
        END IF;
        
/*
        -- Basic checks
        IF p_email IS NULL OR TRIM(p_email) IS NULL THEN
            RETURN 'Email is required';
        END IF;
        
        v_email := LOWER(TRIM(p_email));
        
        -- Length check
        IF LENGTH(v_email) > 320 THEN
            RETURN 'Email address is too long';
        END IF;
        
        -- Improved regex pattern
        IF NOT REGEXP_LIKE(v_email, '^[a-zA-Z0-9][a-zA-Z0-9._+-]*[a-zA-Z0-9]@[a-zA-Z0-9][a-zA-Z0-9.-]*[a-zA-Z0-9]\.[a-zA-Z]{2,}$') 
           AND NOT REGEXP_LIKE(v_email, '^[a-zA-Z0-9]@[a-zA-Z0-9][a-zA-Z0-9.-]*[a-zA-Z0-9]\.[a-zA-Z]{2,}$') THEN
            RETURN 'Invalid email format';
        END IF;
        
        -- Check for invalid patterns
        IF INSTR(v_email, '..') > 0 
           OR INSTR(v_email, '.-') > 0 
           OR INSTR(v_email, '-.') > 0 
           OR INSTR(v_email, '--') > 0 THEN
            RETURN 'Invalid email format - consecutive special characters not allowed';
        END IF;
*/
        -- Uniqueness check
        SELECT COUNT(*) INTO v_count
        FROM PG1_EMPLOYEE_MASTER
        WHERE LOWER(EMAIL) = LOWER(TRIM(p_email))
        AND IS_ACTIVE = 'Y'
        AND (p_emp_id IS NULL OR EMP_ID != p_emp_id);

        IF v_count > 0 THEN
            RETURN 'Email already exists';
        END IF;

        RETURN NULL; -- Valid
    END PG1_VALIDATE_EMAIL;


    FUNCTION PG1_VALIDATE_NID(
        p_nid    IN VARCHAR2,
        p_emp_id IN NUMBER DEFAULT NULL,
        p_insert_or_update IN VARCHAR2 DEFAULT 'INSERT'
    ) RETURN VARCHAR2 IS
        v_count NUMBER;
    BEGIN
        -- Format validation (10, 13, or 17 digits)
        IF p_nid IS NULL 
        OR NOT REGEXP_LIKE(p_nid, '^[0-9]{10}$|^[0-9]{13}$|^[0-9]{17}$') THEN
            RETURN 'NID must be exactly 10, 13, or 17 digits';
        END IF;

        -- Uniqueness check in PG1_EMPLOYEE_MASTER
        SELECT COUNT(*) INTO v_count
        FROM PG1_EMPLOYEE_MASTER
        WHERE NID = p_nid
        AND IS_ACTIVE = 'Y'
        AND (p_emp_id IS NULL OR EMP_ID != p_emp_id);
        
        IF p_insert_or_update = 'UPDATE' THEN
            IF v_count > 0 THEN
                RETURN 'NID already exists';
            END IF;
        ELSIF p_insert_or_update = 'INSERT' THEN
            NULL; -- Do no check
        END IF;

        RETURN NULL; -- Valid
    END PG1_VALIDATE_NID;

    FUNCTION PG1_GET_EMPLOYEE_LIST(
        p_search_term IN VARCHAR2 DEFAULT NULL,
        p_dept_id IN NUMBER DEFAULT NULL,
        p_desig_id IN NUMBER DEFAULT NULL,
        p_page_size IN NUMBER DEFAULT 50,
        p_page_number IN NUMBER DEFAULT 1
    ) RETURN CLOB IS
        v_result CLOB;
        v_offset NUMBER := (p_page_number - 1) * p_page_size;
        v_total_count NUMBER;
    BEGIN
        -- Get total count for pagination
        SELECT COUNT(*)
        INTO v_total_count
        FROM PG1_EMPLOYEE_MASTER e
        WHERE e.IS_ACTIVE = 'Y'
        AND (p_search_term IS NULL OR 
             UPPER(e.FULL_NAME) LIKE UPPER('%' || p_search_term || '%') OR
             UPPER(e.EMP_CODE) LIKE UPPER('%' || p_search_term || '%') OR
             UPPER(e.EMAIL) LIKE UPPER('%' || p_search_term || '%'))
        AND (p_dept_id IS NULL OR e.DEPARTMENT_ID = p_dept_id)
        AND (p_desig_id IS NULL OR e.DESIGNATION_ID = p_desig_id);

        -- Build JSON result with employee list
        SELECT JSON_OBJECT(
            'total_records' VALUE v_total_count,
            'page_number' VALUE p_page_number,
            'page_size' VALUE p_page_size,
            'total_pages' VALUE CEIL(v_total_count / p_page_size),
            'employees' VALUE JSON_ARRAYAGG(
                JSON_OBJECT(
                    'emp_id' VALUE emp_id,
                    'emp_code' VALUE emp_code,
                    'full_name' VALUE full_name,
                    'email' VALUE email,
                    'phone' VALUE NVL(mobile, phone),
                    'department_name' VALUE department_name,
                    'designation_name' VALUE designation_name,
                    'join_date' VALUE TO_CHAR(join_date, 'DD-MON-YYYY'),
                    'photo_available' VALUE CASE WHEN photo IS NOT NULL THEN 'Y' ELSE 'N' END
                ) RETURNING CLOB
            ) RETURNING CLOB
        )
        INTO v_result
        FROM (
            SELECT e.*
            FROM PG1_EMPLOYEE_MASTER e
            WHERE e.IS_ACTIVE = 'Y'
            AND (p_search_term IS NULL OR 
                 UPPER(e.FULL_NAME) LIKE UPPER('%' || p_search_term || '%') OR
                 UPPER(e.EMP_CODE) LIKE UPPER('%' || p_search_term || '%') OR
                 UPPER(e.EMAIL) LIKE UPPER('%' || p_search_term || '%'))
            AND (p_dept_id IS NULL OR e.DEPARTMENT_ID = p_dept_id)
            AND (p_desig_id IS NULL OR e.DESIGNATION_ID = p_desig_id)
            ORDER BY e.EMP_CODE
            OFFSET v_offset ROWS FETCH NEXT p_page_size ROWS ONLY
        );

        RETURN NVL(v_result, '{"total_records":0,"employees":[]}');

    EXCEPTION
        WHEN OTHERS THEN
            RETURN '{"error":"' || SQLERRM || '"}';
    END PG1_GET_EMPLOYEE_LIST;

    FUNCTION PG1_GET_EMPLOYEE_CV_DATA(p_emp_id IN NUMBER) RETURN CLOB IS
        v_result CLOB;
    BEGIN
        -- Build complete CV data from all three tables
        SELECT JSON_OBJECT(
            'employee' VALUE JSON_OBJECT(
                'emp_id' VALUE e.emp_id,
                'emp_code' VALUE e.emp_code,
                'full_name' VALUE e.full_name,
                'first_name' VALUE e.first_name,
                'last_name' VALUE e.last_name,
                'email' VALUE e.email,
                'phone' VALUE e.phone,
                'mobile' VALUE e.mobile,
                'date_of_birth' VALUE TO_CHAR(e.date_of_birth, 'DD-MON-YYYY'),
                'gender' VALUE e.gender,
                'blood_group' VALUE e.blood_group,
                'religion' VALUE e.religion,
                'department_name' VALUE e.department_name,
                'designation_name' VALUE e.designation_name,
                'join_date' VALUE TO_CHAR(e.join_date, 'DD-MON-YYYY'),
                'address_present' VALUE e.address_present,
                'address_permanent' VALUE e.address_permanent,
                'emergency_contact_name' VALUE e.emergency_contact_name,
                'emergency_contact_phone' VALUE e.emergency_contact_phone,
                'marital_status' VALUE e.marital_status,
                'skills' VALUE e.skills
            ),
            'education' VALUE (
                SELECT JSON_ARRAYAGG(
                    JSON_OBJECT(
                        'degree_type' VALUE edu.degree_type,
                        'degree_title' VALUE edu.degree_title,
                        'institution_name' VALUE edu.institution_name,
                        'passing_year' VALUE edu.passing_year,
                        'result_type' VALUE edu.result_type,
                        'result_value' VALUE edu.result_value,
                        'duration_years' VALUE edu.duration_years,
                        'major_subject' VALUE edu.major_subject
                    ) RETURNING CLOB
                )
                FROM PG1_EMPLOYEE_EDUCATION edu
                WHERE edu.EMP_ID = p_emp_id
                -- ORDER BY edu.passing_year DESC
            ),
            'experience' VALUE (
                SELECT JSON_ARRAYAGG(
                    JSON_OBJECT(
                        'company_name' VALUE exp.company_name,
                        'designation' VALUE exp.designation,
                        'department' VALUE exp.department,
                        'start_date' VALUE TO_CHAR(exp.start_date, 'MON YYYY'),
                        'end_date' VALUE CASE WHEN exp.end_date IS NOT NULL THEN TO_CHAR(exp.end_date, 'MON YYYY') ELSE 'Present' END,
                        'duration' VALUE CASE 
                            WHEN exp.end_date IS NOT NULL THEN 
                                ROUND(MONTHS_BETWEEN(exp.end_date, exp.start_date) / 12, 1) || ' years'
                            ELSE 
                                ROUND(MONTHS_BETWEEN(SYSDATE, exp.start_date) / 12, 1) || ' years'
                        END,
                        'job_responsibilities' VALUE exp.job_responsibilities,
                        'salary_range' VALUE exp.salary_range,
                        'location' VALUE exp.location,
                        'employment_type' VALUE exp.employment_type
                    ) RETURNING CLOB
                )
                FROM PG1_EMPLOYEE_EXPERIENCE exp
                WHERE exp.EMP_ID = p_emp_id
                -- ORDER BY exp.start_date DESC
            ) RETURNING CLOB
        )
        INTO v_result
        FROM PG1_EMPLOYEE_MASTER e
        WHERE e.EMP_ID = p_emp_id AND e.IS_ACTIVE = 'Y';

        RETURN v_result;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN '{"error":"Employee not found"}';
        WHEN OTHERS THEN
            RETURN '{"error":"' || SQLERRM || '"}';
    END PG1_GET_EMPLOYEE_CV_DATA;

    -- Lookup functions for dynamic dropdowns
    FUNCTION PG1_GET_GENDER_OPTIONS RETURN VARCHAR2 IS
        v_result VARCHAR2(4000);
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'code' VALUE lookup_code,
                'value' VALUE lookup_value
            ) RETURNING VARCHAR2(4000)
        )
        INTO v_result
        FROM PG1_LOOKUP_VALUES
        WHERE LOOKUP_TYPE = 'GENDER' AND IS_ACTIVE = 'Y'
        ORDER BY DISPLAY_ORDER;

        RETURN NVL(v_result, '[]');
    END PG1_GET_GENDER_OPTIONS;

    FUNCTION PG1_GET_BLOOD_GROUP_OPTIONS RETURN VARCHAR2 IS
        v_result VARCHAR2(4000);
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'code' VALUE lookup_code,
                'value' VALUE lookup_value
            ) RETURNING VARCHAR2(4000)
        )
        INTO v_result
        FROM PG1_LOOKUP_VALUES
        WHERE LOOKUP_TYPE = 'BLOOD_GROUP' AND IS_ACTIVE = 'Y'
        ORDER BY DISPLAY_ORDER;

        RETURN NVL(v_result, '[]');
    END PG1_GET_BLOOD_GROUP_OPTIONS;

    FUNCTION PG1_GET_RELIGION_OPTIONS RETURN VARCHAR2 IS
        v_result VARCHAR2(4000);
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'code' VALUE lookup_code,
                'value' VALUE lookup_value
            ) RETURNING VARCHAR2(4000)
        )
        INTO v_result
        FROM PG1_LOOKUP_VALUES
        WHERE LOOKUP_TYPE = 'RELIGION' AND IS_ACTIVE = 'Y'
        ORDER BY DISPLAY_ORDER;

        RETURN NVL(v_result, '[]');
    END PG1_GET_RELIGION_OPTIONS;

    FUNCTION PG1_GET_DEPARTMENT_OPTIONS(p_search_term IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2 IS
        v_result VARCHAR2(4000);
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id' VALUE dept_id,
                'code' VALUE dept_code,
                'name' VALUE dept_name,
                'display_text' VALUE dept_code || ' - ' || dept_name
            ) RETURNING VARCHAR2(4000)
        )
        INTO v_result
        FROM PG1_DEPARTMENT_MASTER
        WHERE IS_ACTIVE = 'Y'
        AND (p_search_term IS NULL OR 
             UPPER(dept_name) LIKE UPPER('%' || p_search_term || '%') OR
             UPPER(dept_code) LIKE UPPER('%' || p_search_term || '%'))
        ORDER BY dept_name;

        RETURN NVL(v_result, '[]');
    END PG1_GET_DEPARTMENT_OPTIONS;

    FUNCTION PG1_GET_DESIGNATION_OPTIONS(p_dept_id IN NUMBER DEFAULT NULL, p_search_term IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2 IS
        v_result VARCHAR2(4000);
    BEGIN
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'id' VALUE d.desig_id,
                'code' VALUE d.desig_code,
                'name' VALUE d.desig_name,
                'display_text' VALUE d.desig_code || ' - ' || d.desig_name,
                'dept_id' VALUE d.dept_id
            ) RETURNING VARCHAR2(4000)
        )
        INTO v_result
        FROM PG1_DESIGNATION_MASTER d
        WHERE d.IS_ACTIVE = 'Y'
        AND (p_dept_id IS NULL OR d.dept_id = p_dept_id)
        AND (p_search_term IS NULL OR 
             UPPER(d.desig_name) LIKE UPPER('%' || p_search_term || '%') OR
             UPPER(d.desig_code) LIKE UPPER('%' || p_search_term || '%'))
        ORDER BY d.desig_name;

        RETURN NVL(v_result, '[]');
    END PG1_GET_DESIGNATION_OPTIONS;

    PROCEDURE PG1_SAVE_EMPLOYEE_PHOTO(p_emp_id IN NUMBER, p_photo_blob IN BLOB, p_filename IN VARCHAR2, p_mime_type IN VARCHAR2) IS
    BEGIN
        UPDATE PG1_EMPLOYEE_MASTER
        SET PHOTO = p_photo_blob,
            PHOTO_FILENAME = p_filename,
            PHOTO_MIME_TYPE = p_mime_type
        WHERE EMP_ID = p_emp_id;

        COMMIT;
    END PG1_SAVE_EMPLOYEE_PHOTO;

    FUNCTION PG1_GET_EMPLOYEE_PHOTO(p_emp_id IN NUMBER) RETURN BLOB IS
        v_photo BLOB;
    BEGIN
        SELECT PHOTO INTO v_photo
        FROM PG1_EMPLOYEE_MASTER
        WHERE EMP_ID = p_emp_id AND IS_ACTIVE = 'Y';

        RETURN v_photo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END PG1_GET_EMPLOYEE_PHOTO;



    FUNCTION PG1_DELETE_EMPLOYEE(p_emp_id IN NUMBER, p_response OUT VARCHAR2) RETURN VARCHAR2 IS
        v_count NUMBER;
    BEGIN
        -- Check if employee exists
        SELECT COUNT(*) INTO v_count
        FROM PG1_EMPLOYEE_MASTER
        WHERE EMP_ID = p_emp_id AND IS_ACTIVE = 'Y';

        IF v_count = 0 THEN
            -- RETURN 'Employee not found or already inactive';
            RETURN '{"status":"error","statusCode": 404 ,"emp_id":' || p_emp_id || ',"message":"Employee not found or already inactive"}';
        END IF;

        -- Soft delete (set IS_ACTIVE = 'N')
        UPDATE PG1_EMPLOYEE_MASTER
        SET IS_ACTIVE = 'N'
        WHERE EMP_ID = p_emp_id;

        COMMIT;
        -- RETURN 'SUCCESS';
        RETURN '{"status":"success","statusCode": 200 ,"emp_id":' || p_emp_id || ',"message":"Employee Deleted successfully"}';
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            -- RETURN 'Error deleting employee: ' || SQLERRM;
            RETURN '{"status":"error","statusCode": 404 ,"emp_id":' || p_emp_id || ',"message":" Error deleting employee : ' || SQLERRM || '"}';
    END PG1_DELETE_EMPLOYEE;



    FUNCTION PG1_GET_EMPLOYEE_COMPLETE(p_emp_id IN NUMBER) RETURN CLOB IS
        v_result CLOB;
    BEGIN
        -- Get complete employee data from all three tables
        SELECT JSON_OBJECT(
            'master' VALUE JSON_OBJECT(
                'emp_id' VALUE e.emp_id,
                'emp_code' VALUE e.emp_code,
                'first_name' VALUE e.first_name,
                'last_name' VALUE e.last_name,
                'email' VALUE e.email,
                'phone' VALUE e.phone,
                'mobile' VALUE e.mobile,
                'nid' VALUE e.nid,
                'date_of_birth' VALUE TO_CHAR(e.date_of_birth, 'YYYY-MM-DD'),
                'gender' VALUE e.gender,
                'blood_group' VALUE e.blood_group,
                'religion' VALUE e.religion,
                'department_id' VALUE e.department_id,
                'department_name' VALUE e.department_name,
                'designation_id' VALUE e.designation_id,
                'designation_name' VALUE e.designation_name,
                'join_date' VALUE TO_CHAR(e.join_date, 'YYYY-MM-DD'),
                'salary' VALUE e.salary,
                'address_present' VALUE e.address_present,
                'address_permanent' VALUE e.address_permanent,
                'emergency_contact_name' VALUE e.emergency_contact_name,
                'emergency_contact_phone' VALUE e.emergency_contact_phone,
                'marital_status' VALUE e.marital_status,
                'skills' VALUE e.skills,
                'photo_filename' VALUE e.photo_filename
            ),
            'education' VALUE (
                SELECT JSON_ARRAYAGG(
                    JSON_OBJECT(
                        'edu_id' VALUE edu.edu_id,
                        'degree_type' VALUE edu.degree_type,
                        'degree_title' VALUE edu.degree_title,
                        'institution_name' VALUE edu.institution_name,
                        'passing_year' VALUE edu.passing_year,
                        'result_type' VALUE edu.result_type,
                        'result_value' VALUE edu.result_value,
                        'duration_years' VALUE edu.duration_years,
                        'major_subject' VALUE edu.major_subject,
                        'is_current' VALUE edu.is_current
                    ) RETURNING CLOB
                )
                FROM PG1_EMPLOYEE_EDUCATION edu
                WHERE edu.EMP_ID = p_emp_id
                -- ORDER BY edu.passing_year DESC
            ),
            'experience' VALUE (
                SELECT JSON_ARRAYAGG(
                    JSON_OBJECT(
                        'exp_id' VALUE exp.exp_id,
                        'company_name' VALUE exp.company_name,
                        'designation' VALUE exp.designation,
                        'department' VALUE exp.department,
                        'start_date' VALUE TO_CHAR(exp.start_date, 'YYYY-MM-DD'),
                        'end_date' VALUE TO_CHAR(exp.end_date, 'YYYY-MM-DD'),
                        'is_current' VALUE exp.is_current,
                        'job_responsibilities' VALUE exp.job_responsibilities,
                        'salary_range' VALUE exp.salary_range,
                        'reason_for_leaving' VALUE exp.reason_for_leaving,
                        'supervisor_name' VALUE exp.supervisor_name,
                        'supervisor_contact' VALUE exp.supervisor_contact,
                        'location' VALUE exp.location,
                        'employment_type' VALUE exp.employment_type
                    ) RETURNING CLOB
                )
                FROM PG1_EMPLOYEE_EXPERIENCE exp
                WHERE exp.EMP_ID = p_emp_id
                -- ORDER BY exp.start_date DESC
            ) RETURNING CLOB
        )
        INTO v_result
        FROM PG1_EMPLOYEE_MASTER e
        WHERE e.EMP_ID = p_emp_id AND e.IS_ACTIVE = 'Y';

        RETURN v_result;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN '{"error":"Employee not found"}';
        WHEN OTHERS THEN
            RETURN '{"error":"' || SQLERRM || '"}';
    END PG1_GET_EMPLOYEE_COMPLETE;



END PG1_PKG_EMPLOYEE_MGMT;
--------------------------------------------------------
--  DDL for Function PG1_GET_EMPLOYEE_CV_HTML
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PG1_GET_EMPLOYEE_CV_HTML" (p_emp_id NUMBER)
RETURN CLOB
IS
    l_html CLOB;
    l_emp_rec PG1_EMPLOYEE_MASTER%ROWTYPE;
    l_skills_html VARCHAR2(4000) := '';
    l_education_html VARCHAR2(4000) := '';
    l_experience_html VARCHAR2(4000) := '';

BEGIN
    -- Get employee master data
    SELECT * INTO l_emp_rec
    FROM PG1_EMPLOYEE_MASTER
    WHERE EMP_ID = p_emp_id AND IS_ACTIVE = 'Y';

    -- Build skills HTML (parsing JSON format)
    IF l_emp_rec.SKILLS IS NOT NULL THEN
        FOR skill IN (
            SELECT JSON_VALUE(value, '$.name') AS skill_name,
                   JSON_VALUE(value, '$.level') AS skill_level
            FROM JSON_TABLE(l_emp_rec.SKILLS, '$[*]' 
                COLUMNS (value VARCHAR2(4000) FORMAT JSON PATH '$'))
        ) LOOP
            l_skills_html := l_skills_html || '<span class="skill-tag">' || 
                           skill.skill_name || ' (' || skill.skill_level || ')</span>';
        END LOOP;
    END IF;

    -- Build education HTML
    FOR edu_rec IN (
        SELECT DEGREE_TYPE, DEGREE_TITLE, INSTITUTION_NAME, PASSING_YEAR, 
               RESULT_TYPE, RESULT_VALUE
        FROM PG1_EMPLOYEE_EDUCATION
        WHERE EMP_ID = p_emp_id
        ORDER BY PASSING_YEAR DESC
    ) LOOP
        l_education_html := l_education_html || 
            '<div class="education-item">' ||
            '<div><strong>' || edu_rec.DEGREE_TITLE || '</strong> - ' || edu_rec.INSTITUTION_NAME || '</div>' ||
            '<div class="date">' || edu_rec.PASSING_YEAR || 
            CASE WHEN edu_rec.RESULT_TYPE IS NOT NULL THEN ' | ' || edu_rec.RESULT_TYPE || ' ' || NVL(edu_rec.RESULT_VALUE, '') END ||
            '</div></div>';
    END LOOP;

    -- Build experience HTML
    FOR exp_rec IN (
        SELECT COMPANY_NAME, DESIGNATION, EMPLOYMENT_TYPE,
               TO_CHAR(START_DATE, 'Mon YYYY') AS START_DATE_STR,
               CASE WHEN END_DATE IS NULL AND IS_CURRENT = 'Y' THEN 'Present' 
                    ELSE TO_CHAR(END_DATE, 'Mon YYYY') END AS END_DATE_STR,
               REPLACE(REPLACE(NVL(JOB_RESPONSIBILITIES, ''), CHR(10), '<br>'), CHR(13), '') AS JOB_RESPONSIBILITIES
        FROM PG1_EMPLOYEE_EXPERIENCE
        WHERE EMP_ID = p_emp_id
        ORDER BY START_DATE DESC
    ) LOOP
        l_experience_html := l_experience_html ||
            '<div class="experience">' ||
            '<div class="job-title">' || exp_rec.DESIGNATION || '</div>' ||
            '<div class="company">' || exp_rec.COMPANY_NAME || 
            CASE WHEN exp_rec.EMPLOYMENT_TYPE IS NOT NULL THEN ' (' || exp_rec.EMPLOYMENT_TYPE || ')' END ||
            '</div>' ||
            '<div class="date">' || exp_rec.START_DATE_STR || ' - ' || exp_rec.END_DATE_STR || '</div>' ||
            '<div class="job-description">' || exp_rec.JOB_RESPONSIBILITIES || '</div>' ||
            '</div>';
    END LOOP;

    -- Build complete HTML
    l_html := '

<head>
  <title>Dynamic CV</title>
  <style>
    :root {
      --primary-color: #FFD700 !important;
      --secondary-color: #222 !important;
      --light-gray: #f5f5f5 !important;
      --border-color: #ddd !important;
      --header-bg: linear-gradient(135deg, #fff 0%, var(--primary-color) 100%) !important;
    }
    @media print {
      .pdf-download-btn { 
        display: none !important; 
      }
      @page { 
        size: A4; 
        margin: 0mm !important; 
      }
      body { 
        margin: 0 !important; 
        padding: 0 !important; 
        background: white !important;
        width: 190mm !important;
        height: auto !important;
      }
      .cv-container {
        box-shadow: none !important;
        max-width: none !important;
        width: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
      }
      * {
        -webkit-print-color-adjust: exact !important;
        color-adjust: exact !important;
      }
    }
    body {
      font-family: ''Segoe UI'', sans-serif;
      font-size: 13px;
      color: var(--secondary-color);
      background: var(--light-gray);
      margin: 0;
      padding: 20px;
    }
    .cv-container {
      background: #fff;
      box-shadow: 0 0 5px rgba(0,0,0,0.1);

      margin: auto;
    }
    .header {
      background: var(--header-bg);
      color: var(--secondary-color);
      padding: 20px;
      display: flex;
      align-items: center;
      gap: 20px;
    }
    .profile-image {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      border: 3px solid var(--secondary-color);
      overflow: hidden;
      flex-shrink: 0;
    }
    .profile-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .header-text {
      flex: 1;
    }
    .header-text h1 { margin: 0; font-size: 22px; font-weight: bold; }
    .header-text p { margin: 5px 0; font-size: 14px; }
    .main-content {
      display: flex;
      padding: 20px;
      gap: 15px;
    }
    .left-column {
      width: 35%;
      background: var(--light-gray);
      padding: 15px;
      border-radius: 5px;
    }
    .right-column {
      width: 65%;
      padding: 0 10px;
    }
    .section { margin-bottom: 15px; }
    .section h3 {
      font-size: 14px;
      color: var(--secondary-color);
      border-bottom: 2px solid var(--primary-color);
      padding-bottom: 4px;
      margin-bottom: 8px;
      text-transform: uppercase;
    }
    .skill-tag {
      display: inline-block;
      background: var(--primary-color);
      color: var(--secondary-color);
      padding: 3px 8px;
      border-radius: 12px;
      font-size: 12px;
      margin: 2px;
    }
    .experience, .education-item {
      margin-bottom: 10px;
    }
    .job-title { font-weight: bold; font-size: 13px; }
    .company { font-style: italic; font-size: 12px; }
    .date { font-size: 12px; color: gray; }
    .job-description {
      font-size: 12px;
      margin-top: 5px;
      line-height: 1.4;
    }

    .pdf-download-btn {
      position: fixed;
      bottom: 20px;
      right: 20px;
      background: var(--primary-color);
      color: var(--secondary-color);
      border: none;
      border-radius: 50px;
      padding: 15px 20px;
      font-size: 14px;
      font-weight: bold;
      cursor: pointer;
      box-shadow: 0 4px 12px rgba(255, 215, 0, 0.4);
      transition: all 0.3s ease;
      z-index: 1000;
    }

    .pdf-download-btn:hover {
      background: #FFE55C;
      transform: translateY(-2px);
      box-shadow: 0 6px 16px rgba(255, 215, 0, 0.6);
    }
  </style>
</head>
<body>
  <div class="cv-container">
    <div class="header">
      <div class="profile-image">
        <img src="https://via.placeholder.com/100" alt="Profile Photo">
      </div>
      <div class="header-text">
        <h1>' || l_emp_rec.FULL_NAME || '</h1>
        <p>' || NVL(l_emp_rec.DESIGNATION_NAME, 'Employee') || ' | ' || NVL(l_emp_rec.DEPARTMENT_NAME, 'Department') || '</p>
        <p>' || l_emp_rec.EMAIL || ' | ' || NVL(l_emp_rec.MOBILE, l_emp_rec.PHONE) || '</p>
      </div>
    </div>

    <div class="main-content">
      <div class="left-column">
        <div class="section">
          <h3>Personal</h3>
          <p><strong>DOB:</strong> ' || TO_CHAR(l_emp_rec.DATE_OF_BIRTH, 'DD-MON-YYYY') || '</p>
          <p><strong>Gender:</strong> ' || NVL(l_emp_rec.GENDER, 'N/A') || '</p>
          <p><strong>Blood:</strong> ' || NVL(l_emp_rec.BLOOD_GROUP, 'N/A') || '</p>
          <p><strong>Religion:</strong> ' || NVL(l_emp_rec.RELIGION, 'N/A') || '</p>
          <p><strong>Marital:</strong> ' || NVL(l_emp_rec.MARITAL_STATUS, 'N/A') || '</p>
          <p><strong>NID:</strong> ' || l_emp_rec.NID || '</p>
          <p><strong>Address:</strong> ' || NVL(l_emp_rec.ADDRESS_PRESENT, 'N/A') || '</p>
        </div>

        <div class="section">
          <h3>Skills</h3>
          ' || l_skills_html || '
        </div>

        <div class="section">
          <h3>Education</h3>
          ' || l_education_html || '
        </div>
      </div>

      <div class="right-column">
        <div class="section">
          <h3>Experience</h3>
          ' || l_experience_html || '
        </div>
      </div>
    </div>
  </div>

  <button class="pdf-download-btn" onclick="downloadPDF()">
    Download PDF
  </button>

  <script>
    function downloadPDF() {
      const btn = document.querySelector(''.pdf-download-btn'');
      const originalText = btn.innerHTML;
      btn.innerHTML = ''Generating...'';
      btn.disabled = true;

      setTimeout(() => {
        window.print();
        setTimeout(() => {
          btn.innerHTML = originalText;
          btn.disabled = false;
        }, 1000);
      }, 100);
    }
  </script>
</body>
</html>';

    RETURN l_html;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '<h3>Employee not found</h3>';
    WHEN OTHERS THEN
        RETURN '<h3>Error loading CV: ' || SQLERRM || '</h3>';
END pg1_get_employee_cv_html;
--------------------------------------------------------
--  DDL for Function PG1_GET_EMPLOYEE_CV_HTML2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "PG1_GET_EMPLOYEE_CV_HTML2" (p_emp_id NUMBER)
RETURN CLOB
IS
    l_html CLOB;
    l_emp_rec PG1_EMPLOYEE_MASTER%ROWTYPE;
    l_skills_html VARCHAR2(4000) := '';
    l_education_html VARCHAR2(4000) := '';
    l_experience_html VARCHAR2(4000) := '';

BEGIN
    -- Get employee master data
    SELECT * INTO l_emp_rec
    FROM PG1_EMPLOYEE_MASTER
    WHERE EMP_ID = p_emp_id AND IS_ACTIVE = 'Y';

    -- Build skills HTML (parsing JSON format)
    IF l_emp_rec.SKILLS IS NOT NULL THEN
        FOR skill IN (
            SELECT JSON_VALUE(value, '$.name') AS skill_name,
                   JSON_VALUE(value, '$.level') AS skill_level
            FROM JSON_TABLE(l_emp_rec.SKILLS, '$[*]' 
                COLUMNS (value VARCHAR2(4000) FORMAT JSON PATH '$'))
        ) LOOP
            l_skills_html := l_skills_html || '<span class="skill-tag">' || 
                           skill.skill_name || ' (' || skill.skill_level || ')</span>';
        END LOOP;
    END IF;

    -- Build education HTML
    FOR edu_rec IN (
        SELECT DEGREE_TYPE, DEGREE_TITLE, INSTITUTION_NAME, PASSING_YEAR, MAJOR_SUBJECT,
               RESULT_TYPE, RESULT_VALUE
        FROM PG1_EMPLOYEE_EDUCATION
        WHERE EMP_ID = p_emp_id
        ORDER BY PASSING_YEAR DESC
    ) LOOP
    l_education_html := l_education_html ||             
            '<div class="cert-name">' || edu_rec.DEGREE_TYPE || ' ( ' || edu_rec.MAJOR_SUBJECT || ') - ' || NVL(edu_rec.RESULT_VALUE, '') || ' </div>' ||
            '<div class="cert-org">' || edu_rec.INSTITUTION_NAME || ' | ' || edu_rec.PASSING_YEAR || ' | ' || 
            CASE WHEN edu_rec.RESULT_TYPE IS NOT NULL THEN ' | ' || edu_rec.RESULT_TYPE || ' ' || NVL(edu_rec.RESULT_VALUE, '') END || 
            '</div>';
    END LOOP;




    -- Build experience HTML
    FOR exp_rec IN (
        SELECT COMPANY_NAME, DESIGNATION, EMPLOYMENT_TYPE,
               TO_CHAR(START_DATE, 'Mon YYYY') AS START_DATE_STR,
               CASE WHEN END_DATE IS NULL AND IS_CURRENT = 'Y' THEN 'Present' 
                    ELSE TO_CHAR(END_DATE, 'Mon YYYY') END AS END_DATE_STR,
               REPLACE(REPLACE(NVL(JOB_RESPONSIBILITIES, ''), CHR(10), '<br>'), CHR(13), '') AS JOB_RESPONSIBILITIES
        FROM PG1_EMPLOYEE_EXPERIENCE
        WHERE EMP_ID = p_emp_id
        ORDER BY START_DATE DESC
    ) LOOP
        l_experience_html := l_experience_html ||
                '<div class="experience">
                    <div class="experience-header">
                        <div>
                            <span class="job-title">' || exp_rec.DESIGNATION || '</span> -- 
                            <span class="company">'|| exp_rec.COMPANY_NAME || CASE WHEN exp_rec.EMPLOYMENT_TYPE IS NOT NULL THEN ' (' || exp_rec.EMPLOYMENT_TYPE || ')' END || '</span>
                        </div>
                        <div class="date">' || exp_rec.START_DATE_STR || ' - ' || exp_rec.END_DATE_STR || '</div>' ||
                    '</div>
                    <div class="experience-description">
                        ' || exp_rec.JOB_RESPONSIBILITIES || '
                    </div>
                </div>';          

    END LOOP;

    -- Build complete HTML
    l_html := '
<head>
    <style type="text/css">
        @media print {
            @page {
                size: A4 !important;
                margin: 5mm !important;
            }
            body {
                margin: 0 !important;
                padding: 0 !important;
            }
        }

        * {
            margin: 0 !important;
            padding: 0 !important;
            box-sizing: border-box !important;
        }

        body {
            font-family: ''Times New Roman'', serif !important;
            font-size: 14px !important;
            line-height: 1 !important;
            color: #333 !important;
            width: 210mm !important;
            height: 297mm !important;
            margin: 0 auto !important;
            padding: 5mm !important;
            background: white !important;
        }

        .header {
            background-color: #3B3350 !important;
            color: white !important;
            text-align: center !important;
            padding: 10px 20px !important;
            margin: -5mm -5mm 0 -5mm !important;
            position: relative !important;
        }

        .profile-image {
            width: 100px;
            height: 100px;
            border: 3px solid white;
            border-radius: 50%;
            background: #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
            color: #666;
            position: absolute;
            /* left: 20px; */
            top: 50%;
            transform: translateY(-70%);
            z-index: 10;
        }

        .header-content {
            margin-left: 110px;
        }

        .header h1 {
            font-size: 12px;
            margin: 5px 0;
            font-weight: normal;
        }

        .header h2 {
            font-size: 22px;
            margin: 8px 0;
            font-weight: bold;
        }

        .header p {
            font-size: 14px;
            margin: 5px 0;
            font-weight: normal;
        }

        .header-contact {
            font-size: 14px;
            margin: 8px 0;
            color: #ddd;
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .header-contact a {
            color: #ddd;
            text-decoration: none;
        }

        .header-contact a:hover {
            text-decoration: underline;
        }

        .profile-section {
            height: 0;
            margin: 0;
            position: relative;
        }

        .intro-text {
            font-size: 14px;
            line-height: 1;
            text-align: justify;
            margin-bottom: 10px;
            clear: none;
        }

        .main-content {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .left-column {
            width: 33%;
            background: #f7f7fb;
            padding: 20px 15px;
            border-radius: 5px;

            display: flex;
            flex-wrap: wrap;
            align-content: flex-start;
            gap: 10px;
        }

        .right-column {
            width: 67%;
            padding: 0 10px;
        }

        .section {
            margin-bottom: 0px;
            /* border-bottom: 1px solid rgba(59, 51, 80, 0.08); */
            padding-bottom: 5px;
        }

        .section:last-child {
            border-bottom: none;
        }

        .section h3 {
            margin: 4px 0 8px 0;
            font-size: 12pt;
            color: #3B3350;
            border-bottom: 1px solid rgba(59, 51, 80, 0.08);
            padding-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .section-title {
        background: rgb(56 20 80 / 3%);
        padding: 3px 12px 3px 12px;
        border-radius: 10px;
        }

        .highlight {
            background-color: #fffce9;
            padding: 2px 4px;
            border-radius: 3px;
        }

        .personal-info p, .contact-info p, .education p {
            margin-bottom: 5px;
            font-size: 13px;
        }

        .personal-info strong, .contact-info strong, .education strong {
            font-weight: bold;
            display: inline-block;
            width: 80px;
            font-size: 12px;
        }

        .education .cert-name {
            font-weight: bold;
            font-size: 12px;
            line-height: 1.3;
        }

        .education .cert-org {
            font-size: 12px;
            color: #666;
            margin-bottom: 8px;
        }

        .communication-skills ul {
            margin: 0;
            padding-left: 15px;
            font-size: 12px;
            line-height: 1.4;
        }

        .communication-skills li {
            margin-bottom: 5px;
        }

        .work-experience {
            margin-bottom: 10px;
        }

        .job-title {
            font-weight: bold;
            font-size: 14px;
            color: #3B3350;
            margin-bottom: 3px;
        }

        .company {
            font-style: italic;
            font-size: 13px;
            color: #333;
            margin-bottom: 2px;
        }

        .job-period {
            font-size: 12px;
            color: #888;
            margin-bottom: 8px;
        }

        .job-description {
            font-size: 13px;
            line-height: 1.4;
            margin-bottom: 5px;
        }

        .skills-section {
            margin-bottom: 10px;
        }

        .skill-category {
            /* margin-bottom: 5px; */
            display: flex;
            justify-content: flex-start;
            align-items: baseline;
        }

        .skill-category-title {
            font-weight: bold;
            margin-bottom: 8px;
            color: #3B3350;
            font-size: 13px;
        }
        .skill-category.extra-skills {
            display: block;
        }
        .skills-container {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
        }

        .skill-tag {
            background-color: #f4f4ff;
            color: #3B3350;
            padding: 3px 10px;
            border-radius: 15px;
            font-size: 12px;
            display: inline-block;
        }

        .core-strength {
            /* background: #f3f3f3; */
            padding: 5px;
            /* border-left: 4px solid #3B3350; */
            margin-bottom: 10px;
        }

        .core-strength h4 {
            font-size: 14px;
            margin-bottom: 8px;
            color: #3B3350;
        }

        .bullet-list {
            padding-left: 0;
            margin-top: 5px;
            padding-left: 10px;
        }


        .skill-tags {
            margin-top: 10px;
            display: flex;
            justify-content: flex-start;
            flex-wrap: wrap;
            align-items: baseline;
        }

        .tag {
            display: inline-block;
            background: #f3f3f3;
            padding: 3px 8px;
            margin: 2px;
            border-radius: 12px;
            font-size: 11px;
            color: #333;
        }

        .final-note {
            background: #f9f9f9;
            padding-bottom: 5px;
            border-radius: 5px;
            font-size: 12px;
            font-style: italic;
            text-align: center;
        }

        a {
            color: #3B3350;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .portfolio-link {
            font-size: 12px;
            color: #3B3350;
            font-weight: bold;
        }

        @media screen {
            body {
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                margin: 20px auto;
            }
        }
        /* ATS-friendly content (hidden visually) */
        .ats-content {
            position: absolute;
            left: -9999px;
            top: -9999px;
        }

        /* Floating Print Button start */
        .floating-print-btn {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #3B3350;
            color: white;
            border: none;
            border-radius: 50px;
            padding: 12px 20px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(59, 51, 80, 0.3);
            z-index: 1000;
            transition: all 0.3s ease;
            user-select: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .floating-print-btn:hover {
            background: #4a3f6b;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(59, 51, 80, 0.4);
        }

        .floating-print-btn:active {
            transform: translateY(0);
        }

        .floating-print-btn.dragging {
            opacity: 0.8;
            cursor: grabbing;
        }

        /* Hide print button during printing */
        @media print {
            .floating-print-btn {
                display: none !important;
            }
        }
        /* Floating Print Button end */

        /* Experience styles */
        .experience {
            margin-bottom: 20px;
        }
        .experience-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }
        .experience-description {
            margin-top: 5px;
            padding-left: 10px;
        }
        .experience-description ul {
            margin: 5px 0;
            padding-left: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <!-- <div class="profile-image">
            Photo Here
        </div> -->
        <div class="header-content">
            <h2>' || l_emp_rec.FULL_NAME || '</h2>
            <p>' || NVL(l_emp_rec.DESIGNATION_NAME, 'Employee') || ' | ' || NVL(l_emp_rec.DEPARTMENT_NAME, 'Department') || '</p>
            <div class="header-contact">
                <span>' || NVL(l_emp_rec.MOBILE, l_emp_rec.PHONE) || '</span>
                <span><a href="mailto:' || l_emp_rec.EMAIL || '">' || l_emp_rec.EMAIL || '</a></span>
            </div>
        </div>
    </div>

    <div class="profile-section">
        <div class="profile-image">
            <img src="https://picsum.photos/200/200" alt="Mesbah Uddin">
        </div>
    </div>


    <div class="main-content">
        <div class="left-column">
            <!--
            <div class="intro-text">
                Experienced Senior Software Developer and Oracle specialist with strong background in database design, PL/SQL development, Oracle APEX applications, shell scripting automation, and shipping logistics systems. Skilled at building scalable reports, automation and improving system performance. Passionate about UX-aware interfaces, AI integrations and efficient Linux-based deployments.
            </div>
            -->

            <div class="section">
                <h3><span class="section-title">Personal</span></h3>
                <div class="personal-info">
                  <p><strong>DOB:</strong> ' || TO_CHAR(l_emp_rec.DATE_OF_BIRTH, 'DD-MON-YYYY') || '</p>
                  <p><strong>Gender:</strong> ' || NVL(l_emp_rec.GENDER, 'N/A') || '</p>
                  <p><strong>Blood:</strong> ' || NVL(l_emp_rec.BLOOD_GROUP, 'N/A') || '</p>
                  <p><strong>Religion:</strong> ' || NVL(l_emp_rec.RELIGION, 'N/A') || '</p>
                  <p><strong>Marital:</strong> ' || NVL(l_emp_rec.MARITAL_STATUS, 'N/A') || '</p>
                  <p><strong>NID:</strong> ' || l_emp_rec.NID || '</p>
                  <p><strong>Address:</strong> ' || NVL(l_emp_rec.ADDRESS_PRESENT, 'N/A') || '</p>
                </div>
            </div> 

            <div class="section">
            <h3><span class="section-title">Featured Skills</span></h3>
                <div class="skills-container">
                    ' || l_skills_html || '
                </div>
            </div>

            <div class="section">
                <h3><span class="section-title">Education</span></h3>
                <div class="education">
                    ' || l_education_html || '
                </div>
            </div>
        </div>




        <div class="right-column">
            <div class="core-strength">
                <h4><span class="highlight">Core Strength:</span> Problem Solving &amp; Business Logic Design</h4>
                <p>Specialized in transforming complex business requirements into efficient database solutions with focus on performance optimization, user experience, and scalable architecture design.</p>
            </div>

            <div class="section">
                <h3><span class="section-title">Education</span></h3>
                <div class="education">
                        ' || l_experience_html || '
                </div>
            </div>


            <div class="section">
                <h3><span class="section-title">Featured Skills</span></h3>
                <div class="skills-section">
                    <div class="skill-category">
                        <div class="skills-container">
                            ' || l_skills_html || '
                        </div>
                    </div> 
                </div>
            </div>

            <div class="final-note">
                <strong>Final Note:</strong> The above list is a <span class="highlight">''highlight''</span> summary -- deeper skills and advanced practices can be discussed upon request.
            </div> 
        </div>
    </div>


    <!-- Floating Print Button -->
    <button class="floating-print-btn" id="printBtn" title="Print Resume">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
            <path d="M19 8H5c-1.66 0-3 1.34-3 3v6h4v4h12v-4h4v-6c0-1.66-1.34-3-3-3zm-3 11H8v-5h8v5zm3-7c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm-1-9H6v4h12V3z"/>
        </svg>
        Print / Download
    </button>



    <script>
        // Print functionality
        document.getElementById(''printBtn'').addEventListener(''click'', function() {
            window.print();
        });

        // Draggable functionality
        const printBtn = document.getElementById(''printBtn'');
        let isDragging = false;
        let currentX;
        let currentY;
        let initialX;
        let initialY;
        let xOffset = 0;
        let yOffset = 0;

        // Touch events for mobile
        printBtn.addEventListener(''touchstart'', dragStart, false);
        printBtn.addEventListener(''touchend'', dragEnd, false);
        printBtn.addEventListener(''touchmove'', drag, false);

        // Mouse events for desktop
        printBtn.addEventListener(''mousedown'', dragStart, false);
        document.addEventListener(''mousemove'', drag, false);
        document.addEventListener(''mouseup'', dragEnd, false);

        function dragStart(e) {
            if (e.type === ''touchstart'') {
                initialX = e.touches[0].clientX - xOffset;
                initialY = e.touches[0].clientY - yOffset;
            } else {
                initialX = e.clientX - xOffset;
                initialY = e.clientY - yOffset;
            }

            if (e.target === printBtn) {
                isDragging = true;
                printBtn.classList.add(''dragging'');
            }
        }

        function dragEnd(e) {
            initialX = currentX;
            initialY = currentY;
            isDragging = false;
            printBtn.classList.remove(''dragging'');
        }

        function drag(e) {
            if (isDragging) {
                e.preventDefault();

                if (e.type === ''touchmove'') {
                    currentX = e.touches[0].clientX - initialX;
                    currentY = e.touches[0].clientY - initialY;
                } else {
                    currentX = e.clientX - initialX;
                    currentY = e.clientY - initialY;
                }

                xOffset = currentX;
                yOffset = currentY;

                setTranslate(currentX, currentY, printBtn);
            }
        }

        function setTranslate(xPos, yPos, el) {
            el.style.transform = `translate3d(${xPos}px, ${yPos}px, 0)`;
        }

        // Prevent text selection while dragging
        printBtn.addEventListener(''selectstart'', function(e) {
            e.preventDefault();
        });
    </script>
</body>
</html>';

    RETURN l_html;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '<h3>Employee not found</h3>';
    WHEN OTHERS THEN
        RETURN '<h3>Error loading CV: ' || SQLERRM || '</h3>';
END pg1_get_employee_cv_html2;
--------------------------------------------------------
--  Constraints for Table PG1_EMPLOYEE_EXPERIENCE
--------------------------------------------------------

  ALTER TABLE "PG1_EMPLOYEE_EXPERIENCE" MODIFY ("EMP_ID" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_EXPERIENCE" MODIFY ("COMPANY_NAME" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_EXPERIENCE" MODIFY ("DESIGNATION" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_EXPERIENCE" MODIFY ("START_DATE" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_EXPERIENCE" ADD CHECK (IS_CURRENT IN ('Y', 'N')) ENABLE
  ALTER TABLE "PG1_EMPLOYEE_EXPERIENCE" ADD CONSTRAINT "PG1_CHK_DATE_LOGIC" CHECK (END_DATE IS NULL OR END_DATE >= START_DATE) ENABLE
  ALTER TABLE "PG1_EMPLOYEE_EXPERIENCE" ADD PRIMARY KEY ("EXP_ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table PG_DOCS
--------------------------------------------------------

  ALTER TABLE "PG_DOCS" MODIFY ("ID" NOT NULL ENABLE)
  ALTER TABLE "PG_DOCS" ADD PRIMARY KEY ("ID") USING INDEX  ENABLE
  ALTER TABLE "PG_DOCS" ADD UNIQUE ("TAGS") RELY USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table PG1_EMPLOYEE_EDUCATION
--------------------------------------------------------

  ALTER TABLE "PG1_EMPLOYEE_EDUCATION" MODIFY ("EMP_ID" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_EDUCATION" MODIFY ("DEGREE_TYPE" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_EDUCATION" MODIFY ("DEGREE_TITLE" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_EDUCATION" MODIFY ("INSTITUTION_NAME" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_EDUCATION" MODIFY ("PASSING_YEAR" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_EDUCATION" ADD CHECK (IS_CURRENT IN ('Y', 'N')) ENABLE
  ALTER TABLE "PG1_EMPLOYEE_EDUCATION" ADD CONSTRAINT "PG1_CHK_PASSING_YEAR" CHECK (PASSING_YEAR BETWEEN 1950 AND 2030) ENABLE
  ALTER TABLE "PG1_EMPLOYEE_EDUCATION" ADD PRIMARY KEY ("EDU_ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table PG1_DEPARTMENT_MASTER
--------------------------------------------------------

  ALTER TABLE "PG1_DEPARTMENT_MASTER" MODIFY ("DEPT_CODE" NOT NULL ENABLE)
  ALTER TABLE "PG1_DEPARTMENT_MASTER" MODIFY ("DEPT_NAME" NOT NULL ENABLE)
  ALTER TABLE "PG1_DEPARTMENT_MASTER" ADD CHECK (IS_ACTIVE IN ('Y', 'N')) ENABLE
  ALTER TABLE "PG1_DEPARTMENT_MASTER" ADD PRIMARY KEY ("DEPT_ID") USING INDEX  ENABLE
  ALTER TABLE "PG1_DEPARTMENT_MASTER" ADD UNIQUE ("DEPT_CODE") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table DBTOOLS$EXECUTION_HISTORY
--------------------------------------------------------

  ALTER TABLE "DBTOOLS$EXECUTION_HISTORY" MODIFY ("ID" NOT NULL ENABLE)
  ALTER TABLE "DBTOOLS$EXECUTION_HISTORY" ADD CONSTRAINT "DBTOOLS$EXECUTION_HISTORY_PK" PRIMARY KEY ("ID") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table PG1_LOOKUP_VALUES
--------------------------------------------------------

  ALTER TABLE "PG1_LOOKUP_VALUES" MODIFY ("LOOKUP_TYPE" NOT NULL ENABLE)
  ALTER TABLE "PG1_LOOKUP_VALUES" MODIFY ("LOOKUP_CODE" NOT NULL ENABLE)
  ALTER TABLE "PG1_LOOKUP_VALUES" MODIFY ("LOOKUP_VALUE" NOT NULL ENABLE)
  ALTER TABLE "PG1_LOOKUP_VALUES" ADD CHECK (IS_ACTIVE IN ('Y', 'N')) ENABLE
  ALTER TABLE "PG1_LOOKUP_VALUES" ADD PRIMARY KEY ("LOOKUP_ID") USING INDEX  ENABLE
  ALTER TABLE "PG1_LOOKUP_VALUES" ADD CONSTRAINT "PG1_UK_LOOKUP_TYPE_CODE" UNIQUE ("LOOKUP_TYPE", "LOOKUP_CODE") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table PG1_DESIGNATION_MASTER
--------------------------------------------------------

  ALTER TABLE "PG1_DESIGNATION_MASTER" MODIFY ("DESIG_CODE" NOT NULL ENABLE)
  ALTER TABLE "PG1_DESIGNATION_MASTER" MODIFY ("DESIG_NAME" NOT NULL ENABLE)
  ALTER TABLE "PG1_DESIGNATION_MASTER" ADD CHECK (IS_ACTIVE IN ('Y', 'N')) ENABLE
  ALTER TABLE "PG1_DESIGNATION_MASTER" ADD PRIMARY KEY ("DESIG_ID") USING INDEX  ENABLE
  ALTER TABLE "PG1_DESIGNATION_MASTER" ADD UNIQUE ("DESIG_CODE") USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table PG1_EMPLOYEE_MASTER
--------------------------------------------------------

  ALTER TABLE "PG1_EMPLOYEE_MASTER" MODIFY ("EMP_CODE" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_MASTER" MODIFY ("FIRST_NAME" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_MASTER" MODIFY ("LAST_NAME" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_MASTER" MODIFY ("EMAIL" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_MASTER" MODIFY ("NID" NOT NULL ENABLE)
  ALTER TABLE "PG1_EMPLOYEE_MASTER" ADD CHECK (MARITAL_STATUS IN ('Single', 'Married', 'Divorced', 'Widowed')) ENABLE
  ALTER TABLE "PG1_EMPLOYEE_MASTER" ADD CHECK (IS_ACTIVE IN ('Y', 'N')) ENABLE
  ALTER TABLE "PG1_EMPLOYEE_MASTER" ADD CONSTRAINT "PG1_CHK_EMAIL_FORMAT" CHECK (REGEXP_LIKE(EMAIL, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')) ENABLE
  ALTER TABLE "PG1_EMPLOYEE_MASTER" ADD CONSTRAINT "PG1_CHK_NID_FORMAT" CHECK (REGEXP_LIKE(NID, '^[0-9]{10}$|^[0-9]{13}$|^[0-9]{17}$')) ENABLE
  ALTER TABLE "PG1_EMPLOYEE_MASTER" ADD PRIMARY KEY ("EMP_ID") USING INDEX  ENABLE
  ALTER TABLE "PG1_EMPLOYEE_MASTER" ADD UNIQUE ("EMP_CODE") USING INDEX  ENABLE
  ALTER TABLE "PG1_EMPLOYEE_MASTER" ADD UNIQUE ("EMAIL") USING INDEX  ENABLE
  ALTER TABLE "PG1_EMPLOYEE_MASTER" ADD UNIQUE ("NID") USING INDEX  ENABLE
--------------------------------------------------------
--  Ref Constraints for Table PG1_DESIGNATION_MASTER
--------------------------------------------------------

  ALTER TABLE "PG1_DESIGNATION_MASTER" ADD CONSTRAINT "PG1_FK_DESIG_DEPT" FOREIGN KEY ("DEPT_ID") REFERENCES "PG1_DEPARTMENT_MASTER" ("DEPT_ID") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table PG1_EMPLOYEE_EDUCATION
--------------------------------------------------------

  ALTER TABLE "PG1_EMPLOYEE_EDUCATION" ADD CONSTRAINT "PG1_FK_EDU_EMP" FOREIGN KEY ("EMP_ID") REFERENCES "PG1_EMPLOYEE_MASTER" ("EMP_ID") ON DELETE CASCADE ENABLE
--------------------------------------------------------
--  Ref Constraints for Table PG1_EMPLOYEE_EXPERIENCE
--------------------------------------------------------

  ALTER TABLE "PG1_EMPLOYEE_EXPERIENCE" ADD CONSTRAINT "PG1_FK_EXP_EMP" FOREIGN KEY ("EMP_ID") REFERENCES "PG1_EMPLOYEE_MASTER" ("EMP_ID") ON DELETE CASCADE ENABLE

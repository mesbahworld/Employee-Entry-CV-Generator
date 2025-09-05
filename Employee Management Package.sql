-- =============================================
-- Employee Management System - Task Compliant PL/SQL Package with PG1_ Prefix
-- Targets: PG1_EMPLOYEE_MASTER, PG1_EMPLOYEE_EDUCATION, PG1_EMPLOYEE_EXPERIENCE
-- =============================================

create or replace PACKAGE PG1_PKG_EMPLOYEE_MGMT AS
    
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
    FUNCTION PG1_VALIDATE_NID(p_nid IN VARCHAR2, p_emp_id IN NUMBER DEFAULT NULL) RETURN VARCHAR2;

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
    FUNCTION PG1_DELETE_EMPLOYEE(p_emp_id IN NUMBER) RETURN VARCHAR2;

END PG1_PKG_EMPLOYEE_MGMT;




















/
create or replace PACKAGE BODY PG1_PKG_EMPLOYEE_MGMT AS

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
    BEGIN
        -- Validate email
        v_error_msg := PG1_VALIDATE_EMAIL(p_email, p_emp_id);
        IF v_error_msg IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20001, v_error_msg);
        END IF;

        -- Validate NID
        v_error_msg := PG1_VALIDATE_NID(p_nid, p_emp_id);
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
    BEGIN
        -- Format validation
        IF p_email IS NULL 
        OR NOT REGEXP_LIKE(LOWER(TRIM(p_email)), '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$') THEN
            RETURN 'Invalid email format';
        END IF;

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
        p_emp_id IN NUMBER DEFAULT NULL
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

        IF v_count > 0 THEN
            RETURN 'NID already exists';
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



    FUNCTION PG1_DELETE_EMPLOYEE(p_emp_id IN NUMBER) RETURN VARCHAR2 IS
        v_count NUMBER;
    BEGIN
        -- Check if employee exists
        SELECT COUNT(*) INTO v_count
        FROM PG1_EMPLOYEE_MASTER
        WHERE EMP_ID = p_emp_id AND IS_ACTIVE = 'Y';

        IF v_count = 0 THEN
            RETURN 'Employee not found or already inactive';
        END IF;

        -- Soft delete (set IS_ACTIVE = 'N')
        UPDATE PG1_EMPLOYEE_MASTER
        SET IS_ACTIVE = 'N'
        WHERE EMP_ID = p_emp_id;

        COMMIT;
        RETURN 'SUCCESS';

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RETURN 'Error deleting employee: ' || SQLERRM;
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

/

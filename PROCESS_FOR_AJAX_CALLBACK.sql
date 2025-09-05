
-- =============================================
-- PG1_ APEX Application Processes (for AJAX calls)
-- =============================================

-- Process: PG1_SAVE_EMPLOYEE
CREATE OR REPLACE PROCEDURE PG1_PROC_SAVE_EMPLOYEE (
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
    HTP.P('{"status":"success","emp_id":' || v_emp_id || ',"message":"Employee saved successfully"}');
    
EXCEPTION
    WHEN OTHERS THEN
        HTP.P('{"status":"error","message":"' || REPLACE(SQLERRM, '"', '\"') || '"}');
END PG1_PROC_SAVE_EMPLOYEE;
/


-- Process: PG1_GET_EMPLOYEE_LIST  
CREATE OR REPLACE PROCEDURE PG1_PROC_GET_EMPLOYEE_LIST AS
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
/

-- Process: PG1_GET_CV_DATA
CREATE OR REPLACE PROCEDURE PG1_PROC_GET_CV_DATA AS
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
/

-- Process: PG1_GET_LOOKUP_DATA
CREATE OR REPLACE PROCEDURE PG1_PROC_GET_LOOKUP_DATA AS
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
/

-- Process: PG1_VALIDATE_FIELD
CREATE OR REPLACE PROCEDURE PG1_PROC_VALIDATE_FIELD AS
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
/
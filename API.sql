CREATE OR REPLACE PROCEDURE PG1_API_GET_EMPLOYEE_FULL_JSON ( 
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
/



SET SERVEROUTPUT ON

DECLARE
    l_json CLOB;
BEGIN
    PG1_API_GET_EMPLOYEE_FULL_JSON(:id, :emp_name, l_json);
    --:body := l_json;
    dbms_output.put_line(l_json);
END;
/


-- Example cURL request (id and emp_name both are optional)
-- To get full data use : https://mesbahuddin.com/web/unorg/pg1_emp_man/data
-- https://mesbahuddin.com/web/unorg/pg1_emp_man/data?id=1&emp_name=Md.%20Mesbah%20Uddin
----------------------------------------------------------------------------------
/*
Get Method:
curl --location 'https://mesbahuddin.com/web/unorg/pg1_emp_man/data'

*/




-- Example JSON response
----------------------------------------------------------------------------------
/*
{
    "status": "success",
    "statusCode": 200,
    "data": [
        {
            "empId": 1,
            "firstName": "Md. Mesbah",
            "lastName": "Uddin",
            "email": "mesbahworld@gmail.com",
            "phone": "8012345",
            "mobile": "801736251716",
            "nid": "19940023500002325",
            "dateOfBirth": "1994-09-21",
            "gender": "M",
            "bloodGroup": "A+",
            "religion": "ISLAM",
            "departmentId": 1,
            "designationId": 7,
            "joinDate": "2025-09-01",
            "salary": 80000,
            "addressPresent": "Kazipara, Dhaka 1216",
            "addressPermanent": "Swarupkathi, Pirojpur, Barishal",
            "emergencyContactName": "8801736000000",
            "emergencyContactPhone": "880173600",
            "maritalStatus": "Single",
            "skills": [
                {
                    "name": "Oracle APEX",
                    "level": "Expert",
                    "years": 5
                },
                {
                    "name": "JavaScript",
                    "level": "Advanced",
                    "years": 4
                },
                {
                    "name": "PL/SQL",
                    "level": "Expert",
                    "years": 6
                },
                {
                    "name": "HTML/CSS",
                    "level": "Advanced",
                    "years": 4
                }
            ],
            "education": [
                {
                    "id": 1,
                    "degreeType": "SSC",
                    "degreeTitle": "Secondary School Certificate",
                    "institutionName": "Swarupkathi Collegiate Academy",
                    "passingYear": 2009,
                    "resultType": "GPA",
                    "resultValue": "5.00",
                    "duration": 2,
                    "majorSubject": "Science",
                    "isCurrent": "N"
                },
                {
                    "id": 3,
                    "degreeType": "Bachelor",
                    "degreeTitle": "Bachelor of Science (B.Sc.)",
                    "institutionName": "Government Titumir College",
                    "passingYear": 2016,
                    "resultType": "CGPS",
                    "resultValue": "2.85",
                    "duration": 4,
                    "majorSubject": "Mathematics",
                    "isCurrent": "N"
                },
                {
                    "id": 2,
                    "degreeType": "HSC",
                    "degreeTitle": "Higher Secondary Certificate",
                    "institutionName": "Government Science College",
                    "passingYear": 2012,
                    "resultType": "GPA",
                    "resultValue": "3.80",
                    "duration": 2,
                    "majorSubject": "Science",
                    "isCurrent": "N"
                }
            ],
            "experience": [
                {
                    "id": 1,
                    "companyName": "Upwork Marketplace",
                    "designation": "Freelancer",
                    "department": null,
                    "employmentType": "Remote",
                    "startDate": "2015-01-01",
                    "endDate": "2021-01-01",
                    "location": "Banani, Dhaka",
                    "salaryRange": "30000-50000",
                    "supervisorName": null,
                    "jobResponsibilities": "-Developed responsive web applications for international clients using HTML5, CSS3, and JavaScript\n-Created user-centered interfaces improving conversion rates by 40%\n-Implemented front-end solutions with focus on user experience and accessibility\n-Gained experience in full project lifecycle from requirements to deployment",
                    "reasonForLeaving": "Got opportunity in full time corporaate job",
                    "isCurrent": "N"
                },
                {
                    "id": 4,
                    "companyName": "FlingEx",
                    "designation": "Software Developer (Lead)",
                    "department": "IT",
                    "employmentType": "Full-time",
                    "startDate": "2023-08-01",
                    "endDate": "2025-04-30",
                    "location": "Banani, Dhaka",
                    "salaryRange": "60000",
                    "supervisorName": null,
                    "jobResponsibilities": "-Led development team of 4 developers for parcel management system handling 10,000+ daily transactions\n-Designed and implemented REST APIs for mobile and web clients using ORDS\n-Developed complex Oracle APEX reports and dashboards for business analytics\n-Optimized PL/SQL routines improving system performance by 35%\n-Implemented automated data validation processes reducing errors by 40%\n-Architected high-performance logistics tracking system with real-time updates\n-Created automated reporting solutions reducing manual work by 80%\n-Managed database administration tasks including backup, recovery, and performance tuning",
                    "reasonForLeaving": "Company goes bankrupt",
                    "isCurrent": "N"
                },
                {
                    "id": 2,
                    "companyName": "Projman Technology",
                    "designation": "Oracle Database Architect (lead)",
                    "department": "IT",
                    "employmentType": "Full-time",
                    "startDate": "2021-04-01",
                    "endDate": "2023-03-31",
                    "location": "Mohakhali, Dhaka",
                    "salaryRange": "53000",
                    "supervisorName": null,
                    "jobResponsibilities": "Project: Bangladesh Bridge Authority Government ERP System\n-Led team of 13 developers in building ERP system for infrastructure project\r\n-Designed database architecture handling 500+ concurrent users\r\n-Implemented role-based security and audit trails for sensitive government data\r\n-Developed complex business logic modules for contract management and approval workflows\r\n-Optimized database performance reducing report generation time by 60%\r\n-Conducted business analysis and requirements gathering for government stakeholders\r\n-Implemented data migration strategies from legacy systems to Modern Oracle APEX\r\n-Provided technical leadership and mentoring to junior developers",
                    "reasonForLeaving": "Got better opportunity",
                    "isCurrent": "N"
                }
            ]
        }
    ]
}

*/


-- On error sample: No employee found
----------------------------------------------------------------------------------
/*
{
    "status": "error",
    "statusCode": 404,
    "message": "No employee found"
}
*/



CREATE OR REPLACE PROCEDURE PG1_API_GET_DEPARTMENT_LIST ( 
    p_dept_id    IN NUMBER   DEFAULT NULL,
    p_dept_name  IN VARCHAR2 DEFAULT NULL,
    p_result    OUT CLOB
) AS
    v_errmsg  VARCHAR2(4000);
    v_errcode NUMBER;
BEGIN
    BEGIN
        -- Main query to build JSON array
        SELECT JSON_OBJECT(
                 'status' VALUE 'success',
                 'statusCode' VALUE 200,
                 'data' VALUE (
                     SELECT JSON_ARRAYAGG(
                                JSON_OBJECT(
                                    'dept_id'   VALUE dept.dept_id,
                                    'dept_name' VALUE dept.dept_name
                                )
                              )
                     FROM pg1_department_master dept
                     WHERE (p_dept_id IS NULL OR dept.dept_id = p_dept_id)
                       AND (p_dept_name IS NULL 
                            OR UPPER(dept.dept_name) LIKE UPPER('%' || p_dept_name || '%') 
                            OR UPPER(dept.dept_code) LIKE UPPER('%' || p_dept_name || '%'))
                 ) FORMAT JSON
               RETURNING CLOB
               )
        INTO p_result
        FROM dual;

        -- If nothing was found (array null)
        IF p_result IS NULL THEN
            SELECT JSON_OBJECT(
                       'status' VALUE 'error',
                       'statusCode' VALUE 404,
                       'message' VALUE 'No department found'
                   RETURNING CLOB)
            INTO p_result
            FROM dual;
        END IF;

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
/

SET SERVEROUTPUT ON

DECLARE
    l_json CLOB;
BEGIN
    PG1_API_GET_DEPARTMENT_LIST (:id, :dept_name, l_json);
    --:body := l_json;
    dbms_output.put_line(l_json);
END;
/

-- Example cURL request (id and dept_name both are optional)
-- To get full data use : https://mesbahuddin.com/web/unorg/pg1_emp_man/list_dept
-- curl --location 'https://mesbahuddin.com/web/unorg/pg1_emp_man/list_dept?id=1&dept_name=It'
----------------------------------------------------------------------------------


/*
Get Method:

curl --location 'https://mesbahuddin.com/web/unorg/pg1_emp_man/list_dept?id=1&dept_name=It'
*/




-- Example JSON response
----------------------------------------------------------------------------------
/*
{
    "status": "success",
    "statusCode": 200,
    "data": [
        {
            "dept_id": 1,
            "dept_name": "Information Technology"
        },
        {
            "dept_id": 2,
            "dept_name": "Human Resources"
        },
        {
            "dept_id": 5,
            "dept_name": "Operations"
        },
        {
            "dept_id": 6,
            "dept_name": "Administration"
        },
        {
            "dept_id": 3,
            "dept_name": "Finance & Accounts"
        },
        {
            "dept_id": 4,
            "dept_name": "Marketing & Sales"
        }
    ]
}

*/


-- On error sample: No employee found
----------------------------------------------------------------------------------
/*
{
    "status": "error",
    "statusCode": 404,
    "message": "No employee found"
}
*/



CREATE OR REPLACE PROCEDURE PG1_API_GET_DESIGNATION_LIST ( 
    p_desig_id    IN NUMBER   DEFAULT NULL,
    p_desig_name  IN VARCHAR2 DEFAULT NULL,
    p_result    OUT CLOB
) AS
    v_errmsg  VARCHAR2(4000);
    v_errcode NUMBER;
BEGIN
    BEGIN
        -- Main query to build JSON array
        SELECT JSON_OBJECT(
                 'status' VALUE 'success',
                 'statusCode' VALUE 200,
                 'data' VALUE (
                     SELECT JSON_ARRAYAGG(
                                JSON_OBJECT(
                                    'desig_id'   VALUE des.desig_id,
                                    'desig_name' VALUE des.desig_name
                                )
                              )
                     FROM pg1_designation_master des
                     WHERE (p_desig_id IS NULL OR des.desig_id = p_desig_id)
                       AND (p_desig_name IS NULL 
                            OR UPPER(des.desig_name) LIKE UPPER('%' || p_desig_name || '%')
                            OR UPPER(des.desig_code) LIKE UPPER('%' || p_desig_name || '%'))
                 ) FORMAT JSON
               RETURNING CLOB
               )
        INTO p_result
        FROM dual;

        -- If nothing was found (array null)
        IF p_result IS NULL THEN
            SELECT JSON_OBJECT(
                       'status' VALUE 'error',
                       'statusCode' VALUE 404,
                       'message' VALUE 'No department found'
                   RETURNING CLOB)
            INTO p_result
            FROM dual;
        END IF;

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
/

SET SERVEROUTPUT ON

DECLARE
    l_json CLOB;
BEGIN
    PG1_API_GET_DESIGNATION_LIST (:id, :desig_name, l_json);
    --:body := l_json;
    dbms_output.put_line(l_json);
END;
/

-- Example cURL request (id and emp_name both are optional)
-- To get full data use : https://mesbahuddin.com/web/unorg/pg1_emp_man/list_dept
-- https://mesbahuddin.com/web/unorg/pg1_emp_man/list_dept?id=1&dept_name=It
----------------------------------------------------------------------------------
/*
Get Method:

curl --location 'https://mesbahuddin.com/web/unorg/pg1_emp_man/list_dept'

*/




-- Example JSON response
----------------------------------------------------------------------------------
/*
{
    "status": "success",
    "statusCode": 200,
    "data": [
        {
            "dept_id": 1,
            "dept_name": "Information Technology"
        },
        {
            "dept_id": 2,
            "dept_name": "Human Resources"
        },
        {
            "dept_id": 5,
            "dept_name": "Operations"
        },
        {
            "dept_id": 6,
            "dept_name": "Administration"
        },
        {
            "dept_id": 3,
            "dept_name": "Finance & Accounts"
        },
        {
            "dept_id": 4,
            "dept_name": "Marketing & Sales"
        }
    ]
}

*/


-- On error sample: No employee found
----------------------------------------------------------------------------------
/*
{
    "status": "error",
    "statusCode": 404,
    "message": "No employee found"
}
*/




-- Ajax Callback Method: JSON payload to insert/update Data All Employe Master and Details 
-- Sample CLOB JSON Data ------------------------------------------------------------------

-- PG1_PROC_SAVE_EMPLOYEE Is a procedure that saves employee data and assign payload using :
--  v_employee_data := APEX_APPLICATION.G_x01; or
--  v_employee_data := apex_application.g_clob_01;
-- PROCESS NAME: PG1_SAVE_EMPLOYEE
BEGIN
    PG1_PROC_SAVE_EMPLOYEE;
END;
/
-- or,
BEGIN
    PG1_PROC_SAVE_EMPLOYEE(p_employee_data => apex_application.g_clob_01); -- or APEX_APPLICATION.G_x01;
END;
/
-- or,
DECLARE
    v_employee_data CLOB := -- Please provide "emp_id" for update and null for Insert
 '
    {
    "emp_id": null,
    "first_name": "John",
    "last_name": "Doe",
    "email": "john.doe@updated.com",
    "phone": "1234567890",
    "mobile": "9876543210",
    "nid": "1234567890123",
    "date_of_birth": "1990-01-01",
    "gender": "M",
    "blood_group": "O+",
    "religion": "Islam",
    "department_id": 1,
    "designation_id": 2,
    "join_date": "2020-01-01",
    "salary": 50000,
    "address_present": "Dhaka",
    "address_permanent": "Chittagong",
    "emergency_contact_name": "Jane Doe",
    "emergency_contact_phone": "0123456789",
    "marital_status": "Married",
    "skills": "Oracle, PL/SQL, APEX",

    "education": [
        {
        "degree_type": "BSc",
        "degree_title": "Computer Science",
        "institution_name": "Dhaka University",
        "passing_year": 2012,
        "result_type": "CGPA",
        "result_value": "3.8",
        "duration_years": 4,
        "major_subject": "CSE",
        "is_current": "N"
        },
        {
        "degree_type": "MSc",
        "degree_title": "Software Engineering",
        "institution_name": "BUET",
        "passing_year": 2014,
        "result_type": "CGPA",
        "result_value": "3.9",
        "duration_years": 2,
        "major_subject": "SE",
        "is_current": "N"
        }
    ],

    "experience": [
        {
        "company_name": "ABC Ltd",
        "designation": "Software Engineer",
        "department": "IT",
        "start_date": "2015-01-01",
        "end_date": "2018-01-01",
        "is_current": "N",
        "job_responsibilities": "Development",
        "salary_range": "30k-40k",
        "reason_for_leaving": "Better opportunity",
        "supervisor_name": "Mr. X",
        "supervisor_contact": "0123456789",
        "location": "Dhaka",
        "employment_type": "Full-time"
        },
        {
        "company_name": "XYZ Ltd",
        "designation": "Senior Software Engineer",
        "department": "IT",
        "start_date": "2018-02-01",
        "end_date": null,
        "is_current": "Y",
        "job_responsibilities": "Team Lead",
        "salary_range": "50k-60k",
        "reason_for_leaving": null,
        "supervisor_name": "Mr. Y",
        "supervisor_contact": "0987654321",
        "location": "Chittagong",
        "employment_type": "Full-time"
        }
    ]
    }

'
    ;
BEGIN
    PG1_PROC_SAVE_EMPLOYEE(p_employee_data => v_employee_data);
END;
/



-- API Method: JSON payload to insert/update Data All Employe Master and Details 
-- Sample CLOB JSON Data (Exact Identical structure) ------------------------------------------------------------------

/*
curl --location 'https://mesbahuddin.com/web/unorg/pg1_emp_man/data' \
--header 'Content-Type: application/json' \
--data-raw ' data-raw instruction: Same JSON data as v_employee_data used earlier in ajax callback. Please provide "emp_id" for update and null for Insert'

*/

-- Success Response:
/*
{
    "status": "success",
    "statusCode": 200,
    "emp_id": 11,
    "message": "Employee saved successfully"
}
*/


-- Error Response:

/*
{
    "status": "error",
    "statusCode": 404,
    "message": "Employee not found / Random error"
}
*/


-- Delete API
-- curl --location --request DELETE 'https://mesbahuddin.com/web/unorg/pg1_emp_man/data?id=55'

/*
Status Example:
{
    "status": "success",
    "statusCode": 200,
    "emp_id": 12,
    "message": "Employee Deleted successfully"
}

{
    "status": "error",
    "statusCode": 404,
    "emp_id": 12,
    "message": "Employee not found or already inactive"
}

*/

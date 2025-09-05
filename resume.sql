create or replace FUNCTION pg1_get_employee_cv_html(p_emp_id NUMBER)
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
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Dynamic CV</title>
  <style>
    :root {
      --primary-color: #FFD700;
      --secondary-color: #222;
      --light-gray: #f5f5f5;
      --border-color: #ddd;
      --header-bg: linear-gradient(135deg, #fff 0%, var(--primary-color) 100%);
    }
    @media print {
      .pdf-download-btn { 
        display: none !important; 
      }
      @page { 
        size: A4; 
        margin: 5mm; 
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
      max-width: 800px;
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

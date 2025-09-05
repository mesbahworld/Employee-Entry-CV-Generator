// Global variables 
let departments = []; 
let designations = []; 
let employeeSkills = []; 

// Base container for all DOM queries
const baseContainer = document.querySelector('#content_region');

document.addEventListener('DOMContentLoaded', function() { 
    // Load department and designation lists 
    loadDepartments(); 
    loadDesignations(); 
     
    // Tab navigation 
    const tabs = baseContainer.querySelectorAll('.tab'); 
    const tabContents = baseContainer.querySelectorAll('.tab-content'); 
     
    tabs.forEach(tab => { 
        tab.addEventListener('click', () => { 
            const tabId = tab.getAttribute('data-tab'); 
             
            // Deactivate all tabs 
            tabs.forEach(t => t.classList.remove('active')); 
            tabContents.forEach(tc => tc.classList.remove('active')); 
             
            // Activate current tab 
            tab.classList.add('active'); 
            baseContainer.querySelector(`#${tabId}-tab`).classList.add('active'); 
        }); 
    }); 
     
    // Same as present address checkbox 
    baseContainer.querySelector('#sameAsPresent').addEventListener('change', function() { 
        if (this.checked) { 
            baseContainer.querySelector('#permanentAddress').value =  
                baseContainer.querySelector('#presentAddress').value; 
            baseContainer.querySelector('#permanentAddress').setAttribute('readonly', true); 
        } else { 
            baseContainer.querySelector('#permanentAddress').removeAttribute('readonly'); 
        } 
    }); 
     
    // Photo upload preview 
    baseContainer.querySelector('#uploadBtn').addEventListener('click', function() { 
        baseContainer.querySelector('#photo').click(); 
    }); 
     
    baseContainer.querySelector('#photo').addEventListener('change', function() { 
        const file = this.files[0]; 
        if (file) { 
            const reader = new FileReader(); 
            reader.onload = function(e) { 
                const preview = baseContainer.querySelector('#photoPreview'); 
                preview.src = e.target.result; 
                preview.style.display = 'block'; 
                baseContainer.querySelector('.photo-preview i').style.display = 'none'; 
            } 
            reader.readAsDataURL(file); 
        } 
    }); 
     
    // Skills management 
    baseContainer.querySelector('#addSkillBtn').addEventListener('click', addSkill); 
     
    // Add education row 
    let educationRowCount = 0; 
    baseContainer.querySelector('#addEducation').addEventListener('click', function() { 
        educationRowCount++; 
        const newRow = document.createElement('div'); 
        newRow.className = 'dynamic-row'; 
        newRow.setAttribute('data-id', educationRowCount); 
        newRow.innerHTML = ` 
            <span class="remove-row" onclick="removeEducationRow(${educationRowCount})"><i class="fas fa-times-circle"></i></span> 
             
            <div class="ui-row"> 
                <div class="ui-col ui-col-4"> 
                    <div class="form-group"> 
                        <label>Degree Type *</label> 
                        <select name="degreeType" class="form-control" required> 
                            <option value="">Select Type</option> 
                            <option value="SSC">SSC</option> 
                            <option value="HSC">HSC</option> 
                            <option value="Bachelor">Bachelor</option> 
                            <option value="Master">Master</option> 
                            <option value="PhD">PhD</option> 
                            <option value="Diploma">Diploma</option> 
                        </select> 
                    </div> 
                </div> 
                <div class="ui-col ui-col-8"> 
                    <div class="form-group"> 
                        <label>Degree Title *</label> 
                        <input type="text" name="degreeTitle" class="form-control" required> 
                    </div> 
                </div> 
            </div> 
             
            <div class="ui-row"> 
                <div class="ui-col ui-col-6"> 
                    <div class="form-group"> 
                        <label>Institution Name *</label> 
                        <input type="text" name="institutionName" class="form-control" required> 
                    </div> 
                </div> 
                <div class="ui-col ui-col-3"> 
                    <div class="form-group"> 
                        <label>Passing Year *</label> 
                        <input type="number" name="passingYear" class="form-control" min="1950" max="2030" required> 
                    </div> 
                </div> 
                <div class="ui-col ui-col-3"> 
                    <div class="form-group"> 
                        <label>Duration (Years)</label> 
                        <input type="number" name="duration" class="form-control" min="1" max="10"> 
                    </div> 
                </div> 
            </div> 
             
            <div class="ui-row"> 
                <div class="ui-col ui-col-4"> 
                    <div class="form-group"> 
                        <label>Result Type</label> 
                        <select name="resultType" class="form-control"> 
                            <option value="">Select Type</option> 
                            <option value="GPA">GPA</option> 
                            <option value="CGPA">CGPA</option> 
                            <option value="Division">Division</option> 
                            <option value="Grade">Grade</option> 
                            <option value="Percentage">Percentage</option> 
                        </select> 
                    </div> 
                </div> 
                <div class="ui-col ui-col-4"> 
                    <div class="form-group"> 
                        <label>Result Value</label> 
                        <input type="text" name="resultValue" class="form-control"> 
                    </div> 
                </div> 
                <div class="ui-col ui-col-4"> 
                    <div class="form-group"> 
                        <label>Major Subject</label> 
                        <input type="text" name="majorSubject" class="form-control"> 
                    </div> 
                </div> 
            </div> 
             
            <div class="form-group"> 
                <label class="checkbox-group"> 
                    <input type="checkbox" name="isCurrent" value="Y"> This is my current education 
                </label> 
            </div> 
        `; 
         
        baseContainer.querySelector('#educationRows').appendChild(newRow); 
    }); 
     
    // Add experience row 
    let experienceRowCount = 0; 
    baseContainer.querySelector('#addExperience').addEventListener('click', function() { 
        experienceRowCount++; 
        const newRow = document.createElement('div'); 
        newRow.className = 'dynamic-row'; 
        newRow.setAttribute('data-id', experienceRowCount); 
        newRow.innerHTML = ` 
            <span class="remove-row" onclick="removeExperienceRow(${experienceRowCount})"><i class="fas fa-times-circle"></i></span> 
             
            <div class="ui-row"> 
                <div class="ui-col ui-col-6"> 
                    <div class="form-group"> 
                        <label>Company Name *</label> 
                        <input type="text" name="companyName" class="form-control" required> 
                    </div> 
                </div> 
                <div class="ui-col ui-col-6"> 
                    <div class="form-group"> 
                        <label>Position *</label> 
                        <input type="text" name="position" class="form-control" required> 
                    </div> 
                </div> 
            </div> 
             
            <div class="ui-row"> 
                <div class="ui-col ui-col-4"> 
                    <div class="form-group"> 
                        <label>Start Date</label> 
                        <input type="date" name="startDate" class="form-control"> 
                    </div> 
                </div> 
                <div class="ui-col ui-col-4"> 
                    <div class="form-group"> 
                        <label>End Date</label> 
                        <input type="date" name="endDate" class="form-control"> 
                    </div> 
                </div> 
                <div class="ui-col ui-col-4"> 
                    <div class="form-group"> 
                        <label>Salary</label> 
                        <input type="number" name="expSalary" class="form-control" step="0.01"> 
                    </div> 
                </div> 
            </div> 
             
            <div class="form-group"> 
                <label>Responsibilities</label> 
                <textarea name="responsibilities" class="form-control" rows="3"></textarea> 
            </div> 
             
            <div class="form-group"> 
                <label class="checkbox-group"> 
                    <input type="checkbox" name="isCurrentJob" value="Y"> This is my current job 
                </label> 
            </div> 
        `; 
         
        baseContainer.querySelector('#experienceRows').appendChild(newRow); 
    }); 

    // Search functionality
    baseContainer.querySelector('#searchBtn').addEventListener('click', performSearch);
    baseContainer.querySelector('#clearSearchBtn').addEventListener('click', clearSearch);
    baseContainer.querySelector('#closeResultsBtn').addEventListener('click', closeSearchResults);

    // Form submission
    baseContainer.querySelector('#employeeForm').addEventListener('submit', handleFormSubmit);

    // Reset form
    baseContainer.querySelector('#resetForm').addEventListener('click', resetForm);

    // Delete employee
    baseContainer.querySelector('#deleteEmployee').addEventListener('click', deleteEmployee);

    // Present address sync
    baseContainer.querySelector('#presentAddress').addEventListener('input', function() {
        if (baseContainer.querySelector('#sameAsPresent').checked) {
            baseContainer.querySelector('#permanentAddress').value = this.value;
        }
    });

    // Department change handler
    baseContainer.querySelector('#department').addEventListener('change', function() {
        loadDesignationsByDepartment(this.value);
    });
}); 

// Remove education row function
function removeEducationRow(id) {
    const row = baseContainer.querySelector(`[data-id="${id}"]`);
    if (row) {
        row.remove();
    }
}

// Remove experience row function  
function removeExperienceRow(id) {
    const row = baseContainer.querySelector(`[data-id="${id}"]`);
    if (row) {
        row.remove();
    }
}

// Skills management functions
function addSkill() {
    const skillName = baseContainer.querySelector('#skillName').value.trim();
    const skillLevel = baseContainer.querySelector('#skillLevel').value;
    const skillYears = baseContainer.querySelector('#skillYears').value;

    if (!skillName || !skillLevel) {
        showStatus('Please enter skill name and level', 'error');
        return;
    }

    const skill = {
        name: skillName,
        level: skillLevel,
        years: skillYears || 0
    };

    employeeSkills.push(skill);
    updateSkillsDisplay();
    clearSkillInputs();
    updateSkillsHiddenField();
}

function removeSkill(index) {
    employeeSkills.splice(index, 1);
    updateSkillsDisplay();
    updateSkillsHiddenField();
}

function updateSkillsDisplay() {
    const skillsDisplay = baseContainer.querySelector('#skillsDisplay');
    skillsDisplay.innerHTML = '';

    employeeSkills.forEach((skill, index) => {
        const skillTag = document.createElement('div');
        skillTag.className = 'skill-tag';
        skillTag.innerHTML = `
            <span>${skill.name} (${skill.level}${skill.years ? `, ${skill.years} years` : ''})</span>
            <button type="button" onclick="removeSkill(${index})" class="skill-remove">
                <i class="fas fa-times"></i>
            </button>
        `;
        skillsDisplay.appendChild(skillTag);
    });
}

function clearSkillInputs() {
    baseContainer.querySelector('#skillName').value = '';
    baseContainer.querySelector('#skillLevel').value = '';
    baseContainer.querySelector('#skillYears').value = '';
}

function updateSkillsHiddenField() {
    baseContainer.querySelector('#skills').value = JSON.stringify(employeeSkills);
}

// API Functions
async function loadDepartments() {
    try {
        showLoading(true);
        const response = await fetch('/ords/hr/departments/', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            const data = await response.json();
            departments = data.items || [];
            populateDepartmentDropdown();
            showApiStatus('Departments loaded successfully', 'success');
        } else {
            throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
    } catch (error) {
        console.error('Error loading departments:', error);
        showApiStatus('Failed to load departments: ' + error.message, 'error');
    } finally {
        showLoading(false);
    }
}

async function loadDesignations() {
    try {
        const response = await fetch('/ords/hr/designations/', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            const data = await response.json();
            designations = data.items || [];
            populateDesignationDropdown();
            showApiStatus('Designations loaded successfully', 'success');
        } else {
            throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
    } catch (error) {
        console.error('Error loading designations:', error);
        showApiStatus('Failed to load designations: ' + error.message, 'error');
    }
}

function populateDepartmentDropdown() {
    const departmentSelect = baseContainer.querySelector('#department');
    departmentSelect.innerHTML = '<option value="">Select Department</option>';
    
    departments.forEach(dept => {
        const option = document.createElement('option');
        option.value = dept.department_id;
        option.textContent = dept.department_name;
        departmentSelect.appendChild(option);
    });
}

function populateDesignationDropdown() {
    const designationSelect = baseContainer.querySelector('#designation');
    designationSelect.innerHTML = '<option value="">Select Designation</option>';
    
    designations.forEach(des => {
        const option = document.createElement('option');
        option.value = des.designation_id;
        option.textContent = des.designation_name;
        designationSelect.appendChild(option);
    });
}

async function loadDesignationsByDepartment(departmentId) {
    if (!departmentId) {
        populateDesignationDropdown();
        return;
    }

    try {
        const response = await fetch(`/ords/hr/designations/?q={"department_id":"${departmentId}"}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            const data = await response.json();
            const filteredDesignations = data.items || [];
            
            const designationSelect = baseContainer.querySelector('#designation');
            designationSelect.innerHTML = '<option value="">Select Designation</option>';
            
            filteredDesignations.forEach(des => {
                const option = document.createElement('option');
                option.value = des.designation_id;
                option.textContent = des.designation_name;
                designationSelect.appendChild(option);
            });
        }
    } catch (error) {
        console.error('Error loading designations for department:', error);
        populateDesignationDropdown(); // Fallback to all designations
    }
}

// Search Functions
async function performSearch() {
    const searchId = baseContainer.querySelector('#searchId').value.trim();
    const searchName = baseContainer.querySelector('#searchName').value.trim();

    if (!searchId && !searchName) {
        showStatus('Please enter either Employee ID or Name to search', 'error');
        return;
    }

    try {
        showLoading(true);
        let url = '/ords/hr/employees/?';
        
        if (searchId) {
            url += `q={"emp_id":"${searchId}"}`;
        } else if (searchName) {
            url += `q={"$or":[{"first_name":{"$like":"%${searchName}%"}},{"last_name":{"$like":"%${searchName}%"}}]}`;
        }

        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            const data = await response.json();
            displaySearchResults(data.items || []);
            showApiStatus('Search completed successfully', 'success');
        } else {
            throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
    } catch (error) {
        console.error('Search error:', error);
        showApiStatus('Search failed: ' + error.message, 'error');
        showStatus('Search failed. Please try again.', 'error');
    } finally {
        showLoading(false);
    }
}

function displaySearchResults(employees) {
    const employeeList = baseContainer.querySelector('#employeeList');
    const searchResultsSection = baseContainer.querySelector('#searchResultsSection');

    if (employees.length === 0) {
        showStatus('No employees found matching your search criteria', 'info');
        return;
    }

    employeeList.innerHTML = '';
    
    employees.forEach(emp => {
        const empDiv = document.createElement('div');
        empDiv.className = 'employee-item';
        empDiv.innerHTML = `
            <div class="employee-info">
                <div class="employee-name">${emp.first_name} ${emp.last_name}</div>
                <div class="employee-details">
                    ID: ${emp.emp_id} | 
                    ${emp.department_name || 'N/A'} | 
                    ${emp.designation_name || 'N/A'}
                </div>
            </div>
            <button type="button" class="btn btn-primary btn-sm" onclick="loadEmployeeData(${emp.emp_id})">
                <i class="fas fa-edit"></i> Edit
            </button>
        `;
        employeeList.appendChild(empDiv);
    });

    searchResultsSection.style.display = 'block';
}

function clearSearch() {
    baseContainer.querySelector('#searchId').value = '';
    baseContainer.querySelector('#searchName').value = '';
    closeSearchResults();
    clearStatus();
}

function closeSearchResults() {
    baseContainer.querySelector('#searchResultsSection').style.display = 'none';
}

// Load employee data for editing
async function loadEmployeeData(empId) {
    try {
        showLoading(true);
        const response = await fetch(`/ords/hr/employees/${empId}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            const employee = await response.json();
            populateForm(employee);
            closeSearchResults();
            showApiStatus('Employee data loaded successfully', 'success');
            showStatus('Employee data loaded for editing', 'success');
            
            // Show delete button for existing employees
            baseContainer.querySelector('#deleteEmployee').style.display = 'inline-block';
        } else {
            throw new Error(`HTTP ${response.status}: ${response.statusText}`);
        }
    } catch (error) {
        console.error('Error loading employee:', error);
        showApiStatus('Failed to load employee: ' + error.message, 'error');
        showStatus('Failed to load employee data', 'error');
    } finally {
        showLoading(false);
    }
}

function populateForm(employee) {
    // Personal Details
    baseContainer.querySelector('#empId').value = employee.emp_id || '';
    baseContainer.querySelector('#firstName').value = employee.first_name || '';
    baseContainer.querySelector('#lastName').value = employee.last_name || '';
    baseContainer.querySelector('#email').value = employee.email || '';
    baseContainer.querySelector('#nid').value = employee.nid || '';
    baseContainer.querySelector('#phone').value = employee.phone || '';
    baseContainer.querySelector('#mobile').value = employee.mobile || '';
    baseContainer.querySelector('#dob').value = employee.dob || '';
    baseContainer.querySelector('#gender').value = employee.gender || '';
    baseContainer.querySelector('#bloodGroup').value = employee.blood_group || '';
    baseContainer.querySelector('#religion').value = employee.religion || '';
    
    // Set marital status radio button
    if (employee.marital_status) {
        const maritalRadio = baseContainer.querySelector(`input[name="maritalStatus"][value="${employee.marital_status}"]`);
        if (maritalRadio) maritalRadio.checked = true;
    }
    
    baseContainer.querySelector('#emergencyContactName').value = employee.emergency_contact_name || '';
    baseContainer.querySelector('#emergencyContactPhone').value = employee.emergency_contact_phone || '';
    baseContainer.querySelector('#presentAddress').value = employee.present_address || '';
    baseContainer.querySelector('#permanentAddress').value = employee.permanent_address || '';

    // Employment Details
    baseContainer.querySelector('#department').value = employee.department_id || '';
    baseContainer.querySelector('#designation').value = employee.designation_id || '';
    baseContainer.querySelector('#joinDate').value = employee.join_date || '';
    baseContainer.querySelector('#salary').value = employee.salary || '';
    baseContainer.querySelector('#empCode').value = employee.emp_code || '';

    // Load department-specific designations
    if (employee.department_id) {
        loadDesignationsByDepartment(employee.department_id);
    }

    // Skills
    if (employee.skills) {
        try {
            employeeSkills = JSON.parse(employee.skills);
            updateSkillsDisplay();
            updateSkillsHiddenField();
        } catch (e) {
            console.error('Error parsing skills:', e);
            employeeSkills = [];
        }
    }

    // Education and Experience would be loaded via separate API calls
    if (employee.emp_id) {
        loadEducationData(employee.emp_id);
        loadExperienceData(employee.emp_id);
    }
}

// Form submission
async function handleFormSubmit(e) {
    e.preventDefault();
    
    if (!validateForm()) {
        showStatus('Please fix the validation errors before submitting', 'error');
        return;
    }

    const formData = collectFormData();
    const empId = baseContainer.querySelector('#empId').value;

    try {
        showLoading(true);
        
        if (empId) {
            // Update existing employee
            await updateEmployee(empId, formData);
        } else {
            // Create new employee
            await createEmployee(formData);
        }
    } catch (error) {
        console.error('Form submission error:', error);
        showStatus('Failed to save employee data', 'error');
    } finally {
        showLoading(false);
    }
}

async function createEmployee(formData) {
    const response = await fetch('/ords/hr/employees/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
    });

    if (response.ok) {
        const result = await response.json();
        showApiStatus('Employee created successfully', 'success');
        showStatus('Employee created successfully!', 'success');
        
        // Update form with new employee ID
        baseContainer.querySelector('#empId').value = result.emp_id;
        baseContainer.querySelector('#deleteEmployee').style.display = 'inline-block';
    } else {
        const error = await response.text();
        throw new Error(`Failed to create employee: ${error}`);
    }
}

async function updateEmployee(empId, formData) {
    const response = await fetch(`/ords/hr/employees/${empId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
    });

    if (response.ok) {
        showApiStatus('Employee updated successfully', 'success');
        showStatus('Employee updated successfully!', 'success');
    } else {
        const error = await response.text();
        throw new Error(`Failed to update employee: ${error}`);
    }
}

async function deleteEmployee() {
    const empId = baseContainer.querySelector('#empId').value;
    
    if (!empId) {
        showStatus('No employee selected for deletion', 'error');
        return;
    }

    if (!confirm('Are you sure you want to delete this employee? This action cannot be undone.')) {
        return;
    }

    try {
        showLoading(true);
        const response = await fetch(`/ords/hr/employees/${empId}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            showApiStatus('Employee deleted successfully', 'success');
            showStatus('Employee deleted successfully!', 'success');
            resetForm();
        } else {
            const error = await response.text();
            throw new Error(`Failed to delete employee: ${error}`);
        }
    } catch (error) {
        console.error('Delete error:', error);
        showApiStatus('Failed to delete employee: ' + error.message, 'error');
        showStatus('Failed to delete employee', 'error');
    } finally {
        showLoading(false);
    }
}

function collectFormData() {
    const formData = {
        first_name: baseContainer.querySelector('#firstName').value,
        last_name: baseContainer.querySelector('#lastName').value,
        email: baseContainer.querySelector('#email').value,
        nid: baseContainer.querySelector('#nid').value,
        phone: baseContainer.querySelector('#phone').value,
        mobile: baseContainer.querySelector('#mobile').value,
        dob: baseContainer.querySelector('#dob').value,
        gender: baseContainer.querySelector('#gender').value,
        blood_group: baseContainer.querySelector('#bloodGroup').value,
        religion: baseContainer.querySelector('#religion').value,
        marital_status: baseContainer.querySelector('input[name="maritalStatus"]:checked')?.value || '',
        emergency_contact_name: baseContainer.querySelector('#emergencyContactName').value,
        emergency_contact_phone: baseContainer.querySelector('#emergencyContactPhone').value,
        present_address: baseContainer.querySelector('#presentAddress').value,
        permanent_address: baseContainer.querySelector('#permanentAddress').value,
        department_id: baseContainer.querySelector('#department').value,
        designation_id: baseContainer.querySelector('#designation').value,
        join_date: baseContainer.querySelector('#joinDate').value,
        salary: baseContainer.querySelector('#salary').value,
        emp_code: baseContainer.querySelector('#empCode').value,
        skills: JSON.stringify(employeeSkills)
    };

    // Collect education data
    const educationRows = baseContainer.querySelectorAll('#educationRows .dynamic-row');
    const education = [];
    educationRows.forEach(row => {
        const edu = {
            degree_type: row.querySelector('[name="degreeType"]').value,
            degree_title: row.querySelector('[name="degreeTitle"]').value,
            institution_name: row.querySelector('[name="institutionName"]').value,
            passing_year: row.querySelector('[name="passingYear"]').value,
            duration: row.querySelector('[name="duration"]').value,
            result_type: row.querySelector('[name="resultType"]').value,
            result_value: row.querySelector('[name="resultValue"]').value,
            major_subject: row.querySelector('[name="majorSubject"]').value,
            is_current: row.querySelector('[name="isCurrent"]').checked ? 'Y' : 'N'
        };
        education.push(edu);
    });
    formData.education = education;

    // Collect experience data
    const experienceRows = baseContainer.querySelectorAll('#experienceRows .dynamic-row');
    const experience = [];
    experienceRows.forEach(row => {
        const exp = {
            company_name: row.querySelector('[name="companyName"]').value,
            position: row.querySelector('[name="position"]').value,
            start_date: row.querySelector('[name="startDate"]').value,
            end_date: row.querySelector('[name="endDate"]').value,
            salary: row.querySelector('[name="expSalary"]').value,
            responsibilities: row.querySelector('[name="responsibilities"]').value,
            is_current_job: row.querySelector('[name="isCurrentJob"]').checked ? 'Y' : 'N'
        };
        experience.push(exp);
    });
    formData.experience = experience;

    return formData;
}

// Validation Functions
function validateForm() {
    let isValid = true;
    
    // Clear all previous errors
    baseContainer.querySelectorAll('.error').forEach(error => {
        error.style.display = 'none';
    });
    baseContainer.querySelectorAll('.form-control').forEach(control => {
        control.classList.remove('error-field');
    });

    // Validate required fields
    const requiredFields = [
        { id: 'firstName', errorId: 'firstNameError', message: 'Please enter a valid first name' },
        { id: 'lastName', errorId: 'lastNameError', message: 'Please enter a valid last name' },
        { id: 'email', errorId: 'emailError', message: 'Please enter a valid email address' },
        { id: 'nid', errorId: 'nidError', message: 'NID must be 10, 13, or 17 digits' },
        { id: 'mobile', errorId: 'mobileError', message: 'Please enter a valid mobile number' },
        { id: 'gender', errorId: 'genderError', message: 'Please select a gender' },
        { id: 'department', errorId: 'departmentError', message: 'Please select a department' },
        { id: 'designation', errorId: 'designationError', message: 'Please select a designation' }
    ];

    requiredFields.forEach(field => {
        const element = baseContainer.querySelector(`#${field.id}`);
        const errorElement = baseContainer.querySelector(`#${field.errorId}`);
        
        if (!element.value.trim()) {
            showFieldError(element, errorElement, field.message);
            isValid = false;
        }
    });

    // Validate email format
    const email = baseContainer.querySelector('#email').value;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (email && !emailRegex.test(email)) {
        showFieldError(
            baseContainer.querySelector('#email'), 
            baseContainer.querySelector('#emailError'), 
            'Please enter a valid email address'
        );
        isValid = false;
    }

    // Validate NID format
    const nid = baseContainer.querySelector('#nid').value;
    const nidRegex = /^(\d{10}|\d{13}|\d{17})$/;
    if (nid && !nidRegex.test(nid)) {
        showFieldError(
            baseContainer.querySelector('#nid'), 
            baseContainer.querySelector('#nidError'), 
            'NID must be 10, 13, or 17 digits'
        );
        isValid = false;
    }

    // Validate mobile number
    const mobile = baseContainer.querySelector('#mobile').value;
    const mobileRegex = /^(\+88)?01[3-9]\d{8}$/;
    if (mobile && !mobileRegex.test(mobile)) {
        showFieldError(
            baseContainer.querySelector('#mobile'), 
            baseContainer.querySelector('#mobileError'), 
            'Please enter a valid mobile number'
        );
        isValid = false;
    }

    return isValid;
}

function showFieldError(element, errorElement, message) {
    element.classList.add('error-field');
    errorElement.textContent = message;
    errorElement.style.display = 'block';
}

// Education and Experience data loading
async function loadEducationData(empId) {
    try {
        const response = await fetch(`/ords/hr/education/?q={"emp_id":"${empId}"}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            const data = await response.json();
            const educationData = data.items || [];
            
            // Clear existing education rows
            baseContainer.querySelector('#educationRows').innerHTML = '';
            
            // Add education rows
            educationData.forEach(edu => {
                addEducationRow(edu);
            });
        }
    } catch (error) {
        console.error('Error loading education data:', error);
    }
}

async function loadExperienceData(empId) {
    try {
        const response = await fetch(`/ords/hr/experience/?q={"emp_id":"${empId}"}`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            const data = await response.json();
            const experienceData = data.items || [];
            
            // Clear existing experience rows
            baseContainer.querySelector('#experienceRows').innerHTML = '';
            
            // Add experience rows
            experienceData.forEach(exp => {
                addExperienceRow(exp);
            });
        }
    } catch (error) {
        console.error('Error loading experience data:', error);
    }
}

function addEducationRow(data = {}) {
    const educationRowCount = Date.now(); // Use timestamp for unique ID
    const newRow = document.createElement('div');
    newRow.className = 'dynamic-row';
    newRow.setAttribute('data-id', educationRowCount);
    newRow.innerHTML = `
        <span class="remove-row" onclick="removeEducationRow(${educationRowCount})"><i class="fas fa-times-circle"></i></span>
        
        <div class="ui-row">
            <div class="ui-col ui-col-4">
                <div class="form-group">
                    <label>Degree Type *</label>
                    <select name="degreeType" class="form-control" required>
                        <option value="">Select Type</option>
                        <option value="SSC" ${data.degree_type === 'SSC' ? 'selected' : ''}>SSC</option>
                        <option value="HSC" ${data.degree_type === 'HSC' ? 'selected' : ''}>HSC</option>
                        <option value="Bachelor" ${data.degree_type === 'Bachelor' ? 'selected' : ''}>Bachelor</option>
                        <option value="Master" ${data.degree_type === 'Master' ? 'selected' : ''}>Master</option>
                        <option value="PhD" ${data.degree_type === 'PhD' ? 'selected' : ''}>PhD</option>
                        <option value="Diploma" ${data.degree_type === 'Diploma' ? 'selected' : ''}>Diploma</option>
                    </select>
                </div>
            </div>
            <div class="ui-col ui-col-8">
                <div class="form-group">
                    <label>Degree Title *</label>
                    <input type="text" name="degreeTitle" class="form-control" value="${data.degree_title || ''}" required>
                </div>
            </div>
        </div>
        
        <div class="ui-row">
            <div class="ui-col ui-col-6">
                <div class="form-group">
                    <label>Institution Name *</label>
                    <input type="text" name="institutionName" class="form-control" value="${data.institution_name || ''}" required>
                </div>
            </div>
            <div class="ui-col ui-col-3">
                <div class="form-group">
                    <label>Passing Year *</label>
                    <input type="number" name="passingYear" class="form-control" min="1950" max="2030" value="${data.passing_year || ''}" required>
                </div>
            </div>
            <div class="ui-col ui-col-3">
                <div class="form-group">
                    <label>Duration (Years)</label>
                    <input type="number" name="duration" class="form-control" min="1" max="10" value="${data.duration || ''}">
                </div>
            </div>
        </div>
        
        <div class="ui-row">
            <div class="ui-col ui-col-4">
                <div class="form-group">
                    <label>Result Type</label>
                    <select name="resultType" class="form-control">
                        <option value="">Select Type</option>
                        <option value="GPA" ${data.result_type === 'GPA' ? 'selected' : ''}>GPA</option>
                        <option value="CGPA" ${data.result_type === 'CGPA' ? 'selected' : ''}>CGPA</option>
                        <option value="Division" ${data.result_type === 'Division' ? 'selected' : ''}>Division</option>
                        <option value="Grade" ${data.result_type === 'Grade' ? 'selected' : ''}>Grade</option>
                        <option value="Percentage" ${data.result_type === 'Percentage' ? 'selected' : ''}>Percentage</option>
                    </select>
                </div>
            </div>
            <div class="ui-col ui-col-4">
                <div class="form-group">
                    <label>Result Value</label>
                    <input type="text" name="resultValue" class="form-control" value="${data.result_value || ''}">
                </div>
            </div>
            <div class="ui-col ui-col-4">
                <div class="form-group">
                    <label>Major Subject</label>
                    <input type="text" name="majorSubject" class="form-control" value="${data.major_subject || ''}">
                </div>
            </div>
        </div>
        
        <div class="form-group">
            <label class="checkbox-group">
                <input type="checkbox" name="isCurrent" value="Y" ${data.is_current === 'Y' ? 'checked' : ''}> This is my current education
            </label>
        </div>
    `;
    
    baseContainer.querySelector('#educationRows').appendChild(newRow);
}

function addExperienceRow(data = {}) {
    const experienceRowCount = Date.now(); // Use timestamp for unique ID
    const newRow = document.createElement('div');
    newRow.className = 'dynamic-row';
    newRow.setAttribute('data-id', experienceRowCount);
    newRow.innerHTML = `
        <span class="remove-row" onclick="removeExperienceRow(${experienceRowCount})"><i class="fas fa-times-circle"></i></span>
        
        <div class="ui-row">
            <div class="ui-col ui-col-6">
                <div class="form-group">
                    <label>Company Name *</label>
                    <input type="text" name="companyName" class="form-control" value="${data.company_name || ''}" required>
                </div>
            </div>
            <div class="ui-col ui-col-6">
                <div class="form-group">
                    <label>Position *</label>
                    <input type="text" name="position" class="form-control" value="${data.position || ''}" required>
                </div>
            </div>
        </div>
        
        <div class="ui-row">
            <div class="ui-col ui-col-4">
                <div class="form-group">
                    <label>Start Date</label>
                    <input type="date" name="startDate" class="form-control" value="${data.start_date || ''}">
                </div>
            </div>
            <div class="ui-col ui-col-4">
                <div class="form-group">
                    <label>End Date</label>
                    <input type="date" name="endDate" class="form-control" value="${data.end_date || ''}">
                </div>
            </div>
            <div class="ui-col ui-col-4">
                <div class="form-group">
                    <label>Salary</label>
                    <input type="number" name="expSalary" class="form-control" step="0.01" value="${data.salary || ''}">
                </div>
            </div>
        </div>
        
        <div class="form-group">
            <label>Responsibilities</label>
            <textarea name="responsibilities" class="form-control" rows="3">${data.responsibilities || ''}</textarea>
        </div>
        
        <div class="form-group">
            <label class="checkbox-group">
                <input type="checkbox" name="isCurrentJob" value="Y" ${data.is_current_job === 'Y' ? 'checked' : ''}> This is my current job
            </label>
        </div>
    `;
    
    baseContainer.querySelector('#experienceRows').appendChild(newRow);
}

// Utility Functions
function resetForm() {
    baseContainer.querySelector('#employeeForm').reset();
    baseContainer.querySelector('#empId').value = '';
    employeeSkills = [];
    updateSkillsDisplay();
    updateSkillsHiddenField();
    
    // Clear dynamic rows
    baseContainer.querySelector('#educationRows').innerHTML = '';
    baseContainer.querySelector('#experienceRows').innerHTML = '';
    
    // Hide delete button
    baseContainer.querySelector('#deleteEmployee').style.display = 'none';
    
    // Reset photo preview
    const photoPreview = baseContainer.querySelector('#photoPreview');
    photoPreview.src = '';
    photoPreview.style.display = 'none';
    baseContainer.querySelector('.photo-preview i').style.display = 'block';
    
    // Clear all errors
    baseContainer.querySelectorAll('.error').forEach(error => {
        error.style.display = 'none';
    });
    baseContainer.querySelectorAll('.form-control').forEach(control => {
        control.classList.remove('error-field');
    });
    
    // Switch to first tab
    baseContainer.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    baseContainer.querySelectorAll('.tab-content').forEach(tc => tc.classList.remove('active'));
    baseContainer.querySelector('.tab[data-tab="personal"]').classList.add('active');
    baseContainer.querySelector('#personal-tab').classList.add('active');
    
    clearStatus();
    showStatus('Form reset successfully', 'success');
}

function showLoading(show) {
    const loadingIndicator = baseContainer.querySelector('#loadingIndicator');
    loadingIndicator.style.display = show ? 'flex' : 'none';
}

function showStatus(message, type) {
    const statusMessage = baseContainer.querySelector('#statusMessage');
    statusMessage.textContent = message;
    statusMessage.className = `status-message ${type}`;
    statusMessage.style.display = 'block';
    
    // Auto-hide after 5 seconds for success messages
    if (type === 'success') {
        setTimeout(() => {
            clearStatus();
        }, 5000);
    }
}

function clearStatus() {
    const statusMessage = baseContainer.querySelector('#statusMessage');
    statusMessage.style.display = 'none';
    statusMessage.textContent = '';
    statusMessage.className = 'status-message';
}

function showApiStatus(message, type) {
    const apiStatus = baseContainer.querySelector('#apiStatus');
    apiStatus.textContent = message;
    apiStatus.className = `api-status ${type}`;
    apiStatus.style.display = 'block';
    
    // Auto-hide after 3 seconds
    setTimeout(() => {
        apiStatus.style.display = 'none';
    }, 3000);
}

// Global functions that need to be accessible from HTML onclick handlers
window.removeEducationRow = function(id) {
    const row = baseContainer.querySelector(`[data-id="${id}"]`);
    if (row) {
        row.remove();
    }
};

window.removeExperienceRow = function(id) {
    const row = baseContainer.querySelector(`[data-id="${id}"]`);
    if (row) {
        row.remove();
    }
};

window.removeSkill = function(index) {
    employeeSkills.splice(index, 1);
    updateSkillsDisplay();
    updateSkillsHiddenField();
};

window.loadEmployeeData = function(empId) {
    loadEmployeeData(empId);
};

// Auto-generate employee code based on department and designation
baseContainer.querySelector('#department').addEventListener('change', generateEmployeeCode);
baseContainer.querySelector('#designation').addEventListener('change', generateEmployeeCode);

function generateEmployeeCode() {
    const deptSelect = baseContainer.querySelector('#department');
    const desigSelect = baseContainer.querySelector('#designation');
    const empCodeField = baseContainer.querySelector('#empCode');
    
    if (deptSelect.value && desigSelect.value) {
        const deptName = deptSelect.options[deptSelect.selectedIndex].text;
        const desigName = desigSelect.options[desigSelect.selectedIndex].text;
        
        const deptCode = deptName.substring(0, 3).toUpperCase();
        const desigCode = desigName.substring(0, 3).toUpperCase();
        const timestamp = Date.now().toString().slice(-4);
        
        empCodeField.value = `${deptCode}${desigCode}${timestamp}`;
    }
}

// Enhanced skill input with Enter key support
baseContainer.querySelector('#skillName').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        e.preventDefault();
        addSkill();
    }
});

baseContainer.querySelector('#skillYears').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        e.preventDefault();
        addSkill();
    }
});

// Form auto-save functionality (optional)
let autoSaveTimeout;
function setupAutoSave() {
    const formInputs = baseContainer.querySelectorAll('input, select, textarea');
    formInputs.forEach(input => {
        input.addEventListener('input', function() {
            clearTimeout(autoSaveTimeout);
            autoSaveTimeout = setTimeout(() => {
                // Auto-save logic can be implemented here
                console.log('Auto-saving...');
            }, 2000);
        });
    });
}

// Initialize auto-save if needed
// setupAutoSave(); // Uncomment if you want auto-save functionality

// Form validation on input change
baseContainer.querySelectorAll('.form-control[required]').forEach(field => {
    field.addEventListener('blur', function() {
        validateField(this);
    });
});

function validateField(field) {
    const fieldId = field.id;
    const errorElement = baseContainer.querySelector(`#${fieldId}Error`);
    
    if (errorElement) {
        if (field.value.trim()) {
            field.classList.remove('error-field');
            errorElement.style.display = 'none';
        } else {
            field.classList.add('error-field');
            errorElement.style.display = 'block';
        }
    }
}
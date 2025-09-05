        // Global variables
        let departments = [];
        let designations = [];
        let employeeSkills = [];
        
        document.addEventListener('DOMContentLoaded', function() {
            // Load department and designation lists
            loadDepartments();
            loadDesignations();
            
            // Tab navigation
            const tabs = document.querySelectorAll('.tab');
            const tabContents = document.querySelectorAll('.tab-content');
            
            tabs.forEach(tab => {
                tab.addEventListener('click', () => {
                    const tabId = tab.getAttribute('data-tab');
                    
                    // Deactivate all tabs
                    tabs.forEach(t => t.classList.remove('active'));
                    tabContents.forEach(tc => tc.classList.remove('active'));
                    
                    // Activate current tab
                    tab.classList.add('active');
                    document.getElementById(`${tabId}-tab`).classList.add('active');
                });
            });
            
            // Same as present address checkbox
            document.getElementById('sameAsPresent').addEventListener('change', function() {
                if (this.checked) {
                    document.getElementById('permanentAddress').value = 
                        document.getElementById('presentAddress').value;
                    document.getElementById('permanentAddress').setAttribute('readonly', true);
                } else {
                    document.getElementById('permanentAddress').removeAttribute('readonly');
                }
            });
            
            // Photo upload preview
            document.getElementById('uploadBtn').addEventListener('click', function() {
                document.getElementById('photo').click();
            });
            
            document.getElementById('photo').addEventListener('change', function() {
                const file = this.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const preview = document.getElementById('photoPreview');
                        preview.src = e.target.result;
                        preview.style.display = 'block';
                        document.querySelector('.photo-preview i').style.display = 'none';
                    }
                    reader.readAsDataURL(file);
                }
            });
            
            // Skills management
            document.getElementById('addSkillBtn').addEventListener('click', addSkill);
            
            // Add education row
            let educationRowCount = 0;
            document.getElementById('addEducation').addEventListener('click', function() {
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
                
                document.getElementById('educationRows').appendChild(newRow);
            });
            
            // Add experience row
            let experienceRowCount = 0;
            document.getElementById('addExperience').addEventListener('click', function() {
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
                                <label>Designation *</label>
                                <input type="text" name="designation" class="form-control" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="ui-row">
                        <div class="ui-col ui-col-6">
                            <div class="form-group">
                                <label>Department</label>
                                <input type="text" name="department" class="form-control">
                            </div>
                        </div>
                        <div class="ui-col ui-col-6">
                            <div class="form-group">
                                <label>Employment Type</label>
                                <select name="employmentType" class="form-control">
                                    <option value="">Select Type</option>
                                    <option value="Full-time">Full-time</option>
                                    <option value="Part-time">Part-time</option>
                                    <option value="Contract">Contract</option>
                                    <option value="Internship">Internship</option>
                                    <option value="Remote">Remote</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="ui-row">
                        <div class="ui-col ui-col-4">
                            <div class="form-group">
                                <label>Start Date *</label>
                                <input type="date" name="startDate" class="form-control" required>
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
                                <label>Location</label>
                                <input type="text" name="location" class="form-control">
                            </div>
                        </div>
                    </div>
                    
                    <div class="ui-row">
                        <div class="ui-col ui-col-6">
                            <div class="form-group">
                                <label>Salary Range</label>
                                <input type="text" name="salaryRange" class="form-control" placeholder="e.g., 50000-70000">
                            </div>
                        </div>
                        <div class="ui-col ui-col-6">
                            <div class="form-group">
                                <label>Supervisor Name</label>
                                <input type="text" name="supervisorName" class="form-control">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Job Responsibilities</label>
                        <textarea name="jobResponsibilities" class="form-control" rows="3"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label>Reason for Leaving</label>
                        <input type="text" name="reasonForLeaving" class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox-group">
                            <input type="checkbox" name="isCurrent" value="Y"> I currently work here
                        </label>
                    </div>
                `;
                
                document.getElementById('experienceRows').appendChild(newRow);
            });
            
            // Form validation and submission
            document.getElementById('employeeForm').addEventListener('submit', function(e) {
                e.preventDefault();
                
                if (validateForm()) {
                    const formData = collectFormData();
                    submitEmployeeData(formData);
                }
            });
            
            // Reset form
            document.getElementById('resetForm').addEventListener('click', function() {
                if (confirm('Are you sure you want to reset the form? All unsaved data will be lost.')) {
                    resetForm();
                }
            });
            
            // Delete employee
            document.getElementById('deleteEmployee').addEventListener('click', function() {
                const empId = document.getElementById('empId').value;
                if (empId && confirm('Are you sure you want to delete this employee? This action cannot be undone.')) {
                    deleteEmployeeData(empId);
                }
            });
            
            // Search functionality
            document.getElementById('searchBtn').addEventListener('click', function() {
                const id = document.getElementById('searchId').value;
                const name = document.getElementById('searchName').value;
                
                if (id || name) {
                    searchEmployees(id, name);
                } else {
                    showFloatingNotification('Please enter an ID or name to search', 'warning', 'Search Required');
                }
            });
            
            // Clear search functionality
            document.getElementById('clearSearchBtn').addEventListener('click', function() {
                clearSearchData();
            });
            
            // Close search results
            document.getElementById('closeResultsBtn').addEventListener('click', function() {
                document.getElementById('searchResultsSection').style.display = 'none';
            });
            
            // Generate employee code based on name
            document.getElementById('firstName').addEventListener('blur', generateEmployeeCode);
            document.getElementById('lastName').addEventListener('blur', generateEmployeeCode);
            
            // Add at least one education and experience row on page load
            document.getElementById('addEducation').click();
            document.getElementById('addExperience').click();
        });
        
        // Skills management functions
        function addSkill() {
            const skillName = document.getElementById('skillName').value.trim();
            const skillLevel = document.getElementById('skillLevel').value;
            const skillYears = document.getElementById('skillYears').value;
            
            if (!skillName) {
                showFloatingNotification('Please enter a skill name', 'warning', 'Skill Required');
                return;
            }
            
            // Check if skill already exists
            if (employeeSkills.some(skill => skill.name.toLowerCase() === skillName.toLowerCase())) {
                showFloatingNotification('This skill already exists', 'warning', 'Duplicate Skill');
                return;
            }
            
            const skill = {
                name: skillName,
                level: skillLevel || 'Beginner',
                years: parseInt(skillYears) || 0
            };
            
            employeeSkills.push(skill);
            updateSkillsDisplay();
            updateSkillsHiddenField();
            
            // Clear inputs
            document.getElementById('skillName').value = '';
            document.getElementById('skillLevel').value = '';
            document.getElementById('skillYears').value = '';
            
            showFloatingNotification(`Skill "${skillName}" added successfully`, 'success', 'Skill Added');
        }
        
        function removeSkill(index) {
            const removedSkill = employeeSkills.splice(index, 1)[0];
            updateSkillsDisplay();
            updateSkillsHiddenField();
            showFloatingNotification(`Skill "${removedSkill.name}" removed`, 'success', 'Skill Removed');
        }
        
        function updateSkillsDisplay() {
            const display = document.getElementById('skillsDisplay');
            display.innerHTML = '';
            
            employeeSkills.forEach((skill, index) => {
                const skillTag = document.createElement('div');
                skillTag.className = 'skill-tag';
                skillTag.innerHTML = `
                    <span>${skill.name} (${skill.level}${skill.years > 0 ? `, ${skill.years} years` : ''})</span>
                    <span class="remove-skill" onclick="removeSkill(${index})">
                        <i class="fas fa-times"></i>
                    </span>
                `;
                display.appendChild(skillTag);
            });
        }
        
        function updateSkillsHiddenField() {
            document.getElementById('skills').value = JSON.stringify(employeeSkills);
        }
        
        // Floating notification function
        function showFloatingNotification(message, type = 'success', title = '') {
            // Remove any existing notification
            const existingNotification = document.querySelector('.floating-notification');
            if (existingNotification) {
                existingNotification.remove();
            }
            
            const notification = document.createElement('div');
            notification.className = `floating-notification ${type}`;
            
            let icon = 'fas fa-check-circle';
            if (type === 'error') icon = 'fas fa-exclamation-circle';
            else if (type === 'warning') icon = 'fas fa-exclamation-triangle';
            
            notification.innerHTML = `
                <div class="icon">
                    <i class="${icon}"></i>
                </div>
                <div class="content">
                    ${title ? `<div class="title">${title}</div>` : ''}
                    <div class="message">${message}</div>
                </div>
            `;
            
            document.body.appendChild(notification);
            
            // Show notification
            setTimeout(() => {
                notification.classList.add('show');
            }, 100);
            
            // Auto-hide after 4 seconds
            setTimeout(() => {
                notification.classList.remove('show');
                setTimeout(() => {
                    if (notification.parentNode) {
                        notification.parentNode.removeChild(notification);
                    }
                }, 300);
            }, 4000);
        }
        
        // Delete employee function
        function deleteEmployeeData(empId) {
            // Show loading indicator
            document.getElementById('loadingIndicator').style.display = 'block';
            
            fetch(`https://mesbahuddin.com/web/unorg/pg1_emp_man/data?id=${empId}`, {
                method: 'DELETE'
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                // Hide loading indicator
                document.getElementById('loadingIndicator').style.display = 'none';
                
                if (data.status === 'success') {
                    showFloatingNotification(
                        `Employee deleted successfully! Employee ID: ${data.emp_id}`, 
                        'success', 
                        'Employee Deleted'
                    );
                    
                    // Reset form after successful deletion
                    resetForm(false);
                    clearSearchData();
                } else {
                    showFloatingNotification(
                        data.message || 'Failed to delete employee', 
                        'error', 
                        'Delete Failed'
                    );
                }
            })
            .catch(error => {
                // Hide loading indicator
                document.getElementById('loadingIndicator').style.display = 'none';
                
                showFloatingNotification(
                    'Error deleting employee: ' + error.message, 
                    'error', 
                    'Delete Error'
                );
                console.error('Error deleting employee:', error);
            });
        }
        
        // Clear search data and reset search panel
        function clearSearchData() {
            document.getElementById('searchId').value = '';
            document.getElementById('searchName').value = '';
            document.getElementById('apiStatus').style.display = 'none';
            document.getElementById('searchResultsSection').style.display = 'none';
            document.getElementById('employeeList').innerHTML = '';
            showFloatingNotification('Search cleared successfully', 'success', 'Search Cleared');
        }
        
        // Load departments from API with correct endpoint
        function loadDepartments() {
            fetch('https://mesbahuddin.com/web/unorg/pg1_emp_man/list_dept')
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.status === 'success' && data.data) {
                        departments = data.data;
                        const departmentSelect = document.getElementById('department');
                        
                        // Clear existing options except the first one
                        while (departmentSelect.options.length > 1) {
                            departmentSelect.remove(1);
                        }
                        
                        // Add departments to dropdown
                        departments.forEach(dept => {
                            const option = document.createElement('option');
                            option.value = dept.dept_id;
                            option.textContent = dept.dept_name;
                            departmentSelect.appendChild(option);
                        });
                        console.log('Departments loaded successfully:', departments.length);
                    } else {
                        console.error('Failed to load departments:', data.message);
                        showFloatingNotification('Failed to load departments', 'error', 'Loading Error');
                    }
                })
                .catch(error => {
                    console.error('Error loading departments:', error);
                    showFloatingNotification('Error loading departments', 'error', 'Loading Error');
                });
        }
        
        // Load designations from API with correct endpoint
        function loadDesignations() {
            fetch('https://mesbahuddin.com/web/unorg/pg1_emp_man/list_des')
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.status === 'success' && data.data) {
                        designations = data.data;
                        const designationSelect = document.getElementById('designation');
                        
                        // Clear existing options except the first one
                        while (designationSelect.options.length > 1) {
                            designationSelect.remove(1);
                        }
                        
                        // Add designations to dropdown
                        designations.forEach(desig => {
                            const option = document.createElement('option');
                            option.value = desig.desig_id;
                            option.textContent = desig.desig_name;
                            designationSelect.appendChild(option);
                        });
                        console.log('Designations loaded successfully:', designations.length);
                    } else {
                        console.error('Failed to load designations:', data.message);
                        showFloatingNotification('Failed to load designations', 'error', 'Loading Error');
                    }
                })
                .catch(error => {
                    console.error('Error loading designations:', error);
                    showFloatingNotification('Error loading designations', 'error', 'Loading Error');
                });
        }
        
        function generateEmployeeCode() {
            const firstName = document.getElementById('firstName').value;
            const lastName = document.getElementById('lastName').value;
            
            if (firstName && lastName) {
                const code = `${firstName.charAt(0)}${lastName.charAt(0)}${Math.floor(1000 + Math.random() * 9000)}`;
                document.getElementById('empCode').value = code.toUpperCase();
            }
        }
        
        function showError(inputElement, errorElementId) {
            inputElement.classList.add('error-field');
            document.getElementById(errorElementId).style.display = 'block';
        }
        
        function hideError(inputElement, errorElementId) {
            inputElement.classList.remove('error-field');
            document.getElementById(errorElementId).style.display = 'none';
        }
        
        // Auto-hide errors when user starts typing
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('input', function() {
                this.classList.remove('error-field');
                const errorId = this.id + 'Error';
                if (document.getElementById(errorId)) {
                    document.getElementById(errorId).style.display = 'none';
                }
            });
        });
        
        // Form validation function
        function validateForm(isDraft = false) {
            let isValid = true;
            
            // Validate required fields
            const requiredFields = [
                'firstName', 'lastName', 'email', 'nid', 'mobile', 
                'gender', 'department', 'designation'
            ];
            
            requiredFields.forEach(field => {
                const element = document.getElementById(field);
                if (!element.value.trim()) {
                    showError(element, `${field}Error`);
                    isValid = false;
                } else {
                    hideError(element, `${field}Error`);
                }
            });
            
            // For drafts, skip some validations
            if (isDraft) {
                return isValid;
            }
            
            // Validate email format
            const email = document.getElementById('email');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (email.value && !emailRegex.test(email.value)) {
                showError(email, 'emailError');
                document.getElementById('emailError').textContent = 'Please enter a valid email address';
                isValid = false;
            }
            
            // Validate NID format (10, 13, or 17 digits)
            const nid = document.getElementById('nid');
            const nidRegex = /^\d{10}$|^\d{13}$|^\d{17}$/;
            if (nid.value && !nidRegex.test(nid.value)) {
                showError(nid, 'nidError');
                isValid = false;
            }
            
            return isValid;
        }
        
        // Collect all form data into a structured object matching API payload
        function collectFormData() {
            let maritalStatus = '';
            document.querySelectorAll('input[name="maritalStatus"]').forEach(radio => {
                if (radio.checked) {
                    maritalStatus = radio.value;
                }
            });

            const educationData = [];
            document.querySelectorAll('#educationRows .dynamic-row').forEach(row => {
                const eduData = {
                    degree_type: row.querySelector('select[name="degreeType"]').value,
                    degree_title: row.querySelector('input[name="degreeTitle"]').value,
                    institution_name: row.querySelector('input[name="institutionName"]').value,
                    passing_year: parseInt(row.querySelector('input[name="passingYear"]').value) || null,
                    result_type: row.querySelector('select[name="resultType"]').value,
                    result_value: row.querySelector('input[name="resultValue"]').value,
                    duration_years: parseInt(row.querySelector('input[name="duration"]').value) || null,
                    major_subject: row.querySelector('input[name="majorSubject"]').value,
                    is_current: row.querySelector('input[name="isCurrent"]')?.checked ? 'Y' : 'N'
                };
                if (eduData.degree_type && eduData.degree_title) {
                    educationData.push(eduData);
                }
            });

            const experienceData = [];
            document.querySelectorAll('#experienceRows .dynamic-row').forEach(row => {
                const expData = {
                    company_name: row.querySelector('input[name="companyName"]').value,
                    designation: row.querySelector('input[name="designation"]').value,
                    department: row.querySelector('input[name="department"]').value,
                    employment_type: row.querySelector('select[name="employmentType"]').value,
                    start_date: row.querySelector('input[name="startDate"]').value,
                    end_date: row.querySelector('input[name="endDate"]').value,
                    location: row.querySelector('input[name="location"]').value,
                    salary_range: row.querySelector('input[name="salaryRange"]').value,
                    supervisor_name: row.querySelector('input[name="supervisorName"]').value,
                    job_responsibilities: row.querySelector('textarea[name="jobResponsibilities"]').value,
                    reason_for_leaving: row.querySelector('input[name="reasonForLeaving"]').value,
                    is_current: row.querySelector('input[name="isCurrent"]')?.checked ? 'Y' : 'N'
                };
                if (expData.company_name && expData.designation) {
                    experienceData.push(expData);
                }
            });

            let skillsData = employeeSkills.length > 0 ? employeeSkills : [];

            return {
                emp_id: document.getElementById('empId').value || null,
                first_name: document.getElementById('firstName').value,
                last_name: document.getElementById('lastName').value,
                email: document.getElementById('email').value,
                phone: document.getElementById('phone').value,
                mobile: document.getElementById('mobile').value,
                nid: document.getElementById('nid').value,
                date_of_birth: document.getElementById('dob').value || null,
                gender: document.getElementById('gender').value,
                blood_group: document.getElementById('bloodGroup').value,
                religion: document.getElementById('religion').value,
                department_id: parseInt(document.getElementById('department').value) || null,
                designation_id: parseInt(document.getElementById('designation').value) || null,
                join_date: document.getElementById('joinDate').value || null,
                salary: parseFloat(document.getElementById('salary').value) || null,
                address_present: document.getElementById('presentAddress').value,
                address_permanent: document.getElementById('permanentAddress').value,
                emergency_contact_name: document.getElementById('emergencyContactName').value,
                emergency_contact_phone: document.getElementById('emergencyContactPhone').value,
                marital_status: maritalStatus,
                skills: skillsData,
                education: educationData,
                experience: experienceData
            };
        }
        
        // AJAX callback function for APEX integration
        function submitEmployeeData(formData) {
            // Show loading indicator
            document.getElementById('loadingIndicator').style.display = 'block';
            
            const isUpdate = formData.emp_id && formData.emp_id !== '';
            
            // Check if running in APEX environment
            if (typeof apex !== 'undefined' && apex.server) {
                // Running in APEX environment - use APEX callback
                apex.server.process(
                    "PG1_SAVE_EMPLOYEE",
                    {
                        x01: JSON.stringify(formData)
                    },
                    {
                        success: function(pData) {
                            handleSaveResponse(pData, 'apex', isUpdate);
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            handleSaveError(textStatus + ': ' + errorThrown, 'apex');
                        }
                    }
                );
            } else {
                // Running in standalone HTML - use fetch API
                fetch('https://mesbahuddin.com/web/unorg/pg1_emp_man/data', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(formData)
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    handleSaveResponse(data, 'api', isUpdate);
                })
                .catch(error => {
                    handleSaveError(error.message, 'api');
                });
            }
        }
        
        // Handle save response (unified for both APEX and API)
        function handleSaveResponse(data, source, isUpdate) {
            // Hide loading indicator
            document.getElementById('loadingIndicator').style.display = 'none';
            
            try {
                // Parse response if it's a string (from APEX)
                const response = typeof data === 'string' ? JSON.parse(data) : data;
                
                if (response.status === 'success') {
                    const operation = isUpdate ? 'updated' : 'created';
                    const title = isUpdate ? 'Employee Updated' : 'Employee Created';
                    
                    showFloatingNotification(
                        `Employee ${operation} successfully! Employee ID: ${response.emp_id}`, 
                        'success',
                        title
                    );
                    
                    // If this was a new employee, set the returned employee ID and show delete button
                    if (!isUpdate && response.emp_id) {
                        document.getElementById('empId').value = response.emp_id;
                        document.getElementById('deleteEmployee').style.display = 'inline-flex';
                    }
                    
                    // If this was a new insert, clear the form after showing success message
                    if (!isUpdate) {
                        setTimeout(() => {
                            resetForm(false);
                        }, 2000);
                    }
                    
                    // Clear search results if visible
                    clearSearchData();
                    markFormClean();
                } else {
                    showFloatingNotification(
                        response.message || 'Unknown error occurred', 
                        'error',
                        'Save Failed'
                    );
                }
            } catch (error) {
                showFloatingNotification(
                    'Error processing response: ' + error.message, 
                    'error',
                    'Response Error'
                );
            }
        }
        
        // Handle save error (unified for both APEX and API)
        function handleSaveError(errorMessage, source) {
            // Hide loading indicator
            document.getElementById('loadingIndicator').style.display = 'none';
            
            showFloatingNotification(
                `Error saving data: ${errorMessage}`, 
                'error',
                'Save Error'
            );
            console.error(`Save error (${source}):`, errorMessage);
        }
        
        // Search employees via API with correct structure
        function searchEmployees(id, name) {
            // Show loading indicator
            document.getElementById('loadingIndicator').style.display = 'block';
            document.getElementById('apiStatus').textContent = 'Searching employees...';
            document.getElementById('apiStatus').style.display = 'block';
            document.getElementById('apiStatus').style.backgroundColor = '#fff3cd';
            document.getElementById('apiStatus').style.color = '#856404';
            
            // Build URL with query parameters
            let url = 'https://mesbahuddin.com/web/unorg/pg1_emp_man/data';
            const params = new URLSearchParams();
            
            if (id) params.append('id', id);
            if (name) params.append('emp_name', name);
            
            if (params.toString()) {
                url += '?' + params.toString();
            }
            
            // Make API call
            fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                // Hide loading indicator
                document.getElementById('loadingIndicator').style.display = 'none';
                
                if (data.status === 'success' && data.data && data.data.length > 0) {
                    displayEmployeeResults(data.data);
                    document.getElementById('apiStatus').textContent = `Found ${data.data.length} employee(s)`;
                    document.getElementById('apiStatus').style.backgroundColor = '#d4edda';
                    document.getElementById('apiStatus').style.color = '#155724';
                    document.getElementById('searchResultsSection').style.display = 'block';
                    
                    showFloatingNotification(
                        `Found ${data.data.length} employee(s) matching your search`, 
                        'success',
                        'Search Results'
                    );
                } else {
                    document.getElementById('employeeList').innerHTML = '<p style="text-align: center; padding: 20px; color: #666;">No employees found matching your criteria.</p>';
                    document.getElementById('apiStatus').textContent = data.message || 'No employees found';
                    document.getElementById('apiStatus').style.backgroundColor = '#fff3cd';
                    document.getElementById('apiStatus').style.color = '#856404';
                    document.getElementById('searchResultsSection').style.display = 'block';
                    
                    showFloatingNotification(
                        'No employees found matching your search criteria', 
                        'warning',
                        'No Results'
                    );
                }
            })
            .catch(error => {
                // Hide loading indicator
                document.getElementById('loadingIndicator').style.display = 'none';
                
                // Show error
                document.getElementById('apiStatus').textContent = 'Error searching employees: ' + error.message;
                document.getElementById('apiStatus').style.backgroundColor = '#f8d7da';
                document.getElementById('apiStatus').style.color = '#721c24';
                
                showFloatingNotification(
                    'Error searching employees: ' + error.message, 
                    'error',
                    'Search Error'
                );
                console.error('Error searching employees:', error);
            });
        }
        
        // Display employee search results with improved formatting
        function displayEmployeeResults(employees) {
            const employeeList = document.getElementById('employeeList');
            employeeList.innerHTML = '';
            
            if (!employees || employees.length === 0) {
                employeeList.innerHTML = '<p style="text-align: center; padding: 20px; color: #666;">No employees found matching your criteria.</p>';
                return;
            }
            
            employees.forEach(employee => {
                // Get department and designation names
                const deptName = departments.find(d => d.dept_id == employee.departmentId)?.dept_name || 'Unknown Department';
                const desigName = designations.find(d => d.desig_id == employee.designationId)?.desig_name || 'Unknown Designation';
                
                const employeeCard = document.createElement('div');
                employeeCard.className = 'card employee-card';
                employeeCard.innerHTML = `
                    <div class="card-body">
                        <div class="ui-row">
                            <div class="ui-col ui-col-8">
                                <h3>${employee.firstName} ${employee.lastName}</h3>
                                <p><strong>Employee ID:</strong> ${employee.empId}</p>
                                <p><strong>Email:</strong> ${employee.email}</p>
                                <p><strong>Mobile:</strong> ${employee.mobile || 'N/A'}</p>
                                <p><strong>Department:</strong> ${deptName}</p>
                                <p><strong>Designation:</strong> ${desigName}</p>
                            </div>
                            <div class="ui-col ui-col-4" style="text-align: right;">
                                <button class="btn btn-info btn-select-employee" data-id="${employee.empId}">
                                    <i class="fas fa-user-edit"></i> Select for Editing
                                </button>
                            </div>
                        </div>
                    </div>
                `;
                
                employeeList.appendChild(employeeCard);
            });
            
            // Add event listeners to select buttons
            document.querySelectorAll('.btn-select-employee').forEach(button => {
                button.addEventListener('click', function() {
                    const empId = this.getAttribute('data-id');
                    loadEmployeeForEditing(empId);
                });
            });
        }
        
        // Load employee data for editing with full data retrieval
        function loadEmployeeForEditing(empId) {
            // Show loading indicator
            document.getElementById('loadingIndicator').style.display = 'block';
            document.getElementById('apiStatus').textContent = 'Loading employee details...';
            document.getElementById('apiStatus').style.backgroundColor = '#fff3cd';
            document.getElementById('apiStatus').style.color = '#856404';
            
            // Make API call to get specific employee data with full details
            fetch(`https://mesbahuddin.com/web/unorg/pg1_emp_man/data?id=${empId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                // Hide loading indicator
                document.getElementById('loadingIndicator').style.display = 'none';
                
                if (data.status === 'success' && data.data && data.data.length > 0) {
                    // Populate form with employee data
                    populateFormWithEmployeeData(data.data[0]);
                    
                    document.getElementById('apiStatus').textContent = 'Employee data loaded successfully';
                    document.getElementById('apiStatus').style.backgroundColor = '#d4edda';
                    document.getElementById('apiStatus').style.color = '#155724';
                    
                    showFloatingNotification(
                        'Employee data loaded successfully. You can now update the information.', 
                        'success',
                        'Data Loaded'
                    );
                    
                    // Show delete button for existing employee
                    document.getElementById('deleteEmployee').style.display = 'inline-flex';
                    
                    // Switch to first tab for editing
                    document.querySelector('.tab[data-tab="personal"]').click();
                } else {
                    document.getElementById('apiStatus').textContent = data.message || 'No employee data found';
                    document.getElementById('apiStatus').style.backgroundColor = '#f8d7da';
                    document.getElementById('apiStatus').style.color = '#721c24';
                    showFloatingNotification(
                        'No employee data found for the selected ID', 
                        'error',
                        'Load Failed'
                    );
                }
            })
            .catch(error => {
                // Hide loading indicator
                document.getElementById('loadingIndicator').style.display = 'none';
                
                // Show error
                document.getElementById('apiStatus').textContent = 'Error loading employee: ' + error.message;
                document.getElementById('apiStatus').style.backgroundColor = '#f8d7da';
                document.getElementById('apiStatus').style.color = '#721c24';
                showFloatingNotification(
                    'Error loading employee data: ' + error.message, 
                    'error',
                    'Load Error'
                );
                console.error('Error loading employee:', error);
            });
        }
        
        // Populate form with employee data matching the API response structure
        function populateFormWithEmployeeData(employeeData) {
            // Clear existing form
            resetForm(false); // false = don't show reset message
            
            // Basic info
            document.getElementById('empId').value = employeeData.empId || '';
            document.getElementById('firstName').value = employeeData.firstName || '';
            document.getElementById('lastName').value = employeeData.lastName || '';
            document.getElementById('email').value = employeeData.email || '';
            document.getElementById('phone').value = employeeData.phone || '';
            document.getElementById('mobile').value = employeeData.mobile || '';
            document.getElementById('nid').value = employeeData.nid || '';
            document.getElementById('dob').value = employeeData.dateOfBirth || '';
            document.getElementById('gender').value = employeeData.gender || '';
            document.getElementById('bloodGroup').value = employeeData.bloodGroup || '';
            document.getElementById('religion').value = employeeData.religion || '';
            document.getElementById('department').value = employeeData.departmentId || '';
            document.getElementById('designation').value = employeeData.designationId || '';
            document.getElementById('joinDate').value = employeeData.joinDate || '';
            document.getElementById('salary').value = employeeData.salary || '';
            document.getElementById('presentAddress').value = employeeData.addressPresent || '';
            document.getElementById('permanentAddress').value = employeeData.addressPermanent || '';
            document.getElementById('emergencyContactName').value = employeeData.emergencyContactName || '';
            document.getElementById('emergencyContactPhone').value = employeeData.emergencyContactPhone || '';
            
            // Skills - handle both array and string format
            employeeSkills = [];
            if (employeeData.skills) {
                try {
                    if (Array.isArray(employeeData.skills)) {
                        employeeSkills = employeeData.skills;
                    } else if (typeof employeeData.skills === 'string') {
                        employeeSkills = JSON.parse(employeeData.skills);
                    }
                } catch (e) {
                    console.warn('Could not parse skills data:', e);
                    employeeSkills = [];
                }
            }
            updateSkillsDisplay();
            updateSkillsHiddenField();
            
            // Marital status
            if (employeeData.maritalStatus) {
                document.querySelectorAll('input[name="maritalStatus"]').forEach(radio => {
                    radio.checked = (radio.value === employeeData.maritalStatus);
                });
            }
            
            // Clear existing education and experience rows
            document.getElementById('educationRows').innerHTML = '';
            document.getElementById('experienceRows').innerHTML = '';
            
            // Add education rows
            if (employeeData.education && Array.isArray(employeeData.education) && employeeData.education.length > 0) {
                employeeData.education.forEach(edu => {
                    document.getElementById('addEducation').click();
                    const lastRow = document.querySelector('#educationRows .dynamic-row:last-child');
                    
                    if (lastRow) {
                        lastRow.querySelector('select[name="degreeType"]').value = edu.degreeType || '';
                        lastRow.querySelector('input[name="degreeTitle"]').value = edu.degreeTitle || '';
                        lastRow.querySelector('input[name="institutionName"]').value = edu.institutionName || '';
                        lastRow.querySelector('input[name="passingYear"]').value = edu.passingYear || '';
                        lastRow.querySelector('select[name="resultType"]').value = edu.resultType || '';
                        lastRow.querySelector('input[name="resultValue"]').value = edu.resultValue || '';
                        lastRow.querySelector('input[name="duration"]').value = edu.duration || '';
                        lastRow.querySelector('input[name="majorSubject"]').value = edu.majorSubject || '';
                        if (lastRow.querySelector('input[name="isCurrent"]')) {
                            lastRow.querySelector('input[name="isCurrent"]').checked = (edu.isCurrent === 'Y');
                        }
                    }
                });
            } else {
                // Add at least one empty education row
                document.getElementById('addEducation').click();
            }
            
            // Add experience rows
            if (employeeData.experience && Array.isArray(employeeData.experience) && employeeData.experience.length > 0) {
                employeeData.experience.forEach(exp => {
                    document.getElementById('addExperience').click();
                    const lastRow = document.querySelector('#experienceRows .dynamic-row:last-child');
                    
                    if (lastRow) {
                        lastRow.querySelector('input[name="companyName"]').value = exp.companyName || '';
                        lastRow.querySelector('input[name="designation"]').value = exp.designation || '';
                        lastRow.querySelector('input[name="department"]').value = exp.department || '';
                        lastRow.querySelector('select[name="employmentType"]').value = exp.employmentType || '';
                        lastRow.querySelector('input[name="startDate"]').value = exp.startDate || '';
                        lastRow.querySelector('input[name="endDate"]').value = exp.endDate || '';
                        lastRow.querySelector('input[name="location"]').value = exp.location || '';
                        lastRow.querySelector('input[name="salaryRange"]').value = exp.salaryRange || '';
                        lastRow.querySelector('input[name="supervisorName"]').value = exp.supervisorName || '';
                        lastRow.querySelector('textarea[name="jobResponsibilities"]').value = exp.jobResponsibilities || '';
                        lastRow.querySelector('input[name="reasonForLeaving"]').value = exp.reasonForLeaving || '';
                        if (lastRow.querySelector('input[name="isCurrent"]')) {
                            lastRow.querySelector('input[name="isCurrent"]').checked = (exp.isCurrent === 'Y');
                        }
                    }
                });
            } else {
                // Add at least one empty experience row
                document.getElementById('addExperience').click();
            }
            
            // Generate employee code if needed
            if (!document.getElementById('empCode').value) {
                generateEmployeeCode();
            }
        }
        
        // Reset form with option to suppress message
        function resetForm(showMessage = true) {
            document.getElementById('employeeForm').reset();
            document.getElementById('empId').value = '';
            document.getElementById('educationRows').innerHTML = '';
            document.getElementById('experienceRows').innerHTML = '';
            
            // Reset skills
            employeeSkills = [];
            updateSkillsDisplay();
            updateSkillsHiddenField();
            
            // Reset photo preview
            const photoPreview = document.getElementById('photoPreview');
            const photoIcon = document.querySelector('.photo-preview i');
            if (photoPreview) photoPreview.style.display = 'none';
            if (photoIcon) photoIcon.style.display = 'block';
            
            // Hide delete button for new entries
            document.getElementById('deleteEmployee').style.display = 'none';
            
            // Clear any error states
            document.querySelectorAll('.form-control').forEach(input => {
                input.classList.remove('error-field');
            });
            document.querySelectorAll('.error').forEach(error => {
                error.style.display = 'none';
            });
            
            // Add at least one education and experience row
            document.getElementById('addEducation').click();
            document.getElementById('addExperience').click();
            
            if (showMessage) {
                showFloatingNotification(
                    'Form has been reset. You can now enter new employee data.', 
                    'success',
                    'Form Reset'
                );
            }
            
            markFormClean();
        }
        
        // Show status message with auto-hide (keeping for backward compatibility)
        function showStatusMessage(message, type) {
            showFloatingNotification(message, type);
        }
        
        // Remove education row with validation
        function removeEducationRow(id) {
            const row = document.querySelector(`#educationRows .dynamic-row[data-id="${id}"]`);
            const totalRows = document.querySelectorAll('#educationRows .dynamic-row').length;
            
            if (row && totalRows > 1) {
                row.remove();
                showFloatingNotification('Education row removed', 'success', 'Row Removed');
            } else if (row && totalRows === 1) {
                if (confirm('This is the last education row. Are you sure you want to remove it?')) {
                    row.remove();
                    // Add a new empty row
                    document.getElementById('addEducation').click();
                    showFloatingNotification('Education row removed and new one added', 'success', 'Row Replaced');
                }
            }
        }
        
        // Remove experience row with validation
        function removeExperienceRow(id) {
            const row = document.querySelector(`#experienceRows .dynamic-row[data-id="${id}"]`);
            const totalRows = document.querySelectorAll('#experienceRows .dynamic-row').length;
            
            if (row && totalRows > 1) {
                row.remove();
                showFloatingNotification('Experience row removed', 'success', 'Row Removed');
            } else if (row && totalRows === 1) {
                if (confirm('This is the last experience row. Are you sure you want to remove it?')) {
                    row.remove();
                    // Add a new empty row
                    document.getElementById('addExperience').click();
                    showFloatingNotification('Experience row removed and new one added', 'success', 'Row Replaced');
                }
            }
        }
        
        // Enhanced error handling for API calls
        function handleApiError(error, context) {
            console.error(`API Error in ${context}:`, error);
            
            let errorMessage = 'An unexpected error occurred';
            
            if (error.name === 'TypeError' && error.message.includes('fetch')) {
                errorMessage = 'Network error - please check your internet connection';
            } else if (error.message.includes('404')) {
                errorMessage = 'API endpoint not found';
            } else if (error.message.includes('500')) {
                errorMessage = 'Server error - please try again later';
            } else {
                errorMessage = error.message;
            }
            
            return errorMessage;
        }
        
        // Utility function to safely get nested object properties
        function safeGet(obj, path, defaultValue = '') {
            return path.split('.').reduce((current, key) => {
                return current && current[key] !== undefined ? current[key] : defaultValue;
            }, obj);
        }
        
        // Add present address auto-copy functionality
        document.getElementById('presentAddress').addEventListener('input', function() {
            if (document.getElementById('sameAsPresent').checked) {
                document.getElementById('permanentAddress').value = this.value;
            }
        });
        
        // Add form dirty checking to prevent accidental navigation
        let formIsDirty = false;
        
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('input', function() {
                formIsDirty = true;
            });
        });
        
        // Warn before leaving if form has unsaved changes
        window.addEventListener('beforeunload', function(e) {
            if (formIsDirty) {
                e.preventDefault();
                e.returnValue = 'You have unsaved changes. Are you sure you want to leave?';
                return e.returnValue;
            }
        });
        
        // Mark form as clean after successful save
        function markFormClean() {
            formIsDirty = false;
        }
        
        // Add keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl+Enter or Cmd+Enter to submit
            if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
                e.preventDefault();
                document.getElementById('employeeForm').dispatchEvent(new Event('submit'));
            }
            
            // Ctrl+R or Cmd+R to reset (with confirmation)
            if ((e.ctrlKey || e.metaKey) && e.key === 'r') {
                e.preventDefault();
                document.getElementById('resetForm').click();
            }
        });
        
        // Skills input enter key support
        document.getElementById('skillName').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                addSkill();
            }
        });
        
        document.getElementById('skillYears').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                addSkill();
            }
        });


        // Enhanced search: trigger on typing (after 4 chars) or press Enter
        const searchInput = document.getElementById('searchName');
        const searchButton = document.getElementById('searchBtn');

        searchInput.addEventListener('keyup', function (event) {
            const value = this.value.trim();

            // If Enter key is pressed ? trigger search
            if (event.key === 'Enter') {
                if (value.length > 0) {
                    searchButton.click();
                } else {
                    clearSearchData();
                }
                return;
            }

            // If at least 4 characters typed ? trigger search automatically
            if (value.length >= 4) {
                searchButton.click();
            } 
            // If input cleared or less than 4 chars ? clear results
            else if (value.length === 0) {
                clearSearchData();
            }
        });
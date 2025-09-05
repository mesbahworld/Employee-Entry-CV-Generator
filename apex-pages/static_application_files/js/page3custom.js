// Global variables
        let departments = [];
        let designations = [];
        let employeeSkills = [];
        let activeInput = null; // track which input opened the LOV
        
        document.addEventListener('DOMContentLoaded', function() {
            // Set P3_EMP_ID value from APEX page item ONLY if it's meant for editing
            if (typeof apex !== 'undefined' && apex.item) {
                const empIdValue = apex.item('P3_EMP_ID').getValue();
                if (empIdValue) {
                    // Check if we're in "edit mode" vs "new mode"
                    const urlParams = new URLSearchParams(window.location.search);
                    // const editMode = urlParams.get('edit') || urlParams.get('mode');
                    const editMode = urlParams.get('p3_edit') || urlParams.get('p3_mode');
                    
                    if (editMode === 'edit' || editMode === 'update') {
                        document.getElementById('empId').value = empIdValue;
                        document.getElementById('searchId').value = empIdValue;
                        updateSaveButtonText();
                        loadEmployeeForEditing(empIdValue);
                    }
                    // If not in edit mode, don't auto-populate
                }
            }
    
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
                                <select data-name="degreeType" class="form-control" required>
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
                                <input type="text" data-name="degreeTitle" class="form-control" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="ui-row">
                        <div class="ui-col ui-col-6">
                            <div class="form-group">
                                <label>Institution Name *</label>
                                <input type="text" data-name="institutionName" class="form-control" required>
                            </div>
                        </div>
                        <div class="ui-col ui-col-3">
                            <div class="form-group">
                                <label>Passing Year *</label>
                                <input type="number" data-name="passingYear" class="form-control" min="1950" max="2030" required>
                            </div>
                        </div>
                        <div class="ui-col ui-col-3">
                            <div class="form-group">
                                <label>Duration (Years)</label>
                                <input type="number" data-name="duration" class="form-control" min="1" max="10">
                            </div>
                        </div>
                    </div>
                    
                    <div class="ui-row">
                        <div class="ui-col ui-col-4">
                            <div class="form-group">
                                <label>Result Type</label>
                                <select data-name="resultType" class="form-control">
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
                                <input type="text" data-name="resultValue" class="form-control">
                            </div>
                        </div>
                        <div class="ui-col ui-col-4">
                            <div class="form-group">
                                <label>Major Subject</label>
                                <input type="text" data-name="majorSubject" class="form-control">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox-group">
                            <input type="checkbox" data-name="isCurrent" value="Y"> This is my current education
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
                                <input type="text" data-name="companyName" class="form-control" required>
                            </div>
                        </div>
                        <div class="ui-col ui-col-6">
                            <div class="form-group">
                                <label>Designation *</label>
                                <input type="text" data-name="designation" class="form-control" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="ui-row">
                        <div class="ui-col ui-col-6">
                            <div class="form-group">
                                <label>Department</label>
                                <input type="text" data-name="department" class="form-control">
                            </div>
                        </div>
                        <div class="ui-col ui-col-6">
                            <div class="form-group">
                                <label>Employment Type</label>
                                <select data-name="employmentType" class="form-control">
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
                                <input type="date" data-name="startDate" class="form-control" required>
                            </div>
                        </div>
                        <div class="ui-col ui-col-4">
                            <div class="form-group">
                                <label>End Date</label>
                                <input type="date" data-name="endDate" class="form-control">
                            </div>
                        </div>
                        <div class="ui-col ui-col-4">
                            <div class="form-group">
                                <label>Location</label>
                                <input type="text" data-name="location" class="form-control">
                            </div>
                        </div>
                    </div>
                    
                    <div class="ui-row">
                        <div class="ui-col ui-col-6">
                            <div class="form-group">
                                <label>Salary Range</label>
                                <input type="text" data-name="salaryRange" class="form-control" placeholder="e.g., 50000-70000">
                            </div>
                        </div>
                        <div class="ui-col ui-col-6">
                            <div class="form-group">
                                <label>Supervisor Name</label>
                                <input type="text" data-name="supervisorName" class="form-control">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Job Responsibilities</label>
                        <textarea data-name="jobResponsibilities" class="form-control" rows="3"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label>Reason for Leaving</label>
                        <input type="text" data-name="reasonForLeaving" class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label class="checkbox-group">
                            <input type="checkbox" data-name="isCurrent" value="Y"> I currently work here
                        </label>
                    </div>
                `;
                
                document.getElementById('experienceRows').appendChild(newRow);
            });
/* 
            // Form validation and submission
            document.getElementById('employeeForm').addEventListener('submit', function(e) {
                e.preventDefault();
                
                if (validateForm()) {
                    const formData = collectFormData();
                    submitEmployeeData(formData);
                }
            });
             */

            // Form validation and submission
            apex.jQuery(document).on("apexreadyend", function () {
            const form = document.getElementById('employeeForm');
            if (form) {
                    form.addEventListener('submit', function(e) {
                        e.preventDefault();
                        console.log("Form submit event triggered.");

                        if (validateForm()) {
                            console.log("Form validation passed. Collecting data...");
                            const formData = collectFormData();
                            console.log("Collected Form Data:", formData);
                            submitEmployeeData(formData);
                        } else {
                            console.warn("Form validation failed. Submission aborted.");
                        }
                    });
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

            // ========== NEW POPUP MODAL INTEGRATION ==========
            
            // Add focus event listeners for the popup
            document.getElementById("searchId").addEventListener("focus", function() {
              activeInput = this;
              document.getElementById("searchName").value = "";
              document.getElementById("searchId").value = "";
              openLov();
            });

            document.getElementById("searchName").addEventListener("focus", function() {
              activeInput = this;
              document.getElementById("searchId").value = "";
              document.getElementById("searchName").value = "";
              openLov();
            });

            // Optional: Close popup when clicking outside
            document.getElementById("popupLov").addEventListener("click", function(e) {
              if (e.target === this) {
                this.style.display = "none";
              }
            });

        });

        // ========== POPUP MODAL FUNCTIONS ==========

        // Prevent APEX default page submit when typing in popup search
document.getElementById("popupSearch").addEventListener("input", debounce(async function() {
    const val = this.value.trim();
    if (!val) {
        document.getElementById("popupList").innerHTML = "<div>Type to search...</div>";
        return;
    }

    try {
        let url;
        // Check which input field opened the popup
        if (activeInput.id === "searchId") {
            // ID search - minimum 1 character
            url = `https://mesbahuddin.com/web/unorg/pg1_emp_man/list_emp?id=${encodeURIComponent(val)}`;
        } else {
            // Name search - minimum 3 characters
            if (val.length < 3) {
                document.getElementById("popupList").innerHTML = "<div style='padding:8px;color:#888;'>Enter at least 3 characters for name search...</div>";
                return;
            }
            url = `https://mesbahuddin.com/web/unorg/pg1_emp_man/list_emp?p_emp_name=${encodeURIComponent(val)}`;
        }

        const response = await fetch(url);
        const json = await response.json();

        if (json.status === "success") {
            // Handle case where data might be null or empty array
            if (Array.isArray(json.data) && json.data.length > 0) {
                renderList(json.data);
            } else {
                document.getElementById("popupList").innerHTML =
                    "<div style='padding:8px;color:#888;'>No employees found</div>";
            }
        } else {
            document.getElementById("popupList").innerHTML =
                "<div style='padding:8px;color:red;'>No data found</div>";
        }
    } catch (err) {
        document.getElementById("popupList").innerHTML =
            "<div style='padding:8px;color:red;'>API call failed</div>";
        console.error(err);
    }
}, 300)); // 300ms debounce

// Debounce function to prevent too many API calls
function debounce(func, wait) {
    let timeout;
    return function(...args) {
        clearTimeout(timeout);
        timeout = setTimeout(() => func.apply(this, args), wait);
    };
}



        // Prevent page submit when clicking inside modal
        document.getElementById("popupLov").addEventListener("click", function(e) {
          e.stopPropagation();
        });

        // Close modal (without submitting page)
        document.getElementById("closePopup").addEventListener("click", function(e) {
          e.preventDefault();  // stop default button behavior
          e.stopPropagation();
          document.getElementById("popupLov").style.display = "none";
        });

        // Open popup
        function openLov() {
        document.getElementById("popupLov").style.display = "block";
        document.getElementById("popupSearch").value = "";
        document.getElementById("popupSearch").focus();
        
        // Set placeholder and instruction based on which field was clicked
        const searchInput = document.getElementById("popupSearch");
        if (activeInput.id === "searchId") {
            searchInput.placeholder = "Enter employee ID...";
            document.getElementById("popupList").innerHTML = "<div style='padding:8px;color:#888;'>Type employee ID for exact search...</div>";
        } else {
            searchInput.placeholder = "Search employee name...";
            document.getElementById("popupList").innerHTML = "<div style='padding:8px;color:#888;'>Type employee name to search...</div>";
        }
        }

        // Render list with enhanced functionality
        function renderList(list) {
            const container = document.getElementById("popupList");
            container.innerHTML = "";

            if (!list.length) {
                container.innerHTML = "<div style='padding:8px;color:#888;'>No results found</div>";
                return;
            }

            list.forEach(emp => {
                const div = document.createElement("div");
                div.classList.add("list-item");
                div.textContent = `${emp.empId} - ${emp.fullName}`;
                div.onclick = (e) => {
                    e.preventDefault();
                    e.stopPropagation();
                    
                    // Set the visible field value
                    if (activeInput.id === "searchId") {
                        activeInput.value = emp.empId;
                    } else {
                        activeInput.value = emp.fullName;
                    }
                    
                    // Set the hidden empId field
                    document.getElementById("empId").value = emp.empId;
                    
                    // Update APEX page item if available
                    if (typeof apex !== 'undefined' && apex.item) {
                        apex.item('P3_EMP_ID').setValue(emp.empId);
                    }
                    
                    // Update button text to "Update"
                    updateSaveButtonText();
                    
                    // Load full employee data for editing
                    loadEmployeeForEditing(emp.empId);
                    
                    // Close the popup
                    document.getElementById("popupLov").style.display = "none";
                };
                container.appendChild(div);
            });
        }


        // Add a "New Employee" button to explicitly clear everything
        function createNewEmployee() {
            // Clear URL parameters (if possible)
            if (window.history && window.history.replaceState) {
                const url = new URL(window.location);
                url.searchParams.delete('P3_EMP_ID');
                url.searchParams.delete('edit');
                url.searchParams.delete('mode');
                window.history.replaceState({}, '', url);
            }
            
            // Clear APEX page item
            if (typeof apex !== 'undefined' && apex.item) {
                apex.item('P3_EMP_ID').setValue('');
            }
            
            // Reset form completely
            resetForm(true);
            
            // Show success message
            showFloatingNotification(
                'Ready to create new employee', 
                'success',
                'New Employee Mode'
            );
        }

    // Add button to header section (call this in DOMContentLoaded)
    function addNewEmployeeButton() {
        const header = document.querySelector('.header');
        if (header) {
            const newButton = document.createElement('button');
            newButton.type = 'button';
            newButton.className = 'btn btn-success';
            newButton.innerHTML = '<i class="fas fa-user-plus"></i> New Employee';
            newButton.onclick = createNewEmployee;
            newButton.style.marginTop = '10px';
            header.appendChild(newButton);
        }
    }

        // Live search inside popup (fetch from API)
        document.getElementById("popupSearch").addEventListener("input", async function() {
          const val = this.value.trim();
          if (!val) {
            document.getElementById("popupList").innerHTML = "<div>Type to search...</div>";
            return;
          }

          try {
            const response = await fetch(
              `https://mesbahuddin.com/web/unorg/pg1_emp_man/list_emp?p_emp_name=${encodeURIComponent(val)}`
            );
            const json = await response.json();

            if (json.status === "success" && Array.isArray(json.data)) {
              renderList(json.data);
            } else {
              document.getElementById("popupList").innerHTML =
                "<div style='padding:8px;color:red;'>No data found</div>"; //Error loading data
            }
          } catch (err) {
            document.getElementById("popupList").innerHTML =
              "<div style='padding:8px;color:red;'>API call failed</div>";
            console.error(err);
          }
        });

        // ========== END POPUP MODAL FUNCTIONS ==========

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
            document.querySelectorAll('input[data-name="maritalStatus"]').forEach(radio => {
                if (radio.checked) {
                    maritalStatus = radio.value;
                }
            });

            const educationData = [];
            document.querySelectorAll('#educationRows .dynamic-row').forEach(row => {
                const eduData = {
                    degree_type: row.querySelector('select[data-name="degreeType"]').value,
                    degree_title: row.querySelector('input[data-name="degreeTitle"]').value,
                    institution_name: row.querySelector('input[data-name="institutionName"]').value,
                    passing_year: parseInt(row.querySelector('input[data-name="passingYear"]').value) || null,
                    result_type: row.querySelector('select[data-name="resultType"]').value,
                    result_value: row.querySelector('input[data-name="resultValue"]').value,
                    duration_years: parseInt(row.querySelector('input[data-name="duration"]').value) || null,
                    major_subject: row.querySelector('input[data-name="majorSubject"]').value,
                    is_current: row.querySelector('input[data-name="isCurrent"]')?.checked ? 'Y' : 'N'
                };
                if (eduData.degree_type && eduData.degree_title) {
                    educationData.push(eduData);
                }
            });

            const experienceData = [];
            document.querySelectorAll('#experienceRows .dynamic-row').forEach(row => {
                const expData = {
                    company_name: row.querySelector('input[data-name="companyName"]').value,
                    designation: row.querySelector('input[data-name="designation"]').value,
                    department: row.querySelector('input[data-name="department"]').value,
                    employment_type: row.querySelector('select[data-name="employmentType"]').value,
                    start_date: row.querySelector('input[data-name="startDate"]').value,
                    end_date: row.querySelector('input[data-name="endDate"]').value,
                    location: row.querySelector('input[data-name="location"]').value,
                    salary_range: row.querySelector('input[data-name="salaryRange"]').value,
                    supervisor_name: row.querySelector('input[data-name="supervisorName"]').value,
                    job_responsibilities: row.querySelector('textarea[data-name="jobResponsibilities"]').value,
                    reason_for_leaving: row.querySelector('input[data-name="reasonForLeaving"]').value,
                    is_current: row.querySelector('input[data-name="isCurrent"]')?.checked ? 'Y' : 'N'
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
            console.log("Submitting employee data...", formData);

            // Show loading indicator
            document.getElementById('loadingIndicator').style.display = 'block';

            const isUpdate = formData.emp_id && formData.emp_id !== '';
            console.log("Is update?", isUpdate);

            if (typeof apex !== 'undefined' && apex.server) {
                console.log("Submitting via APEX process...");
                apex.server.process(
                    "PG1_SAVE_EMPLOYEE",
                    { x01: JSON.stringify(formData) },
                    {
                        success: function(pData) {
                            console.log("APEX success response:", pData);
                            handleSaveResponse(pData, 'apex', isUpdate);
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.error("APEX error:", textStatus, errorThrown);
                            handleSaveError(textStatus + ': ' + errorThrown, 'apex');
                        }
                    }
                );
            } else {
                console.log("Submitting via fetch API...");
                fetch('https://mesbahuddin.com/web/unorg/pg1_emp_man/data', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(formData)
                })
                .then(response => {
                    console.log("Fetch response object:", response);
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("Fetch success data:", data);
                    handleSaveResponse(data, 'api', isUpdate);
                })
                .catch(error => {
                    console.error("Fetch error:", error);
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
                    
                    // For new employees, optionally load the created employee for further editing
                    if (!isUpdate && response.emp_id) {
                        // Ask user if they want to continue editing or create new
                        setTimeout(() => {
                            if (confirm('Employee created successfully! Do you want to continue editing this employee? Click Cancel to create a new employee.')) {
                                // Set the employee ID and switch to edit mode
                                document.getElementById('empId').value = response.emp_id;
                                document.getElementById('deleteEmployee').style.display = 'inline-flex';
                                updateSaveButtonText();
                                
                                // Update APEX page item if available
                                if (typeof apex !== 'undefined' && apex.item) {
                                    apex.item('P3_EMP_ID').setValue(response.emp_id);
                                }
                            } else {
                                // Reset form for new employee
                                resetForm(false);
                            }
                        }, 1500);
                    }
                    
                    // Clear search results if visible
                    if (document.getElementById('searchResultsSection').style.display !== 'none') {
                        clearSearchData();
                    }
                    
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
                                <button type="button" class="btn btn-info btn-select-employee" data-id="${employee.empId}">
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
                document.querySelectorAll('input[data-name="maritalStatus"]').forEach(radio => {
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
                        lastRow.querySelector('select[data-name="degreeType"]').value = edu.degreeType || '';
                        lastRow.querySelector('input[data-name="degreeTitle"]').value = edu.degreeTitle || '';
                        lastRow.querySelector('input[data-name="institutionName"]').value = edu.institutionName || '';
                        lastRow.querySelector('input[data-name="passingYear"]').value = edu.passingYear || '';
                        lastRow.querySelector('select[data-name="resultType"]').value = edu.resultType || '';
                        lastRow.querySelector('input[data-name="resultValue"]').value = edu.resultValue || '';
                        lastRow.querySelector('input[data-name="duration"]').value = edu.duration || '';
                        lastRow.querySelector('input[data-name="majorSubject"]').value = edu.majorSubject || '';
                        if (lastRow.querySelector('input[data-name="isCurrent"]')) {
                            lastRow.querySelector('input[data-name="isCurrent"]').checked = (edu.isCurrent === 'Y');
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
                        lastRow.querySelector('input[data-name="companyName"]').value = exp.companyName || '';
                        lastRow.querySelector('input[data-name="designation"]').value = exp.designation || '';
                        lastRow.querySelector('input[data-name="department"]').value = exp.department || '';
                        lastRow.querySelector('select[data-name="employmentType"]').value = exp.employmentType || '';
                        lastRow.querySelector('input[data-name="startDate"]').value = exp.startDate || '';
                        lastRow.querySelector('input[data-name="endDate"]').value = exp.endDate || '';
                        lastRow.querySelector('input[data-name="location"]').value = exp.location || '';
                        lastRow.querySelector('input[data-name="salaryRange"]').value = exp.salaryRange || '';
                        lastRow.querySelector('input[data-name="supervisorName"]').value = exp.supervisorName || '';
                        lastRow.querySelector('textarea[data-name="jobResponsibilities"]').value = exp.jobResponsibilities || '';
                        lastRow.querySelector('input[data-name="reasonForLeaving"]').value = exp.reasonForLeaving || '';
                        if (lastRow.querySelector('input[data-name="isCurrent"]')) {
                            lastRow.querySelector('input[data-name="isCurrent"]').checked = (exp.isCurrent === 'Y');
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

        // Debud helper to see if #employeeForm is inside the DOM
        function debugDomScan() {
            console.group("DOM Debug Scan");

            // Check if form exists
            const form = document.getElementById("employeeForm");
            console.log("employeeForm:", form);

            // If form exists, list its children
            if (form) {
                console.log("Form innerHTML:", form.innerHTML);
            }

            // Check if empId field exists
            const empIdField = document.getElementById("empId");
            console.log("empId field:", empIdField);

            // List ALL forms on page
            const forms = document.getElementsByTagName("form");
            console.log("All forms on page:", forms);

            // List ALL inputs on page (with IDs)
            const inputs = document.querySelectorAll("input[id]");
            console.log("All input elements with IDs:");
            inputs.forEach(el => {
                console.log("  ID:", el.id, " Value:", el.value, " Parent:", el.closest("form")?.id);
            });

            // Dump all region containers (APEX often wraps regions)
            const regions = document.querySelectorAll("div[id^='R']");
            console.log("APEX Regions (IDs starting with R):", regions);

            console.groupEnd();
        }

        function clearUrlParams() {
            const url = new URL(window.location);
            url.searchParams.delete("P3_EMP_ID");
            url.searchParams.delete("p3_edit");
            url.searchParams.delete("p3_mode");
            window.history.replaceState({}, document.title, url.pathname); 
        }

        // Reset form with option to suppress message
        // debugDomScan(); // 👈 check DOM state first

        function resetForm(showMessage = true) {
            const container = document.getElementById("employeeForm");
            if (!container) {
                console.warn("Form container not found in DOM yet.");
                return;
            }

            // Reset all inputs, selects, and textareas inside container
            container.querySelectorAll("input, select, textarea").forEach(el => {
                switch (el.type) {
                    case "checkbox":
                    case "radio":
                        el.checked = false;
                        break;
                    case "file":
                        el.value = null;
                        break;
                    default:
                        el.value = "";
                }
            });

            // IMPORTANT: Explicitly clear empId for new entries
            document.getElementById('empId').value = "";
            document.getElementById('searchId').value = "";
            document.getElementById('searchName').value = "";

            // Clear APEX page item if it exists
            if (typeof apex !== 'undefined' && apex.item) {
                apex.item('P3_EMP_ID').setValue('');
            }

            // Reset dynamic rows
            const educationRows = document.getElementById("educationRows");
            if (educationRows) educationRows.innerHTML = "";

            const experienceRows = document.getElementById("experienceRows");
            if (experienceRows) experienceRows.innerHTML = "";

            // Reset skills
            if (typeof employeeSkills !== "undefined") {
                employeeSkills = [];
                if (typeof updateSkillsDisplay === "function") updateSkillsDisplay();
                if (typeof updateSkillsHiddenField === "function") updateSkillsHiddenField();
            }

            // reset url parameter
            clearUrlParams();    

            // Reset search inputs
            const empId = document.getElementById("empId");
            const searchId = document.getElementById("searchId");
            const searchName = document.getElementById("searchName");

            if (empId) empId.value = "";
            if (searchId) searchId.value = "";
            if (searchName) searchName.value = "";

            // Reset photo preview
            const photoPreview = document.getElementById("photoPreview");
            const photoIcon = document.querySelector(".photo-preview i");
            if (photoPreview) {
                photoPreview.style.display = "none";
                photoPreview.src = "";
            }
            if (photoIcon) photoIcon.style.display = "block";

            // Hide delete button for new entries
            const deleteBtn = document.getElementById("deleteEmployee");
            if (deleteBtn) deleteBtn.style.display = "none";

            // Clear any error states
            container.querySelectorAll(".form-control").forEach(input => {
                input.classList.remove("error-field");
            });
            container.querySelectorAll(".error").forEach(error => {
                error.style.display = "none";
            });

            // Clear search results
            document.getElementById('searchResultsSection').style.display = 'none';
            document.getElementById('apiStatus').style.display = 'none';

            // Add at least one education and experience row
            const addEducation = document.getElementById("addEducation");
            if (addEducation) addEducation.click();

            const addExperience = document.getElementById("addExperience");
            if (addExperience) addExperience.click();

            // Update button back to "Save" mode
            updateSaveButtonText();

            if (showMessage && typeof showFloatingNotification === "function") {
                showFloatingNotification(
                    "Form has been reset. You can now enter new employee data.",
                    "success",
                    "Form Reset"
                );
            }

            if (typeof markFormClean === "function") {
                markFormClean();
            }
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

        // Function to update button text based on empId
        function updateSaveButtonText() {
            const empId = document.getElementById('empId').value;
            const saveButton = document.getElementById('saveEmployee');
            const saveIcon = saveButton.querySelector('i');
            
            if (empId) {
                saveButton.innerHTML = '<i class="fas fa-sync-alt"></i> Update';
            } else {
                saveButton.innerHTML = '<i class="fas fa-check-circle"></i> Save';
            }
        }

// Call this function when empId changes
document.getElementById('empId').addEventListener('input', updateSaveButtonText);

// Also call it on page load
document.addEventListener('DOMContentLoaded', function() {
    updateSaveButtonText();
});
// Hook up Save button click to trigger form submission
document.addEventListener('DOMContentLoaded', function () {
    const saveBtn = document.getElementById('saveEmployee');
    const form = document.getElementById('employeeForm');

    if (saveBtn && form) {
        saveBtn.addEventListener('click', function () {
            console.log("Save button clicked. Triggering form submit...");
            form.dispatchEvent(new Event('submit', { cancelable: true, bubbles: true }));
        });
    } else {
        console.warn("Save button or form not found!");
    }
});

// And call it whenever you set the empId value (like in your popup selection)
// Add this line inside your popup selection onclick handler where you set empId:
// updateSaveButtonText(); 
        
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
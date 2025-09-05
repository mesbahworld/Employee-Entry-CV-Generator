        // Global variables
        let allEmployees = [];
        let departments = [];
        let filteredEmployees = [];

        // Initialize the application
        document.addEventListener('DOMContentLoaded', function() {
            loadDepartments();
            loadEmployees();
            setupEventListeners();
        });

        // Setup event listeners
        function setupEventListeners() {
            document.getElementById('searchBtn').addEventListener('click', searchEmployees);
            document.getElementById('clearBtn').addEventListener('click', clearFilters);
            document.getElementById('refreshBtn').addEventListener('click', loadEmployees);
            document.getElementById('closeModal').addEventListener('click', closeModal);
            
            // Add enter key support for search inputs
            document.getElementById('empId').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') searchEmployees();
            });
            document.getElementById('empName').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') searchEmployees();
            });

            // Close modal when clicking outside
            document.getElementById('employeeModal').addEventListener('click', function(e) {
                if (e.target === this) closeModal();
            });
        }

        // Load departments for filter dropdown
        async function loadDepartments() {
            try {
                const response = await fetch('https://mesbahuddin.com/web/unorg/pg1_emp_man/list_dept');
                const result = await response.json();
                
                if (result.status === 'success') {
                    departments = result.data;
                    populateDepartmentFilter();
                }
            } catch (error) {
                console.error('Error loading departments:', error);
            }
        }

        // Populate department filter dropdown
        function populateDepartmentFilter() {
            const deptFilter = document.getElementById('deptFilter');
            deptFilter.innerHTML = '<option value="">All Departments</option>';
            
            departments.forEach(dept => {
                const option = document.createElement('option');
                option.value = dept.dept_id;
                option.textContent = dept.dept_name;
                deptFilter.appendChild(option);
            });
        }

        // Load all employees
        async function loadEmployees() {
            showLoadingState();
            
            try {
                const response = await fetch('https://mesbahuddin.com/web/unorg/pg1_emp_man/data');
                const result = await response.json();
                
                if (result.status === 'success') {
                    allEmployees = result.data;
                    filteredEmployees = [...allEmployees];
                    displayEmployees();
                    updateResultCount();
                } else {
                    showErrorState();
                }
            } catch (error) {
                console.error('Error loading employees:', error);
                showErrorState();
            }
        }

        // Search employees with filters
        async function searchEmployees() {
            const empId = document.getElementById('empId').value.trim();
            const empName = document.getElementById('empName').value.trim();
            const deptId = document.getElementById('deptFilter').value;

            showSearchLoading(true);

            try {
                let url = 'https://mesbahuddin.com/web/unorg/pg1_emp_man/data';
                const params = new URLSearchParams();
                
                if (empId) params.append('id', empId);
                if (empName) params.append('emp_name', empName);
                
                if (params.toString()) {
                    url += '?' + params.toString();
                }

                const response = await fetch(url);
                const result = await response.json();
                
                if (result.status === 'success') {
                    let employees = result.data;
                    
                    // Apply department filter on frontend if selected
                    if (deptId) {
                        employees = employees.filter(emp => emp.departmentId == deptId);
                    }
                    
                    filteredEmployees = employees;
                    displayEmployees();
                    updateResultCount();
                } else {
                    filteredEmployees = [];
                    showEmptyState();
                }
            } catch (error) {
                console.error('Error searching employees:', error);
                showErrorState();
            } finally {
                showSearchLoading(false);
            }
        }

        // Clear all filters
        function clearFilters() {
            document.getElementById('empId').value = '';
            document.getElementById('empName').value = '';
            document.getElementById('deptFilter').value = '';
            
            filteredEmployees = [...allEmployees];
            displayEmployees();
            updateResultCount();
        }

        // Display employees in table
        function displayEmployees() {
            const tbody = document.getElementById('employeeTableBody');
            tbody.innerHTML = '';

            if (filteredEmployees.length === 0) {
                showEmptyState();
                return;
            }

            showTableState();

            filteredEmployees.forEach(employee => {
                const row = createEmployeeRow(employee);
                tbody.appendChild(row);
            });
        }

        // Create individual employee row
        function createEmployeeRow(employee) {
            const row = document.createElement('tr');
            row.className = 'hover:bg-gray-50 fade-in';
            
            const departmentName = departments.find(d => d.dept_id === employee.departmentId)?.dept_name || 'Unknown';
            
            row.innerHTML = `
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="flex items-center">
                        <div class="flex-shrink-0 h-10 w-10">
                            <div class="h-10 w-10 rounded-full gradient-bg flex items-center justify-center text-white font-bold">
                                ${employee.firstName?.charAt(0) || ''}${employee.lastName?.charAt(0) || ''}
                            </div>
                        </div>
                        <div class="ml-4">
                            <div class="text-sm font-medium text-gray-900">${employee.firstName || ''} ${employee.lastName || ''}</div>
                            <div class="text-sm text-gray-500">ID: ${employee.empId || 'N/A'}</div>
                        </div>
                    </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <div class="text-sm text-gray-900">${employee.email || 'N/A'}</div>
                    <div class="text-sm text-gray-500">${employee.mobile || 'N/A'}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                    <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full" 
                          style="background-color: rgba(255, 215, 0, 0.1); color: var(--secondary-color);">
                        ${departmentName}
                    </span>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    ${employee.joinDate ? new Date(employee.joinDate).toLocaleDateString() : 'N/A'}
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                    ${employee.salary ? '৳' + employee.salary.toLocaleString() : 'N/A'}
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                    <div class="flex gap-2">
                        <button onclick="viewEmployee(${employee.empId})" 
                                type="button"
                                class="text-white px-3 py-1 rounded text-xs font-medium" 
                                style="background: var(--primary-color); color: var(--secondary-color);"
                                onmouseover="this.style.background='#FFA500'"
                                onmouseout="this.style.background='var(--primary-color)'">
                            View Details
                        </button>
                        <div class="relative">
                            <button onclick="toggleActionMenu(${employee.empId})" 
                                    type="button"
                                    class="bg-gray-500 text-white px-3 py-1 rounded text-xs hover:bg-gray-600 flex items-center">
                                <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z"></path>
                                </svg>
                                Actions
                                <svg class="w-3 h-3 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                </svg>
                            </button>
                            <div id="actionMenu-${employee.empId}" class="absolute right-0 mt-1 w-36 bg-white border rounded shadow-lg hidden z-10">
                                <a href="https://mesbahuddin.com/web/r/apps/playground/employee-entry?P3_EMP_ID=${employee.empId}&p3_edit=edit" target="_blank" 
                                   class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                    </svg>
                                    Edit Profile
                                </a>
                                <a href="https://mesbahuddin.com/web/r/apps/playground/resume?P4_EMP_ID=${employee.empId}" target="_blank" 
                                   class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                    </svg>
                                    View CV
                                </a>
                            </div>
                        </div>
                    </div>
                </td>
            `;
            
            return row;
        }

        // Toggle action menu dropdown
        function toggleActionMenu(empId) {
            // Close all other menus first
            document.querySelectorAll('[id^="actionMenu-"]').forEach(menu => {
                if (menu.id !== `actionMenu-${empId}`) {
                    menu.classList.add('hidden');
                }
            });
            
            const menu = document.getElementById(`actionMenu-${empId}`);
            menu.classList.toggle('hidden');
        }

        // Close action menus when clicking outside
        document.addEventListener('click', function(e) {
            if (!e.target.closest('button[onclick*="toggleActionMenu"]')) {
                document.querySelectorAll('[id^="actionMenu-"]').forEach(menu => {
                    menu.classList.add('hidden');
                });
            }
        });

        // View employee details in modal
        function viewEmployee(empId) {
            // Find the employee in the filtered list first, then fall back to all employees
            let employee = filteredEmployees.find(emp => emp.empId === empId);
            if (!employee) {
                employee = allEmployees.find(emp => emp.empId === empId);
            }
            
            if (!employee) {
                console.error("Employee not found with ID:", empId);
                return;
            }

            const modal = document.getElementById('employeeModal');
            const modalName = document.getElementById('modalEmployeeName');
            const modalContent = document.getElementById('modalContent');

            modalName.textContent = `${employee.firstName || ''} ${employee.lastName || ''}`;
            modalContent.innerHTML = createEmployeeDetailContent(employee);
            
            modal.classList.remove('hidden');
            document.body.style.overflow = 'hidden';
        }

        // Create detailed employee content for modal
        function createEmployeeDetailContent(employee) {
            const departmentName = departments.find(d => d.dept_id === employee.departmentId)?.dept_name || 'Unknown';
            
            // Safely handle arrays that might be null or undefined
            const skills = employee.skills || [];
            const education = employee.education || [];
            const experience = employee.experience || [];
            
            return `
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <!-- Personal Information -->
                    <div class="space-y-6">
                        <div class="bg-gray-50 rounded-lg p-4">
                            <h4 class="text-lg font-semibold mb-4 text-gray-800">Personal Information</h4>
                            <div class="space-y-3">
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Employee ID:</span>
                                    <span class="text-gray-900">${employee.empId || 'N/A'}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Full Name:</span>
                                    <span class="text-gray-900">${employee.firstName || ''} ${employee.lastName || ''}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Email:</span>
                                    <span class="text-gray-900">${employee.email || 'N/A'}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Phone:</span>
                                    <span class="text-gray-900">${employee.phone || 'N/A'}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Mobile:</span>
                                    <span class="text-gray-900">${employee.mobile || 'N/A'}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Date of Birth:</span>
                                    <span class="text-gray-900">${employee.dateOfBirth ? new Date(employee.dateOfBirth).toLocaleDateString() : 'N/A'}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Gender:</span>
                                    <span class="text-gray-900">${employee.gender === 'M' ? 'Male' : employee.gender === 'F' ? 'Female' : 'N/A'}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Blood Group:</span>
                                    <span class="text-gray-900">${employee.bloodGroup || 'N/A'}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Religion:</span>
                                    <span class="text-gray-900">${employee.religion || 'N/A'}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Marital Status:</span>
                                    <span class="text-gray-900">${employee.maritalStatus || 'N/A'}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">NID:</span>
                                    <span class="text-gray-900">${employee.nid || 'N/A'}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Work Information -->
                        <div class="bg-gray-50 rounded-lg p-4">
                            <h4 class="text-lg font-semibold mb-4 text-gray-800">Work Information</h4>
                            <div class="space-y-3">
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Department:</span>
                                    <span class="text-gray-900">${departmentName}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Join Date:</span>
                                    <span class="text-gray-900">${employee.joinDate ? new Date(employee.joinDate).toLocaleDateString() : 'N/A'}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Salary:</span>
                                    <span class="text-gray-900">${employee.salary ? '৳' + employee.salary.toLocaleString() : 'N/A'}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Address Information -->
                        <div class="bg-gray-50 rounded-lg p-4">
                            <h4 class="text-lg font-semibold mb-4 text-gray-800">Address Information</h4>
                            <div class="space-y-3">
                                <div>
                                    <span class="font-medium text-gray-600">Present Address:</span>
                                    <p class="text-gray-900 mt-1">${employee.addressPresent || 'N/A'}</p>
                                </div>
                                <div>
                                    <span class="font-medium text-gray-600">Permanent Address:</span>
                                    <p class="text-gray-900 mt-1">${employee.addressPermanent || 'N/A'}</p>
                                </div>
                            </div>
                        </div>

                        <!-- Emergency Contact -->
                        <div class="bg-gray-50 rounded-lg p-4">
                            <h4 class="text-lg font-semibold mb-4 text-gray-800">Emergency Contact</h4>
                            <div class="space-y-3">
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Contact Name:</span>
                                    <span class="text-gray-900">${employee.emergencyContactName || 'N/A'}</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium text-gray-600">Contact Phone:</span>
                                    <span class="text-gray-900">${employee.emergencyContactPhone || 'N/A'}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Skills, Education, and Experience -->
                    <div class="space-y-6">
                        <!-- Skills -->
                        <div class="bg-gray-50 rounded-lg p-4">
                            <h4 class="text-lg font-semibold mb-4 text-gray-800">Skills</h4>
                            <div class="space-y-3">
                                ${skills.length > 0 ? skills.map(skill => `
                                    <div class="flex justify-between items-center bg-white p-3 rounded">
                                        <div>
                                            <span class="font-medium text-gray-900">${skill.name || 'N/A'}</span>
                                            <span class="text-sm text-gray-500 ml-2">(${skill.years || 0} years)</span>
                                        </div>
                                        <span class="px-2 py-1 text-xs font-semibold rounded-full ${
                                            skill.level === 'Expert' ? 'bg-green-100 text-green-800' :
                                            skill.level === 'Advanced' ? 'bg-blue-100 text-blue-800' :
                                            'bg-yellow-100 text-yellow-800'
                                        }">
                                            ${skill.level || 'Beginner'}
                                        </span>
                                    </div>
                                `).join('') : '<p class="text-gray-500 text-center py-4">No skills listed</p>'}
                            </div>
                        </div>

                        <!-- Education -->
                        <div class="bg-gray-50 rounded-lg p-4">
                            <h4 class="text-lg font-semibold mb-4 text-gray-800">Education</h4>
                            <div class="space-y-3">
                                ${education.length > 0 ? education.map(edu => `
                                    <div class="bg-white p-3 rounded">
                                        <div class="font-medium text-gray-900">${edu.degreeTitle || 'N/A'}</div>
                                        <div class="text-sm text-gray-600">${edu.institutionName || 'N/A'}</div>
                                        <div class="text-xs text-gray-500 mt-1">
                                            ${edu.majorSubject || ''} • ${edu.passingYear || ''} • ${edu.resultType || ''}: ${edu.resultValue || ''}
                                        </div>
                                    </div>
                                `).join('') : '<p class="text-gray-500 text-center py-4">No education information</p>'}
                            </div>
                        </div>

                        <!-- Experience -->
                        <div class="bg-gray-50 rounded-lg p-4">
                            <h4 class="text-lg font-semibold mb-4 text-gray-800">Work Experience</h4>
                            <div class="space-y-4">
                                ${experience.length > 0 ? experience.map(exp => `
                                    <div class="bg-white p-4 rounded border-l-4 border-blue-500">
                                        <div class="font-medium text-gray-900">${exp.designation || 'N/A'}</div>
                                        <div class="text-sm text-gray-600">${exp.companyName || 'N/A'}</div>
                                        <div class="text-xs text-gray-500 mt-1">
                                            ${exp.startDate ? new Date(exp.startDate).toLocaleDateString() : 'N/A'} - 
                                            ${exp.endDate ? new Date(exp.endDate).toLocaleDateString() : 'Present'}
                                            ${exp.location ? ` • ${exp.location}` : ''}
                                        </div>
                                        ${exp.jobResponsibilities ? `
                                            <div class="mt-2 text-sm text-gray-700">
                                                <strong>Responsibilities:</strong>
                                                <div class="mt-1 whitespace-pre-line">${exp.jobResponsibilities}</div>
                                            </div>
                                        ` : ''}
                                        ${exp.reasonForLeaving ? `
                                            <div class="mt-2 text-xs text-gray-500">
                                                <strong>Reason for leaving:</strong> ${exp.reasonForLeaving}
                                            </div>
                                        ` : ''}
                                    </div>
                                `).join('') : '<p class="text-gray-500 text-center py-4">No work experience listed</p>'}
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex gap-4 pt-4">
                            <a href="https://mesbahuddin.com/web/r/apps/playground/employee-entry?P3_EMP_ID=${employee.empId}" target="_blank" 
                               class="flex-1 btn-primary text-white px-6 py-3 rounded-md font-medium text-center hover:bg-blue-600">
                                Edit Profile
                            </a>
                            <a href="https://mesbahuddin.com/web/r/apps/playground/resume?P4_EMP_ID=${employee.empId}" target="_blank" 
                               class="flex-1 bg-green-500 text-white px-6 py-3 rounded-md font-medium text-center hover:bg-green-600">
                                View CV
                            </a>
                        </div>
                    </div>
                </div>
            `;
        }

        // Close modal
        function closeModal() {
            document.getElementById('employeeModal').classList.add('hidden');
            document.body.style.overflow = 'auto';
        }

        // Update result count display
        function updateResultCount() {
            const countElement = document.getElementById('resultCount');
            const count = filteredEmployees.length;
            const total = allEmployees.length;
            
            if (count === total) {
                countElement.textContent = `Showing all ${total} employees`;
            } else {
                countElement.textContent = `Showing ${count} of ${total} employees`;
            }
        }

        // Show loading state
        function showLoadingState() {
            document.getElementById('loadingState').classList.remove('hidden');
            document.getElementById('employeeTable').classList.add('hidden');
            document.getElementById('errorState').classList.add('hidden');
            document.getElementById('emptyState').classList.add('hidden');
        }

        // Show table state
        function showTableState() {
            document.getElementById('loadingState').classList.add('hidden');
            document.getElementById('employeeTable').classList.remove('hidden');
            document.getElementById('errorState').classList.add('hidden');
            document.getElementById('emptyState').classList.add('hidden');
        }

        // Show error state
        function showErrorState() {
            document.getElementById('loadingState').classList.add('hidden');
            document.getElementById('employeeTable').classList.add('hidden');
            document.getElementById('errorState').classList.remove('hidden');
            document.getElementById('emptyState').classList.add('hidden');
            document.getElementById('resultCount').textContent = 'Error loading data';
        }

        // Show empty state
        function showEmptyState() {
            document.getElementById('loadingState').classList.add('hidden');
            document.getElementById('employeeTable').classList.add('hidden');
            document.getElementById('errorState').classList.add('hidden');
            document.getElementById('emptyState').classList.remove('hidden');
            updateResultCount();
        }

        // Show/hide search loading spinner
        function showSearchLoading(loading) {
            const btn = document.getElementById('searchBtn');
            const text = document.getElementById('searchBtnText');
            const spinner = document.getElementById('searchSpinner');
            const icon = document.getElementById('searchIcon');
            
            if (loading) {
                btn.disabled = true;
                btn.style.opacity = '0.8';
                text.textContent = 'Searching';
                icon.classList.add('hidden');
                spinner.classList.remove('hidden');
                spinner.classList.add('inline-block');
            } else {
                btn.disabled = false;
                btn.style.opacity = '1';
                text.textContent = 'Search';
                icon.classList.remove('hidden');
                spinner.classList.add('hidden');
                spinner.classList.remove('inline-block');
            }
        }

        // Utility function to get age from date of birth
        function calculateAge(dateOfBirth) {
            if (!dateOfBirth) return 'N/A';
            
            const today = new Date();
            const birthDate = new Date(dateOfBirth);
            let age = today.getFullYear() - birthDate.getFullYear();
            const monthDiff = today.getMonth() - birthDate.getMonth();
            
            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
                age--;
            }
            
            return age;
        }

        // Add responsive behavior for mobile
        window.addEventListener('resize', function() {
            // Close any open action menus on resize
            document.querySelectorAll('[id^="actionMenu-"]').forEach(menu => {
                menu.classList.add('hidden');
            });
        });

        // Add keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Escape key to close modal
            if (e.key === 'Escape') {
                closeModal();
            }
            
            // Ctrl/Cmd + K to focus search
            if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                e.preventDefault();
                document.getElementById('empName').focus();
            }
        });

        // Add search on input for real-time filtering
        let searchTimeout;
        document.getElementById('empName').addEventListener('input', function() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                if (this.value.length > 2 || this.value.length === 0) {
                    searchEmployees();
                }
            }, 500);
        });

        // Handle network errors gracefully
        window.addEventListener('online', function() {
            console.log('Network connection restored');
            if (allEmployees.length === 0) {
                loadEmployees();
            }
        });

        window.addEventListener('offline', function() {
            console.log('Network connection lost');
        });
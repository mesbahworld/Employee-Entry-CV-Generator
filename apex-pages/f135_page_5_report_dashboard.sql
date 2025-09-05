prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>100000
,p_default_application_id=>135
,p_default_id_offset=>0
,p_default_owner=>'UNORGANIZED'
);
end;
/
 
prompt APPLICATION 135 - Playground
--
-- Application Export:
--   Application:     135
--   Name:            Playground
--   Exported By:     MESBAHWORLD
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 5
--   Manifest End
--   Version:         24.2.0
--   Instance ID:     743399910586821
--

begin
null;
end;
/
prompt --application/pages/delete_00005
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>5);
end;
/
prompt --application/pages/page_00005
begin
wwv_flow_imp_page.create_page(
 p_id=>5
,p_name=>'Report Dashboard'
,p_alias=>'REPORT-DASHBOARD'
,p_step_title=>'Report Dashboard'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.js',
'#APP_FILES#js/page5custom#MIN#.js'))
,p_css_file_urls=>'https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'',
'        .t-Footer, .t-Header  {',
'            display: none !important;',
'        }',
'',
'',
'',
'        :root {',
'            --primary-color: #FFD700 !important;',
'            --secondary-color: #222 !important;',
'            --light-gray: #f5f5f5 !important;',
'            --border-color: #ddd !important;',
'            --header-bg: linear-gradient(135deg, #fff 0%, var(--primary-color) 100%) !important;',
'        }',
'        ',
'        .modal-backdrop {',
'            backdrop-filter: blur(5px);',
'            background-color: rgba(0, 0, 0, 0.5);',
'        }',
'        .glassmorphism {',
'            background: rgba(255, 255, 255, 0.1);',
'            backdrop-filter: blur(10px);',
'            border: 1px solid rgba(255, 255, 255, 0.2);',
'        }',
'        .card-hover {',
'            transition: all 0.3s ease;',
'        }',
'        .card-hover:hover {',
'            transform: translateY(-2px);',
'            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);',
'        }',
'        .gradient-bg {',
'            background: var(--header-bg);',
'            color: var(--secondary-color);',
'        }',
'        .btn-primary {',
'            background: linear-gradient(135deg, var(--primary-color) 0%, #FFA500 100%);',
'            color: var(--secondary-color);',
'            transition: all 0.3s ease;',
'            font-weight: 600;',
'        }',
'        .btn-primary:hover {',
'            transform: translateY(-1px);',
'            box-shadow: 0 10px 20px rgba(255, 215, 0, 0.3);',
'            background: linear-gradient(135deg, #FFA500 0%, var(--primary-color) 100%);',
'        }',
'        .loading-spinner {',
'            border: 2px solid var(--light-gray);',
'            border-top: 2px solid var(--primary-color);',
'            border-radius: 50%;',
'            width: 20px;',
'            height: 20px;',
'            animation: spin 1s linear infinite;',
'        }',
'        @keyframes spin {',
'            0% { transform: rotate(0deg); }',
'            100% { transform: rotate(360deg); }',
'        }',
'        .fade-in {',
'            animation: fadeIn 0.5s ease-in;',
'        }',
'        @keyframes fadeIn {',
'            from { opacity: 0; transform: translateY(20px); }',
'            to { opacity: 1; transform: translateY(0); }',
'        }',
'        ',
'        /* Custom color overrides */',
'        .bg-gray-50 {',
'            background-color: var(--light-gray) !important;',
'        }',
'        .border-gray-300 {',
'            border-color: var(--border-color) !important;',
'        }',
'        .focus\:ring-blue-500:focus {',
'            ring-color: var(--primary-color) !important;',
'        }',
'        .bg-blue-500 {',
'            background-color: var(--primary-color) !important;',
'            color: var(--secondary-color) !important;',
'        }',
'        .hover\:bg-blue-600:hover {',
'            background-color: #FFA500 !important;',
'        }',
'        .text-blue-100 {',
'            color: rgba(34, 34, 34, 0.8) !important;',
'        }',
'        .bg-blue-100 {',
'            background-color: rgba(255, 215, 0, 0.1) !important;',
'        }',
'        .text-blue-800 {',
'            color: var(--secondary-color) !important;',
'        }',
'        .border-blue-500 {',
'            border-color: var(--primary-color) !important;',
'        }',
''))
,p_step_template=>2979075366320325194
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'U'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1657069868487212)
,p_plug_name=>'html'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    <!-- Header -->',
'    <header class="gradient-bg text-white shadow-lg">',
'        <div class="container mx-auto px-6 py-4">',
'            <div class="flex justify-between items-center flex-wrap gap-3">',
'            <!-- Logo and title section -->',
'            <div class="flex items-center">',
'                <!-- Logo with link -->',
'                <a href="https://mesbahuddin.com/web/r/apps/playground/pg1-landing-page" class="flex items-center mr-4">',
'                    <div class="h-12 w-12 rounded-full bg-white flex items-center justify-center shadow-md">',
'                        <svg class="h-8 w-8" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">',
'                            <path d="M12 4.35418C12.7329 3.52375 13.8053 3 15 3C17.2091 3 19 4.79086 19 7C19 7.73428 18.8115 8.42586 18.4818 9.03189L21.8205 12.3705C22.575 13.125 22.575 14.325 21.8205 15.0795C21.4782 15.4218 21.0337 15.6119 20.5605 1'
||'5.6497C20.4689 15.6574 20.375 15.6667 20.2857 15.6667H19V19C19 20.1046 18.1046 21 17 21H13V17C13 16.4477 12.5523 16 12 16C11.4477 16 11 16.4477 11 17V21H7C5.89543 21 5 20.1046 5 19V15.6667H3.71429C3.62498 15.6667 3.53106 15.6574 3.43946 15.6497C2.966'
||'31 15.6119 2.52175 15.4218 2.17949 15.0795C1.42502 14.325 1.42502 13.125 2.17949 12.3705L5.51811 9.03189C5.18845 8.42586 5 7.73428 5 7C5 4.79086 6.79086 3 9 3C10.1947 3 11.2671 3.52375 12 4.35418Z" fill="var(--primary-color)"/>',
'                        </svg>',
'                    </div>',
'                </a>',
'                <!-- Title and subtitle -->',
'                <div>',
'                    <h1 class="text-3xl font-bold">Employee  Dashboard</h1>',
'                    <p class="text-blue-100 mt-1">Manage and view employee information</p>',
'                </div>',
'            </div>',
'                <div class="flex gap-3">',
'                    <!-- New Employee button without parameters -->',
'                    <a href="https://mesbahuddin.com/web/r/apps/playground/employee-entry"',
'                       class="bg-white text-purple-600 px-6 py-2 rounded-md font-medium hover:bg-gray-100 flex items-center gap-2 transition-all">',
'                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">',
'                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>',
'                        </svg>',
'                        New Employee',
'                    </a>',
'                </div>',
'            </div>',
'        </div>',
'    </header>',
'',
'    <div class="container mx-auto px-6 py-8">',
'        <!-- Filter Section -->',
'        <div class="bg-white rounded-lg shadow-md p-6 mb-8 card-hover">',
'            <h2 class="text-xl font-semibold mb-4 text-gray-800">Search & Filter</h2>',
'            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">',
'                <div>',
'                    <label class="block text-sm font-medium text-gray-700 mb-2">Employee ID</label>',
'                    <input type="number" id="empId" placeholder="Enter Employee ID" ',
'                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">',
'                </div>',
'                <div>',
'                    <label class="block text-sm font-medium text-gray-700 mb-2">Employee Name</label>',
'                    <input type="text" id="empName" placeholder="Search by name..." ',
'                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">',
'                </div>',
'                <div>',
'                    <label class="block text-sm font-medium text-gray-700 mb-2">Department</label>',
'                    <select id="deptFilter" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">',
'                        <option value="">All Departments</option>',
'                    </select>',
'                </div>',
'            </div>',
'            <div class="mt-4 flex gap-3">',
'                <button type="button" id="searchBtn" class="btn-primary text-white px-6 py-2 rounded-md font-medium hover:bg-blue-600 flex items-center justify-center">',
'                    <svg id="searchIcon" class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">',
'                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>',
'                    </svg>',
'                    <span id="searchBtnText">Search</span>',
'                    <div id="searchSpinner" class="loading-spinner ml-2 hidden inline-block"></div>',
'                </button>',
'                <button type="button" id="clearBtn" class="bg-gray-500 text-white px-6 py-2 rounded-md font-medium hover:bg-gray-600 flex items-center">',
'                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">',
'                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>',
'                    </svg>',
'                    Clear Filters',
'                </button>',
'                <button type="button" id="refreshBtn" class="bg-green-500 text-white px-6 py-2 rounded-md font-medium hover:bg-green-600 flex items-center">',
'                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">',
'                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>',
'                    </svg>',
'                    Refresh Data',
'                </button>',
'            </div>',
'        </div>',
'',
'        <!-- Results Section -->',
'        <div class="bg-white rounded-lg shadow-md overflow-hidden">',
'            <div class="p-6 border-b border-gray-200">',
'                <h2 class="text-xl font-semibold text-gray-800">Employee List</h2>',
'                <p id="resultCount" class="text-gray-600 mt-1">Loading employees...</p>',
'            </div>',
'            ',
'            <!-- Loading State -->',
'            <div id="loadingState" class="p-8 text-center">',
'                <div class="loading-spinner mx-auto mb-4"></div>',
'                <p class="text-gray-600">Loading employees...</p>',
'            </div>',
'',
'            <!-- Error State -->',
'            <div id="errorState" class="p-8 text-center hidden">',
unistr('                <div class="text-red-500 text-6xl mb-4">\26A0\FE0F</div>'),
'                <p class="text-red-600 mb-4">Failed to load employee data</p>',
'                <button type="button" onclick="loadEmployees()" class="btn-primary text-white px-4 py-2 rounded-md">',
'                    Try Again',
'                </button>',
'            </div>',
'',
'            <!-- Employee Table -->',
'            <div id="employeeTable" class="hidden">',
'                <div class="overflow-x-auto">',
'                    <table class="w-full">',
'                        <thead class="bg-gray-50">',
'                            <tr>',
'                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Employee</th>',
'                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Contact</th>',
'                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Department</th>',
'                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Join Date</th>',
'                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Salary</th>',
'                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>',
'                            </tr>',
'                        </thead>',
'                        <tbody id="employeeTableBody" class="bg-white divide-y divide-gray-200">',
'                        </tbody>',
'                    </table>',
'                </div>',
'            </div>',
'',
'            <!-- Empty State -->',
'            <div id="emptyState" class="p-8 text-center hidden">',
unistr('                <div class="text-gray-400 text-6xl mb-4">\D83D\DC65</div>'),
'                <p class="text-gray-600 mb-4">No employees found</p>',
'                <p class="text-gray-500 text-sm">Try adjusting your search criteria</p>',
'            </div>',
'        </div>',
'    </div>',
'',
'    <!-- Employee Detail Modal -->',
'    <div id="employeeModal" class="fixed inset-0 z-50 hidden modal-backdrop">',
'        <div class="flex items-center justify-center min-h-screen p-4">',
'            <div class="bg-white rounded-lg shadow-xl max-w-4xl w-full max-h-screen overflow-y-auto">',
'                <div class="p-6 border-b border-gray-200 gradient-bg text-white">',
'                    <div class="flex justify-between items-center">',
'                        <h3 class="text-2xl font-bold" id="modalEmployeeName">Employee Details</h3>',
'                        <button type="button" id="closeModal" class="text-white hover:text-gray-300 text-2xl">&times;</button>',
'                    </div>',
'                </div>',
'                <div class="p-6" id="modalContent">',
'                    <!-- Modal content will be populated dynamically -->',
'                </div>',
'            </div>',
'        </div>',
'    </div>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done

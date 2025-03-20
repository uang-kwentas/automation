*** Variables ***
${URL}                     http://localhost:4200/login
${DASHBOARD_URL}           http://localhost:4200/dashboard
${COURSELIST}              http://localhost:4200/courselist
${BROWSER}                 Chrome
${USERNAME}                admin
${PASSWORD}                admin
${search_data}             21
${search_data1}            invalid1

#XPATHS
${dashboard_header}         xpath=//h1[contains(text(), 'DASHBOARD OVERVIEW')]
${username_field}           xpath=//input[@placeholder='Username']
${password_field}           xpath=//input[@placeholder='Password']
${login_button}             xpath=//button[@type='submit']
${course_header}            xpath=//h1[contains(., 'Course Master List')]
${course_button}            xpath=(//a[normalize-space()='Course Master List'])[1]
${course_search_bar}        xpath=(//input[@placeholder='🔍 Search All Data'])[1]
${course_search_result}     xpath=(//div[@class='table-container'])[1]
${status_deactivate}        xpath=(//td[normalize-space()='Inactive'])[1]
${status1_activate}         xpath=(//td[contains(text(),'Active')])[1]

#MODAL FIELDS
${course_modal}             xpath=((//div[@class='modal-content'])[1])
${coursename_field}         xpath=//input[@id='addCourseName']
${coursecode_field}         xpath=//input[@id='addCourseCode']
${coursedept_field}         xpath=//input[@id='addDepartment']
${course_duration}          xpath=//input[@id='addDuration']
${course_description}       xpath=//input[@id='addDescription']
${course_status}            xpath=//select[@id='addStatus']
${course_table}             xpath=//div[@class='filter-container']

#COURSE BUTTONS
${course_search_button}     xpath=(//button[contains(text(),'🔎 Search')])[1]
${course_savebutton}        xpath=//button[@type='submit']
${course_reset_button}      xpath=(//button[contains(text(),'🔄 Reset')])[1]
${course_cancelbutton}      xpath=//button[contains(@class, 'cancel-btn')]
${addcourse_button}         xpath=(//button[@class='add-btn'])
${logout_button}            xpath=(//button[@class='logout-btn'])
${reset_button}             xpath=(//button[@class='reset-btn'])
${csave}                    xpath=//button[@type='submit']
${editcourse_button}        xpath=//tbody/tr[1]/td[7]/button[1]
#${deactivate_button}       xpath=(//button[@class='remove-btn'][contains(text(),'🔴 Deactivate')])[1]
#${restore_button}          xpath=(//button[contains(text(),'🔄 Restore')])[1]

#MODAL DATAS
${modal_NAME}               Bachelor of ${{random.choice(['Science', 'Arts', 'Technology'])}}
${modal_CODE}               ${{random.choice(['BS','BEED', 'BSP', 'BSHM', 'BSTM', 'BSIE', 'BIT']) + str(random.randint(101, 999))}}
${modal_DEPT}               ${{random.choice(["account", "engrish", "itik", "hrmus", "mkttas", "mgts", "finish"])}}
${modal_DURATION}           ${{random.randint(1, 5)}}
${modal_STATUS}             ${{random.choice(['Active', 'Inactive'])}}
${modal_DESC}               This is a course description


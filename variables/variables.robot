*** Variables ***
${URL}                     http://localhost:4200/login
${DASHBOARD_URL}           http://localhost:4200/dashboard
${COURSELIST}              http://localhost:4200/courselist
${BROWSER}                 Chrome
${USERNAME}                admin
${PASSWORD}                admin
${search_data}             Bachelor of Science
${search_data1}            IT101
#XPATHS
${dashboard_header}         xpath=//h1[contains(text(), 'DASHBOARD OVERVIEW')]
${username_field}           xpath=//input[@placeholder='Username']
${password_field}           xpath=//input[@placeholder='Password']
${login_button}             xpath=//button[@type='submit']
${course_header}            xpath=//h1[contains(., 'Course Master List')]
${course_button}            xpath=(//a[normalize-space()='Course Master List'])[1]
${course_search_bar}        xpath=(//input[@placeholder='🔍 Search All Data'])[1]
${course_searchbutton}      xpath=(//button[contains(text(),'🔎 Search')])[1]
${course_table}             xpath=(//div[@class='table-container'])[1]
${deactivate}               xpath=(//button[@class='remove-btn'][contains(text(),'🔴 Deactivate')])[1]
${activate}                 xpath=(//button[@class='restore-btn'][contains(text(),'🔄 Restore')])[1]
${coursetable_scroll}       xpath=(//div[@class='table-scroll'])[1]
${select_category}          xpath=//select[contains(@class, 'ng-valid')]
${select_category1}         Course Name    # This corresponds to the value of "Search by Course Name"
${select_category2}         Course Code    # This corresponds to the value of "Search by Course Code"
#MODAL FIELDS

${course_modal}             xpath=((//div[@class='modal-content'])[1])
${coursename_field}         xpath=//input[@id='addCourseName']
${coursecode_field}         xpath=//input[@id='addCourseCode']
${coursedept_field}         xpath=//input[@id='addDepartment']
${course_duration}          xpath=//input[@id='addDuration']
${course_description}       xpath=//input[@id='addDescription']
${course_table}             xpath=//div[@class='filter-container']
${FA103}                    xpath=(//td[normalize-space()='FA103'])[1]
${IT101}                    xpath=(//td[normalize-space()='IT101'])[1]

#COURSE BUTTONS
${course_search_button}     xpath=(//button[contains(text(),'🔎 Search')])[1]
${course_savebutton}        xpath=//button[@type='submit']
${course_reset_button}      xpath=(//button[contains(text(),'🔄 Reset')])[1]
${course_cancelbutton}      xpath=//button[contains(@class, 'cancel-btn')]
${addcourse_button}         xpath=(//button[@class='add-btn'])
${logout_button}            xpath=(//button[@class='logout-btn'])
${reset_button}             xpath=(//button[@class='reset-btn'])
${csave}                    xpath=//button[@type='submit']
${editcourse_button}        xpath=(//button[@class='edit-btn'][contains(text(),'✏️ Edit')])[1]

${activate}                 xpath=(//button[contains(text(),'🔄 Restore')])[1]
${deactivate}               xpath=(//button[@class='remove-btn'][contains(text(),'🔴 Deactivate')])[1]
@{OPTIONS}                   Restore  Deactivate

#MODAL DATAS
${modal_NAME}              ${{"Bachelor of " + random.choice(['Science', 'Arts', 'Technology'])}}
${modal_CODE}              ${{random.choice(['BS','BEED', 'BSP', 'BSHM', 'BSTM', 'BSIE', 'BIT']) + str(random.randint(101, 499))}}
${modal_DEPT}              ${{random.choice(["account", "engrish", "itik", "hrmus", "mkttas", "mgts", "finish"])}}
${modal_DURATION}          ${{random.randint(1, 5)}}
# Science Course Codes & Departments
@{SCIENCE_CODES}          BSBIO   BSCHEM    BSPHYS    BSM   BSES
@{SCIENCE_DEPTS}            Biology    Chemistry    Physics    Mathematics    Environmental Science
# Arts Course Codes & Departments
@{ARTS_CODES}               BFA   BMUS    BTA    BALIT    BAEL
@{ARTS_DEPTS}                Fine Arts    Music    Theater Arts    Literature    Linguistics
# Technology Course Codes & Departments
@{TECH_CODES}               BSIT    BSCS    BSE    BSNET    BSR
@{TECH_DEPTS}                Information Technology    Computer Science    Engineering    Networking    Robotics
@{SCIENCE_DESC}
...    A comprehensive study of physics, chemistry, and biology.
...    Prepares students for careers in research and healthcare.
...    Equips learners with fundamental and applied scientific knowledge.

@{ARTS_DESC}
...    An in-depth study of various artistic disciplines and creative expression.
...    Covers visual arts, music, and literature.
...    Encourages students to develop their unique artistic voices.

@{TECH_DESC}
...    A hands-on course focusing on modern technological advancements and applications.
...    Provides extensive training in software development and IT infrastructure.
...    Prepares students for careers in emerging technologies.
...    A cutting-edge program on emerging technologies.
...    Focuses on practical applications in the tech industry.
...    Equips students with essential IT and engineering skills.

${modal_DESC}      ${{random.choice(SCIENCE_DESC) if 'Science' in modal_NAME else random.choice(ARTS_DESC) if 'Arts' in modal_NAME else  random.choice(TECH_DESC)}}

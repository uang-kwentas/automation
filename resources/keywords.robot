*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    BuiltIn
Library    random
Resource   ../common/common.py
Resource   ../resources/keywords.robot
Resource   ../variables/variables.robot

*** Keywords ***
Open Login Page
    [Documentation]  Opens the browser and navigates to the login page
    [Tags]           LP-001
    Open Browser                    ${URL}   ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible   ${username_field}           10s

Verify Login Elements
    [Documentation]  Verifies essential login elements are visible and enabled
    [Tags]           LP-001
    Page Should Contain Element    ${username_field}
    Element Should Be Enabled      ${username_field}
    Page Should Contain Element    ${password_field}
    Element Should Be Enabled      ${password_field}
    Page Should Contain Element    ${login_button}
    Element Should Be Enabled      ${login_button}

Enter Credentials
    [Documentation]  Inputs username and password, then clicks login
    [Tags]           LP-001
    [Arguments]                     ${username}          ${password}
    Input Text                      ${username_field}    ${username}
    Input Text                      ${password_field}    ${password}
    Click Element                   ${login_button}

Confirm Dashboard Navigation to Course Master List
    [Documentation]  Verifies successful navigation to the dashboard
    [Tags]           DP-001
    Wait Until Element Is Visible    ${dashboard_header}         10s
    Page Should Contain Element      ${dashboard_header}
    Click Element                    ${course_button}
Access and Search Course Master List
    [Documentation]  Clicks the Course Master List button
    [Tags]            CML-001
    Wait Until Element Is Visible  ${course_header}              3s
    Page Should Contain Element    ${course_header}
    Element Should Be Enabled      ${course_header}
    Sleep                                                        1s

    # Select "Search by Course Name" from the dropdown
    Click Button                   ${course_searchbutton}
    Sleep                                                        1s
    Alert Should Be Present
    Select From List By Value      ${select_category}      ${select_category1}
    Input Text                     ${course_search_bar}    ${search_data}
    Click Button                   ${course_searchbutton}
    Sleep                                                        1s
    Click Button                   ${course_reset_button}
    Click Button                   ${course_searchbutton}
    Sleep                                                        1s
    Alert Should Be Present

    # Wait and verify the course table
    Wait Until Element Is Visible  ${course_table}               5s
    Page Should Contain Element    ${course_table}
    Element Should Be Enabled      ${course_table}

    # Select "Search by Course Code" from the dropdown
    Select From List By Value      ${select_category}      ${select_category2}
    Input Text                     ${course_search_bar}    ${search_data1}
    Click Button                   ${course_searchbutton}
    Sleep                                                        1s
    Click Button                   ${course_reset_button}
    Click Button                   ${course_searchbutton}
    Sleep                                                        1s
    Alert Should Be Present
    Wait Until Element Is Visible  ${course_table}               1s
    Sleep                                                        5s
    Page Should Contain Element    ${course_table}               5s
    Element Should Be Enabled      ${course_table}
Generate Course Name, Code, and Department
    [Documentation]  #Generates random course name, code, and department.
    [Tags]            CML-001
    ${course_type}   Evaluate    random.choice(['Science', 'Arts', 'Technology'])
    ${modal_NAME}    Set Variable    Bachelor of ${course_type}

    # Assign correct course code based on course type
    ${modal_CODE}    Run Keyword If    '${course_type}' == 'Science'    Evaluate    random.choice(${SCIENCE_CODES}) + str(random.randint(101, 999))
    ...    ELSE IF   '${course_type}' == 'Arts'    Evaluate    random.choice(${ARTS_CODES}) + str(random.randint(101, 999))
    ...    ELSE      Evaluate    random.choice(${TECH_CODES}) + str(random.randint(101, 999))

    # Assign corresponding department based on course type
    ${modal_DEPT}    Run Keyword If    '${course_type}' == 'Science'    Evaluate    random.choice(${SCIENCE_DEPTS})
    ...    ELSE IF   '${course_type}' == 'Arts'    Evaluate    random.choice(${ARTS_DEPTS})
    ...    ELSE      Evaluate    random.choice(${TECH_DEPTS})

           RETURN      ${modal_NAME}    ${modal_CODE}    ${modal_DEPT}

Generate Random Description
    [Documentation]  Fills in the course details and submits
    [Tags]            CML-001
    [Arguments]    ${course_name}
    ${modal_DESC}    Set Variable    Default Course Description

    IF       "Science" in "${course_name}"
            ${modal_DESC}    Evaluate    random.choice(${SCIENCE_DESC})    random
    ELSE IF  "Arts" in "${course_name}"
            ${modal_DESC}    Evaluate    random.choice(${ARTS_DESC})    random
    ELSE IF  "Technology" in "${course_name}"
            ${modal_DESC}    Evaluate    random.choice(${TECH_DESC})    random
    END

    RETURN  ${modal_DESC}
Complete and Submit Course Details
    [Documentation]  Fills in the course details and submits
    [Tags]            CML-001
    ${modal_NAME}                  ${modal_CODE}             ${modal_DEPT}  Generate Course Name, Code, and Department
    ${modal_DESC}              Generate Random Description   ${modal_NAME}
    Click Element                  ${addcourse_button}
    Sleep                                                        1s
    Input Text                     ${coursename_field}      ${modal_NAME}
    Sleep                                                        1s
    Input Text                     ${coursecode_field}      ${modal_CODE}
    Sleep                                                        1s
    Input Text                     ${coursedept_field}      ${modal_DEPT}
    Sleep                                                        1s
    Input Text                     ${course_duration}       ${modal_DURATION}
    Sleep                                                        1s
    Input Text                    ${course_description}      ${modal_DESC}
Confirm Save Button
   [Documentation]  Verifies the save button is enabled and clicks it
    [Tags]             CML-001
    Click Button                   ${csave}
    Sleep                                                        5s
    Alert Should Be Present
    Sleep                                                        5s
    Wait Until Element Is Visible  ${course_table}               30s
    Page Should Contain Element    ${course_table}
    Element Should Be Enabled      ${course_table}
Edit Modal Course
    [Documentation]  Edits the course details and submits
    [Tags]            CML-001
    ${modal_NAME}                  ${modal_CODE}              ${modal_DEPT}    Generate Course Name, Code, and Department
    ${modal_DESC}    Generate Random Description              ${modal_NAME}
    Click Button                   ${editcourse_button}
    Wait Until Element Is Visible  ${course_modal}             5s
    Sleep                                                      1s
    Input Text                     ${coursename_field}         ${modal_NAME}
    Sleep                                                      1s
    Input Text                     ${coursecode_field}         ${modal_CODE}
    Sleep                                                      1s
    Input Text                     ${coursedept_field}         ${modal_DEPT}
    Sleep                                                      1s
    Input Text                     ${course_duration}          ${modal_DURATION}
    Sleep                                                      1s
    Input Text                     ${course_description}        ${modal_DESC}
    Click Button                   ${csave}
    Alert Should Be Present
    Sleep                                                       5s

Course Restore and Deactivation thru Course Code
    [Documentation]
    [Tags]        CML-001
    Log    Checking course status...
    # Check if the Deactivate button is present (course is active)
    FOR  ${i}  IN RANGE  2  # Only deactivate the first two courses
    Log  Iteration ${i + 1}: Checking course status...
    Sleep  1s

        ${FA103_CODE}     Get Text     ${FA103}
        ${IT101_CODE}     Get Text     ${IT101}
        Log To Console    Course Code: ${FA103_CODE}
        Log To Console    Course Code: ${IT101_CODE}

    # Check if the Deactivate button is present (course is active)
        ${deactivate_present} =  Run Keyword And Return Status  Element Should Be Visible  ${deactivate}
        Log To Console  Deactivate button visibility: ${deactivate_present}
        Sleep  1s
        IF  ${deactivate_present}
        Log  Course is active. Proceeding to deactivate...
        Click Button  ${deactivate}
        Log  Clicking Deactivate button...
        Sleep  1s
        # Handle the confirmation pop-up
        ${alert_present} =  Run Keyword And Return Status  Alert Should Be Present
        IF  ${alert_present}
            Handle Alert  accept
            Log  Successfully handled alert after deactivation
        END
        Sleep   1s
        # Confirm that the Restore button appears after deactivation
        Wait Until Element Is Visible  ${activate}
        Log  Successfully deactivated, Restore button should be visible now.
        Sleep   1s
        ELSE
        Log  Skipping deactivation since course is already inactive.
        END
        Log  Iteration ${i + 1} completed.
        Sleep  1s
        END
        Sleep  3s
        Log  All selected courses deactivated. Proceeding to restore...

        FOR  ${i}  IN RANGE  2  # Only restore the first two courses
        Log  Iteration ${i + 1}: Restoring course...
        Sleep               1s
            ${FA103_CODE}     Get Text     ${FA103}
            ${IT101_CODE}     Get Text     ${IT101}
            Log To Console    Course Code: ${FA103_CODE}
            Log To Console    Course Code: ${IT101_CODE}

        # Check if the Restore button is present (course is inactive)
        ${restore_present} =  Run Keyword And Return Status  Element Should Be Visible  ${activate}
        Log To Console  Restore button visibility: ${restore_present}
    Sleep   1s

        IF  ${restore_present}
        Log  Course is inactive. Proceeding to restore...
        Click Button  ${activate}
        Log  Clicking Restore button...
        Sleep  1s
        # Handle the confirmation pop-up
        ${alert_present} =  Run Keyword And Return Status  Alert Should Be Present
        IF  ${alert_present}
            Handle Alert  accept
            Log  Successfully handled alert after restoration
        END
        Sleep   1s
        # Confirm that the Deactivate button appears after restoration
        Wait Until Element Is Visible  ${deactivate}
        Log  Successfully restored, Deactivate button should be visible now.
        Sleep   1s
        ELSE
        Log  Skipping restoration since course is already active.
        END
        Log  Iteration ${i + 1} completed.
        Sleep  1s
        END
        Log  Test completed. First two courses were deactivated and restored, no additional deactivations performed.


Perform User Logout
       [Documentation]  Logs out the user
       [Tags]            CML-001
       Sleep                                                       1s
       Page Should Contain Element    ${logout_button}
       Element Should Be Enabled      ${logout_button}
       Sleep                                                       1s
       Click Button                   ${logout_button}
       Sleep                                                       1s
       Alert Should Be Present















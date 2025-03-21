*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    BuiltIn
Library    random
#Resource   ../common/common.py
Resource   ../resources/keywords.robot
Resource   ../variables/variables.robot
#Resource   ../variables/locators.robot

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

Confirm Dashboard Navigation
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
    Input Text                     ${course_search_bar}    ${search_data}
    Sleep                                                        1s
    Click Button                   ${course_reset_button}
    Wait Until Element Is Visible  ${course_table}               5s
    Page Should Contain Element    ${course_table}
    Element Should Be Enabled      ${course_table}
    Sleep                                                        1s
    Input Text                     ${course_search_bar}    ${search_data1}
    Wait Until Element Is Visible  ${course_table}               1s
    Sleep                                                        5s
    Page Should Contain Element    ${course_table}               5s
    Element Should Be Enabled      ${course_table}
    Click Button                   ${course_reset_button}
    Sleep                                                         1s
Complete and Submit Course Details
    [Documentation]  Fills in the course details and submits
    [Tags]            CML-001
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
    Input Text                     ${course_description}    ${modal_DESC}
    Sleep                                                        1s
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
    Click Button                   ${editcourse_button}
    Wait Until Element Is Visible  ${course_modal}             5s
    Sleep                                                      1s
    Input Text                     ${coursename_field}      ${modal_NAME}
    Sleep                                                      1s
    Input Text                     ${coursecode_field}      ${modal_CODE}
    Sleep                                                      1s
    Input Text                     ${coursedept_field}      ${modal_DEPT}
    Sleep                                                      1s
    Input Text                     ${course_duration}       ${modal_DURATION}
    Sleep                                                      1s
    Input Text                     ${course_description}    ${modal_DESC}
    Sleep                                                      1s
    Click Button                   ${csave}
    Alert Should Be Present
    Sleep                                                       5s

Restore And Deactivate
    [Documentation]  Restores the course and deactivates it
    [Tags]            CML-001
    FOR    ${ACTION}    IN    @{OPTIONS}
    Log    Performing action: ${ACTION}

    # Check if the deactivate button is visible
    ${deactivate_present} =   Run Keyword And Return Status
    ...   Element Should Be Visible   ${deactivate}

    Log To Console   Deactivate button visibility: ${deactivate_present}

    IF  '${ACTION}' == 'restore' and not ${deactivate_present}
        Wait Until Element Is Visible    ${activate}
        Click Button    ${activate}
        Log    Clicking Restore button...
        # Confirm that the deactivate button is visible again
        Wait Until Element Is Visible    ${deactivate}
        Log    Successfully restored, deactivate button should be visible now.

    ELSE IF  '${ACTION}' == 'deactivate' and ${deactivate_present}
        Wait Until Element Is Visible    ${deactivate}
        Click Button    ${deactivate}
        Log    Clicking Deactivate button...

        # Handle the alert after clicking deactivate
        ${alert_present} =   Run Keyword And Return Status   Alert Should Be Present
        IF  ${alert_present}
            Handle Alert    accept
            Log    Successfully handled alert after deactivation
        END

        # Confirm that the activate button is visible now
        Wait Until Element Is Visible    ${activate}
        Log    Successfully deactivated, restore button should be visible now.

    ELSE
        Log    Invalid action or action cannot be performed: ${ACTION}

    END
    END
   ${alert_present} =   Run Keyword And Return Status   Alert Should Be Present
    IF  ${alert_present}
    Handle Alert    accept
    Log    Successfully handled alert
    ELSE
    Log    No alert appeared
    END

Perform User Logout
    [Documentation]  Logs out the user
    [Tags]            CML-001
    Page Should Contain Element    ${logout_button}
    Element Should Be Enabled      ${logout_button}
    Sleep                                                        5s
    Click Button                   ${logout_button}
    Alert Should Be Present















*** Settings ***
Documentation      This test suite verifies the functionality of the application.
...               #Author: Joshua Remoroza
Library           SeleniumLibrary
#Resource          ../common/common.py
Resource          ../variables/variables.robot
Resource          ../resources/keywords.robot
#Resource          ../variables/locators.robot
*** Test Cases ***
Master Course List
    [Documentation]  Validates login, dashboard navigation, course master list access,
    ...               course creation, and logout in one seamless flow.
    [Tags]            LP-001  DP-001  CML-001
    Open Login Page
    Verify Login Elements
    Enter Credentials                 ${USERNAME}    ${PASSWORD}
    Confirm Dashboard Navigation
    Access and Search Course Master List
    Complete and Submit Course Details
    Confirm Save Button
    Perform User Logout
    #Toggle Course Status
    Sleep    3s
    [Teardown]    Close Browser

*** Settings ***
Documentation    Common keywords được sử dụng trong Mobile test suites
Library          AppiumLibrary
Library          Collections
Library          DateTime
Library          OperatingSystem

*** Keywords ***
Setup Test Environment
    [Documentation]    Thiết lập môi trường test
    Create Directory    results/screenshots
    Create Directory    logs

Cleanup Test Environment
    [Documentation]    Dọn dẹp môi trường test
    Close Application

Setup Test Case
    [Documentation]    Thiết lập cho mỗi test case
    Log    Starting test case: ${TEST_NAME}

Cleanup Test Case
    [Documentation]    Dọn dẹp sau mỗi test case
    # Run Keyword If Test Failed    Capture Page Screenshot    ${TEST_NAME}_FAILED.png
    Log    Completed test case: ${TEST_NAME}

Wait For Element And Click Mobile
    [Documentation]    Đợi element xuất hiện và click trên mobile
    [Arguments]    ${locator}    ${timeout}=10s
    
    Wait Until Page Contains Element    ${locator}    ${timeout}
    Click Element    ${locator}

Wait For Element And Input Text Mobile
    [Documentation]    Đợi element xuất hiện và nhập text trên mobile
    [Arguments]    ${locator}    ${text}    ${timeout}=10s
    
    Wait Until Page Contains Element    ${locator}    ${timeout}
    Clear Text    ${locator}
    Input Text    ${locator}    ${text}

Wait For Element And Get Text Mobile
    [Documentation]    Đợi element xuất hiện và lấy text trên mobile
    [Arguments]    ${locator}    ${timeout}=10s
    
    Wait Until Page Contains Element    ${locator}    ${timeout}
    ${text}=    Get Text    ${locator}
    [Return]    ${text}

Verify Element Is Visible Mobile
    [Documentation]    Kiểm tra element có hiển thị không trên mobile
    [Arguments]    ${locator}    ${timeout}=10s
    
    Wait Until Page Contains Element    ${locator}    ${timeout}
    Element Should Be Visible    ${locator}

Verify Element Is Not Visible Mobile
    [Documentation]    Kiểm tra element không hiển thị trên mobile
    [Arguments]    ${locator}    ${timeout}=10s
    
    Wait Until Page Does Not Contain Element    ${locator}    ${timeout}
    Page Should Not Contain Element    ${locator}

Scroll To Element Mobile
    [Documentation]    Cuộn đến element trên mobile
    [Arguments]    ${locator}
    
    Scroll Element Into View    ${locator}

Take Screenshot With Timestamp
    [Documentation]    Chụp ảnh màn hình với timestamp
    [Arguments]    ${filename}
    
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${full_filename}=    Set Variable    ${filename}_${timestamp}.png
    # Capture Page Screenshot    ${full_filename}
    [Return]    ${full_filename}

Generate Random Email
    [Documentation]    Tạo email ngẫu nhiên
    ${timestamp}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${random_email}=    Set Variable    test_${timestamp}@example.com
    [Return]    ${random_email}

Generate Random String
    [Documentation]    Tạo chuỗi ngẫu nhiên
    [Arguments]    ${length}=8
    ${random_string}=    Generate Random String    ${length}
    [Return]    ${random_string}

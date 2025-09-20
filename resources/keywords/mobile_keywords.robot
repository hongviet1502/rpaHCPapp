*** Settings ***
Documentation    Keywords cho Mobile testing
Library          AppiumLibrary
Resource         common_keywords.robot

*** Keywords ***
Launch Mobile App
    [Documentation]    Khởi động ứng dụng mobile
    [Arguments]    ${appium_server}=${APPIUM_SERVER}    ${platform_name}=${PLATFORM_NAME}    ${device_name}=${DEVICE_NAME}
    ...    ${app_package}=${APP_PACKAGE}    ${app_activity}=${APP_ACTIVITY}    ${automation_name}=${AUTOMATION_NAME}
    
    Open Application    ${appium_server}    platformName=${platform_name}    deviceName=${device_name}
    ...    appPackage=${app_package}    appActivity=${app_activity}    automationName=${automation_name}
    
    Wait Until Page Contains Element    id:app-container    ${TIMEOUT}

Close Mobile App
    [Documentation]    Đóng ứng dụng mobile
    
    Close Application

Mobile Login
    [Documentation]    Đăng nhập trên mobile
    [Arguments]    ${username}    ${password}
    
    Wait Until Page Contains Element    id:username-input    ${TIMEOUT}
    Input Text    id:username-input    ${username}
    Input Text    id:password-input    ${password}
    Click Element    id:login-button
    
    Wait Until Page Contains Element    id:dashboard    ${TIMEOUT}

Mobile Logout
    [Documentation]    Đăng xuất trên mobile
    
    Wait Until Page Contains Element    id:menu-button    ${TIMEOUT}
    Click Element    id:menu-button
    Wait Until Page Contains Element    id:logout-button    ${TIMEOUT}
    Click Element    id:logout-button
    
    Wait Until Page Contains Element    id:login-page    ${TIMEOUT}

Swipe Screen
    [Documentation]    Vuốt màn hình
    [Arguments]    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}=1000
    
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}

Swipe Up
    [Documentation]    Vuốt lên
    [Arguments]    ${duration}=1000
    
    ${screen_width}=    Get Window Width
    ${screen_height}=    Get Window Height
    ${start_x}=    Evaluate    ${screen_width} / 2
    ${start_y}=    Evaluate    ${screen_height} * 0.8
    ${end_x}=    Evaluate    ${screen_width} / 2
    ${end_y}=    Evaluate    ${screen_height} * 0.2
    
    Swipe Screen    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}

Swipe Down
    [Documentation]    Vuốt xuống
    [Arguments]    ${duration}=1000
    
    ${screen_width}=    Get Window Width
    ${screen_height}=    Get Window Height
    ${start_x}=    Evaluate    ${screen_width} / 2
    ${start_y}=    Evaluate    ${screen_height} * 0.2
    ${end_x}=    Evaluate    ${screen_width} / 2
    ${end_y}=    Evaluate    ${screen_height} * 0.8
    
    Swipe Screen    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}

Swipe Left
    [Documentation]    Vuốt trái
    [Arguments]    ${duration}=1000
    
    ${screen_width}=    Get Window Width
    ${screen_height}=    Get Window Height
    ${start_x}=    Evaluate    ${screen_width} * 0.8
    ${start_y}=    Evaluate    ${screen_height} / 2
    ${end_x}=    Evaluate    ${screen_width} * 0.2
    ${end_y}=    Evaluate    ${screen_height} / 2
    
    Swipe Screen    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}

Swipe Right
    [Documentation]    Vuốt phải
    [Arguments]    ${duration}=1000
    
    ${screen_width}=    Get Window Width
    ${screen_height}=    Get Window Height
    ${start_x}=    Evaluate    ${screen_width} * 0.2
    ${start_y}=    Evaluate    ${screen_height} / 2
    ${end_x}=    Evaluate    ${screen_width} * 0.8
    ${end_y}=    Evaluate    ${screen_height} / 2
    
    Swipe Screen    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}

Tap Element
    [Documentation]    Chạm vào element
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    
    Wait Until Page Contains Element    ${locator}    ${timeout}
    Click Element    ${locator}

Long Press Element
    [Documentation]    Nhấn giữ element
    [Arguments]    ${locator}    ${duration}=2000    ${timeout}=${TIMEOUT}
    
    Wait Until Page Contains Element    ${locator}    ${timeout}
    Long Press    ${locator}    ${duration}

Double Tap Element
    [Documentation]    Chạm đôi vào element
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    
    Wait Until Page Contains Element    ${locator}    ${timeout}
    Double Tap    ${locator}

Input Text Mobile
    [Documentation]    Nhập text trên mobile
    [Arguments]    ${locator}    ${text}    ${timeout}=${TIMEOUT}
    
    Wait Until Page Contains Element    ${locator}    ${timeout}
    Clear Text    ${locator}
    Input Text    ${locator}    ${text}

Verify Element Visible Mobile
    [Documentation]    Kiểm tra element hiển thị trên mobile
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    
    Wait Until Page Contains Element    ${locator}    ${timeout}
    Element Should Be Visible    ${locator}

Verify Element Not Visible Mobile
    [Documentation]    Kiểm tra element không hiển thị trên mobile
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    
    Wait Until Page Does Not Contain Element    ${locator}    ${timeout}
    Element Should Not Be Visible    ${locator}

Scroll To Element Mobile
    [Documentation]    Cuộn đến element trên mobile
    [Arguments]    ${locator}
    
    Scroll Element Into View    ${locator}

Set Orientation
    [Documentation]    Xoay màn hình
    [Arguments]    ${orientation}
    
    Set Orientation    ${orientation}

Get Screen Size
    [Documentation]    Lấy kích thước màn hình
    ${width}=    Get Window Width
    ${height}=    Get Window Height
    [Return]    ${width}    ${height}

Take Mobile Screenshot
    [Documentation]    Chụp ảnh màn hình mobile
    [Arguments]    ${filename}
    
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${full_filename}=    Set Variable    ${filename}_mobile_${timestamp}.png
    Take Screenshot    ${full_filename}
    [Return]    ${full_filename}

Navigate To Screen
    [Documentation]    Điều hướng đến màn hình
    [Arguments]    ${screen_name}
    
    Run Keyword If    '${screen_name}' == 'home'
    ...    Tap Element    id:home-tab
    ...    ELSE IF    '${screen_name}' == 'profile'
    ...    Tap Element    id:profile-tab
    ...    ELSE IF    '${screen_name}' == 'settings'
    ...    Tap Element    id:settings-tab
    ...    ELSE IF    '${screen_name}' == 'menu'
    ...    Tap Element    id:menu-button

Verify Screen Title
    [Documentation]    Kiểm tra tiêu đề màn hình
    [Arguments]    ${expected_title}
    
    ${actual_title}=    Get Text    id:screen-title
    Should Be Equal As Strings    ${actual_title}    ${expected_title}

Wait For Loading Complete
    [Documentation]    Đợi loading hoàn thành
    [Arguments]    ${timeout}=${TIMEOUT}
    
    Wait Until Page Does Not Contain Element    id:loading-indicator    ${timeout}

Handle Permission Dialog
    [Documentation]    Xử lý dialog permission
    [Arguments]    ${action}=allow
    ${button_id}=    Set Variable If    '${action}' == 'allow'    id:allow-button    id:deny-button
    Run Keyword And Ignore Error    Tap Element    ${button_id}

Switch To Context
    [Documentation]    Chuyển đổi context (NATIVE_APP, WEBVIEW)
    [Arguments]    ${context_name}
    
    Switch To Context    ${context_name}

Get Current Context
    [Documentation]    Lấy context hiện tại
    ${context}=    Get Current Context
    [Return]    ${context}

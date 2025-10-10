*** Settings ***
Documentation    Test suite cho Smart Home app testing
Resource         ../../resources/settings.robot

# Cấu hình mặc định
Suite Setup      Setup Test Environment
Suite Teardown   Cleanup Test Environment
Test Setup       Setup Test Case
Test Teardown    Cleanup Test Case

# Timeout settings
Default Tags     regression
Test Timeout     5 minutes

*** Test Cases ***
TC001_Launch Smart Home App
    [Documentation]    Khởi động Smart Home app
    [Tags]    smoke    app_launch
    
    Launch Smart Home App    ${APPIUM_SERVER}    ${PLATFORM_NAME}    ${DEVICE_NAME}    ${APP_PACKAGE}    ${APP_ACTIVITY}    ${AUTOMATION_NAME}
    # Capture Page Screenshot    app_launched.png

# TC002_Login To Smart Home App
#     [Documentation]    Đăng nhập vào Smart Home app
#     [Tags]    smoke    login
    
#     Launch Smart Home App
#     Login To Smart Home App    ${VALID_USER['password']}
    # Capture Page Screenshot    login_success.png

TC002_Navigate To Device List
    [Documentation]    Điều hướng đến danh sách tất cả thiết bị
    [Tags]    navigation    device_list
    
    Launch Smart Home App
    # Login To Smart Home App
    Navigate To Device List
    # Capture Page Screenshot    device_list

TC003_Find Switch Basic
    [Documentation]    Tìm thiết bị Switch với method cơ bản nhất
    [Tags]    basic    scroll
    
    Launch Smart Home App
    Navigate To Device List
    
    Find Device With Custom Scroll    ${UI_Switch_Device_Card}
    Click Element    ${UI_Switch_Device_Card}

TC004_Control Button All
    [Documentation]    Điều khiển tất cả các nút
    [Tags]    device_control    switch
    Click All Switch Button  # Click bất kể trạng thái hiện tại
    Click All Switch Button  # Click lần nữa để toggle

TC005_Test Single Switch
    [Documentation]    Điều khiển từng nút
    [Tags]    device_control    switch
    Test Control Single Button
TC006_Back To Home Screen
    [Documentation]    Điều khiển dim
    [Tags]    navigation    home
    # Click Button Go Back
    Close Application

    
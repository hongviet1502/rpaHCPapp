*** Settings ***
Documentation    Test suite cho Smart Home app testing
Resource         ../../resources/settings.robot
Resource        ../../resources/UI_Import.robot
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

TC003_Find Downlight Basic
    [Documentation]    Tìm thiết bị Downlight với method cơ bản nhất
    [Tags]    basic    scroll
    
    Launch Smart Home App
    Navigate To Device List
    Find Device With Custom Scroll    ${UI_Downlight_Device_Card}
    Click Element    ${UI_Downlight_Device_Card}
    
TC004_Control Button All
    [Documentation]    Điều khiển tắt bật tất cả
    [Tags]    device_control    switch
    Check Specific Switch
    # Bật switch
    Set Switch Status    ${UI_Downlight_Button_All}    on
    Verify Switch Status    ${UI_Downlight_Button_All}    on
    
    Sleep    2s
    
    # Tắt switch  
    Set Switch Status    ${UI_Downlight_Button_All}    off
    Verify Switch Status    ${UI_Downlight_Button_All}    off

TC0006_Control Dim Slider Three Positions
    [Documentation]    Điều khiển dim
    [Tags]    device_control    dim
    Control Dim Slider    0    # Click đầu slider (0%)
    Control Dim Slider    50   # Click giữa slider (50%)
    Control Dim Slider    100  # Click cuối slider (100%)

TC006_Back To Home Screen
    [Documentation]    Điều khiển dim
    [Tags]    navigation    home
    Go Back
    Sleep    1s

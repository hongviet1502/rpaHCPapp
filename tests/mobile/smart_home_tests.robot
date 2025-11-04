*** Settings ***
Documentation    Test suite cho Smart Home app testing
Resource         ../../resources/settings.robot
Resource        ../../resources/UI_Import.robot
# Cấu hình mặc định
Suite Setup      Setup Test Environment
Suite Teardown   Run Keyword And Ignore Error    Cleanup Test Environment
Test Setup       Setup Test Case
Test Teardown    Run Keyword And Ignore Error    Cleanup Test Case


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
    Smart Device Search For Continuous Testing    ${UI_Downlight_Device_Card}
    Click Element    ${UI_Downlight_Device_Card}
    
TC004_Control Button All
    [Documentation]    Đặt switch về trạng thái ON để có thể điều khiển dimming
    [Tags]    device_control    switch
    
    # Đảm bảo element tồn tại
    Wait Until Page Contains Element    ${UI_Downlight_Button_All}    10s
    
    # Kiểm tra trạng thái hiện tại
    ${current_status}=    Get Switch Info    ${UI_Downlight_Button_All}
    Log    Current switch status: ${current_status}
    
    # Nếu switch đang OFF, click để bật ON
    Run Keyword If    ${current_status} == ${False}
    ...    Log    Switch is OFF, clicking to turn ON
    
    Run Keyword If    ${current_status} == ${False}
    ...    Click Element    ${UI_Downlight_Button_All}
    
    Run Keyword If    ${current_status} == ${True}
    ...    Log    Switch is already ON
    
    # Đợi UI cập nhật và kiểm tra trạng thái với retry
    Sleep    3s
    
    # Kiểm tra trạng thái với retry (tối đa 3 lần)
    ${max_attempts}=    Set Variable    3
    ${final_status}=    Set Variable    ${EMPTY}
    
    FOR    ${i}    IN RANGE    ${max_attempts}
        ${final_status}=    Get Switch Info    ${UI_Downlight_Button_All}
        Log    Attempt ${i+1}: Final switch status: ${final_status}
        
        # Nếu đã ON thì thoát loop
        Exit For Loop If    ${final_status} == ${True}
        
        # Nếu chưa ON và chưa phải lần cuối, đợi và thử lại
        Run Keyword If    ${i} < ${max_attempts}-1
        ...    Log    Switch not ON yet, waiting and retrying...    WARN
        
        Run Keyword If    ${i} < ${max_attempts}-1
        ...    Sleep    2s
        
        Run Keyword If    ${i} < ${max_attempts}-1
        ...    Click Element    ${UI_Downlight_Button_All}
        
        Run Keyword If    ${i} < ${max_attempts}-1
        ...    Sleep    2s
    END
    
    # Đảm bảo switch ở trạng thái ON
    Should Be Equal    ${final_status}    ${True}    Switch must be ON for dimming control after ${max_attempts} attempts
    
    Log    ✅ Switch is now ON and ready for dimming control

TC005_Control Dim Slider Three Positions
    [Documentation]    Điều khiển dim
    [Tags]    device_control    dim
    Control Dim Slider    0    # Click đầu slider (0%)
    Control Dim Slider    50   # Click giữa slider (50%)
    Control Dim Slider    100  # Click cuối slider (100%)

TC006_Back To Home Screen
    [Documentation]    Kết thúc chu trình test switch - terminate app trên thiết bị rồi đóng session Appium
    [Tags]    smoke    app_close
    # 1) Thử terminate bằng AppiumLibrary (preferred)
    Run Keyword And Ignore Error    Terminate Application    ${APP_PACKAGE}
    # 2) Fallback (Android): force-stop app bằng adb nếu terminate không có hiệu lực
    Run Keyword And Ignore Error    Run    adb -s ${DEVICE_NAME} shell am force-stop ${APP_PACKAGE}
    Sleep    1s
    # 3) Đóng session Appium (bỏ qua lỗi nếu session đã đóng)
    Run Keyword And Ignore Error    Close Application
    Log    App terminated on device and Appium session closed

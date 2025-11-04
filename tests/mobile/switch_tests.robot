*** Settings ***
Documentation    Test suite cho Smart Home app testing
Resource         ../../resources/settings.robot
Resource    ../../resources/utils/get_some_texts.robot
Library    ../../resources/keywords/connect_to_mqtt.py
# Cấu hình mặc định
Suite Setup      Setup Test Environment
Suite Teardown   Run Keyword And Ignore Error    Cleanup Test Environment
Test Setup       Setup Test Case
# Test Teardown    Run Keyword And Ignore Error    Cleanup Test Case

# Timeout settings
Default Tags     regression
Test Timeout     5 minutes

*** Test Cases ***
TC001_Launch Smart Home App
    [Documentation]    Khởi động Smart Home app
    [Tags]    smoke    app_launch
    
    Mqtt Connect
    Launch Smart Home App    ${APPIUM_SERVER}    ${PLATFORM_NAME}    ${DEVICE_NAME}    ${APP_PACKAGE}    ${APP_ACTIVITY}    ${AUTOMATION_NAME}
    ${Domitory}    Get Dormitory
    ${topicmqtt}=    Set Variable    /v2/report/${Domitory}/server/json_req
    Set Global Variable    ${topicmqtt}
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
    
    Smart Device Search For Continuous Testing    ${UI_Switch_Device_Card}
    Tap Element    ${UI_Switch_Device_Card}

# TC004_Control Button All
#     [Documentation]    Điều khiển tất cả các nút
#     [Tags]    device_control        switch
#     Click All Switch Button  # Click bất kể trạng thái hiện tại
#     Click All Switch Button  # Click lần nữa để toggle

TC004_Test Single Switch
    [Documentation]    Điều khiển từng nút
    [Tags]    device_control    switch

    ${Mac}    Get MAC Devices
    ${ID}    Get ID Devices
    Test Control Single Button    ${topicmqtt}    ${Mac}    ${ID}
TC005_Back To Home Screen
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

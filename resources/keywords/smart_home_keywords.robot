*** Settings ***
Documentation    Keywords cho Smart Home app testing

Library          AppiumLibrary
Resource         common_keywords.robot
Resource         mobile_keywords.robot
Resource         ../settings.robot
Resource        ../UI_Import.robot

*** Keywords ***
Launch Smart Home App
    [Documentation]    Khởi động Smart Home app
    [Arguments]    ${appium_server}=${APPIUM_SERVER}    ${platform_name}=${PLATFORM_NAME}    ${device_name}=${DEVICE_NAME}
    ...    ${app_package}=${APP_PACKAGE}    ${app_activity}=${APP_ACTIVITY}    ${automation_name}=${AUTOMATION_NAME}
    
    Open Application    ${appium_server}    
    ...    platformName=${platform_name}    
    ...    deviceName=${device_name}
    ...    appPackage=${app_package}    
    ...    appActivity=${app_activity}    
    ...    automationName=${automation_name}
    ...    noReset=true
    ...    fullReset=false
    ...    newCommandTimeout=600
    ...    uiautomator2ServerLaunchTimeout=300000
    ...    uiautomator2ServerInstallTimeout=300000
    ...    skipServerInstallation=false
    ...    disableWindowAnimation=true
    ...    autoGrantPermissions=true
    
    Wait Until Page Contains Element    ${UI_HomePage_txt_Tatcathietbi}    ${TIMEOUT}

Login To Smart Home App
    [Documentation]    Đăng nhập vào Smart Home app
    [Arguments]    ${password}=${VALID_USER['password']}
    
    # Đợi trang login xuất hiện
    Wait Until Page Contains Element    id:login-container    ${TIMEOUT}
    
    # Nhập password
    Wait For Element And Input Text Mobile    id:password-input    ${password}
    
    # Click login button
    Wait For Element And Click Mobile    id:login-button
    
    # Đợi trang chủ load
    Wait Until Page Contains Element    id:home-container    ${TIMEOUT}

Navigate To Device List
    [Documentation]    Điều hướng đến danh sách thiết bị
    
    Wait For Element And Click Mobile    ${UI_HomePage_txt_Tatcathietbi}
    Click Element    ${UI_HomePage_txt_Tatcathietbi}
    Wait Until Page Contains Element    ${UI_HomePage_RecyclerView}   ${TIMEOUT}

Select Device
    [Documentation]    Chọn thiết bị từ danh sách
    [Arguments]    ${device_name}
    
    # Scroll để tìm thiết bị
    common_keywords.Scroll To Element Mobile    xpath://android.widget.TextView[@text='${device_name}']
    
    # Click vào thiết bị
    Wait For Element And Click Mobile    xpath://android.widget.TextView[@text='${device_name}']
    
    # Đợi trang thiết bị load
    Wait Until Page Contains Element    id:device-control-container    ${TIMEOUT}

Control Device Switch
    [Documentation]    Điều khiển công tắc thiết bị
    [Arguments]    ${switch_number}    ${action}=on
    
    ${switch_locator}=    Set Variable    id:switch-${switch_number}
    
    # Kiểm tra trạng thái hiện tại
    ${current_state}=    Get Element Attribute    ${switch_locator}    checked
    
    # Click switch nếu cần thay đổi trạng thái
    Run Keyword If    '${action}' == 'on' and '${current_state}' == 'false'
    ...    Wait For Element And Click Mobile    ${switch_locator}
    ...    ELSE IF    '${action}' == 'off' and '${current_state}' == 'true'
    ...    Wait For Element And Click Mobile    ${switch_locator}
    
    # Đợi trạng thái thay đổi
    Sleep    2s

Verify Device Status
    [Documentation]    Kiểm tra trạng thái thiết bị
    [Arguments]    ${switch_number}    ${expected_status}
    
    ${switch_locator}=    Set Variable    id:switch-${switch_number}
    ${actual_status}=    Get Element Attribute    ${switch_locator}    checked
    
    ${expected_bool}=    Set Variable If    '${expected_status}' == 'on'    true    false
    Should Be Equal    ${actual_status}    ${expected_bool}

Control All Switches
    [Documentation]    Điều khiển tất cả công tắc
    [Arguments]    ${action}=on
    
    FOR    ${i}    IN RANGE    1    4
        Control Device Switch    ${i}    ${action}
        Sleep    1s
    END

Test Device Iteration
    [Documentation]    Test một lần lặp điều khiển thiết bị
    [Arguments]    ${device_name}    ${iterations}=1
    
    FOR    ${iteration}    IN RANGE    ${iterations}
        Log    Testing iteration ${iteration + 1} for device: ${device_name}
        
        # Chọn thiết bị
        Select Device    ${device_name}
        
        # Test bật tất cả công tắc
        Control All Switches    on
        Sleep    2s
        
        # Test tắt tất cả công tắc
        Control All Switches    off
        Sleep    2s
        
        # Quay lại danh sách thiết bị
        Navigate To Device List
    END

Test Multiple Devices
    [Documentation]    Test nhiều thiết bị
    [Arguments]    ${device_list}    ${iterations}=1
    
    FOR    ${device}    IN    @{device_list}
        ${device_name}=    Set Variable    ${device['device_name']}
        ${device_type}=    Set Variable    ${device['device_type']}
        
        Log    Testing device: ${device_name} (Type: ${device_type})
        Test Device Iteration    ${device_name}    ${iterations}
    END

Verify Device Type
    [Documentation]    Kiểm tra loại thiết bị
    [Arguments]    ${device_name}    ${expected_type}
    
    # Navigate to device
    Select Device    ${device_name}
    
    # Verify device type indicator
    ${type_indicator}=    Wait For Element And Get Text Mobile    id:device-type-indicator
    Should Contain    ${type_indicator}    ${expected_type}

Take Device Screenshot
    [Documentation]    Chụp ảnh màn hình thiết bị
    [Arguments]    ${device_name}    ${action}
    
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${filename}=    Set Variable    ${device_name}_${action}_${timestamp}.png
    # Capture Page Screenshot    ${filename}

Scroll Using Swipe Simple
    [Documentation]    Cuộn đơn giản bằng swipe với tọa độ cố định
    [Arguments]    ${direction}=down
    
    # Tọa độ cố định cho màn hình Android thông thường
    ${center_x}=    Set Variable    540
    
    Run Keyword If    '${direction}' == 'down'
    ...    Execute Swipe Down    ${center_x}
    ...    ELSE
    ...    Execute Swipe Up      ${center_x}

Execute Swipe Down
    [Documentation]    Thực hiện swipe xuống
    [Arguments]    ${x}
    
    ${start_y}=    Set Variable    1200
    ${end_y}=      Set Variable    400
    
    # Sử dụng syntax đúng của Swipe
    Swipe    start_x=${x}    start_y=${start_y}    end_x=${x}    end_y=${end_y}

Execute Swipe Up
    [Documentation]    Thực hiện swipe lên
    [Arguments]    ${x}
    
    ${start_y}=    Set Variable    400
    ${end_y}=      Set Variable    1200
    
    Swipe    start_x=${x}    start_y=${start_y}    end_x=${x}    end_y=${end_y}

Find Device With Custom Scroll
    [Documentation]    Tìm thiết bị với custom scroll method
    [Arguments]    ${device_xpath}    ${max_attempts}=30
    
    FOR    ${attempt}    IN RANGE    ${max_attempts}
        ${found}=    Run Keyword And Return Status
        ...    Page Should Contain Element    ${device_xpath}
        
        Exit For Loop If    ${found}
        
        # Sử dụng swipe custom
        Scroll Using Swipe Simple    down
        Sleep    2s
    END
    
    Page Should Contain Element    ${device_xpath}

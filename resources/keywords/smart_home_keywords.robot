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

Check Switch Status
    [Documentation]    Kiểm tra trạng thái switch có được check hay không
    [Arguments]    ${switch_xpath}
    
    # Đợi switch xuất hiện
    Wait Until Page Contains Element    ${switch_xpath}    10s
    
    # Lấy trạng thái checked
    ${is_checked}=    Get Element Attribute    ${switch_xpath}    checked
    
    Log    Switch status: ${is_checked}
    [Return]    ${is_checked}

Is Switch On
    [Documentation]    Kiểm tra switch có đang ON không
    [Arguments]    ${switch_xpath}
    
    ${status}=    Check Switch Status    ${switch_xpath}
    ${is_on}=     Evaluate    '${status}' == 'true'
    
    [Return]    ${is_on}

Is Switch Off
    [Documentation]    Kiểm tra switch có đang OFF không
    [Arguments]    ${switch_xpath}
    
    ${status}=    Check Switch Status    ${switch_xpath}
    ${is_off}=    Evaluate    '${status}' == 'false'
    
    [Return]    ${is_off}

Verify Switch Status
    [Documentation]    Xác minh trạng thái switch
    [Arguments]    ${switch_xpath}    ${expected_status}
    
    ${actual_status}=    Check Switch Status    ${switch_xpath}
    
    Run Keyword If    '${expected_status}' == 'on'
    ...    Should Be Equal    ${actual_status}    true    Switch should be ON but is OFF
    ...    ELSE IF    '${expected_status}' == 'off'
    ...    Should Be Equal    ${actual_status}    false    Switch should be OFF but is ON
    ...    ELSE
    ...    Should Be Equal    ${actual_status}    ${expected_status}    Switch status mismatch

Check Specific Switch
    [Documentation]    Kiểm tra switch cụ thể của bạn
    ${status}=    Check Switch Status    ${UI_Downlight_Button_All}
    
    Log    Your switch is currently: ${status}
    [Return]    ${status}

Toggle Switch
    [Documentation]    Bật/tắt switch
    [Arguments]    ${switch_xpath}
    
    # Lấy trạng thái hiện tại
    ${current_status}=    Check Switch Status    ${switch_xpath}
    
    # Click để toggle
    Click Element    ${switch_xpath}
    Sleep    2s
    
    # Lấy trạng thái mới
    ${new_status}=    Check Switch Status    ${switch_xpath}
    
    Log    Switch toggled from ${current_status} to ${new_status}
    [Return]    ${new_status}

Set Switch Status
    [Documentation]    Đặt switch về trạng thái mong muốn
    [Arguments]    ${switch_xpath}    ${desired_status}
    
    ${current_status}=    Check Switch Status    ${switch_xpath}
    
    # Chỉ click nếu cần thay đổi trạng thái
    Run Keyword If    '${desired_status}' == 'on' and '${current_status}' == 'false'
    ...    Click Element    ${switch_xpath}
    ...    ELSE IF    '${desired_status}' == 'off' and '${current_status}' == 'true'  
    ...    Click Element    ${switch_xpath}
    
    # Đợi và xác minh
    Sleep    2s
    ${final_status}=    Check Switch Status    ${switch_xpath}
    
    Run Keyword If    '${desired_status}' == 'on'
    ...    Should Be Equal    ${final_status}    true
    ...    ELSE IF    '${desired_status}' == 'off'
    ...    Should Be Equal    ${final_status}    false

Get Switch Info
    [Documentation]    Lấy thông tin chi tiết về switch
    [Arguments]    ${switch_xpath}
    
    # Lấy các thuộc tính khác nhau
    ${checked}=      Run Keyword And Return Status    Get Element Attribute    ${switch_xpath}    checked
    ${enabled}=      Run Keyword And Return Status    Get Element Attribute    ${switch_xpath}    enabled  
    ${clickable}=    Run Keyword And Return Status    Get Element Attribute    ${switch_xpath}    clickable
    
    Log    Switch Details:
    Log    - Checked: ${checked}
    Log    - Enabled: ${enabled} 
    Log    - Clickable: ${clickable}
    
    [Return]    ${checked}

# Điều chỉnh dim
Get Slider Coordinates
    [Documentation]    Lấy tọa độ và kích thước của slider
    [Arguments]    ${slider_xpath}
    
    # Đợi slider xuất hiện
    Wait Until Page Contains Element    ${slider_xpath}    10s
    
    # Lấy vị trí và kích thước
    ${location}=    Get Element Location    ${slider_xpath}
    ${size}=        Get Element Size       ${slider_xpath}
    
    Log    Slider Location: ${location}
    Log    Slider Size: ${size}
    
    [Return]    ${location}    ${size}

Click Slider Position
    [Documentation]    Click vào vị trí cụ thể trên slider
    [Arguments]    ${slider_xpath}    ${position}
    # position: start, middle, end
    
    ${location}    ${size}=    Get Slider Coordinates    ${slider_xpath}
    
    # Tính tọa độ dựa trên position
    ${y}=    Evaluate    ${location}[y] + ${size}[height] // 2
    
    Run Keyword If    '${position}' == 'start'     Click Slider Start    ${location}    ${y}
    ...    ELSE IF    '${position}' == 'middle'    Click Slider Middle   ${location}    ${size}    ${y}
    ...    ELSE IF    '${position}' == 'end'       Click Slider End      ${location}    ${size}    ${y}
    ...    ELSE       Fail    Invalid position: ${position}. Use: start, middle, end

Click Slider Start
    [Documentation]    Click đầu slider (0%)
    [Arguments]    ${location}    ${y}
    
    ${x}=    Evaluate    ${location}[x] + 10
    Log    Clicking slider START at (${x}, ${y})
    @{coords}=    Create List    ${x}    ${y}
    Tap    ${coords}
    Sleep    2s

Click Slider Middle
    [Documentation]    Click giữa slider (50%)
    [Arguments]    ${location}    ${size}    ${y}
    
    ${x}=    Evaluate    ${location}[x] + ${size}[width] // 2
    Log    Clicking slider MIDDLE at (${x}, ${y})
    @{coords}=    Create List    ${x}    ${y}
    Tap    ${coords}
    Sleep    2s

Click Slider End
    [Documentation]    Click cuối slider (100%)
    [Arguments]    ${location}    ${size}    ${y}
    
    ${x}=    Evaluate    ${location}[x] + ${size}[width] - 10
    Log    Clicking slider END at (${x}, ${y})
    @{coords}=    Create List    ${x}    ${y}
    Tap    ${coords}
    Sleep    2s

Control Dim Slider
    [Documentation]    Điều khiển dim slider với 3 mức: đầu, giữa, cuối
    [Arguments]    ${level}
    # level: 0, 50, 100 hoặc start, middle, end
    Run Keyword If    '${level}' == '0' or '${level}' == 'start'
    ...    Click Slider Position    ${UI_Downlight_Dim_Slider}    start
    ...    ELSE IF    '${level}' == '50' or '${level}' == 'middle'  
    ...    Click Slider Position    ${UI_Downlight_Dim_Slider}    middle
    ...    ELSE IF    '${level}' == '100' or '${level}' == 'end'
    ...    Click Slider Position    ${UI_Downlight_Dim_Slider}    end
    ...    ELSE
    ...    Fail    Invalid level: ${level}. Use: 0/start, 50/middle, 100/end
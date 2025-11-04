*** Settings ***
Documentation    Keywords điều khiển switch và button tắt/bật tất cả
Library          AppiumLibrary
Library          ../../resources/keywords/connect_to_mqtt.py
Library          ../utils/helper_funtions.py
Resource        ../variables/variables_switch.robot
*** Keywords ***
Get All Switch Button Status
    [Documentation]    Lấy trạng thái hiện tại của button tắt/bật tất cả
    
    # XPath cho button tắt tất cả
    ${turn_off_button}=    Set Variable    //android.view.ViewGroup[@content-desc="Tắt tất cả"]
    # XPath cho button bật tất cả  
    ${turn_on_button}=     Set Variable    //android.view.ViewGroup[@content-desc="Bật tất cả"]
    
    # Kiểm tra button nào đang hiển thị
    ${is_turn_off_visible}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${turn_off_button}
    
    ${is_turn_on_visible}=     Run Keyword And Return Status  
    ...    Page Should Contain Element    ${turn_on_button}
    
    Run Keyword If    ${is_turn_off_visible}    
    ...    Log    Current button: "Tắt tất cả" (switches are ON)
    ...    ELSE IF    ${is_turn_on_visible}
    ...    Log    Current button: "Bật tất cả" (switches are OFF)
    ...    ELSE
    ...    Log    No all switch button found    WARN
    
    [Return]    ${is_turn_off_visible}    ${is_turn_on_visible}

Click All Switch Button
    [Documentation]    Click vào button tắt/bật tất cả (bất kể trạng thái hiện tại)
    
    ${is_turn_off}    ${is_turn_on}=    Get All Switch Button Status
    
    Run Keyword If    ${is_turn_off}
    ...    Click Turn Off All Button
    ...    ELSE IF    ${is_turn_on}
    ...    Click Turn On All Button
    ...    ELSE
    ...    Fail    Cannot find any all switch button

Click Turn Off All Button
    [Documentation]    Click button "Tắt tất cả"
    
    ${button_xpath}=    Set Variable    //android.view.ViewGroup[@content-desc="Tắt tất cả"]
    Page Should Contain Element    ${button_xpath}    10s
    Click Element    ${button_xpath}
    Sleep    3s
    Log    Clicked "Tắt tất cả" button

Click Turn On All Button  
    [Documentation]    Click button "Bật tất cả"
    
    ${button_xpath}=    Set Variable    //android.view.ViewGroup[@content-desc="Bật tất cả"]
    Page Should Contain Element    ${button_xpath}    10s
    Click Element    ${button_xpath}
    Sleep    3s
    Log    Clicked "Bật tất cả" button

Turn Off All Switches
    [Documentation]    Tắt tất cả switches (chỉ click nếu đang bật)
    
    ${is_turn_off}    ${is_turn_on}=    Get All Switch Button Status
    
    Run Keyword If    ${is_turn_off}
    ...    Click Turn Off All Button
    ...    ELSE IF    ${is_turn_on}
    ...    Log    Switches are already OFF, no action needed
    ...    ELSE
    ...    Fail    Cannot determine switch status

Turn On All Switches
    [Documentation]    Bật tất cả switches (chỉ click nếu đang tắt)
    
    ${is_turn_off}    ${is_turn_on}=    Get All Switch Button Status
    
    Run Keyword If    ${is_turn_on}
    ...    Click Turn On All Button
    ...    ELSE IF    ${is_turn_off}
    ...    Log    Switches are already ON, no action needed
    ...    ELSE
    ...    Fail    Cannot determine switch status

Toggle All Switches
    [Documentation]    Chuyển đổi trạng thái tất cả switches
    
    Log    Toggling all switches...
    ${is_turn_off_before}    ${is_turn_on_before}=    Get All Switch Button Status
    
    # Click button hiện tại
    Click All Switch Button
    
    # Kiểm tra trạng thái sau khi click
    ${is_turn_off_after}    ${is_turn_on_after}=    Get All Switch Button Status
    
    # Verify trạng thái đã thay đổi
    Run Keyword If    ${is_turn_off_before} and ${is_turn_on_after}
    ...    Log    Successfully toggled: ON -> OFF
    ...    ELSE IF    ${is_turn_on_before} and ${is_turn_off_after}
    ...    Log    Successfully toggled: OFF -> ON
    ...    ELSE
    ...    Log    Toggle might not have worked as expected    WARN

Test All Switch Control
    [Documentation]    Test điều khiển tắt/bật tất cả switches
    
    Log    Testing all switch control...
    
    # Test 1: Tắt tất cả
    Log    Step 1: Turn OFF all switches
    Turn Off All Switches
    Sleep    3s
    
    # Test 2: Bật tất cả
    Log    Step 2: Turn ON all switches  
    Turn On All Switches
    Sleep    3s
    
    # Test 3: Tắt lại
    Log    Step 3: Turn OFF all switches again
    Turn Off All Switches
    Sleep    3s

Test Switch Toggle Multiple Times
    [Documentation]    Test toggle switches nhiều lần
    [Arguments]    ${times}=3
    
    Log    Testing toggle switches ${times} times
    
    FOR    ${i}    IN RANGE    ${times}
        Log    Toggle iteration ${i + 1}/${times}
        Toggle All Switches
        Sleep    2s
    END

Verify All Switch Button Text
    [Documentation]    Verify text của button all switch
    
    ${is_turn_off}    ${is_turn_on}=    Get All Switch Button Status
    
    Run Keyword If    ${is_turn_off}
    ...    Log    ✅ Button shows "Tắt tất cả" - switches are ON
    ...    ELSE IF    ${is_turn_on}  
    ...    Log    ✅ Button shows "Bật tất cả" - switches are OFF
    ...    ELSE
    ...    Fail    ❌ Cannot verify button text

Wait For Button State Change
    [Documentation]    Đợi button thay đổi trạng thái
    [Arguments]    ${expected_state}    ${timeout}=10s
    # expected_state: turn_off hoặc turn_on
    
    Run Keyword If    '${expected_state}' == 'turn_off'
    ...    Wait Until Page Contains Element    //android.view.ViewGroup[@content-desc="Tắt tất cả"]    ${timeout}
    ...    ELSE IF    '${expected_state}' == 'turn_on'
    ...    Wait Until Page Contains Element    //android.view.ViewGroup[@content-desc="Bật tất cả"]    ${timeout}
    ...    ELSE
    ...    Fail    Invalid expected_state: ${expected_state}

Advanced All Switch Test
    [Documentation]    Test advanced cho all switch control
    
    # Test sequence: OFF -> ON -> OFF -> ON
    Log    Advanced all switch test sequence
    
    Log    Phase 1: Ensure switches are OFF
    Turn Off All Switches
    Verify All Switch Button Text
    Sleep    2s
    
    Log    Phase 2: Turn switches ON
    Turn On All Switches  
    Verify All Switch Button Text
    Sleep    2s
    
    Log    Phase 3: Turn switches OFF again
    Turn Off All Switches
    Verify All Switch Button Text
    Sleep    2s
    
    Log    Phase 4: Final turn ON
    Turn On All Switches
    Verify All Switch Button Text
    
    Log    Advanced test completed

Test Control Single Button
    [Documentation]    Test từng nút của công tắc
    [Arguments]    ${topic}    ${mac}    ${id}

    Wait Until Page Contains Element    ${UI_Button_1}    20
    ${changed1}=    Run Keyword And Return Status    Check Color Changed    ${UI_Button_1}
    Click Element    ${UI_Button_1}
    Run Keyword If    '${changed1}'=='True'    Log    Button 1 toggled successfully
    Run Keyword If    '${changed1}'=='False'    Log    Button 1 toggled failed
    Send Result To Mqtt     ${topic}    controlRL1    ${mac}    ${id}    ${changed1}    ${errorCode}
    Log    Clicked button 1
    Sleep    5s

    Wait Until Page Contains Element    ${UI_Button_2}    20
    ${changed2}=    Run Keyword And Return Status    Check Color Changed    ${UI_Button_2}
    Click Element    ${UI_Button_2}
    Run Keyword If    '${changed2}'=='True'    Log    Button 2 toggled successfully
    Run Keyword If    '${changed2}'=='False'    Log    Button 2 toggled failed
    Send Result To Mqtt     ${topic}    controlRL2    ${mac}    ${id}    ${changed2}    ${errorCode}
    Log    Clicked button 2
    Sleep    5s

    Wait Until Page Contains Element    ${UI_Button_3}    20
    ${changed3}=    Run Keyword And Return Status    Check Color Changed    ${UI_Button_3}
    Click Element    ${UI_Button_3}
    Run Keyword If    '${changed3}'=='True'    Log    Button 3 toggled successfully
    Run Keyword If    '${changed3}'=='False'    Log    Button 3 toggled failed
    Send Result To Mqtt     ${topic}    controlRL3    ${mac}    ${id}    ${changed3}    ${errorCode}
    Log    Clicked button 3
    Sleep    5s
    # Wait Until Page Contains Element    ${UI_Button_4}    20
    # Click Element    ${UI_Button_4}
    # Sleep    5s

Click Button Go Back
    [Documentation]    Nhấn go back nếu test mọi thứ oke
    Page Should Contain Element    ${UI_Button_Back}    20
    Click Element    ${UI_Button_Back}
    Sleep    5s
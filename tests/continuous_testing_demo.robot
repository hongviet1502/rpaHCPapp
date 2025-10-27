*** Settings ***
Documentation    Demo test cases cho continuous testing với scroll improvements
Resource         ../resources/settings.robot
Resource        ../resources/UI_Import.robot

# Cấu hình mặc định
Suite Setup      Setup Test Environment
Suite Teardown   Cleanup Test Environment
Test Setup       Setup Test Case
Test Teardown    Cleanup Test Case

# Timeout settings
Default Tags     regression    continuous
Test Timeout     5 minutes

*** Variables ***
${DEVICE_CURTAIN}    Curtain
${DEVICE_SWITCH}     Switch  
${DEVICE_DOWNLIGHT}  Downlight

*** Test Cases ***
TC001_Continuous_Test_Curtain_Device
    [Documentation]    Test continuous cho thiết bị Curtain với scroll improvements
    [Tags]    continuous    curtain    scroll_fix
    
    Launch Smart Home App
    Navigate To Device List For Continuous Testing
    Smart Device Search For Continuous Testing    ${UI_Curtain_Device_Card}    ${DEVICE_CURTAIN}
    Click Element    ${UI_Curtain_Device_Card}
    Log    Curtain device test completed

TC002_Continuous_Test_Switch_Device  
    [Documentation]    Test continuous cho thiết bị Switch với scroll improvements
    [Tags]    continuous    switch    scroll_fix
    
    Launch Smart Home App
    Navigate To Device List For Continuous Testing
    Smart Device Search For Continuous Testing    ${UI_Switch_Device_Card}    ${DEVICE_SWITCH}
    Click Element    ${UI_Switch_Device_Card}
    Log    Switch device test completed

TC003_Continuous_Test_Downlight_Device
    [Documentation]    Test continuous cho thiết bị Downlight với scroll improvements  
    [Tags]    continuous    downlight    scroll_fix
    
    Launch Smart Home App
    Navigate To Device List For Continuous Testing
    Smart Device Search For Continuous Testing    ${UI_Downlight_Device_Card}    ${DEVICE_DOWNLIGHT}
    Click Element    ${UI_Downlight_Device_Card}
    Log    Downlight device test completed

TC004_Continuous_Test_Multiple_Devices
    [Documentation]    Test liên tục nhiều thiết bị để verify scroll fix
    [Tags]    continuous    multiple_devices    scroll_fix
    
    # Test Curtain
    Launch Smart Home App
    Navigate To Device List For Continuous Testing
    Smart Device Search For Continuous Testing    ${UI_Curtain_Device_Card}    ${DEVICE_CURTAIN}
    Click Element    ${UI_Curtain_Device_Card}
    Log    Step 1: Curtain device found and clicked
    
    # Back to device list
    Click Button Go Back
    Navigate To Device List For Continuous Testing
    
    # Test Switch
    Smart Device Search For Continuous Testing    ${UI_Switch_Device_Card}    ${DEVICE_SWITCH}
    Click Element    ${UI_Switch_Device_Card}
    Log    Step 2: Switch device found and clicked
    
    # Back to device list  
    Click Button Go Back
    Navigate To Device List For Continuous Testing
    
    # Test Downlight
    Smart Device Search For Continuous Testing    ${UI_Downlight_Device_Card}    ${DEVICE_DOWNLIGHT}
    Click Element    ${UI_Downlight_Device_Card}
    Log    Step 3: Downlight device found and clicked
    
    Log    All devices tested successfully in continuous mode

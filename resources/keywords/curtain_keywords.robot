*** Settings ***
Documentation    Keywords điều khiển switch và button tắt/bật tất cả
Library          AppiumLibrary

*** Keywords ***
Fill Password
    [Documentation]    Điền password curtain
    Wait Until Page Contains Element    ${UI_Password_Input_Curtain}    20
    Input Password    ${UI_Password_Input_Curtain}    1
    Click Element    ${UI_Button_Confirm_Password}

Test Control
    [Documentation]    Test mở, dừng, đóng curtain
    Wait Until Page Contains Element    ${UI_Button_Open}    20
    Click Element    ${UI_Button_Open}
    Sleep    5s
    Wait Until Page Contains Element    ${UI_Button_Pause}    20
    Click Element    ${UI_Button_Pause}
    Sleep    5s
    Wait Until Page Contains Element    ${UI_Button_Close}    20
    Click Element    ${UI_Button_Close}
    Sleep    5s
    Wait Until Page Contains Element    ${UI_Button_Pause}    20
    Click Element    ${UI_Button_Pause}
    Sleep    5s
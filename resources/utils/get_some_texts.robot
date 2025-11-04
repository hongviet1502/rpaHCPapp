*** Settings ***
Library    XML
Library    AppiumLibrary
Library    String
Library    OperatingSystem
Library    Collections

*** Keywords ***
Get Dormitory
    Wait Until Page Contains Element    //android.widget.TextView[contains(@text, 'dormId')]
    ${element}=    Get Webelement    //android.widget.TextView[contains(@text, 'dormId:')]
    ${full_text}=       Get Text          ${element}
    # ${full_text}=    Get Element Text   //android.widget.TextView[contains(@text, 'dormId')]
    ${split_parts}=    Evaluate    '${full_text}'.split("dormId:")    # Tách chuỗi tại "Dorm:"
    ${Domitory}=    Get From List    ${split_parts}    1    # Lấy phần sau "Dorm:"
    ${Domitory}=    Strip String    ${Domitory}    # Loại bỏ khoảng trắng thừa
    Log To Console    Dorm: ${Domitory}
    RETURN    ${Domitory}

Get MAC Devices
    Wait Until Page Contains Element    //android.widget.TextView[contains(@text, 'Mac:')]
    ${element}=    Get Webelement    //android.widget.TextView[contains(@text, 'Mac:')]
    ${full_text}=       Get Text          ${element}
    ${split_parts}=    Evaluate    '${full_text}'.split("Mac:")
    ${MAC}=    Get From List    ${split_parts}    1
    ${mac}=    Strip String    ${MAC}
    Log To Console    MAC: ${MAC}

    RETURN    ${mac}

Get ID Devices
    Wait Until Page Contains Element    //android.widget.TextView[contains(@text, 'ID:')]
    ${element}=    Get Webelement    //android.widget.TextView[contains(@text, 'ID:')]
    ${full_text}=       Get Text          ${element}
    ${split_parts}=    Evaluate    '${full_text}'.split("ID:")
    ${ID}=    Get From List    ${split_parts}    1
    ${id}=    Strip String    ${id}
    Log To Console    id device: ${id}
    
    RETURN    ${id}
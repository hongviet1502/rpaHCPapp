# Hướng dẫn bắt đầu với Robot Framework

## Giới thiệu

Robot Framework là một framework tự động hóa testing mã nguồn mở, được thiết kế để dễ sử dụng và mở rộng. Nó hỗ trợ nhiều loại testing khác nhau như Web, API, Mobile, Database, v.v.

## Cài đặt cơ bản

### 1. Cài đặt Python

Robot Framework yêu cầu Python 3.6 trở lên:

```bash
# Kiểm tra Python version
python --version

# Cài đặt pip nếu chưa có
python -m ensurepip --upgrade
```

### 2. Cài đặt Robot Framework

```bash
pip install robotframework
```

### 3. Cài đặt các thư viện cần thiết

```bash
# Web testing
pip install robotframework-seleniumlibrary
pip install selenium

# API testing  
pip install robotframework-requests
pip install requests

# Mobile testing
pip install robotframework-appiumlibrary
pip install appium-python-client

# Data driven testing
pip install robotframework-datadriver
```

## Cấu trúc file Robot Framework

### Cú pháp cơ bản

```robot
*** Settings ***
Documentation    Mô tả test suite
Library          SeleniumLibrary
Resource         keywords.robot

*** Variables ***
${BROWSER}       chrome
${URL}          https://example.com

*** Test Cases ***
Test Case Name
    [Documentation]    Mô tả test case
    [Tags]            smoke
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    Example Domain
    Close Browser

*** Keywords ***
Custom Keyword
    [Arguments]    ${arg1}    ${arg2}
    Log    Argument 1: ${arg1}
    Log    Argument 2: ${arg2}
```

### Các section chính

1. **Settings**: Cấu hình, import libraries, resources
2. **Variables**: Định nghĩa biến
3. **Test Cases**: Các test case
4. **Keywords**: Custom keywords
5. **Tasks**: Automated tasks (không có trong test suites)

## Viết test case đầu tiên

### 1. Tạo file test đơn giản

```robot
*** Settings ***
Documentation    Test suite đầu tiên
Library          SeleniumLibrary

*** Variables ***
${BROWSER}       chrome
${URL}          https://www.google.com

*** Test Cases ***
Google Search Test
    [Documentation]    Test tìm kiếm Google
    Open Browser    ${URL}    ${BROWSER}
    Input Text      name=q    Robot Framework
    Press Keys      name=q    RETURN
    Wait Until Page Contains    Robot Framework
    Close Browser
```

### 2. Chạy test

```bash
robot google_test.robot
```

## Sử dụng Keywords

### Built-in Keywords

```robot
*** Test Cases ***
Using Built-in Keywords
    Log    This is a log message
    ${current_time}=    Get Current Date
    Log    Current time: ${current_time}
    
    ${random_string}=    Generate Random String    10
    Log    Random string: ${random_string}
    
    Should Be Equal    hello    hello
    Should Contain    hello world    world
```

### Custom Keywords

```robot
*** Keywords ***
Login To Website
    [Arguments]    ${username}    ${password}
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}
    Click Button    id=login-button
    Wait Until Page Contains    Dashboard

Search For Product
    [Arguments]    ${search_term}
    Input Text    id=search-box    ${search_term}
    Click Button    id=search-button
    Wait Until Page Contains Element    class=search-results
```

## Sử dụng Variables

### Scalar Variables

```robot
*** Variables ***
${USERNAME}      testuser@example.com
${PASSWORD}      TestPassword123
${BASE_URL}      https://example.com
${TIMEOUT}       10s
```

### List Variables

```robot
*** Variables ***
@{BROWSERS}      chrome    firefox    edge
@{CREDENTIALS}   testuser@example.com    TestPassword123
```

### Dictionary Variables

```robot
*** Variables ***
&{USER_DATA}     username=testuser@example.com    password=TestPassword123    role=admin
```

## Tags và Documentation

### Tags

```robot
*** Test Cases ***
Smoke Test
    [Tags]    smoke    critical
    Log    This is a smoke test

Regression Test  
    [Tags]    regression    api
    Log    This is a regression test

Mobile Test
    [Tags]    mobile    android
    Log    This is a mobile test
```

### Documentation

```robot
*** Test Cases ***
User Login Test
    [Documentation]    Test đăng nhập user với thông tin hợp lệ
    ...                Expected: User đăng nhập thành công và chuyển đến dashboard
    [Tags]             smoke    login
    Login To Website    ${USERNAME}    ${PASSWORD}
    Verify Dashboard Page
```

## Setup và Teardown

```robot
*** Settings ***
Suite Setup      Setup Test Environment
Suite Teardown   Cleanup Test Environment
Test Setup       Setup Test Case
Test Teardown    Cleanup Test Case

*** Keywords ***
Setup Test Environment
    Log    Setting up test environment
    Create Directory    results

Cleanup Test Environment  
    Log    Cleaning up test environment
    Close All Browsers

Setup Test Case
    Log    Starting test case: ${TEST_NAME}

Cleanup Test Case
    Log    Completed test case: ${TEST_NAME}
    Run Keyword If Test Failed    Take Screenshot
```

## Chạy tests với options

### Command line options

```bash
# Chạy với tags
robot --include smoke tests/
robot --exclude mobile tests/

# Chạy với output tùy chỉnh
robot --outputdir results --log log.html --report report.html tests/

# Chạy với variables
robot --variable BROWSER:firefox --variable HEADLESS:true tests/

# Chạy với timeout
robot --testtimeout 5m tests/

# Chạy với parallel
robot --processes 4 tests/
```

### Robot options file

Tạo file `robot_options.py`:

```python
def get_options():
    return {
        'outputdir': 'results',
        'log': 'log.html', 
        'report': 'report.html',
        'include': ['smoke'],
        'exclude': ['mobile'],
        'variable': ['BROWSER:chrome', 'HEADLESS:false']
    }
```

## Best Practices

### 1. Tổ chức code

- Sử dụng Resource files để chia sẻ keywords
- Tách biệt test data ra file riêng
- Sử dụng Page Object Model cho Web testing
- Đặt tên có ý nghĩa cho test cases và keywords

### 2. Error handling

```robot
*** Keywords ***
Safe Click Element
    [Arguments]    ${locator}    ${timeout}=10s
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Click Element    ${locator}

Safe Input Text
    [Arguments]    ${locator}    ${text}    ${timeout}=10s
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}
```

### 3. Data driven testing

```robot
*** Settings ***
Library          DataDriver    data.csv

*** Test Cases ***
Login Test
    [Arguments]    ${username}    ${password}    ${expected_result}
    Login To Website    ${username}    ${password}
    Run Keyword If    '${expected_result}' == 'success'
    ...    Verify Dashboard Page
    ...    ELSE
    ...    Verify Error Message
```

### 4. Parallel execution

```bash
# Chạy song song với pabot
pip install robotframework-pabot
pabot --processes 4 tests/
```

## Debugging

### 1. Logging

```robot
*** Test Cases ***
Debug Test
    Log    This is an info message    INFO
    Log    This is a warning message    WARN
    Log    This is an error message    ERROR
    Log    This is a debug message    DEBUG
```

### 2. Screenshots

```robot
*** Test Cases ***
Screenshot Test
    Open Browser    https://example.com    chrome
    Take Screenshot    homepage.png
    Close Browser
```

### 3. Debug mode

```bash
# Chạy với debug mode
robot --loglevel DEBUG tests/

# Chạy với trace mode
robot --loglevel TRACE tests/
```

## Tích hợp CI/CD

### GitHub Actions

```yaml
name: Robot Framework Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.9'
    - name: Install dependencies
      run: |
        pip install -r requirements.txt
    - name: Run tests
      run: |
        robot tests/
    - name: Upload results
      uses: actions/upload-artifact@v2
      with:
        name: test-results
        path: results/
```

## Tài liệu tham khảo

- [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [Robot Framework Standard Libraries](https://robotframework.org/robotframework/latest/libraries/)
- [Robot Framework SeleniumLibrary](https://robotframework.org/SeleniumLibrary/)
- [Robot Framework Best Practices](https://github.com/robotframework/HowToWriteGoodTestCases)

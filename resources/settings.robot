*** Settings ***
Documentation    Cấu hình chung cho Mobile test suites
Library          AppiumLibrary
Library          Collections
Library          String
Library          DateTime
Library          OperatingSystem

# Biến môi trường
Variables        ${CURDIR}/data/test_data.py

# Resource files
Resource         ${CURDIR}/keywords/common_keywords.robot
Resource         ${CURDIR}/keywords/mobile_keywords.robot
Resource         ${CURDIR}/keywords/smart_home_keywords.robot

*** Variables ***
# Appium settings
${APPIUM_SERVER}    http://localhost:4723/wd/hub
${PLATFORM_NAME}    Android
${DEVICE_NAME}      R3CM605NEME
${APP_PACKAGE}      vn.com.rangdong.rallismartv3dev
${APP_ACTIVITY}     vn.com.rangdong.rallismartv3dev.MainActivity
${AUTOMATION_NAME}  uiautomator2

# File paths
${SCREENSHOT_DIR}    ${CURDIR}/../results/screenshots
${LOG_DIR}           ${CURDIR}/../logs
${DATA_DIR}          ${CURDIR}/data

*** Variables ***
# Timeouts được tăng lên
${TIMEOUT}             50s
${LONG_TIMEOUT}         60s
${APP_LAUNCH_TIMEOUT}   45s

# Appium capabilities được cải thiện
${NEW_COMMAND_TIMEOUT}        300
${ANDROID_INSTALL_TIMEOUT}    300000
${ADB_EXEC_TIMEOUT}          300000
${UIAUTOMATOR2_SERVER_LAUNCH_TIMEOUT}    300000
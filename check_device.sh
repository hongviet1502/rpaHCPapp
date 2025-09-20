#!/bin/bash

# Script kiểm tra và hướng dẫn kết nối thiết bị Android
# Usage: ./check_device.sh

# Màu sắc cho output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 Kiểm tra thiết bị Android...${NC}"

# Kiểm tra adb
if ! command -v adb &> /dev/null; then
    echo -e "${RED}❌ ADB chưa được cài đặt!${NC}"
    echo -e "${YELLOW}📝 Hướng dẫn cài đặt:${NC}"
    echo "1. Cài đặt Android Studio hoặc Android SDK"
    echo "2. Thêm Android SDK vào PATH:"
    echo "   export ANDROID_HOME=/path/to/android/sdk"
    echo "   export PATH=\$PATH:\$ANDROID_HOME/tools:\$ANDROID_HOME/platform-tools"
    exit 1
fi

echo -e "${GREEN}✅ ADB đã được cài đặt${NC}"

# Kiểm tra thiết bị
echo -e "${YELLOW}📱 Kiểm tra thiết bị kết nối...${NC}"
adb devices

# Kiểm tra thiết bị cụ thể
if adb devices | grep -q "R3CM605NEME"; then
    echo -e "${GREEN}✅ Thiết bị R3CM605NEME đã được kết nối!${NC}"
    
    # Lấy thông tin thiết bị
    echo -e "${BLUE}📋 Thông tin thiết bị:${NC}"
    echo "Device ID: R3CM605NEME"
    echo "Status: $(adb devices | grep R3CM605NEME | awk '{print $2}')"
    
    # Kiểm tra app đã cài đặt chưa
    echo -e "${YELLOW}📱 Kiểm tra Smart Home app...${NC}"
    if adb shell pm list packages | grep -q "com.rd.smart"; then
        echo -e "${GREEN}✅ Smart Home app đã được cài đặt${NC}"
    else
        echo -e "${RED}❌ Smart Home app chưa được cài đặt${NC}"
        echo -e "${YELLOW}📝 Hướng dẫn cài đặt app:${NC}"
        echo "1. Tải file APK của Smart Home app"
        echo "2. Cài đặt: adb install com.rd.smart.apk"
    fi
    
else
    echo -e "${RED}❌ Thiết bị R3CM605NEME chưa được kết nối!${NC}"
    echo -e "${YELLOW}📝 Hướng dẫn kết nối thiết bị:${NC}"
    echo "1. Bật USB Debugging trên thiết bị Android"
    echo "2. Kết nối thiết bị với máy tính qua USB"
    echo "3. Chấp nhận USB Debugging trên thiết bị"
    echo "4. Chạy lại: adb devices"
    echo ""
    echo -e "${BLUE}🔧 Các bước chi tiết:${NC}"
    echo "1. Vào Settings > About Phone"
    echo "2. Tap vào 'Build Number' 7 lần để bật Developer Options"
    echo "3. Vào Settings > Developer Options"
    echo "4. Bật 'USB Debugging'"
    echo "5. Kết nối USB và chấp nhận debugging"
fi

echo ""
echo -e "${BLUE}🚀 Sau khi thiết bị đã kết nối, chạy tests:${NC}"
echo "./run_tests.sh"

# Robot Framework Mobile Test Project

Dự án test tự động sử dụng Robot Framework cho Mobile testing (Android & iOS).

## 📁 Cấu trúc dự án

```
TestAppHcp/
├── tests/                          # Test suites
│   └── mobile/                     # Mobile testing
│       └── mobile_tests.robot
├── resources/                      # Resources và keywords
│   ├── keywords/                   # Custom keywords
│   │   ├── common_keywords.robot
│   │   └── mobile_keywords.robot
│   ├── pages/                      # Page objects (tùy chọn)
│   ├── data/                       # Test data
│   │   └── test_data.py
│   └── settings.robot             # Cấu hình chung
├── results/                        # Kết quả test
├── logs/                          # Log files
├── reports/                       # Báo cáo
├── docs/                          # Documentation
├── requirements.txt               # Dependencies
├── robot_tasks.py                # Script chạy test
└── README.md                      # Documentation chính
```

## 🚀 Cài đặt

### 1. Cài đặt Python dependencies

```bash
pip install -r requirements.txt
```

### 2. Cài đặt Appium

#### Cài đặt Appium Server
```bash
npm install -g appium
npm install -g appium-doctor
```

#### Cài đặt Appium drivers
```bash
# Android driver
appium driver install uiautomator2

# iOS driver (chỉ trên macOS)
appium driver install xcuitest
```

### 3. Cài đặt Android SDK (cho Android testing)

```bash
# Cài đặt Android Studio hoặc Android SDK
# Thiết lập biến môi trường:
export ANDROID_HOME=/path/to/android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

### 4. Cài đặt iOS dependencies (cho iOS testing)

```bash
# Cài đặt Xcode từ App Store
# Cài đặt Xcode Command Line Tools
xcode-select --install

# Cài đặt Carthage (nếu cần)
brew install carthage
```

## 🎯 Cách sử dụng

### Chạy mobile tests

```bash
# Chạy tất cả mobile tests
python robot_tasks.py

# Chạy với platform khác
python robot_tasks.py --platform ios

# Chạy với device khác
python robot_tasks.py --device "iPhone 14"

# Chạy với Appium server khác
python robot_tasks.py --appium-server "http://192.168.1.100:4723"
```

### Chạy với Robot Framework trực tiếp

```bash
# Chạy mobile tests
robot tests/mobile/

# Chạy với tags
robot --include smoke tests/mobile/
robot --exclude android tests/mobile/

# Chạy với output tùy chỉnh
robot --outputdir results --log log.html --report report.html tests/mobile/
```

## 📱 Mobile Test Cases

### Android Testing
- ✅ App launch và initialization
- ✅ User login/logout
- ✅ Navigation và menu
- ✅ Form input và validation
- ✅ Scroll và swipe gestures
- ✅ Screen orientation
- ✅ Touch gestures (tap, long press, double tap)
- ✅ Network connectivity testing
- ✅ Permission handling

### iOS Testing
- ✅ App launch và initialization
- ✅ User authentication
- ✅ Navigation flow
- ✅ Form interactions
- ✅ Gesture recognition
- ✅ Orientation changes
- ✅ Network testing
- ✅ System integration

## 🏷️ Tags

Tests được phân loại bằng tags:

- `smoke`: Tests cơ bản, chạy nhanh
- `regression`: Tests đầy đủ
- `mobile`: Mobile testing
- `android`: Android specific tests
- `ios`: iOS specific tests
- `login`: Authentication tests
- `gestures`: Touch gesture tests
- `navigation`: Navigation tests
- `forms`: Form interaction tests

## ⚙️ Cấu hình

### Biến môi trường

Chỉnh sửa trong `resources/settings.robot`:

```robot
*** Variables ***
${APPIUM_SERVER}    http://localhost:4723
${PLATFORM_NAME}    Android
${DEVICE_NAME}      Pixel_4_API_30
${APP_PACKAGE}      com.example.app
${APP_ACTIVITY}     com.example.app.MainActivity
```

### Test Data

Chỉnh sửa trong `resources/data/test_data.py`:

```python
VALID_USER = {
    "username": "testuser@example.com",
    "password": "TestPassword123!"
}

MOBILE_CONFIG = {
    "platform": "Android",
    "device_name": "Pixel_4_API_30",
    "app_package": "com.example.app",
    "app_activity": "com.example.app.MainActivity"
}
```

## 📊 Báo cáo

Sau khi chạy tests, kết quả sẽ được lưu trong thư mục `results/`:

- `log.html`: Chi tiết log của tests
- `report.html`: Báo cáo tổng quan
- `output.xml`: Kết quả XML
- `screenshots/`: Ảnh chụp màn hình mobile

## 🔧 Troubleshooting

### Lỗi Appium

```bash
# Kiểm tra Appium installation
appium-doctor

# Kiểm tra Android setup
appium-doctor --android

# Kiểm tra iOS setup (macOS only)
appium-doctor --ios

# Restart Appium server
appium --port 4723
```

### Lỗi Android

```bash
# Kiểm tra Android devices
adb devices

# Kiểm tra Android SDK
echo $ANDROID_HOME

# Kiểm tra emulator
emulator -list-avds
```

### Lỗi iOS

```bash
# Kiểm tra iOS simulators
xcrun simctl list devices

# Kiểm tra Xcode installation
xcode-select -p

# Kiểm tra iOS devices
instruments -s devices
```

### Lỗi Python packages

```bash
# Cập nhật pip
pip install --upgrade pip

# Cài đặt lại packages
pip install -r requirements.txt --force-reinstall
```

## 📚 Tài liệu tham khảo

- [Robot Framework Documentation](https://robotframework.org/)
- [AppiumLibrary](https://robotframework.org/AppiumLibrary/)
- [Appium Documentation](https://appium.io/)
- [Android Testing Guide](https://developer.android.com/training/testing)
- [iOS Testing Guide](https://developer.apple.com/testing/)

## 🤝 Đóng góp

1. Fork dự án
2. Tạo feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Mở Pull Request

## 📄 License

Dự án này được phân phối dưới MIT License. Xem file `LICENSE` để biết thêm chi tiết.
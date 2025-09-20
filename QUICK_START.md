# 🚀 Quick Start Guide - Mobile Testing

## ✅ Đã hoàn thành setup!

Dự án Robot Framework Mobile Testing đã được cài đặt và cấu hình hoàn chỉnh.

## 🎯 Cách chạy tests

### 1. Sử dụng script tự động (Khuyến nghị)

```bash
# Chạy tất cả mobile tests
./run_tests.sh

# Chạy với platform khác
./run_tests.sh --platform ios

# Chạy với device khác
./run_tests.sh --device "iPhone 14"
```

### 2. Chạy thủ công

```bash
# Activate virtual environment
source venv/bin/activate

# Chạy tests
python3 robot_tasks.py

# Hoặc chạy trực tiếp với Robot Framework
robot tests/mobile/
```

## 📱 Test Cases có sẵn

Dự án đã có sẵn **20 mobile test cases**:

### Smart Home App Tests (12 test cases):
1. **TC001_Launch Smart Home App** - Khởi động Smart Home app
2. **TC002_Login To Smart Home App** - Đăng nhập với password
3. **TC003_Navigate To Device List** - Điều hướng danh sách thiết bị
4. **TC004_Control Single Device Switch** - Điều khiển công tắc đơn lẻ
5. **TC005_Control All Switches** - Điều khiển tất cả công tắc
6. **TC006_Test Multiple Devices** - Test nhiều thiết bị
7. **TC007_Test Device Connectivity** - Test kết nối thiết bị
8. **TC008_Verify Device Types** - Kiểm tra loại thiết bị
9. **TC009_Test Device Iteration** - Test lặp điều khiển
10. **TC010_App Navigation Flow** - Test luồng điều hướng
11. **TC011_Device Control Stress Test** - Test stress điều khiển
12. **TC012_App Background Foreground Test** - Test background/foreground

### General Mobile Tests (8 test cases):
1. **TC001_Launch Mobile App** - Khởi động ứng dụng
2. **TC002_Mobile Login Test** - Test đăng nhập
3. **TC003_Mobile Navigation Test** - Test điều hướng
4. **TC004_Mobile Form Input Test** - Test nhập form
5. **TC005_Mobile Scroll Test** - Test cuộn trang
6. **TC006_Mobile Orientation Test** - Test xoay màn hình
7. **TC007_Mobile Touch Test** - Test chạm màn hình
8. **TC008_Mobile Network Test** - Test mạng

## ⚙️ Cấu hình Appium

### Cài đặt Appium (nếu chưa có)

```bash
# Cài đặt Appium
npm install -g appium

# Cài đặt Android driver
appium driver install uiautomator2

# Cài đặt iOS driver (macOS only)
appium driver install xcuitest
```

### Khởi động Appium Server

```bash
# Khởi động Appium server
appium --port 4723

# Hoặc khởi động với log
appium --port 4723 --log-level debug
```

## 📊 Xem kết quả

Sau khi chạy tests, kết quả sẽ được lưu trong thư mục `results/`:

- `log.html` - Chi tiết log của tests
- `report.html` - Báo cáo tổng quan
- `screenshots/` - Ảnh chụp màn hình

Mở file `results/log.html` trong trình duyệt để xem kết quả chi tiết.

## 🔧 Troubleshooting

### Lỗi "Appium server not running"
```bash
# Khởi động Appium server
appium --port 4723
```

### Lỗi "Device not found"
- Kiểm tra device đã kết nối: `adb devices` (Android)
- Kiểm tra simulator: `xcrun simctl list devices` (iOS)

### Lỗi "App not found"
- App đã được cấu hình: `com.rd.smart` với activity `com.thingclips.smart.hometab.activity.FamilyHomeActivity`
- Đảm bảo Smart Home app đã được cài đặt trên device `R3CM605NEME`

### Cấu hình Smart Home App
- **App Package**: `com.rd.smart`
- **Start Activity**: `com.thingclips.smart.hometab.activity.FamilyHomeActivity`
- **Password**: `Digital@2804`
- **Device ID**: `R3CM605NEME`
- **Automation**: `UiAutomator2`

## 📚 Tài liệu tham khảo

- [README.md](README.md) - Hướng dẫn chi tiết
- [docs/getting_started.md](docs/getting_started.md) - Hướng dẫn Robot Framework
- [Robot Framework Documentation](https://robotframework.org/)
- [Appium Documentation](https://appium.io/)

## 🎉 Bắt đầu testing!

Bây giờ bạn có thể bắt đầu viết và chạy mobile tests với Robot Framework!

```bash
./run_tests.sh
```

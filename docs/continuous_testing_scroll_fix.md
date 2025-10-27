# Continuous Testing Scroll Fix - Hướng dẫn sử dụng

## Vấn đề đã được giải quyết

Trước đây, khi chạy continuous testing với nhiều thiết bị khác nhau, có vấn đề:
- Sau khi test xong một thiết bị (ví dụ: đèn), danh sách thiết bị đang ở cuối
- Khi tìm thiết bị tiếp theo, việc scroll không hoạt động đúng cách
- Dẫn đến không tìm thấy thiết bị tiếp theo

## Giải pháp đã triển khai

### 1. Keywords mới được thêm vào `smart_home_keywords.robot`:

#### `Reset Scroll To Top`
- Reset scroll position về đầu danh sách
- Scroll lên nhiều lần để đảm bảo về đầu

#### `Find Device With Bidirectional Scroll` 
- Tìm thiết bị với scroll 2 chiều (lên và xuống)
- Luôn bắt đầu từ đầu danh sách
- Nếu không tìm thấy khi scroll xuống, sẽ thử scroll lên

#### `Navigate To Device List For Continuous Testing`
- Điều hướng đến danh sách thiết bị với cải tiến cho continuous testing
- Tự động reset scroll position

#### `Smart Device Search For Continuous Testing`
- Tìm kiếm thiết bị thông minh cho continuous testing
- Đảm bảo luôn bắt đầu từ đầu danh sách
- Có error handling tốt hơn

### 2. Cải tiến Continuous Test Runner

File `continous_test_runner.py` đã được cải tiến:
- Thêm biến `CONTINUOUS_TESTING:True`
- Cải thiện logging và error handling
- Thêm thời gian đợi giữa các test cases

### 3. Test Cases mới

File `continuous_testing_demo.robot` chứa các test cases mẫu:
- `TC001_Continuous_Test_Curtain_Device`
- `TC002_Continuous_Test_Switch_Device` 
- `TC003_Continuous_Test_Downlight_Device`
- `TC004_Continuous_Test_Multiple_Devices`

## Cách sử dụng

### Cho Test Cases mới:

```robot
*** Test Cases ***
TC001_Test_Device
    [Documentation]    Test thiết bị với scroll fix
    [Tags]    continuous
    
    Launch Smart Home App
    Navigate To Device List For Continuous Testing
    Smart Device Search For Continuous Testing    ${UI_Device_Card}    Device Name
    Click Element    ${UI_Device_Card}
```

### Cho Test Cases hiện có:

Thay thế:
```robot
Navigate To Device List
Find Device With Custom Scroll    ${UI_Device_Card}
```

Bằng:
```robot
Navigate To Device List For Continuous Testing  
Smart Device Search For Continuous Testing    ${UI_Device_Card}    Device Name
```

### Chạy Continuous Testing:

```bash
python continous_test_runner.py
```

## Lợi ích

1. **Giải quyết vấn đề scroll**: Mỗi test case luôn bắt đầu từ đầu danh sách
2. **Tăng độ tin cậy**: Scroll 2 chiều giúp tìm thiết bị tốt hơn
3. **Error handling tốt hơn**: Có logging chi tiết và fallback methods
4. **Dễ sử dụng**: Keywords đơn giản, rõ ràng
5. **Tương thích**: Không ảnh hưởng đến test cases hiện có

## Lưu ý

- Sử dụng `Smart Device Search For Continuous Testing` cho continuous testing
- Sử dụng `Find Device With Bidirectional Scroll` cho test cases thông thường
- Luôn đặt `device_name` parameter để logging rõ ràng hơn
- Test cases với tag `continuous` sẽ được tối ưu cho continuous testing

## Troubleshooting

### Nếu vẫn không tìm thấy thiết bị:

1. Kiểm tra XPath của thiết bị có đúng không
2. Tăng `max_attempts` trong keywords
3. Kiểm tra UI có thay đổi không
4. Xem log để debug chi tiết

### Nếu scroll quá chậm:

1. Giảm `Sleep` time trong keywords
2. Tăng `max_scroll_attempts` trong `Reset Scroll To Top`
3. Điều chỉnh tọa độ swipe trong `Scroll Using Swipe Simple`

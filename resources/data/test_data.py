"""
Test Data cho Robot Framework Mobile Testing
Chứa các dữ liệu test được sử dụng trong mobile test cases
"""

# User credentials
VALID_USER = {
    "username": "testuser@example.com",
    "password": "Digital@2804",
    "first_name": "Test",
    "last_name": "User"
}

INVALID_USER = {
    "username": "invalid@example.com",
    "password": "wrongpassword"
}

# Mobile configurations
MOBILE_CONFIG = {
    "platform": "Android",
    "device_name": "R3CM605NEME",
    "app_package": "com.rd.smart",
    "app_activity": "com.thingclips.smart.hometab.activity.FamilyHomeActivity",
    "automation_name": "UiAutomator2",
    "appium_server": "http://localhost:4723/wd/hub"
}

# iOS configurations
IOS_CONFIG = {
    "platform": "iOS",
    "device_name": "iPhone 14",
    "bundle_id": "com.example.app",
    "udid": "00008030-001234567890123A"
}

# Test app data
TEST_APPS = {
    "android": {
        "package": "com.example.app",
        "activity": "com.example.app.MainActivity",
        "version": "1.0.0"
    },
    "ios": {
        "bundle_id": "com.example.app",
        "version": "1.0.0"
    }
}

# Test form data
FORM_DATA = {
    "contact": {
        "name": "Test User",
        "email": "test@example.com",
        "phone": "0123456789",
        "message": "This is a test message"
    },
    "registration": {
        "first_name": "Test",
        "last_name": "User",
        "email": "testuser@example.com",
        "password": "TestPassword123!",
        "confirm_password": "TestPassword123!"
    }
}

# Test products for mobile app
MOBILE_PRODUCTS = [
    {
        "name": "Mobile Product 1",
        "price": 99.99,
        "description": "This is a mobile test product",
        "category": "electronics"
    },
    {
        "name": "Mobile Product 2", 
        "price": 149.99,
        "description": "Another mobile test product",
        "category": "clothing"
    }
]

# Screen orientations
ORIENTATIONS = ["PORTRAIT", "LANDSCAPE"]

# Gesture test data
GESTURE_DATA = {
    "swipe_duration": 1000,
    "long_press_duration": 2000,
    "double_tap_delay": 500
}

# Smart Home Device List
DEVICE_LIST = [
    {
        "device_name": "Downlight SMT_c871b738c1a4",
        "device_type": 3
    },
    {
        "device_name": "Công tắc ba nút V2  8", 
        "device_type": 3
    },
    {
        "device_name": "Công tắc ba nút V2  7",
        "device_type": 3
    },
    {
        "device_name": "Công tắc ba nút V2  6",
        "device_type": 3
    }
]

# Device Type Mapping
DEVICE_TYPE_MAP = {
    "Công tắc một": 1,
    "Công tắc hai": 2,
    "Công tắc ba": 3,
    "Công tắc bốn": 4,
    "Curtain switch": 3
}

# Test Configuration
TEST_CONFIG = {
    "iterations": 1,
    "password": "Digital@2804",
    "phone_id": "R3CM605NEME"
}

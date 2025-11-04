#!/usr/bin/env python3
"""
Robot Framework Mobile Test Runner Script
Chạy mobile test suite với các tùy chọn khác nhau
"""

import os
import sys
import subprocess
from pathlib import Path

def run_tests(platform="android", device_name="emulator-5554", appium_server="http://localhost:4723/wd/hub"):
    """
    Chạy mobile tests với các tùy chọn khác nhau
    
    Args:
        platform: platform (android, ios)
        device_name: tên devicesel
        appium_server: địa chỉ Appium server
    """
    
    # Tạo thư mục results nếu chưa có
    results_dir = Path("results")
    results_dir.mkdir(exist_ok=True)
    
    # Cấu hình cơ bản
    robot_args = [
        "robot",
        "--outputdir", str(results_dir),
        "--variable", f"PLATFORM_NAME:{platform}",
        "--variable", f"DEVICE_NAME:{device_name}",
        "--variable", f"APPIUM_SERVER:{appium_server}",
        "--include", "smoke",
        "--include", "navigation",
        "--include", "basic",
        "--include", "device_control",
    ]
    
    # Chạy mobile tests
    robot_args.append("tests/mobile/switch_tests.robot")
    
    print(f"Chạy tests: {' '.join(robot_args)}")
    
    try:
        result = subprocess.run(robot_args, check=True)
        print("✅ Tests hoàn thành thành công!")
        return result.returncode
    except subprocess.CalledProcessError as e:
        print(f"❌ Tests thất bại với mã lỗi: {e.returncode}")
        return e.returncode

if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Robot Framework Mobile Test Runner")
    parser.add_argument("--platform", choices=["android", "ios"], 
                       default="android", help="Platform mobile")
    parser.add_argument("--device", default="emulator-5554", 
                       help="Tên device")
    parser.add_argument("--appium-server", default="http://localhost:4723/wd/hub", 
                       help="Địa chỉ Appium server")
    
    args = parser.parse_args()
    
    exit_code = run_tests(args.platform, args.device, args.appium_server)
    sys.exit(exit_code)

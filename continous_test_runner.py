#!/usr/bin/env python3
"""
Simple Continuous Test Runner
Chạy tất cả file test .robot trong tests/mobile/ liên tục
"""

import os
import subprocess
import time
import glob
from datetime import datetime
from pathlib import Path

def run_all_tests_continuous(platform="android", device_name="R3CM605NEME", appium_server="http://localhost:4723/wd/hub"):
    """Chạy tất cả test files liên tục"""
    
    # Tìm tất cả file .robot
    test_files = glob.glob("tests/mobile/*.robot")
    test_files.sort()
    
    if not test_files:
        print("❌ Không tìm thấy file test nào trong tests/mobile/")
        return
    
    print(f"🎯 Tìm thấy {len(test_files)} file test:")
    for file in test_files:
        print(f"   📄 {os.path.basename(file)}")
    
    cycle = 1
    
    try:
        while True:  # Vòng lặp vô hạn
            print(f"\n{'='*50}")
            print(f"🚀 CYCLE {cycle} - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
            print(f"{'='*50}")
            
            for test_file in test_files:
                file_name = os.path.basename(test_file).replace('.robot', '')
                
                # Tạo thư mục results
                timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
                results_dir = f"results/cycle_{cycle:03d}_{file_name}_{timestamp}"
                os.makedirs(results_dir, exist_ok=True)
                
                print(f"\n🔄 Chạy: {file_name}")
                
                # Command robot
                cmd = [
                    "robot",
                    "--outputdir", str(results_dir),
                    "--variable", f"PLATFORM_NAME:{platform}",
                    "--variable", f"DEVICE_NAME:{device_name}",
                    "--variable", f"APPIUM_SERVER:{appium_server}",
                    "--include", "smoke",
                    "--include", "navigation",
                    "--include", "basic",
                    "--include", "device_control",
                    test_file
                ]
                
                # Chạy test
                start_time = time.time()
                try:
                    result = subprocess.run(cmd, timeout=1800)  # 30 phút timeout
                    duration = time.time() - start_time
                    
                    if result.returncode == 0:
                        print(f"✅ {file_name} - PASSED ({duration:.1f}s)")
                    else:
                        print(f"❌ {file_name} - FAILED ({duration:.1f}s)")
                        
                except subprocess.TimeoutExpired:
                    print(f"⏰ {file_name} - TIMEOUT (30 phút)")
                except Exception as e:
                    print(f"💥 {file_name} - ERROR: {str(e)}")
                
                # Đợi 5 giây giữa các file
                time.sleep(5)
            
            print(f"\n✨ Hoàn thành Cycle {cycle}")
            cycle += 1
            
            # Đợi 30 giây trước cycle tiếp theo
            print(f"⏳ Đợi 30 giây trước cycle tiếp theo...")
            time.sleep(30)
            
    except KeyboardInterrupt:
        print(f"\n🛑 Dừng bởi người dùng (Ctrl+C)")
        print(f"📊 Đã hoàn thành {cycle-1} cycles")

if __name__ == "__main__":
    print("🚀 Starting Continuous Mobile Test Runner")
    print("📋 Sẽ chạy tất cả file .robot trong tests/mobile/")
    print("⏹️ Nhấn Ctrl+C để dừng")
    print("-" * 50)
    
    run_all_tests_continuous()
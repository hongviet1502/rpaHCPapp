#!/bin/bash

# Script để chạy mobile tests với virtual environment
# Usage: ./run_tests.sh [options]

# Màu sắc cho output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Robot Framework Mobile Test Runner${NC}"
echo "=================================="

# Kiểm tra virtual environment
if [ ! -d "venv" ]; then
    echo -e "${RED}❌ Virtual environment không tồn tại!${NC}"
    echo "Vui lòng chạy: python3 -m venv venv"
    exit 1
fi

# Activate virtual environment
echo -e "${YELLOW}📦 Activating virtual environment...${NC}"
source venv/bin/activate

# Kiểm tra Robot Framework
if ! command -v robot &> /dev/null; then
    echo -e "${RED}❌ Robot Framework chưa được cài đặt!${NC}"
    echo "Vui lòng chạy: pip install -r requirements.txt"
    exit 1
fi

echo -e "${GREEN}✅ Robot Framework version:${NC}"
robot --version

# Chạy tests với các options
if [ $# -eq 0 ]; then
    echo -e "${YELLOW}🧪 Chạy tất cả mobile tests...${NC}"
    python3 robot_tasks.py
else
    echo -e "${YELLOW}🧪 Chạy mobile tests với options: $@${NC}"
    python3 robot_tasks.py "$@"
fi

# Kiểm tra kết quả
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Tests hoàn thành thành công!${NC}"
    echo -e "${BLUE}📊 Xem kết quả tại: results/log.html${NC}"
else
    echo -e "${RED}❌ Tests thất bại!${NC}"
    echo -e "${BLUE}📊 Xem chi tiết tại: results/log.html${NC}"
fi

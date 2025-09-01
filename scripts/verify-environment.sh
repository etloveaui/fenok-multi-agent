#!/bin/bash

echo "🔍 WSL2 Dev-Agents 환경 검증"
echo "================================"

# WSL 버전 확인
echo "📋 WSL 정보:"
cat /proc/version | grep -i microsoft

# OS 정보
echo -e "\n📋 OS 정보:"
lsb_release -a

# Node.js 정보
echo -e "\n📋 Node.js 환경:"
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "npm prefix: $(npm config get prefix)"

# Git 정보
echo -e "\n📋 Git 설정:"
echo "User: $(git config --global user.name) <$(git config --global user.email)>"

# 디렉터리 구조
echo -e "\n📋 프로젝트 구조:"
tree -a -L 2 2>/dev/null || find . -maxdepth 2 -type d | sort

# 권한 확인
echo -e "\n📋 권한 확인:"
echo "Current user: $(whoami)"
echo "Working directory: $(pwd)"
echo "Directory permissions: $(ls -ld .)"

# 네트워크 확인
echo -e "\n📋 네트워크 연결:"
ping -c 1 google.com > /dev/null 2>&1 && echo "✅ Internet connected" || echo "❌ Internet connection failed"

echo -e "\n✅ 환경 검증 완료!"

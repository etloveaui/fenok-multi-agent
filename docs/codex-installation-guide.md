# OpenAI Codex 설치 가이드

## 🎯 OpenAI Codex란?

OpenAI Codex는 로컬에서 실행되는 AI 코딩 에이전트입니다. 터미널에서 직접 실행되며 로컬 머신의 코드를 읽고, 수정하고, 실행할 수 있어 빠른 기능 구축과 버그 수정을 도와줍니다.

**중요**: Codex는 **API 키를 사용하지 않습니다**. ChatGPT Plus/Pro/Team/Edu/Enterprise 계정으로 로그인하여 사용합니다.

## ✅ 사전 요구사항

### 1. 계정 확인
- ChatGPT Plus, Pro, Team, Edu, Enterprise 계정 필요
- 무료 계정에서는 사용 불가

### 2. 시스템 요구사항
```bash
# 지원 플랫폼 확인
# ✅ macOS (공식 지원)
# ✅ Linux (공식 지원)  
# ⚠️  Windows (WSL2 권장 - 실험적 지원)

# fenok-multi-agent 환경 확인
cd /home/etloveaui/workspace/fenok-multi-agent
pwd
```

## 🚀 Codex CLI 설치 방법

### Option 1: Homebrew 설치 (권장 - v0.2.0)
```bash
# macOS나 Linux에서 Homebrew 사용
brew install codex

# 설치 확인
codex --version
```

### Option 2: 바이너리 직접 다운로드 (최신 v0.27.0)
```bash
# WSL2 Ubuntu에서 최신 바이너리 설치
cd /tmp

# Linux aarch64 바이너리 다운로드 (2025년 8월 29일 최신)
wget https://github.com/openai/codex/releases/download/v0.27.0/codex-v0.27.0-aarch64-unknown-linux-gnu.tar.gz

# 압축 해제 및 설치
tar -xzf codex-v0.27.0-aarch64-unknown-linux-gnu.tar.gz
sudo mv codex /usr/local/bin/

# 실행 권한 설정
sudo chmod +x /usr/local/bin/codex

# 설치 확인
codex --version
```

### Option 3: 프로젝트 로컬 설치 (환경 이식성)
```bash
# fenok-multi-agent 프로젝트에 로컬 설치
cd /home/etloveaui/workspace/fenok-multi-agent

# bin 디렉터리에 바이너리 설치
mkdir -p bin/external
wget -O bin/external/codex https://github.com/openai/codex/releases/download/v0.27.0/codex-v0.27.0-aarch64-unknown-linux-gnu
chmod +x bin/external/codex

# package.json에 스크립트 추가
npm pkg set scripts.codex="./bin/external/codex"
```

## ⚙️ Codex 설정

### 1. 설정 디렉터리 구성
```bash
# Codex 전용 설정 디렉터리 생성
mkdir -p configs/codex/{settings,templates,logs,projects}

# 기본 설정 파일 생성
touch configs/codex/settings/team.json
touch configs/codex/settings/local.json.template
```

### 2. 팀 공유 설정
```bash
cat > configs/codex/settings/team.json << 'EOF'
{
  "version": "1.0",
  "features": {
    "autoSave": true,
    "contextMemory": true,
    "codeExecution": true,
    "fileModification": true
  },
  "security": {
    "allowFileWrite": true,
    "allowCommandExecution": false,
    "restrictToProject": true
  },
  "integrations": {
    "vscode": true,
    "git": true,
    "terminal": true
  },
  "workspace": {
    "projectRoot": "/home/etloveaui/workspace/fenok-multi-agent",
    "configPath": "configs/codex",
    "logPath": "configs/codex/logs"
  }
}
EOF
```

### 3. 개인 설정 템플릿
```bash
cat > configs/codex/settings/local.json.template << 'EOF'
{
  "user": {
    "name": "Your Name",
    "preferences": {
      "codeStyle": "modern",
      "verbosity": "normal",
      "autoExplain": true
    }
  },
  "editor": {
    "theme": "dark",
    "fontSize": 14,
    "tabSize": 2
  },
  "advanced": {
    "experimentalFeatures": false,
    "debugMode": false,
    "performanceMode": "balanced"
  }
}
EOF
```

## 🔧 Codex 래퍼 스크립트

### 1. 실행 스크립트 생성
```bash
cat > bin/codex << 'EOF'
#!/bin/bash

# Codex 실행 래퍼 스크립트
set -e

# 환경 로드
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Codex 설정 경로
export CODEX_CONFIG_PATH="$PROJECT_ROOT/configs/codex"
export CODEX_PROJECT_ROOT="$PROJECT_ROOT"

# 로그 디렉터리 생성
mkdir -p "$CODEX_CONFIG_PATH/logs"

# Codex 실행 방식 결정
if [ -f "$PROJECT_ROOT/bin/external/codex" ]; then
    echo "🤖 Starting Codex (local installation)..."
    exec "$PROJECT_ROOT/bin/external/codex" "$@"
elif command -v codex >/dev/null 2>&1; then
    echo "🤖 Starting Codex (system installation)..."
    exec codex "$@"
else
    echo "❌ Codex가 설치되지 않았습니다."
    echo "📦 설치 방법:"
    echo "   brew install codex"
    echo "   또는 바이너리 수동 설치"
    exit 1
fi
EOF

chmod +x bin/codex
```

### 2. VS Code 통합 설정

#### .vscode/tasks.json 업데이트
```bash
# 기존 .vscode/tasks.json에 Codex 작업 추가
cat >> .vscode/tasks.json << 'EOF'
    },
    {
        "label": "Codex Interactive",
        "type": "shell", 
        "command": "${workspaceFolder}/bin/codex",
        "group": "build",
        "presentation": {
            "echo": true,
            "reveal": "always",
            "focus": true,
            "panel": "new"
        },
        "problemMatcher": []
    },
    {
        "label": "Codex Code Review",
        "type": "shell",
        "command": "${workspaceFolder}/bin/codex",
        "args": ["review", "${file}"],
        "group": "build",
        "presentation": {
            "echo": true,
            "reveal": "always", 
            "focus": false,
            "panel": "shared"
        },
        "problemMatcher": []
    }
EOF
```

## 🎯 Codex 사용법

### 1. 로그인 및 첫 실행
```bash
# Codex 실행 (자동 로그인 프롬프트)
npm run codex

# 또는 직접 실행
./bin/codex

# 로그인 후 간단한 테스트
./bin/codex "현재 프로젝트 구조를 분석해주세요"
```

### 2. 주요 사용 시나리오

#### 코드 분석 및 리뷰
```bash
# 특정 파일 분석
./bin/codex review path/to/file.js

# 프로젝트 전체 분석
./bin/codex "이 프로젝트의 아키텍처를 분석하고 개선점을 알려주세요"
```

#### 기능 구현 지원
```bash
# 새 기능 구현
./bin/codex "React 컴포넌트로 사용자 인증 폼을 만들어주세요"

# 버그 수정
./bin/codex "이 함수에서 메모리 누수가 발생하는 원인을 찾고 수정해주세요"
```

#### VS Code에서 사용
- **Ctrl+Shift+P** → `Tasks: Run Task` → `Codex Interactive`
- 현재 열린 파일 리뷰: `Codex Code Review` 작업 실행

## 🔗 Codex MCP 서버 통합 (고급)

### MCP 서버 설정 (선택사항)
```bash
# MCP 서버 설정 디렉터리
mkdir -p configs/codex/mcp

# MCP 서버 설정 파일
cat > configs/codex/mcp/server.json << 'EOF'
{
  "name": "codex-mcp-server",
  "version": "1.0.0",
  "endpoints": {
    "code_analysis": "/analyze",
    "code_generation": "/generate", 
    "code_review": "/review"
  },
  "integration": {
    "claude": true,
    "gemini": true,
    "vscode": true
  }
}
EOF
```

## ✅ 설치 확인

### 종합 테스트
```bash
echo "🎯 Codex 설치 확인"
echo "=================="

# 1. Codex 실행 가능 확인
./bin/codex --version && echo "✅ Codex 실행 가능" || echo "❌ Codex 실행 불가"

# 2. 설정 디렉터리 확인  
[ -d configs/codex ] && echo "✅ 설정 디렉터리 존재" || echo "❌ 설정 디렉터리 없음"

# 3. 로그인 상태 확인
./bin/codex status 2>/dev/null && echo "✅ 로그인 상태 정상" || echo "❌ 로그인 필요"

# 4. VS Code 통합 확인
[ -f .vscode/tasks.json ] && echo "✅ VS Code 작업 설정됨" || echo "❌ VS Code 설정 확인 필요"

echo ""
echo "🚀 모든 ✅가 표시되면 Codex 설치 완료!"
echo "💡 VS Code에서 Ctrl+Shift+P → 'Codex Interactive' 로 시작하세요!"
```

## 🔄 업데이트 및 유지보수

### 정기 업데이트
```bash
# Homebrew 설치 시
brew upgrade codex

# 바이너리 설치 시 (최신 릴리스 확인)
# https://github.com/openai/codex/releases

# 설정 백업
cp configs/codex/settings/local.json configs/codex/settings/local.json.backup
```

이제 OpenAI Codex가 fenok-multi-agent 환경에 통합되었습니다! 🎉
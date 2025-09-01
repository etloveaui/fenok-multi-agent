# 📖 WSL2 기반 Dev-Agents 구현 가이드 (완전 상세판)

**⚠️ 기존 Windows PowerShell + Python venv 방식 완전 폐기**
**🐧 WSL2 Ubuntu 네이티브 환경에서 처음부터 새로 구축**

***

## 🎯 Chapter 0: WSL2 환경 구축 및 기본 설정

### **목표**
- Windows에서 WSL2 Ubuntu 22.04 설치 및 최적화
- 개발 환경 기본 패키지 설치
- 프로젝트 디렉터리 구조 생성
- VS Code Remote-WSL 연동 준비

### **사전 요구사항**
- Windows 10 version 2004 이상 또는 Windows 11
- 관리자 권한
- 인터넷 연결

### **Step 1: WSL2 설치**

#### **1.1 Windows 기능 활성화**
```powershell
# PowerShell (관리자 권한으로 실행)
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# 재부팅 필요
Restart-Computer
```

#### **1.2 WSL2 기본 설정**
```powershell
# 재부팅 후 PowerShell (관리자 권한)
wsl --set-default-version 2
wsl --install Ubuntu-22.04

# 설치 확인
wsl --list --verbose
```

**예상 출력:**
```
  NAME            STATE           VERSION
* Ubuntu-22.04    Running         2
```

#### **1.3 WSL2 리소스 최적화**
```powershell
# %USERPROFILE%\.wslconfig 파일 생성
notepad $env:USERPROFILE\.wslconfig
```

**파일 내용:**
```ini
[wsl2]
memory=4GB
processors=2
swap=1GB
localhostForwarding=true
guiApplications=true
```

```powershell
# WSL 재시작하여 설정 적용
wsl --shutdown
wsl
```

### **Step 2: Ubuntu 기본 환경 설정**

#### **2.1 시스템 업데이트**
```bash
# WSL Ubuntu 터미널에서
sudo apt update && sudo apt upgrade -y

# 시간대 설정
sudo timedatectl set-timezone Asia/Seoul
```

#### **2.2 필수 개발 패키지 설치**
```bash
# 기본 개발 도구
sudo apt install -y \
    curl \
    wget \
    git \
    vim \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

# Git 설정 (개인 정보로 변경)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
```

#### **2.3 Node.js LTS 설치**
```bash
# NodeSource 저장소 추가
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# Node.js 설치
sudo apt-get install -y nodejs

# 버전 확인
node --version    # v18.17.0 이상 확인
npm --version     # 9.6.0 이상 확인

# npm 글로벌 설치 권한 설정
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### **Step 3: 프로젝트 디렉터리 구조 생성**

#### **3.1 기본 디렉터리 생성**
```bash
# Windows 파일 시스템 활용 (VS Code 연동을 위해)
mkdir -p /mnt/c/Projects/dev-agents-wsl
cd /mnt/c/Projects/dev-agents-wsl

# 프로젝트 기본 구조 생성
mkdir -p {bin,scripts,configs,docs,.vscode}
mkdir -p configs/{claude,gemini,codex}

# 초기 파일 생성
touch README.md .gitignore
```

#### **3.2 .gitignore 기본 설정**
```bash
cat > .gitignore << 'EOF'
# WSL 관련
.wslconfig

# Node.js
node_modules/
npm-debug.log*
.npm

# Claude 개인 설정
configs/claude/settings.local.json
configs/claude/.claude_session
configs/claude/api_keys

# Gemini 개인 설정  
configs/gemini/settings.local.json
configs/gemini/.gemini_session
configs/gemini/api_keys

# Codex 개인 설정
configs/codex/settings.local.json
configs/codex/.codex_session
configs/codex/auth_tokens

# OS 관련
.DS_Store
Thumbs.db

# IDE 관련
.vscode/settings.json
.idea/

# 로그 파일
*.log
logs/

# 임시 파일
*.tmp
*.temp
EOF
```

#### **3.3 기본 README 작성**
```bash
cat > README.md << 'EOF'
# Dev-Agents WSL2

🤖 WSL2 Ubuntu 기반 AI 에이전트 통합 개발 환경

## 🚀 Quick Start

```
# 1. WSL2 설치
wsl --install Ubuntu-22.04

# 2. 프로젝트 클론 및 설정
git clone <repository-url>
cd dev-agents-wsl
bash scripts/setup.sh

# 3. VS Code로 열기
code .
```

## 📁 구조

- `bin/` - 실행 스크립트
- `scripts/` - 설치 및 관리 스크립트  
- `configs/` - 에이전트별 설정
- `docs/` - 문서

## 🛠️ 지원 에이전트

- **Claude** - Anthropic Claude Code
- **Gemini** - Google Gemini CLI
- **Codex** - OpenAI Codex CLI

EOF
```

### **Step 4: Git 저장소 초기화**

#### **4.1 Git 저장소 설정**
```bash
# Git 초기화
git init

# 초기 커밋
git add .
git commit -m "🎯 Initial WSL2 project setup

- WSL2 Ubuntu 22.04 기반 환경 구축
- 기본 디렉터리 구조 생성  
- Node.js LTS 설치 완료
- .gitignore 및 README.md 기본 설정"
```

### **Step 5: VS Code Remote-WSL 준비**

#### **5.1 VS Code Remote-WSL 확장 설치**
```bash
# Windows에서 VS Code가 설치되어 있다고 가정
# WSL에서 VS Code 설치 확인
code --version
```

**만약 `code` 명령이 없다면:**
```bash
# VS Code 서버 설치
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code
```

#### **5.2 기본 VS Code 설정**
```bash
# .vscode 디렉터리 설정
mkdir -p .vscode

# 기본 설정 파일 생성
cat > .vscode/settings.json << 'EOF'
{
    "terminal.integrated.defaultProfile.linux": "bash",
    "terminal.integrated.cwd": "${workspaceFolder}",
    "files.eol": "\n",
    "files.encoding": "utf8",
    "editor.tabSize": 2,
    "editor.insertSpaces": true,
    "files.associations": {
        "*.sh": "shellscript"
    },
    "shellcheck.enable": true,
    "remote.WSL.fileWatcher.polling": true
}
EOF

# 확장 추천 설정
cat > .vscode/extensions.json << 'EOF'
{
    "recommendations": [
        "ms-vscode-remote.remote-wsl",
        "ms-vscode.vscode-json",
        "timonwong.shellcheck",
        "foxundermoon.shell-format"
    ]
}
EOF
```

### **Step 6: 환경 검증**

#### **6.1 시스템 정보 확인**
```bash
# 시스템 검증 스크립트 생성
cat > scripts/verify-environment.sh << 'EOF'
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
EOF

chmod +x scripts/verify-environment.sh
./scripts/verify-environment.sh
```

#### **6.2 성공 조건 확인**
다음 모든 항목이 ✅ 표시되어야 합니다:

```bash
# 필수 확인 사항
echo "🎯 Chapter 0 완료 체크리스트:"
echo "================================"

# WSL 버전
wsl.exe --status | grep -q "Default Version: 2" && echo "✅ WSL2 기본 버전 설정" || echo "❌ WSL2 설정 확인 필요"

# Node.js 버전
node_version=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
[ "$node_version" -ge 18 ] && echo "✅ Node.js 18+ 설치됨" || echo "❌ Node.js 버전 확인 필요"

# 프로젝트 구조
[ -d "bin" ] && [ -d "scripts" ] && [ -d "configs" ] && echo "✅ 프로젝트 디렉터리 구조" || echo "❌ 디렉터리 구조 확인 필요"

# Git 저장소
[ -d ".git" ] && echo "✅ Git 저장소 초기화" || echo "❌ Git 저장소 확인 필요"

# VS Code 연동
code --version > /dev/null 2>&1 && echo "✅ VS Code 연동 준비" || echo "❌ VS Code 설치 확인 필요"

# 권한 확인
[ -x "scripts/verify-environment.sh" ] && echo "✅ 스크립트 실행 권한" || echo "❌ 스크립트 권한 확인 필요"

echo -e "\n📍 현재 위치: $(pwd)"
echo "📍 Windows 경로: $(wslpath -w $(pwd))"
```

### **Step 7: 다음 단계 준비**

#### **7.1 환경 변수 설정**
```bash
# 프로젝트 환경 변수를 .bashrc에 추가
cat >> ~/.bashrc << 'EOF'

# Dev-Agents WSL2 Environment
export DEV_AGENTS_ROOT="/mnt/c/Projects/dev-agents-wsl"
export DEV_AGENTS_BIN="$DEV_AGENTS_ROOT/bin"
export DEV_AGENTS_CONFIG="$DEV_AGENTS_ROOT/configs"

# PATH에 bin 디렉터리 추가
export PATH="$DEV_AGENTS_BIN:$PATH"

# 편의 함수
alias dev-agents='cd $DEV_AGENTS_ROOT'
alias agents-verify='$DEV_AGENTS_ROOT/scripts/verify-environment.sh'

EOF

# 설정 즉시 적용
source ~/.bashrc
```

#### **7.2 Chapter 1 준비 확인**
```bash
# Chapter 1로 넘어가기 전 최종 확인
echo "🎯 Chapter 1 준비 상태 확인:"
echo "==============================="

# 환경 변수 확인
echo "DEV_AGENTS_ROOT: $DEV_AGENTS_ROOT"
echo "DEV_AGENTS_BIN: $DEV_AGENTS_BIN"
echo "DEV_AGENTS_CONFIG: $DEV_AGENTS_CONFIG"

# 단축 명령어 테스트
echo -e "\n📁 단축 명령어 테스트:"
dev-agents && echo "✅ dev-agents 명령어 작동" || echo "❌ dev-agents 명령어 오류"
agents-verify > /dev/null 2>&1 && echo "✅ agents-verify 명령어 작동" || echo "❌ agents-verify 명령어 오류"

echo -e "\n🎉 Chapter 0 완료!"
echo "다음 단계: Chapter 1 - Claude Code 설치 및 설정"
```

***

## 🤖 Chapter 1: Claude Code 설치 및 설정

### **목표**
- WSL Ubuntu에서 Claude Code npm 패키지 설치
- 프로젝트별 Claude 설정 디렉터리 구성
- 기본 Claude 실행 환경 구축
- API 키 설정 및 첫 실행 테스트

### **사전 조건**
- Chapter 0 완료 (WSL2 + Node.js + 프로젝트 구조)
- Anthropic API 키 준비 (https://console.anthropic.com/)

### **Step 1: Claude Code 설치**

#### **1.1 글로벌 설치 방식**
```bash
# dev-agents 프로젝트 디렉터리로 이동
dev-agents

# Claude Code 글로벌 설치
npm install -g @anthropic/claude

# 설치 확인
claude --version
which claude

# 설치 위치 확인
ls -la ~/.npm-global/bin/claude*
```

#### **1.2 로컬 설치 방식 (프로젝트 종속)**
```bash
# package.json 초기화
npm init -y

# 프로젝트명과 설명 수정
cat > package.json << 'EOF'
{
  "name": "dev-agents-wsl",
  "version": "1.0.0",
  "description": "WSL2 기반 AI 에이전트 통합 개발 환경",
  "main": "index.js",
  "scripts": {
    "claude": "claude",
    "setup": "bash scripts/setup.sh",
    "verify": "bash scripts/verify-environment.sh"
  },
  "keywords": ["ai", "claude", "gemini", "codex", "wsl2"],
  "author": "Your Name",
  "license": "MIT",
  "dependencies": {
    "@anthropic/claude": "^1.0.0"
  }
}
EOF

# Claude Code 로컬 설치
npm install @anthropic/claude

# 설치 확인
./node_modules/.bin/claude --version
```

### **Step 2: Claude 설정 디렉터리 구성**

#### **2.1 설정 디렉터리 구조 생성**
```bash
# Claude 전용 설정 디렉터리 생성
mkdir -p configs/claude/{settings,sessions,prompts,mcp}

# 설정 파일들 생성
touch configs/claude/settings/{team.json,local.json,mcp.json}
touch configs/claude/.clauderc

# 디렉터리 구조 확인
tree configs/claude/ || find configs/claude/ -type f
```

#### **2.2 팀 공유 설정 파일**
```bash
cat > configs/claude/settings/team.json << 'EOF'
{
  "model": "claude-3-5-sonnet-20241022",
  "maxTokens": 8000,
  "temperature": 0.1,
  "outputStyle": {
    "format": "markdown",
    "codeHighlighting": true,
    "useEmojis": true
  },
  "features": {
    "autoSave": true,
    "contextMemory": true,
    "multilineInput": true
  },
  "mcp": {
    "enabled": true,
    "servers": ["context7", "sequential", "playwright"]
  },
  "workspace": {
    "projectRoot": "/mnt/c/Projects/dev-agents-wsl",
    "configPath": "configs/claude",
    "sessionPath": "configs/claude/sessions"
  }
}
EOF
```

#### **2.3 개인 설정 템플릿**
```bash
cat > configs/claude/settings/local.json.template << 'EOF'
{
  "apiKey": "sk-ant-api03-your-actual-api-key-here",
  "user": {
    "name": "Your Name",
    "email": "your.email@example.com",
    "preferences": {
      "language": "korean",
      "timezone": "Asia/Seoul",
      "autoTranslate": false
    }
  },
  "advanced": {
    "debugMode": false,
    "verboseLogging": false,
    "experimentalFeatures": true
  }
}
EOF

# 실제 local.json은 .gitignore에 포함되어 있음
echo "⚠️  configs/claude/settings/local.json.template을 복사하여"
echo "   configs/claude/settings/local.json로 만들고 API 키를 설정하세요"
```

#### **2.4 Claude RC 설정**
```bash
cat > configs/claude/.clauderc << 'EOF'
# Claude 환경 설정 파일
export CLAUDE_CONFIG_PATH="/mnt/c/Projects/dev-agents-wsl/configs/claude"
export CLAUDE_SESSION_PATH="$CLAUDE_CONFIG_PATH/sessions"
export CLAUDE_PROMPTS_PATH="$CLAUDE_CONFIG_PATH/prompts"
export CLAUDE_MCP_PATH="$CLAUDE_CONFIG_PATH/mcp"

# Claude 기본 설정
export CLAUDE_MODEL="claude-3-5-sonnet-20241022"
export CLAUDE_MAX_TOKENS="8000"
export CLAUDE_TEMPERATURE="0.1"

# 로깅 설정
export CLAUDE_LOG_LEVEL="info"
export CLAUDE_LOG_FILE="$CLAUDE_CONFIG_PATH/claude.log"

# MCP 서버 설정
export CLAUDE_MCP_ENABLED="true"
export CLAUDE_MCP_SERVERS="context7,sequential,playwright"
EOF
```

### **Step 3: Claude 실행 래퍼 스크립트**

#### **3.1 메인 실행 스크립트**
```bash
cat > bin/claude << 'EOF'
#!/bin/bash

# Claude 실행 래퍼 스크립트 (WSL2 네이티브)
set -e

# 프로젝트 루트 경로
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Claude 설정 로드
CLAUDE_CONFIG_PATH="$PROJECT_ROOT/configs/claude"
export CLAUDE_CONFIG_PATH

# 설정 파일 확인
if [ ! -f "$CLAUDE_CONFIG_PATH/settings/local.json" ]; then
    echo "❌ Claude 개인 설정이 없습니다."
    echo "📝 다음 명령어로 설정을 생성하세요:"
    echo "   cp $CLAUDE_CONFIG_PATH/settings/local.json.template $CLAUDE_CONFIG_PATH/settings/local.json"
    echo "   편집기로 열어 API 키를 설정하세요."
    exit 1
fi

# 환경 설정 로드
if [ -f "$CLAUDE_CONFIG_PATH/.clauderc" ]; then
    source "$CLAUDE_CONFIG_PATH/.clauderc"
fi

# 로그 디렉터리 생성
mkdir -p "$(dirname "$CLAUDE_LOG_FILE")"

# Claude 실행 방식 결정
if [ -f "$PROJECT_ROOT/node_modules/.bin/claude" ]; then
    # 로컬 설치 우선
    echo "🤖 Starting Claude (local installation)..."
    "$PROJECT_ROOT/node_modules/.bin/claude" "$@"
elif command -v claude >/dev/null 2>&1; then
    # 글로벌 설치 fallback
    echo "🤖 Starting Claude (global installation)..."
    claude "$@"
else
    echo "❌ Claude가 설치되지 않았습니다."
    echo "📦 다음 명령어로 설치하세요:"
    echo "   npm install -g @anthropic/claude"
    echo "   또는"
    echo "   npm install @anthropic/claude"
    exit 1
fi
EOF

chmod +x bin/claude
```

#### **3.2 설정 관리 스크립트**
```bash
cat > bin/claude-config << 'EOF'
#!/bin/bash

# Claude 설정 관리 스크립트
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONFIG_PATH="$PROJECT_ROOT/configs/claude"

show_usage() {
    echo "Claude 설정 관리 도구"
    echo "사용법: claude-config <command> [options]"
    echo ""
    echo "명령어:"
    echo "  init                 - 개인 설정 파일 초기화"
    echo "  status              - 설정 상태 확인"
    echo "  set <key> <value>   - 설정 값 변경"
    echo "  get <key>           - 설정 값 조회"
    echo "  backup              - 설정 백업"
    echo "  restore <backup>    - 설정 복원"
    echo ""
    echo "예시:"
    echo "  claude-config init"
    echo "  claude-config set apiKey 'sk-ant-api03-...'"
    echo "  claude-config get model"
}

init_config() {
    local template_file="$CONFIG_PATH/settings/local.json.template"
    local config_file="$CONFIG_PATH/settings/local.json"
    
    if [ -f "$config_file" ]; then
        echo "⚠️  개인 설정 파일이 이미 존재합니다: $config_file"
        read -p "덮어쓰시겠습니까? (y/N): " -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "취소되었습니다."
            return 1
        fi
    fi
    
    if [ ! -f "$template_file" ]; then
        echo "❌ 템플릿 파일을 찾을 수 없습니다: $template_file"
        return 1
    fi
    
    cp "$template_file" "$config_file"
    echo "✅ 개인 설정 파일이 생성되었습니다: $config_file"
    echo "📝 API 키를 설정하려면 다음 명령어를 실행하세요:"
    echo "   claude-config set apiKey 'your-api-key-here'"
}

check_status() {
    echo "🔍 Claude 설정 상태 확인"
    echo "=========================="
    
    # 설정 파일 확인
    local team_config="$CONFIG_PATH/settings/team.json"
    local local_config="$CONFIG_PATH/settings/local.json"
    
    echo "📂 설정 파일:"
    [ -f "$team_config" ] && echo "  ✅ 팀 설정: $team_config" || echo "  ❌ 팀 설정 없음"
    [ -f "$local_config" ] && echo "  ✅ 개인 설정: $local_config" || echo "  ❌ 개인 설정 없음"
    
    # API 키 확인
    if [ -f "$local_config" ]; then
        if grep -q "sk-ant-api03-" "$local_config" && ! grep -q "your-actual-api-key-here" "$local_config"; then
            echo "  ✅ API 키 설정됨"
        else
            echo "  ❌ API 키 미설정"
        fi
    fi
    
    # Claude 설치 확인
    echo ""
    echo "🤖 Claude 설치 상태:"
    if [ -f "$PROJECT_ROOT/node_modules/.bin/claude" ]; then
        echo "  ✅ 로컬 설치: $PROJECT_ROOT/node_modules/.bin/claude"
    elif command -v claude >/dev/null 2>&1; then
        echo "  ✅ 글로벌 설치: $(which claude)"
    else
        echo "  ❌ Claude 미설치"
    fi
    
    # 디렉터리 구조
    echo ""
    echo "📁 디렉터리 구조:"
    tree "$CONFIG_PATH" 2>/dev/null || find "$CONFIG_PATH" -type d | sort
}

set_config() {
    local key="$1"
    local value="$2"
    local config_file="$CONFIG_PATH/settings/local.json"
    
    if [ -z "$key" ] || [ -z "$value" ]; then
        echo "❌ 키와 값을 모두 제공해야 합니다."
        echo "사용법: claude-config set <key> <value>"
        return 1
    fi
    
    if [ ! -f "$config_file" ]; then
        echo "❌ 개인 설정 파일이 없습니다. 먼저 'claude-config init'을 실행하세요."
        return 1
    fi
    
    # jq를 사용한 JSON 수정
    if command -v jq >/dev/null 2>&1; then
        local temp_file=$(mktemp)
        jq --arg k "$key" --arg v "$value" '.[$k] = $v' "$config_file" > "$temp_file"
        mv "$temp_file" "$config_file"
        echo "✅ $key = $value 설정 완료"
    else
        echo "❌ jq가 설치되지 않았습니다. 수동으로 파일을 편집하세요: $config_file"
        return 1
    fi
}

get_config() {
    local key="$1"
    local config_file="$CONFIG_PATH/settings/local.json"
    
    if [ -z "$key" ]; then
        echo "❌ 조회할 키를 제공해야 합니다."
        echo "사용법: claude-config get <key>"
        return 1
    fi
    
    if [ ! -f "$config_file" ]; then
        echo "❌ 개인 설정 파일이 없습니다."
        return 1
    fi
    
    if command -v jq >/dev/null 2>&1; then
        local value=$(jq -r --arg k "$key" '.[$k] // empty' "$config_file")
        if [ -n "$value" ]; then
            echo "$value"
        else
            echo "❌ 키 '$key'를 찾을 수 없습니다."
            return 1
        fi
    else
        echo "❌ jq가 설치되지 않았습니다."
        return 1
    fi
}

backup_config() {
    local backup_dir="$CONFIG_PATH/backups"
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_file="$backup_dir/claude_config_$timestamp.tar.gz"
    
    mkdir -p "$backup_dir"
    
    tar -czf "$backup_file" -C "$CONFIG_PATH" settings/ .clauderc
    echo "✅ 설정 백업 완료: $backup_file"
}

# 메인 로직
case "$1" in
    "init")
        init_config
        ;;
    "status")
        check_status
        ;;
    "set")
        set_config "$2" "$3"
        ;;
    "get")
        get_config "$2"
        ;;
    "backup")
        backup_config
        ;;
    *)
        show_usage
        ;;
esac
EOF

chmod +x bin/claude-config
```

### **Step 4: jq 설치 및 기본 유틸리티**

#### **4.1 jq 설치**
```bash
# JSON 처리를 위한 jq 설치
sudo apt install -y jq

# 설치 확인
jq --version
```

#### **4.2 tree 설치 (디렉터리 구조 확인용)**
```bash
# tree 설치
sudo apt install -y tree

# 설치 확인
tree --version
```

### **Step 5: 첫 설정 및 테스트**

#### **5.1 개인 설정 초기화**
```bash
# 개인 설정 파일 생성
claude-config init

# 상태 확인
claude-config status
```

#### **5.2 API 키 설정**
```bash
# API 키 설정 (실제 키로 교체)
claude-config set apiKey "sk-ant-api03-your-actual-api-key-here"

# 기타 개인 설정
claude-config set user.name "Your Name"
claude-config set user.email "your.email@example.com"
claude-config set user.preferences.language "korean"

# 설정 확인
claude-config get apiKey
claude-config get user.name
```

#### **5.3 첫 실행 테스트**
```bash
# Claude 첫 실행 (버전 확인)
claude --version

# 간단한 테스트
echo "Claude 테스트를 위한 간단한 질문: 1+1은?" | claude

# 대화형 모드 테스트 (Ctrl+C로 종료)
claude
```

### **Step 6: VS Code 통합 설정**

#### **6.1 VS Code 작업 설정**
```bash
cat > .vscode/tasks.json << 'EOF'
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Claude Interactive",
            "type": "shell",
            "command": "${workspaceFolder}/bin/claude",
            "group": "build",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "new"
            },
            "problemMatcher": []
        },
        {
            "label": "Claude Config Status",
            "type": "shell",
            "command": "${workspaceFolder}/bin/claude-config",
            "args": ["status"],
            "group": "build",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            },
            "problemMatcher": []
        },
        {
            "label": "Setup Claude",
            "type": "shell",
            "command": "${workspaceFolder}/bin/claude-config",
            "args": ["init"],
            "group": "build",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            },
            "problemMatcher": []
        }
    ]
}
EOF
```

#### **6.2 키바인딩 설정**
```bash
cat > .vscode/keybindings.json << 'EOF'
[
    {
        "key": "ctrl+shift+c",
        "command": "workbench.action.tasks.runTask",
        "args": "Claude Interactive",
        "when": "!terminalFocus"
    },
    {
        "key": "f1",
        "command": "workbench.action.tasks.runTask",
        "args": "Claude Config Status",
        "when": "!terminalFocus"
    }
]
EOF
```

### **Step 7: 검증 및 문제 해결**

#### **7.1 종합 검증 스크립트**
```bash
cat > scripts/verify-claude.sh << 'EOF'
#!/bin/bash

echo "🤖 Claude 설치 및 설정 검증"
echo "============================="

# 기본 정보
echo "📋 기본 정보:"
echo "Project Root: $(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "Date: $(date)"
echo ""

# Claude 설치 확인
echo "📦 Claude 설치 상태:"
if [ -f "../node_modules/.bin/claude" ]; then
    echo "✅ 로컬 설치: $(ls -la ../node_modules/.bin/claude | awk '{print $NF}')"
    echo "   버전: $(../node_modules/.bin/claude --version 2>/dev/null || echo 'N/A')"
elif command -v claude >/dev/null 2>&1; then
    echo "✅ 글로벌 설치: $(which claude)"
    echo "   버전: $(claude --version 2>/dev/null || echo 'N/A')"
else
    echo "❌ Claude 미설치"
fi
echo ""

# 설정 파일 확인
echo "📁 설정 파일 상태:"
config_path="../configs/claude"
for file in settings/team.json settings/local.json .clauderc; do
    if [ -f "$config_path/$file" ]; then
        echo "✅ $file"
        if [[ "$file" == "settings/local.json" ]]; then
            if grep -q "your-actual-api-key-here" "$config_path/$file" 2>/dev/null; then
                echo "   ⚠️  API 키가 템플릿 상태입니다"
            else
                echo "   ✅ API 키 설정됨"
            fi
        fi
    else
        echo "❌ $file 없음"
    fi
done
echo ""

# 실행 스크립트 확인
echo "🔧 실행 스크립트 상태:"
for script in claude claude-config; do
    script_path="../bin/$script"
    if [ -f "$script_path" ]; then
        if [ -x "$script_path" ]; then
            echo "✅ $script (실행 가능)"
        else
            echo "⚠️  $script (실행 권한 없음)"
        fi
    else
        echo "❌ $script 없음"
    fi
done
echo ""

# 의존성 확인
echo "📚 의존성 상태:"
dependencies=("jq" "tree" "node" "npm")
for dep in "${dependencies[@]}"; do
    if command -v "$dep" >/dev/null 2>&1; then
        echo "✅ $dep: $(which $dep)"
    else
        echo "❌ $dep 미설치"
    fi
done
echo ""

# 실제 Claude 테스트
echo "🧪 Claude 실행 테스트:"
if ../bin/claude --version >/dev/null 2>&1; then
    echo "✅ Claude 실행 가능"
    echo "   버전: $(../bin/claude --version 2>/dev/null)"
else
    echo "❌ Claude 실행 실패"
    echo "   오류 내용:"
    ../bin/claude --version 2>&1 | sed 's/^/   /'
fi

echo ""
echo "🎯 검증 완료!"
EOF

chmod +x scripts/verify-claude.sh
./scripts/verify-claude.sh
```

#### **7.2 문제 해결 가이드**

**자주 발생하는 문제들:**

1. **API 키 미설정**
```bash
# 해결방법
claude-config set apiKey "sk-ant-api03-your-actual-api-key"
```

2. **실행 권한 없음**
```bash
# 해결방법
chmod +x bin/claude bin/claude-config
```

3. **jq 미설치**
```bash
# 해결방법
sudo apt install -y jq
```

4. **NODE_PATH 관련 오류**
```bash
# 해결방법
echo 'export NODE_PATH=$(npm root -g)' >> ~/.bashrc
source ~/.bashrc
```

### **Step 8: Chapter 1 완료 확인**

#### **8.1 최종 체크리스트**
```bash
echo "🎯 Chapter 1 완료 체크리스트"
echo "============================"

# 필수 항목들 확인
checks=(
    "Claude 설치 확인:../bin/claude --version"
    "설정 파일 존재:test -f configs/claude/settings/local.json"
    "API 키 설정:grep -v 'your-actual-api-key-here' configs/claude/settings/local.json"
    "실행 권한:test -x bin/claude"
    "설정 도구:bin/claude-config status"
    "VS Code 작업:test -f .vscode/tasks.json"
)

all_passed=true
for check in "${checks[@]}"; do
    description="${check%%:*}"
    command="${check#*:}"
    
    if eval "$command" >/dev/null 2>&1; then
        echo "✅ $description"
    else
        echo "❌ $description"
        all_passed=false
    fi
done

echo ""
if [ "$all_passed" = true ]; then
    echo "🎉 Chapter 1 완료! 다음 단계로 진행 가능합니다."
    echo "📋 다음: Chapter 2 - WSL 네이티브 런처 시스템"
else
    echo "⚠️  일부 항목이 완료되지 않았습니다. 위의 ❌ 항목들을 확인하세요."
fi
```

#### **8.2 다음 챕터 준비**
```bash
# Chapter 2를 위한 기본 정보 저장
cat > configs/claude/chapter1-summary.md << 'EOF'
# Chapter 1 완료 상태

## 설치된 항목
- Claude Code (npm 패키지)
- jq (JSON 처리)
- tree (디렉터리 구조 확인)

## 생성된 파일
- bin/claude (실행 스크립트)
- bin/claude-config (설정 관리)
- configs/claude/settings/* (설정 파일들)
- .vscode/tasks.json (VS Code 통합)

## 설정된 환경변수
- CLAUDE_CONFIG_PATH
- CLAUDE_SESSION_PATH
- CLAUDE_MODEL

## 다음 단계
Chapter 2에서는 더 고급 런처 시스템과 자동화를 구축합니다.
EOF

echo "📝 Chapter 1 요약이 저장되었습니다: configs/claude/chapter1-summary.md"
```

***

## 🚀 Chapter 2: WSL 네이티브 런처 시스템

### **목표**
- 고급 Claude 런처 시스템 구축
- 환경변수 격리 및 자동화
- 세션 관리 및 로깅 시스템
- PATH 설정 자동화
- 다중 Claude 인스턴스 관리

### **사전 조건**
- Chapter 1 완료 (Claude Code 설치 및 기본 설정)
- API 키 설정 완료
- jq, tree 등 유틸리티 설치

### **Step 1: 고급 환경 격리 시스템**

#### **1.1 프로젝트별 환경 격리**
```bash
# 환경 설정 스크립트 생성
cat > scripts/setup-environment.sh << 'EOF'
#!/bin/bash

# WSL 네이티브 환경 설정 스크립트
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "🔧 Dev-Agents 환경 설정"
echo "========================"

# 프로젝트 환경변수 설정
setup_project_env() {
    echo "📋 프로젝트 환경변수 설정..."
    
    # 기본 경로들
    export DEV_AGENTS_ROOT="$PROJECT_ROOT"
    export DEV_AGENTS_BIN="$PROJECT_ROOT/bin"
    export DEV_AGENTS_CONFIG="$PROJECT_ROOT/configs"
    export DEV_AGENTS_SCRIPTS="$PROJECT_ROOT/scripts"
    export DEV_AGENTS_LOGS="$PROJECT_ROOT/logs"
    
    # Claude 전용 환경변수
    export CLAUDE_HOME="$DEV_AGENTS_CONFIG/claude"
    export CLAUDE_CONFIG_PATH="$CLAUDE_HOME/settings"
    export CLAUDE_SESSION_PATH="$CLAUDE_HOME/sessions"
    export CLAUDE_PROMPTS_PATH="$CLAUDE_HOME/prompts"
    export CLAUDE_MCP_PATH="$CLAUDE_HOME/mcp"
    export CLAUDE_LOG_PATH="$DEV_AGENTS_LOGS/claude"
    
    # 로그 디렉터리 생성
    mkdir -p "$CLAUDE_LOG_PATH" "$CLAUDE_SESSION_PATH" "$CLAUDE_PROMPTS_PATH" "$CLAUDE_MCP_PATH"
    
    echo "✅ 환경변수 설정 완료"
}

# WSL 특화 설정
setup_wsl_specific() {
    echo "🐧 WSL 특화 설정..."
    
    # Windows 경로 매핑
    export WINDOWS_PROJECT_ROOT=$(wslpath -w "$PROJECT_ROOT" 2>/dev/null || echo "N/A")
    
    # WSL 환경 정보
    export WSL_DISTRO_NAME=$(cat /proc/version | grep -oP 'Microsoft.*WSL\d*' | head -1)
    export WSL_INTEROP=$(ls /run/WSL/ 2>/dev/null | head -1)
    
    # 권한 설정
    umask 022
    
    echo "✅ WSL 설정 완료"
}

# PATH 설정
setup_path() {
    echo "🛤️  PATH 설정..."
    
    # 기존 PATH에서 중복 제거
    export PATH=$(echo "$PATH" | tr ':' '\n' | awk '!seen[$0]++' | tr '\n' ':' | sed 's/:$//')
    
    # 프로젝트 bin을 PATH 앞쪽에 추가
    export PATH="$DEV_AGENTS_BIN:$PATH"
    
    echo "✅ PATH 설정 완료: $DEV_AGENTS_BIN"
}

# 환경 정보 표시
show_environment() {
    echo ""
    echo "🌍 설정된 환경:"
    echo "=================="
    echo "Project Root: $DEV_AGENTS_ROOT"
    echo "Windows Path: $WINDOWS_PROJECT_ROOT"
    echo "WSL Distro: $WSL_DISTRO_NAME"
    echo "Claude Home: $CLAUDE_HOME"
    echo "Logs Path: $CLAUDE_LOG_PATH"
    echo ""
}

# 메인 실행
main() {
    setup_project_env
    setup_wsl_specific
    setup_path
    show_environment
    
    # 환경변수를 파일로 저장 (다른 스크립트에서 사용)
    cat > "$PROJECT_ROOT/.env" << ENV_EOF
# Dev-Agents Environment Variables (Auto-generated)
export DEV_AGENTS_ROOT="$DEV_AGENTS_ROOT"
export DEV_AGENTS_BIN="$DEV_AGENTS_BIN"
export DEV_AGENTS_CONFIG="$DEV_AGENTS_CONFIG"
export DEV_AGENTS_SCRIPTS="$DEV_AGENTS_SCRIPTS"
export DEV_AGENTS_LOGS="$DEV_AGENTS_LOGS"
export CLAUDE_HOME="$CLAUDE_HOME"
export CLAUDE_CONFIG_PATH="$CLAUDE_CONFIG_PATH"
export CLAUDE_SESSION_PATH="$CLAUDE_SESSION_PATH"
export CLAUDE_PROMPTS_PATH="$CLAUDE_PROMPTS_PATH"
export CLAUDE_MCP_PATH="$CLAUDE_MCP_PATH"
export CLAUDE_LOG_PATH="$CLAUDE_LOG_PATH"
export WINDOWS_PROJECT_ROOT="$WINDOWS_PROJECT_ROOT"
export WSL_DISTRO_NAME="$WSL_DISTRO_NAME"
export PATH="$PATH"
ENV_EOF

    echo "✅ 환경 설정 완료! (.env 파일로 저장됨)"
}

# 스크립트가 직접 실행된 경우
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi
EOF

chmod +x scripts/setup-environment.sh
```

#### **1.2 환경 로더 함수**
```bash
cat > scripts/load-environment.sh << 'EOF'
#!/bin/bash

# 환경 로더 (다른 스크립트에서 source로 사용)

# 스크립트 경로 감지
if [ -n "${BASH_SOURCE[0]}" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
elif [ -n "$0" ]; then
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
else
    SCRIPT_DIR="$(pwd)"
fi

PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# 환경 파일이 있으면 로드
if [ -f "$PROJECT_ROOT/.env" ]; then
    source "$PROJECT_ROOT/.env"
else
    # 없으면 기본 환경 설정 실행
    source "$PROJECT_ROOT/scripts/setup-environment.sh"
fi

# 환경 검증
verify_environment() {
    local required_vars=(
        "DEV_AGENTS_ROOT"
        "DEV_AGENTS_BIN" 
        "CLAUDE_HOME"
        "CLAUDE_CONFIG_PATH"
    )
    
    for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
            echo "❌ 환경변수 $var이 설정되지 않았습니다."
            return 1
        fi
    done
    
    return 0
}

# 환경 로드 확인 메시지 (조용한 모드가 아닐 때만)
if [ "$1" != "--quiet" ] && [ -z "$QUIET_LOAD" ]; then
    echo "🌍 Dev-Agents 환경 로드됨: $PROJECT_ROOT"
fi
EOF
```

### **Step 2: 고급 Claude 런처**

#### **2.1 메인 런처 스크립트 (업그레이드)**
```bash
cat > bin/claude << 'EOF'
#!/bin/bash

# Claude 고급 런처 스크립트 (WSL2 네이티브)
set -e

# 환경 로드
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$PROJECT_ROOT/scripts/load-environment.sh" --quiet

# 로깅 설정
setup_logging() {
    local log_file="$CLAUDE_LOG_PATH/claude_$(date +%Y%m%d).log"
    mkdir -p "$(dirname "$log_file")"
    
    # 로그 함수
    log() {
        local level="$1"
        shift
        local message="$*"
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        echo "[$timestamp] [$level] $message" >> "$log_file"
        
        # INFO 레벨 이상은 콘솔에도 출력
        if [ "$level" != "DEBUG" ]; then
            echo "$message"
        fi
    }
    
    export -f log
    export CLAUDE_LOG_FILE="$log_file"
}

# 설정 검증
validate_config() {
    log "INFO" "🔍 Claude 설정 검증 중..."
    
    local team_config="$CLAUDE_CONFIG_PATH/team.json"
    local local_config="$CLAUDE_CONFIG_PATH/local.json"
    
    # 팀 설정 확인
    if [ ! -f "$team_config" ]; then
        log "ERROR" "❌ 팀 설정 파일이 없습니다: $team_config"
        return 1
    fi
    
    # 개인 설정 확인
    if [ ! -f "$local_config" ]; then
        log "ERROR" "❌ 개인 설정 파일이 없습니다: $local_config"
        log "INFO" "📝 다음 명령어로 설정을 생성하세요: claude-config init"
        return 1
    fi
    
    # API 키 검증
    if ! jq -e '.apiKey' "$local_config" >/dev/null 2>&1 || \
       jq -r '.apiKey' "$local_config" | grep -q "your-actual-api-key-here"; then
        log "ERROR" "❌ API 키가 설정되지 않았습니다"
        log "INFO" "📝 다음 명령어로 API 키를 설정하세요: claude-config set apiKey 'your-key'"
        return 1
    fi
    
    log "INFO" "✅ 설정 검증 완료"
    return 0
}

# Claude 실행 방식 결정
find_claude_executable() {
    local claude_paths=(
        "$PROJECT_ROOT/node_modules/.bin/claude"
        "$(which claude 2>/dev/null || echo '')"
    )
    
    for claude_path in "${claude_paths[@]}"; do
        if [ -n "$claude_path" ] && [ -x "$claude_path" ]; then
            echo "$claude_path"
            return 0
        fi
    done
    
    return 1
}

# 세션 관리
manage_session() {
    local session_id="${CLAUDE_SESSION_ID:-$(date +%Y%m%d_%H%M%S)}"
    local session_file="$CLAUDE_SESSION_PATH/session_$session_id.json"
    
    # 세션 정보 생성
    cat > "$session_file" << SESSION_EOF
{
    "sessionId": "$session_id",
    "startTime": "$(date -Iseconds)",
    "projectRoot": "$PROJECT_ROOT",
    "claudeVersion": "$(find_claude_executable | xargs -I {} {} --version 2>/dev/null || echo 'unknown')",
    "arguments": $(printf '%s\n' "$@" | jq -R . | jq -s .),
    "environment": {
        "wslDistro": "$WSL_DISTRO_NAME",
        "windowsPath": "$WINDOWS_PROJECT_ROOT"
    }
}
SESSION_EOF

    export CLAUDE_SESSION_ID="$session_id"
    export CLAUDE_SESSION_FILE="$session_file"
    
    log "INFO" "📋 세션 시작: $session_id"
}

# 실행 전 환경 준비
prepare_execution() {
    # Claude 설정을 환경변수로 설정
    local team_config="$CLAUDE_CONFIG_PATH/team.json"
    local local_config="$CLAUDE_CONFIG_PATH/local.json"
    
    # 설정 병합 및 환경변수 설정
    if command -v jq >/dev/null 2>&1; then
        export ANTHROPIC_API_KEY=$(jq -r '.apiKey' "$local_config")
        export CLAUDE_MODEL=$(jq -r '.model // "claude-3-5-sonnet-20241022"' "$team_config")
        export CLAUDE_MAX_TOKENS=$(jq -r '.maxTokens // 8000' "$team_config")
        export CLAUDE_TEMPERATURE=$(jq -r '.temperature // 0.1' "$team_config")
    fi
    
    # 작업 디렉터리 설정
    cd "$PROJECT_ROOT"
    
    log "INFO" "🚀 Claude 실행 준비 완료"
}

# 사용법 표시
show_usage() {
    cat << USAGE_EOF
🤖 Claude WSL2 네이티브 런처

사용법:
  claude [options] [claude-arguments]

옵션:
  --version          Claude 버전 표시
  --config           설정 상태 표시  
  --session <id>     특정 세션 ID 사용
  --debug            디버그 모드 활성화
  --help             이 도움말 표시

예시:
  claude                          # 대화형 모드
  claude "Hello, Claude!"         # 한 줄 질문
  claude --session mysession     # 특정 세션으로 실행
  claude --debug                  # 디버그 모드

환경:
  Project: $PROJECT_ROOT
  Config: $CLAUDE_CONFIG_PATH
  Logs: $CLAUDE_LOG_PATH
USAGE_EOF
}

# 메인 로직
main() {
    # 로깅 설정
    setup_logging
    
    # 옵션 파싱
    local debug_mode=false
    local show_config=false
    local args=()
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help|-h)
                show_usage
                exit 0
                ;;
            --version)
                local claude_exec=$(find_claude_executable)
                if [ -n "$claude_exec" ]; then
                    "$claude_exec" --version
                else
                    echo "❌ Claude 실행 파일을 찾을 수 없습니다"
                    exit 1
                fi
                exit 0
                ;;
            --config)
                show_config=true
                shift
                ;;
            --session)
                export CLAUDE_SESSION_ID="$2"
                shift 2
                ;;
            --debug)
                debug_mode=true
                set -x
                shift
                ;;
            *)
                args+=("$1")
                shift
                ;;
        esac
    done
    
    # 설정 상태만 표시하고 종료
    if [ "$show_config" = true ]; then
        exec "$PROJECT_ROOT/bin/claude-config" status
    fi
    
    # 설정 검증
    if ! validate_config; then
        exit 1
    fi
    
    # 세션 관리
    manage_session "${args[@]}"
    
    # 실행 준비
    prepare_execution
    
    # Claude 실행 파일 찾기
    local claude_exec=$(find_claude_executable)
    if [ -z "$claude_exec" ]; then
        log "ERROR" "❌ Claude가 설치되지 않았습니다."
        log "INFO" "📦 다음 명령어로 설치하세요:"
        log "INFO" "   npm install -g @anthropic/claude"
        log "INFO" "   또는"  
        log "INFO" "   npm install @anthropic/claude"
        exit 1
    fi
    
    log "INFO" "🤖 Claude 실행: $claude_exec"
    log "DEBUG" "Arguments: ${args[*]}"
    
    # Claude 실행
    if [ ${#args[@]} -eq 0 ]; then
        # 인수가 없으면 대화형 모드
        exec "$claude_exec"
    else
        # 인수가 있으면 해당 인수로 실행
        exec "$claude_exec" "${args[@]}"
    fi
}

# 스크립트 직접 실행 시
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi
EOF

chmod +x bin/claude
```

#### **2.2 세션 관리 스크립트**
```bash
cat > bin/claude-session << 'EOF'
#!/bin/bash

# Claude 세션 관리 스크립트
set -e

# 환경 로드
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$PROJECT_ROOT/scripts/load-environment.sh" --quiet

show_usage() {
    cat << USAGE_EOF
🗂️  Claude 세션 관리

사용법:
  claude-session <command> [options]

명령어:
  list                    모든 세션 목록 표시
  show <session-id>       특정 세션 정보 표시
  clean [days]            오래된 세션 정리 (기본: 7일)
  export <session-id>     세션을 파일로 내보내기
  current                 현재 활성 세션 표시

예시:
  claude-session list
  claude-session show 20250901_143022
  claude-session clean 30
  claude-session export mysession
USAGE_EOF
}

list_sessions() {
    echo "📋 Claude 세션 목록"
    echo "=================="
    
    if [ ! -d "$CLAUDE_SESSION_PATH" ]; then
        echo "❌ 세션 디렉터리가 없습니다: $CLAUDE_SESSION_PATH"
        return 1
    fi
    
    local sessions=($(ls "$CLAUDE_SESSION_PATH"/session_*.json 2>/dev/null | sort -r))
    
    if [ ${#sessions[@]} -eq 0 ]; then
        echo "📭 저장된 세션이 없습니다."
        return 0
    fi
    
    printf "%-20s %-19s %-10s %s\n" "SESSION ID" "START TIME" "DURATION" "ARGUMENTS"
    printf "%-20s %-19s %-10s %s\n" "----------" "----------" "--------" "---------"
    
    for session_file in "${sessions[@]}"; do
        if [ -f "$session_file" ] && command -v jq >/dev/null 2>&1; then
            local session_id=$(jq -r '.sessionId' "$session_file" 2>/dev/null || echo "N/A")
            local start_time=$(jq -r '.startTime' "$session_file" 2>/dev/null | cut -d'T' -f1,2 | tr 'T' ' ' || echo "N/A")
            local args=$(jq -r '.arguments | join(" ")' "$session_file" 2>/dev/null | head -c 30 || echo "N/A")
            
            # 세션 지속 시간 계산 (단순화)
            local duration="N/A"
            if [ -f "${session_file%.json}.log" ]; then
                duration="logged"
            fi
            
            printf "%-20s %-19s %-10s %s\n" "$session_id" "$start_time" "$duration" "$args"
        fi
    done
}

show_session() {
    local session_id="$1"
    
    if [ -z "$session_id" ]; then
        echo "❌ 세션 ID를 제공해야 합니다."
        echo "사용법: claude-session show <session-id>"
        return 1
    fi
    
    local session_file="$CLAUDE_SESSION_PATH/session_$session_id.json"
    
    if [ ! -f "$session_file" ]; then
        echo "❌ 세션을 찾을 수 없습니다: $session_id"
        return 1
    fi
    
    echo "🔍 세션 정보: $session_id"
    echo "=========================="
    
    if command -v jq >/dev/null 2>&1; then
        jq . "$session_file"
    else
        cat "$session_file"
    fi
    
    # 로그 파일 확인
    local log_file="$CLAUDE_LOG_PATH/claude_$(echo $session_id | cut -d'_' -f1).log"
    if [ -f "$log_file" ]; then
        echo ""
        echo "📜 관련 로그 (마지막 10줄):"
        echo "=========================="
        tail -10 "$log_file"
    fi
}

clean_sessions() {
    local days="${1:-7}"
    
    echo "🧹 $days일 이전 세션 정리 중..."
    
    if [ ! -d "$CLAUDE_SESSION_PATH" ]; then
        echo "❌ 세션 디렉터리가 없습니다: $CLAUDE_SESSION_PATH"
        return 1
    fi
    
    local count=0
    while IFS= read -r -d '' session_file; do
        if [ -f "$session_file" ]; then
            rm "$session_file"
            count=$((count + 1))
        fi
    done < <(find "$CLAUDE_SESSION_PATH" -name "session_*.json" -mtime +$days -print0)
    
    echo "✅ $count개 세션이 정리되었습니다."
}

export_session() {
    local session_id="$1"
    
    if [ -z "$session_id" ]; then
        echo "❌ 세션 ID를 제공해야 합니다."
        echo "사용법: claude-session export <session-id>"
        return 1
    fi
    
    local session_file="$CLAUDE_SESSION_PATH/session_$session_id.json"
    local export_file="$PROJECT_ROOT/session_export_$session_id.json"
    
    if [ ! -f "$session_file" ]; then
        echo "❌ 세션을 찾을 수 없습니다: $session_id"
        return 1
    fi
    
    cp "$session_file" "$export_file"
    echo "✅ 세션이 내보내졌습니다: $export_file"
}

show_current() {
    if [ -n "$CLAUDE_SESSION_ID" ]; then
        echo "📍 현재 활성 세션: $CLAUDE_SESSION_ID"
        show_session "$CLAUDE_SESSION_ID"
    else
        echo "📭 현재 활성 세션이 없습니다."
    fi
}

# 메인 로직
case "$1" in
    "list"|"ls")
        list_sessions
        ;;
    "show"|"info")
        show_session "$2"
        ;;
    "clean")
        clean_sessions "$2"
        ;;
    "export")
        export_session "$2"
        ;;
    "current")
        show_current
        ;;
    *)
        show_usage
        ;;
esac
EOF

chmod +x bin/claude-session
```

### **Step 3: 자동 PATH 설정**

#### **3.1 Bash 프로필 통합**
```bash
cat > scripts/setup-bash-integration.sh << 'EOF'
#!/bin/bash

# Bash 프로필 통합 스크립트
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "🔧 Bash 프로필 통합 설정"
echo "========================"

# bashrc에 추가할 내용
BASHRC_CONTENT="
# === Dev-Agents WSL2 Integration ===
# Auto-generated by dev-agents setup

# Dev-Agents 환경 로드
if [ -f \"$PROJECT_ROOT/scripts/load-environment.sh\" ]; then
    source \"$PROJECT_ROOT/scripts/load-environment.sh\" --quiet
fi

# Dev-Agents 편의 함수들
dev-agents() {
    cd \"\$DEV_AGENTS_ROOT\"
}

claude-status() {
    \"\$DEV_AGENTS_BIN/claude-config\" status
}

claude-logs() {
    tail -f \"\$CLAUDE_LOG_PATH/claude_\$(date +%Y%m%d).log\"
}

claude-sessions() {
    \"\$DEV_AGENTS_BIN/claude-session\" list
}

# 개발 편의 alias들
alias agents='dev-agents'
alias cl='claude'
alias cls='claude-session'
alias clc='claude-config'

# === End Dev-Agents Integration ===
"

# bashrc 백업
if [ -f ~/.bashrc ]; then
    cp ~/.bashrc ~/.bashrc.backup.$(date +%Y%m%d_%H%M%S)
    echo "✅ 기존 .bashrc 백업됨"
fi

# 기존 Dev-Agents 설정 제거 (있다면)
if grep -q "Dev-Agents WSL2 Integration" ~/.bashrc 2>/dev/null; then
    echo "🔄 기존 Dev-Agents 설정 제거 중..."
    sed -i '/# === Dev-Agents WSL2 Integration ===/,/# === End Dev-Agents Integration ===/d' ~/.bashrc
fi

# 새 설정 추가
echo "$BASHRC_CONTENT" >> ~/.bashrc

echo "✅ .bashrc에 Dev-Agents 통합 설정 추가됨"
echo "🔄 변경사항 적용 중..."

# 설정 즉시 적용
source ~/.bashrc

echo "✅ Bash 통합 완료!"
echo ""
echo "🎯 사용 가능한 명령어들:"
echo "  dev-agents     - 프로젝트 디렉터리로 이동"
echo "  claude         - Claude 실행"
echo "  claude-config  - Claude 설정 관리"
echo "  claude-session - Claude 세션 관리"
echo "  claude-status  - Claude 상태 확인"
echo "  claude-logs    - Claude 로그 실시간 보기"
echo ""
echo "🎯 단축 명령어들:"
echo "  agents  → dev-agents"
echo "  cl      → claude"
echo "  cls     → claude-session"
echo "  clc     → claude-config"
EOF

chmod +x scripts/setup-bash-integration.sh
```

#### **3.2 PATH 검증 스크립트**
```bash
cat > scripts/verify-path.sh << 'EOF'
#!/bin/bash

echo "🛤️  PATH 설정 검증"
echo "=================="

# 현재 PATH 표시
echo "📋 현재 PATH:"
echo "$PATH" | tr ':' '\n' | nl -v0

# Dev-Agents 관련 경로 확인
echo ""
echo "🔍 Dev-Agents 관련 경로:"
if echo "$PATH" | grep -q "dev-agents-wsl/bin"; then
    echo "✅ Dev-Agents bin 디렉터리가 PATH에 포함됨"
else
    echo "❌ Dev-Agents bin 디렉터리가 PATH에 없음"
fi

# 실행 파일 확인
echo ""
echo "🔧 실행 파일 확인:"
commands=("claude" "claude-config" "claude-session")

for cmd in "${commands[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "✅ $cmd: $(which $cmd)"
    else
        echo "❌ $cmd: 찾을 수 없음"
    fi
done

# npm 글로벌 경로 확인
echo ""
echo "📦 npm 글로벌 경로:"
if command -v npm >/dev/null 2>&1; then
    echo "npm root -g: $(npm root -g 2>/dev/null || echo 'N/A')"
    echo "npm bin -g: $(npm bin -g 2>/dev/null || echo 'N/A')"
else
    echo "❌ npm이 설치되지 않음"
fi

# 권한 확인
echo ""
echo "🔐 권한 확인:"
project_bin="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/bin"
for script in "$project_bin"/*; do
    if [ -f "$script" ]; then
        script_name=$(basename "$script")
        if [ -x "$script" ]; then
            echo "✅ $script_name: 실행 가능"
        else
            echo "❌ $script_name: 실행 권한 없음"
        fi
    fi
done
EOF

chmod +x scripts/verify-path.sh
```

### **Step 4: 로깅 및 모니터링 시스템**

#### **4.1 고급 로깅 시스템**
```bash
mkdir -p scripts/logging

cat > scripts/logging/logger.sh << 'EOF'
#!/bin/bash

# 고급 로깅 시스템
# Usage: source scripts/logging/logger.sh

# 로그 레벨 정의
LOG_LEVEL_DEBUG=0
LOG_LEVEL_INFO=1
LOG_LEVEL_WARN=2
LOG_LEVEL_ERROR=3

# 기본 로그 레벨 (환경변수로 조정 가능)
DEFAULT_LOG_LEVEL=${LOG_LEVEL:-$LOG_LEVEL_INFO}

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 로그 디렉터리 설정
setup_logging() {
    local log_dir="${CLAUDE_LOG_PATH:-./logs}"
    local log_file="$log_dir/claude_$(date +%Y%m%d).log"
    
    mkdir -p "$log_dir"
    
    export CURRENT_LOG_FILE="$log_file"
    export CURRENT_LOG_DIR="$log_dir"
}

# 로그 함수들
log_debug() {
    [ $DEFAULT_LOG_LEVEL -le $LOG_LEVEL_DEBUG ] && _log "DEBUG" "$CYAN" "$@"
}

log_info() {
    [ $DEFAULT_LOG_LEVEL -le $LOG_LEVEL_INFO ] && _log "INFO" "$GREEN" "$@"
}

log_warn() {
    [ $DEFAULT_LOG_LEVEL -le $LOG_LEVEL_WARN ] && _log "WARN" "$YELLOW" "$@"
}

log_error() {
    [ $DEFAULT_LOG_LEVEL -le $LOG_LEVEL_ERROR ] && _log "ERROR" "$RED" "$@"
}

# 내부 로그 함수
_log() {
    local level="$1"
    local color="$2"
    shift 2
    local message="$*"
    
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local script_name=$(basename "${BASH_SOURCE[2]}" 2>/dev/null || echo "shell")
    local line_number="${BASH_LINENO[1]}"
    
    # 파일에 로그 (색상 없이)
    if [ -n "$CURRENT_LOG_FILE" ]; then
        echo "[$timestamp] [$level] [$script_name:$line_number] $message" >> "$CURRENT_LOG_FILE"
    fi
    
    # 콘솔에 출력 (색상 포함)
    echo -e "${color}[$timestamp] [$level] $message${NC}" >&2
}

# 로그 회전
rotate_logs() {
    local log_dir="${CURRENT_LOG_DIR:-./logs}"
    local days_to_keep="${1:-30}"
    
    if [ -d "$log_dir" ]; then
        find "$log_dir" -name "claude_*.log" -mtime +$days_to_keep -delete
        log_info "로그 회전 완료: ${days_to_keep}일 이전 로그 삭제"
    fi
}

# 로그 압축
compress_old_logs() {
    local log_dir="${CURRENT_LOG_DIR:-./logs}"
    local days_to_compress="${1:-7}"
    
    if [ -d "$log_dir" ] && command -v gzip >/dev/null 2>&1; then
        find "$log_dir" -name "claude_*.log" -mtime +$days_to_compress ! -name "*.gz" -exec gzip {} \;
        log_info "이전 로그 압축 완료: ${days_to_compress}일 이전 로그"
    fi
}

# 로그 통계
log_stats() {
    local log_dir="${CURRENT_LOG_DIR:-./logs}"
    
    if [ ! -d "$log_dir" ]; then
        echo "❌ 로그 디렉터리가 없습니다: $log_dir"
        return 1
    fi
    
    echo "📊 로그 통계"
    echo "============"
    
    local total_logs=$(find "$log_dir" -name "claude_*.log*" | wc -l)
    local total_size=$(du -sh "$log_dir" 2>/dev/null | cut -f1)
    
    echo "총 로그 파일: $total_logs"
    echo "총 크기: $total_size"
    
    if [ -f "$CURRENT_LOG_FILE" ]; then
        echo ""
        echo "📋 오늘의 로그 분석:"
        if command -v grep >/dev/null 2>&1; then
            echo "ERROR: $(grep -c 'ERROR' "$CURRENT_LOG_FILE" 2>/dev/null || echo 0)"
            echo "WARN:  $(grep -c 'WARN' "$CURRENT_LOG_FILE" 2>/dev/null || echo 0)"
            echo "INFO:  $(grep -c 'INFO' "$CURRENT_LOG_FILE" 2>/dev/null || echo 0)"
            echo "DEBUG: $(grep -c 'DEBUG' "$CURRENT_LOG_FILE" 2>/dev/null || echo 0)"
        fi
    fi
}

# 초기 설정
setup_logging
EOF
```

#### **4.2 모니터링 스크립트**
```bash
cat > bin/claude-monitor << 'EOF'
#!/bin/bash

# Claude 모니터링 도구
set -e

# 환경 로드
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$PROJECT_ROOT/scripts/load-environment.sh" --quiet
source "$PROJECT_ROOT/scripts/logging/logger.sh"

show_usage() {
    cat << USAGE_EOF
📊 Claude 모니터링 도구

사용법:
  claude-monitor <command> [options]

명령어:
  dashboard           시스템 대시보드 표시
  logs [tail]         로그 보기 (tail: 실시간)
  stats               통계 정보 표시
  health              헬스 체크 실행
  processes           Claude 관련 프로세스 표시

예시:
  claude-monitor dashboard
  claude-monitor logs tail
  claude-monitor health
USAGE_EOF
}

show_dashboard() {
    clear
    echo "🖥️  Claude WSL2 대시보드"
    echo "========================="
    echo "시간: $(date)"
    echo "프로젝트: $PROJECT_ROOT"
    echo ""
    
    # 시스템 정보
    echo "🖥️  시스템 정보:"
    echo "  WSL 배포판: $(cat /proc/version | grep -oP 'Microsoft.*WSL\d*' | head -1)"
    echo "  사용자: $(whoami)"
    echo "  업타임: $(uptime -p)"
    echo ""
    
    # Claude 상태
    echo "🤖 Claude 상태:"
    if command -v claude >/dev/null 2>&1; then
        echo "  ✅ Claude 설치됨: $(which claude)"
        echo "  📋 버전: $(claude --version 2>/dev/null || echo 'N/A')"
    else
        echo "  ❌ Claude 미설치"
    fi
    echo ""
    
    # 활성 세션
    echo "📋 활성 세션:"
    if [ -n "$CLAUDE_SESSION_ID" ]; then
        echo "  🟢 현재 세션: $CLAUDE_SESSION_ID"
    else
        echo "  ⚪ 활성 세션 없음"
    fi
    
    local session_count=$(ls "$CLAUDE_SESSION_PATH"/session_*.json 2>/dev/null | wc -l)
    echo "  📊 총 세션 수: $session_count"
    echo ""
    
    # 로그 상태
    echo "📜 로그 상태:"
    if [ -f "$CURRENT_LOG_FILE" ]; then
        echo "  📋 오늘의 로그: $CURRENT_LOG_FILE"
        echo "  📊 크기: $(du -h "$CURRENT_LOG_FILE" 2>/dev/null | cut -f1 || echo 'N/A')"
        echo "  📈 라인 수: $(wc -l < "$CURRENT_LOG_FILE" 2>/dev/null || echo 'N/A')"
    else
        echo "  📭 오늘의 로그 없음"
    fi
    echo ""
    
    # 리소스 사용량
    echo "📈 리소스 사용량:"
    echo "  💾 메모리: $(free -h | awk 'NR==2{printf "%.1f%%", $3*100/$2 }')"
    echo "  💽 디스크: $(df -h "$PROJECT_ROOT" | awk 'NR==2{print $5}' | tr -d '%')%"
    echo ""
    
    # 최근 활동
    echo "🕐 최근 활동:"
    if [ -f "$CURRENT_LOG_FILE" ]; then
        tail -5 "$CURRENT_LOG_FILE" | while read line; do
            echo "  $line"
        done
    else
        echo "  📭 최근 활동 없음"
    fi
}

show_logs() {
    local mode="$1"
    
    if [ ! -f "$CURRENT_LOG_FILE" ]; then
        echo "📭 오늘의 로그 파일이 없습니다: $CURRENT_LOG_FILE"
        return 1
    fi
    
    if [ "$mode" = "tail" ]; then
        echo "📜 Claude 로그 실시간 모니터링 (Ctrl+C로 종료)"
        echo "=============================================="
        tail -f "$CURRENT_LOG_FILE"
    else
        echo "📜 Claude 로그 (마지막 50줄)"
        echo "============================"
        tail -50 "$CURRENT_LOG_FILE"
    fi
}

show_stats() {
    echo "📊 Claude 상세 통계"
    echo "=================="
    
    # 로그 통계
    log_stats
    
    echo ""
    echo "📋 세션 통계:"
    if [ -d "$CLAUDE_SESSION_PATH" ]; then
        local total_sessions=$(ls "$CLAUDE_SESSION_PATH"/session_*.json 2>/dev/null | wc -l)
        echo "  총 세션: $total_sessions"
        
        if [ $total_sessions -gt 0 ]; then
            echo "  최근 세션: $(ls -t "$CLAUDE_SESSION_PATH"/session_*.json | head -1 | xargs basename | sed 's/session_//' | sed 's/.json//')"
        fi
    else
        echo "  세션 디렉터리 없음"
    fi
    
    echo ""
    echo "📁 디스크 사용량:"
    du -sh "$PROJECT_ROOT"/{configs,logs,bin,scripts} 2>/dev/null | sort -hr
}

health_check() {
    echo "🏥 Claude 헬스 체크"
    echo "=================="
    
    local issues=0
    
    # 필수 디렉터리 확인
    echo "📁 디렉터리 구조:"
    local required_dirs=("$DEV_AGENTS_BIN" "$CLAUDE_CONFIG_PATH" "$CLAUDE_LOG_PATH" "$CLAUDE_SESSION_PATH")
    for dir in "${required_dirs[@]}"; do
        if [ -d "$dir" ]; then
            echo "  ✅ $dir"
        else
            echo "  ❌ $dir 없음"
            issues=$((issues + 1))
        fi
    done
    
    echo ""
    echo "🔧 실행 파일:"
    local scripts=("claude" "claude-config" "claude-session")
    for script in "${scripts[@]}"; do
        if [ -x "$DEV_AGENTS_BIN/$script" ]; then
            echo "  ✅ $script"
        else
            echo "  ❌ $script 실행 불가"
            issues=$((issues + 1))
        fi
    done
    
    echo ""
    echo "⚙️  설정 파일:"
    local configs=("$CLAUDE_CONFIG_PATH/team.json" "$CLAUDE_CONFIG_PATH/local.json")
    for config in "${configs[@]}"; do
        if [ -f "$config" ]; then
            echo "  ✅ $(basename "$config")"
        else
            echo "  ❌ $(basename "$config") 없음"
            issues=$((issues + 1))
        fi
    done
    
    echo ""
    echo "📊 종합 결과:"
    if [ $issues -eq 0 ]; then
        echo "  🎉 모든 체크 통과!"
    else
        echo "  ⚠️  $issues개 문제 발견"
    fi
    
    return $issues
}

show_processes() {
    echo "🔄 Claude 관련 프로세스"
    echo "======================"
    
    # Claude 프로세스 찾기
    if pgrep -f claude >/dev/null 2>&1; then
        echo "🟢 실행 중인 Claude 프로세스:"
        ps aux | grep -v grep | grep claude | while read line; do
            echo "  $line"
        done
    else
        echo "⚪ 실행 중인 Claude 프로세스 없음"
    fi
    
    echo ""
    echo "📊 시스템 리소스:"
    echo "  로드 평균: $(cat /proc/loadavg | cut -d' ' -f1-3)"
    echo "  메모리: $(free -h | awk 'NR==2{printf "%s/%s (%.1f%%)", $3,$2,$3*100/$2 }')"
}

# 메인 로직
case "$1" in
    "dashboard"|"dash")
        show_dashboard
        ;;
    "logs")
        show_logs "$2"
        ;;
    "stats")
        show_stats
        ;;
    "health")
        health_check
        ;;
    "processes"|"ps")
        show_processes
        ;;
    *)
        show_usage
        ;;
esac
EOF

chmod +x bin/claude-monitor
```

### **Step 5: 검증 및 테스트**

#### **5.1 종합 검증 스크립트**
```bash
cat > scripts/verify-chapter2.sh << 'EOF'
#!/bin/bash

echo "🎯 Chapter 2 검증: WSL 네이티브 런처 시스템"
echo "============================================="

# 기본 경로 설정
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# 환경 로드 테스트
echo "🌍 환경 로드 테스트:"
if source "$PROJECT_ROOT/scripts/load-environment.sh" --quiet; then
    echo "✅ 환경 로드 성공"
    echo "  DEV_AGENTS_ROOT: $DEV_AGENTS_ROOT"
    echo "  CLAUDE_HOME: $CLAUDE_HOME"
else
    echo "❌ 환경 로드 실패"
    exit 1
fi

echo ""
echo "🔧 스크립트 실행 테스트:"
scripts_to_test=(
    "claude --help"
    "claude-config status"
    "claude-session list"
    "claude-monitor health"
)

for test_cmd in "${scripts_to_test[@]}"; do
    echo "  테스트: $test_cmd"
    if $test_cmd >/dev/null 2>&1; then
        echo "  ✅ 성공"
    else
        echo "  ❌ 실패"
    fi
done

echo ""
echo "📁 파일 시스템 검증:"
required_files=(
    "bin/claude"
    "bin/claude-config"
    "bin/claude-session"
    "bin/claude-monitor"
    "scripts/load-environment.sh"
    "scripts/setup-environment.sh"
    "scripts/logging/logger.sh"
)

for file in "${required_files[@]}"; do
    if [ -f "$PROJECT_ROOT/$file" ]; then
        if [ -x "$PROJECT_ROOT/$file" ]; then
            echo "  ✅ $file (실행 가능)"
        else
            echo "  ⚠️  $file (실행 권한 없음)"
        fi
    else
        echo "  ❌ $file 없음"
    fi
done

echo ""
echo "🔄 로깅 시스템 테스트:"
if source "$PROJECT_ROOT/scripts/logging

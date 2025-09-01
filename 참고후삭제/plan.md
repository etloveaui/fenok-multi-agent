알겠습니다! 완전히 이해했습니다.

**기존 Windows PowerShell + Python venv 방식 = 완전 폐기**
**WSL2부터 시작해서 처음부터 새로 구현**

## 🐧 WSL2 기반 Dev-Agents 프로젝트 (새로 구현)

### **Phase 0: WSL2 환경 구축**
```bash
# Windows에서 WSL2 설치
wsl --install Ubuntu
wsl --set-default-version 2

# WSL 리소스 제한 (선택)
# %USERPROFILE%\.wslconfig
[wsl2]
memory=4GB
processors=2
swap=1GB
```

### **Phase 1: WSL Ubuntu에서 Claude Code 설치**
```bash
# WSL Ubuntu 터미널에서
sudo apt update && sudo apt install -y nodejs npm git

# Claude Code 설치 (npm 기반)
npm install -g @anthropic/claude-code
claude migrate-installer -y

# 프로젝트 폴더 생성 (Windows 경로 마운트 활용)
mkdir /mnt/c/Projects/dev-agents-wsl
cd /mnt/c/Projects/dev-agents-wsl

# Git 초기화
git init
```

### **Phase 2: WSL 네이티브 실행 환경**
```bash
# scripts/setup_claude.sh (새로 작성)
#!/bin/bash
set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Claude Code 설치 확인
if ! command -v claude &> /dev/null; then
    echo "Installing Claude Code..."
    npm install -g @anthropic/claude-code
    claude migrate-installer -y
fi

# 설정 폴더 생성
mkdir -p "$ROOT/.claude"

echo "✅ Claude Code ready in WSL"
```

### **Phase 3: VS Code + WSL 통합**
```json
// .devcontainer/devcontainer.json
{
  "name": "Dev Agents WSL",
  "build": {
    "dockerfile": "Dockerfile"
  },
  "postCreateCommand": "bash scripts/setup_claude.sh",
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-vscode-remote.remote-wsl",
        "claude.claude-code"
      ]
    }
  }
}
```

### **Phase 4: 완전한 WSL 런처 시스템**
```bash
# bin/claude (새로 작성, Bash 스크립트)
#!/bin/bash
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export CLAUDE_HOME="$ROOT/.claude"
export XDG_CONFIG_HOME="$CLAUDE_HOME"
export XDG_DATA_HOME="$CLAUDE_HOME"

# Claude Code 실행
exec claude "$@"
```

### **최종 목표: 3단계 설치**
```bash
# 1. WSL 설치
wsl --install Ubuntu

# 2. 프로젝트 클론
git clone https://github.com/etloveaui/dev-agents-wsl
cd dev-agents-wsl

# 3. VS Code WSL로 열기
code .  # → 자동으로 모든 것 설치됨 (WSL에서)
```

**핵심**: 
- Windows PowerShell/Python venv 완전 제거
- WSL2 Ubuntu 네이티브 환경 100% 활용  
- npm 기반 Claude Code 직접 설치
- Bash 스크립트로 모든 자동화 재작성
- devcontainer 활용한 완전 자동화
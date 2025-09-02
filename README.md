# fenok-multi-agent

🤖 WSL2 Ubuntu 기반 AI 에이전트 통합 개발 환경

## 🚀 Quick Start

### 새로운 PC/환경에서 설치
```bash
# 1. 저장소 클론
git clone https://github.com/etloveaui/fenok-multi-agent.git  
cd fenok-multi-agent

# 2. 의존성 설치 (Claude Code 포함)
npm install

# 3. Claude Code 실행
npm run claude
```

### 기존 환경에서 실행
```bash
cd fenok-multi-agent
npm run claude
```

## ⚙️ WSL2 환경 설정 (최초 1회)

이 프로젝트는 `Ubuntu-22.04` 기반으로 최적화되어 있습니다. WSL 사용 시 아래 설정을 권장합니다.

### 기본 배포판 설정
```powershell
# 설치된 배포판 확인
wsl -l -v

# 기본 배포판을 Ubuntu-22.04로 설정
wsl --set-default Ubuntu-22.04
```

### 중복 배포판 정리 (옵션)
기존 `Ubuntu` 배포판과 중복된 경우, 아래 명령어로 제거 가능:
```powershell
wsl --unregister Ubuntu
```

> ✅ 설정 후 `wsl` 명령어로 바로 개발 환경 진입 가능

## 📦 설치된 AI 도구

- **Claude Code** - Anthropic의 AI 코딩 어시스턴트 (로컬 설치)

## 🏗️ 프로젝트 구조

```
fenok-multi-agent/
├── .claude/           # Claude Code 로컬 설정
├── docs/              # 문서
├── scripts/           # 유틸리티 스크립트
├── 참고후삭제/         # 개발 과정 참고 자료
├── package.json       # Node.js 프로젝트 설정
└── README.md          # 이 파일
```

## 🔧 사용법

### Claude Code

```bash
# npm 스크립트로 실행
npm run claude

# 직접 실행
./node_modules/.bin/claude

# 버전 확인
npm run claude -- --version
```

### 첫 실행 시 로그인

Claude Code 첫 실행 시 자동으로 OAuth 로그인 프로세스가 시작됩니다:
1. 브라우저가 열리면서 Anthropic 로그인 페이지로 이동
2. Anthropic 계정으로 로그인
3. 인증 완료 후 Claude Code가 활성화됩니다

## 🎯 특징

- **환경 이식성**: 어떤 PC에서든 `git clone` + `npm install`로 즉시 실행
- **로컬 설치**: 프로젝트별로 Claude Code 관리 (글로벌 설치 불필요)
- **Git 통합**: 모든 설정과 스크립트가 버전 관리됨
- **WSL2 최적화**: Ubuntu 환경에서 네이티브 실행
- **크로스 플랫폼**: Windows, macOS, Linux 지원
- **확장 가능**: 향후 Gemini, Codex 등 추가 예정

## 🔧 환경별 호환성

### Windows (WSL2)
- **권장**: Ubuntu-22.04 배포판
- **Git UI**: SourceTree, GitHub Desktop 등과 호환
- **설정 완료**: WSL2-Windows 간 파일 권한 및 줄바꿈 이슈 해결됨

### macOS / Linux
- Node.js 18+ 환경에서 동일하게 동작
- 터미널에서 바로 실행 가능

## 🔄 업데이트

```bash
# Claude Code 최신 버전으로 업데이트
npm update @anthropic-ai/claude-code
```

## 🛠️ 트러블슈팅

### SourceTree에서 커밋이 안되는 경우

#### 1. SSH 키 인증 오류 해결 (이미 해결됨)
WSL2와 Windows 간 SSH 키 동기화가 완료되어 있습니다:

```bash
# SSH 키가 다음 위치에 복사되어 있음
C:\Users\eunta\.ssh\id_ed25519
C:\Users\eunta\.ssh\id_ed25519.pub
```

#### 2. 소스트리 SSH 설정
1. **Tools → Options → SSH Client** 에서 **Use System SSH** 선택
2. 또는 **SSH Key** 탭에서 키 경로 직접 설정: `C:\Users\eunta\.ssh\id_ed25519`

#### 3. Git 설정 (이미 적용됨)
```bash
# WSL2에서 Git 설정 
git config --local core.autocrlf false
git config --local core.filemode false
```

### SSH 키 설정 확인
```bash
# GitHub SSH 연결 테스트
ssh -T git@github.com
```

## 📚 상세 문서

### 사용 가이드
- [Git UI 도구 호환성 가이드](docs/git-ui-setup.md) - 소스트리, GitHub Desktop 등 설정
- [VS Code Git 설정 가이드](docs/vscode-git-setup.md) - WSL2 환경에서 VS Code Git 사용법  
- [환경 이식성 가이드](docs/environment-setup.md) - 새 PC에서 완전 복원하는 방법
- [SuperClaude 설치 가이드](docs/superclaude-installation.md) - 고급 Claude 도구 설치 방법

### 개발 전략
- [로컬 설치 전략](docs/local-installation-strategy.md) - CLI/IDE 도구들의 로컬 설치 철학

### 프로젝트 정보
- [프로젝트 로드맵](docs/project-roadmap.md) - 개발 계획 및 향후 방향성
- [개발 기록](docs/development-history.md) - 주요 이슈 해결 과정 및 학습 내용

## 📝 개발 노트

이 프로젝트의 개발 과정과 주요 결정사항들은 [개발 기록](docs/development-history.md)에 상세히 문서화되어 있습니다.
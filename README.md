# fenok-multi-agent

🤖 WSL2 Ubuntu 기반 AI 에이전트 통합 개발 환경

## 🚀 Quick Start

```bash
# 1. 저장소 클론
git clone https://github.com/etloveaui/fenok-multi-agent.git
cd fenok-multi-agent

# 2. 의존성 설치
npm install

# 3. Claude Code 실행
npm run claude
```

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

- **로컬 설치**: 프로젝트별로 Claude Code 관리
- **Git 통합**: 모든 설정과 스크립트가 버전 관리됨
- **WSL2 최적화**: Ubuntu 환경에서 네이티브 실행
- **확장 가능**: 향후 Gemini, Codex 등 추가 예정

## 🔄 업데이트

```bash
# Claude Code 최신 버전으로 업데이트
npm update @anthropic-ai/claude-code
```

## 📝 개발 노트

`참고후삭제/` 디렉터리에는 이 프로젝트 개발 과정의 계획과 시행착오가 기록되어 있습니다.
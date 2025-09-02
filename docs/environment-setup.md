# 환경 이식성 가이드

새로운 PC나 환경에서 프로젝트를 완전히 복원하기 위한 가이드입니다.

## 🚀 자동으로 복원되는 파일들 (Git으로 관리됨)

다음 파일들은 `git clone` + `npm install`로 자동 복원됩니다:

### 프로젝트 핵심 파일
- ✅ `package.json` - 의존성 정의
- ✅ `package-lock.json` - 의존성 버전 고정 (이제 커밋됨)
- ✅ `.gitattributes` - Git 파일 처리 규칙
- ✅ `.gitignore` - Git 제외 파일 목록

### 설정 파일들
- ✅ `.vscode/` - VS Code 프로젝트 설정
- ✅ `configs/` - AI 도구 공용 설정 템플릿
- ✅ `scripts/` - 유틸리티 스크립트
- ✅ `docs/` - 문서 및 가이드

### Claude Code 설정
- ✅ `.claude/settings.local.json` - Claude 권한 설정 (이제 커밋됨)

## ⚠️ 수동 백업이 필요한 파일들

다음 **보안상 중요한 파일들**은 Git에 커밋되지 않으므로 **별도 백업** 필요:

### SSH 키 (가장 중요!)
```
~/.ssh/id_ed25519      # 개인 키 - 절대 공유 금지
~/.ssh/id_ed25519.pub  # 공개 키 - GitHub에 등록됨
```
**⚠️ 해결방법**: 새 환경에서 SSH 키 재생성 후 GitHub 재등록 권장

### API 키 및 인증 토큰 (중요!)
```
configs/*/api_keys      # AI 서비스 API 키들 - 백업 필요
configs/*/auth_tokens   # 인증 토큰들 - 백업 필요
```
**⚠️ 해결방법**: 클라우드 비밀번호 관리자에 저장 권장

### 세션 파일 (백업 불필요)
```
configs/*/*.session     # 임시 세션 파일들 - 자동 재생성됨
.claude/session-*       # Claude 임시 세션들 - 자동 재생성됨
```
**✅ 해결방법**: 새 환경에서 자동으로 재생성되므로 백업 불필요

## 🔄 새 환경 설정 체크리스트

### 1단계: 프로젝트 복원
```bash
git clone https://github.com/etloveaui/fenok-multi-agent.git
cd fenok-multi-agent
npm install
```

### 2단계: SSH 키 설정
```bash
# 새 SSH 키 생성
ssh-keygen -t ed25519 -C "your_email@example.com"

# GitHub에 공개 키 등록
cat ~/.ssh/id_ed25519.pub
# → GitHub Settings → SSH Keys에 추가

# Windows로 복사 (Git UI 도구용)
mkdir -p /mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" | tr -d '\r')/.ssh
cp ~/.ssh/id_ed25519* /mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" | tr -d '\r')/.ssh/
```

### 3단계: AI 서비스 설정
- **Claude Code**: `npm run claude`로 실행하면 자동 로그인 프로세스 시작
- **Gemini**: (향후 추가 시) API 키 설정 필요
- **Codex**: (향후 추가 시) 인증 토큰 설정 필요

### 4단계: 동작 확인
```bash
# Git 연결 테스트
ssh -T git@github.com

# Claude Code 실행 테스트
npm run claude

# 커밋/푸시 테스트
git add . && git commit -m "test" && git push
```

## 🛡️ 보안 원칙

### ✅ Git에 커밋해도 안전한 것들
- 프로젝트 설정 파일
- 템플릿 설정 (개인 정보 제외)
- 문서 및 스크립트
- Claude Code 권한 설정

### ❌ Git에 절대 커밋하면 안 되는 것들
- SSH 개인 키 (`id_ed25519`) - 보안상 중요
- API 키 (`api_keys`) - 💰 요금 발생 위험
- 인증 토큰 (`auth_tokens`) - 💰 요금 발생 위험

### 🗑️ 백업할 필요 없는 것들 (자동 재생성)
- 세션 파일 (`.session`, `session-*`) - 로그인하면 자동 생성

## 📋 환경별 추가 고려사항

### Windows + WSL2
- WSL2 배포판: Ubuntu-22.04 권장
- Git UI 도구: SSH 키 Windows 복사 필요

### macOS
- Homebrew로 Node.js 설치 권장
- 터미널에서 바로 실행 가능

### Linux (네이티브)
- 패키지 매니저로 Node.js 설치
- 추가 설정 없이 바로 사용 가능

## 💡 권장 백업 전략

1. **SSH 키**: 각 환경마다 새로 생성 (보안상 권장)
2. **API 키**: 클라우드 비밀번호 관리자 저장
3. **프로젝트**: Git 저장소로 완전 관리
4. **문서**: 모든 설정 방법이 문서화되어 있음

이 가이드대로 하면 새로운 환경에서도 10분 내에 완전한 개발환경 구축 가능합니다!
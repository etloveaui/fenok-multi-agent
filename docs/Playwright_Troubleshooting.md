# Playwright 설치 문제 해결 가이드

## 🚨 무한대기 상황 대처법

### 즉시 대응 (무한대기 발생시)
```bash
# 1. 새 터미널 열기 (Ctrl+Shift+T)
# 2. 모든 관련 프로세스 강제 종료
pkill -9 -f "SuperClaude|claude|playwright|mcp"

# 3. npm 캐시 정리
npm cache clean --force
npx clear-npx-cache

# 4. 프로세스 확인
ps aux | grep -E "(claude|mcp|playwright)" | grep -v grep
```

### 안전한 재시작
```bash
# 1. 현재 디렉토리 확인
pwd
# /home/etloveaui/workspace/fenok-multi-agent 인지 확인

# 2. Claude 재시작
npm run claude
```

## 🔧 브라우저 설치 대안책

### 🎯 권장 방법: 수동 설치 (무한대기 우회)

**단계별 수동 설치:**
```bash
# 1단계: 시스템 의존성 설치
sudo apt update && sudo apt install -y \
  libnss3 libatk-bridge2.0-0 libdrm2 libxss1 \
  libgtk-3-0 libgbm1 libasound2 libgconf-2-4

# 2단계: Playwright 브라우저 설치 (권한 문제 해결)
npx playwright install --with-deps

# 3단계: 설치 확인
npx playwright --version
ls ~/.cache/ms-playwright/

# 4단계: MCP 서버 재시작
pkill -f "playwright|mcp"
npm run claude
```

**✅ 이 방법의 장점:**
- "Unfurling..." 무한대기 완전 우회
- sudo 권한 문제 해결
- Claude가 아닌 사용자가 직접 설치하므로 안전함

### 방법 2: 기존 시스템 의존성 선설치 (구버전)
```bash
# WSL2에서 브라우저 의존성 설치
sudo apt update && sudo apt install -y \
  libnss3 \
  libatk-bridge2.0-0 \
  libdrm2 \
  libgtk-3-0 \
  libgbm1 \
  libasound2 \
  libxss1 \
  libgconf-2-4
```

### 방법 2: Playwright 개별 설치
```bash
# 타임아웃 설정으로 안전하게 설치
timeout 300 npx playwright install

# 5분 후에도 완료 안되면 자동 종료됨
```

### 방법 3: Playwright 비활성화
```bash
# .claude/settings.local.json에서 playwright 관련 권한 제거
# 또는 MCP 서버 목록에서 playwright 제거 후 재시작
```

## 📊 진단 명령어

### 현재 상태 확인
```bash
# SuperClaude 설치 상태
ls -la .claude/

# 실행 중인 MCP 서버들
ps aux | grep mcp | grep -v grep

# Playwright 설치 상태
npx playwright --version 2>/dev/null || echo "Playwright not installed"

# 브라우저 바이너리 확인
ls ~/.cache/ms-playwright/ 2>/dev/null || echo "No browser cache"
```

### 로그 확인
```bash
# Claude 로그
ls -la .claude/logs/

# npm 디버그 로그
npm config set loglevel silly
npm run claude 2>&1 | tee debug.log
```

## ⚠️ 예방 조치

### 무한대기 방지
1. **타임아웃 설정**: 모든 설치 명령에 timeout 사용
2. **백그라운드 실행 금지**: 설치 과정은 포그라운드에서만
3. **의존성 체크**: 설치 전 시스템 요구사항 확인

### 안전한 설치 순서
1. 시스템 의존성 먼저 설치
2. SuperClaude 코어만 먼저 설치
3. MCP 서버별 개별 테스트
4. Playwright는 마지막에 별도 설치

## 🔍 문제 패턴 분석

### 알려진 문제 상황
- **WSL2 + 브라우저 설치**: 의존성 충돌
- **네트워크 대기**: 다운로드 중단
- **권한 문제**: npm 전역 설치 충돌

### 회피 전략
1. **단계별 설치**: 한 번에 모든 것 설치 금지
2. **검증 후 진행**: 각 단계마다 동작 확인  
3. **롤백 준비**: 문제시 이전 상태로 복원

## 📋 체크리스트

### 설치 전
- [ ] 시스템 의존성 설치 완료
- [ ] npm 캐시 정리
- [ ] 충분한 디스크 공간 (>2GB)
- [ ] 안정적인 네트워크 연결

### 설치 중  
- [ ] 타임아웃 설정 적용
- [ ] 진행상황 모니터링
- [ ] 에러 로그 기록

### 설치 후
- [ ] 기본 기능 테스트
- [ ] MCP 서버 개별 확인
- [ ] 브라우저 자동화 테스트

**최종 업데이트**: 2025-09-02
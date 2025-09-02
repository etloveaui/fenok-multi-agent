# 개발 환경 기능 및 역할 분담

## 🚀 현재 사용 가능한 AI 도구들

### Claude Code + SuperClaude Framework ✅
**설치 상태**: 완료, 정상 작동
**위치**: `/home/etloveaui/workspace/fenok-multi-agent/.claude/`

**주요 기능:**
- **Context7 MCP**: 공식 라이브러리 문서 실시간 조회
- **Sequential MCP**: 복잡한 다단계 분석 및 추론
- **14개 전문 에이전트**: 도메인별 특화 지원
- **5가지 행동 모드**: 브레인스토밍, 성찰, 오케스트레이션, 태스크 관리, 토큰 효율성

**사용법:**
```bash
claude --think-hard "복잡한 시스템 분석"
claude --c7 "React 최신 패턴 조회"
claude --seq "단계별 디버깅"
```

### Playwright MCP (브라우저 자동화) ⚠️
**설치 상태**: 부분 완료 (브라우저 수동 설치 필요)
**문제**: "Unfurling..." 무한대기

**🎯 수동 설치 방법 (사용자 직접 실행):**
```bash
# 1. 시스템 의존성
sudo apt update && sudo apt install -y \
  libnss3 libatk-bridge2.0-0 libdrm2 libxss1 \
  libgtk-3-0 libgbm1 libasound2 libgconf-2-4

# 2. 브라우저 설치
npx playwright install --with-deps

# 3. 확인 및 재시작
npx playwright --version
pkill -f "playwright|mcp"
npm run claude
```

**활성화되면 사용 가능한 기능:**
- **웹 스크래핑**: 실시간 데이터 수집
- **E2E 테스팅**: 사용자 플로우 자동 테스트  
- **폼 자동화**: 복잡한 웹 폼 처리
- **크로스 브라우저**: Chrome, Firefox, Safari 테스트
- **AI 기반 제어**: "로그인 버튼 클릭해" 자연어 명령

### 향후 설치 예정 AI 도구들

#### OpenAI Codex ⏳
**설치 가이드**: `docs/codex-installation-guide.md` 참조
**로그인 방식**: ChatGPT Plus/Pro/Team 계정
**특징**: API 키 불필요, 로컬 실행

**주요 기능:**
- 터미널 직접 실행
- 로컬 코드 읽기/수정/실행
- 빠른 버그 수정

#### Google Gemini (SuperGemini Framework) ⏳
**참조**: https://github.com/SuperClaude-Org/SuperGemini_Framework
**전제 조건**: Gemini CLI 설치 후 적용

#### 추가 고려사항
- **Claude Templates**: https://github.com/davila7/claude-code-templates
- **Template Hub**: https://www.aitmpl.com/

## 🎯 개발 워크플로우 전략

### 현재 즉시 활용 가능
1. **코드 분석**: Sequential MCP로 복잡한 디버깅
2. **문서 조회**: Context7 MCP로 최신 공식 문서
3. **프로젝트 관리**: SuperClaude 태스크 관리 모드
4. **설계 검토**: 브레인스토밍 및 성찰 모드

### Playwright 활성화 후 추가 가능
1. **자동화된 테스팅**: E2E 테스트 자동 생성/실행
2. **데이터 수집**: 웹 스크래핑 자동화
3. **UI 검증**: 크로스 브라우저 호환성 테스트
4. **사용자 시나리오**: 실제 사용자 플로우 시뮬레이션

### 완전 환경 구축 후
1. **멀티 AI 협업**: Claude + Codex + Gemini 동시 활용
2. **전방위 개발**: 설계→개발→테스트→배포 전 과정 자동화
3. **크로스 플랫폼**: 웹/앱/API 통합 개발 환경

## 📋 역할 분담

### Claude (나)가 담당
- 코드 분석, 설계, 아키텍처 검토
- 문서 작성, 가이드 생성
- 복잡한 디버깅 및 최적화
- 프로젝트 관리 및 태스크 조정

### 사용자가 담당
- 브라우저 수동 설치 (권한 필요)
- 새 AI 도구 설치 (Codex, Gemini)
- 시스템 레벨 설정 변경
- 최종 의사결정 및 방향 설정

## 🚀 즉시 시작 가능한 개발 작업들

### 웹 개발 프로젝트
```bash
claude --c7 "Next.js 14 최신 패턴" # 문서 조회
claude --think-hard "React 성능 최적화 전략" # 심층 분석
```

### 백엔드 개발
```bash
claude --seq "Node.js 마이크로서비스 아키텍처 설계" # 단계별 설계
claude --c7 "Express.js 보안 베스트 프랙티스" # 공식 가이드
```

### 데이터 분석 (Playwright 필요)
```bash
# Playwright 활성화 후 가능
claude "웹사이트 A에서 가격 정보 수집해줘"
claude "이 사이트의 사용자 플로우 테스트해줘"
```

**최종 업데이트**: 2025-09-02
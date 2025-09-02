# fenok-multi-agent 프로젝트 로드맵

## 🎯 프로젝트 비전

**WSL2 Ubuntu 기반 AI 에이전트 통합 개발 환경**
- 다양한 AI 코딩 어시스턴트를 하나의 일관된 환경에서 관리
- 완전한 환경 이식성 (git clone + npm install로 즉시 실행)
- WSL2 네이티브 성능 활용

## 🚀 현재 상태 (Phase 1 완료)

### ✅ 완료된 항목
- WSL2 Ubuntu 22.04 기반 환경 구축
- Claude Code 로컬 설치 및 설정
- Git UI 호환성 (SourceTree, VS Code 등)
- 환경 이식성 최적화
- 프로젝트 구조 및 문서화

### 📂 현재 프로젝트 구조
```
fenok-multi-agent/
├── .claude/           # Claude Code 로컬 설정
├── .vscode/           # VS Code 프로젝트 설정
├── docs/              # 문서 및 가이드
├── scripts/           # 유틸리티 스크립트
├── configs/           # AI 도구별 설정 (향후 확장)
├── bin/               # 실행 스크립트 (향후 확장)
├── node_modules/      # npm 의존성 (로컬 설치)
├── package.json       # Node.js 프로젝트 설정
├── package-lock.json  # 의존성 버전 고정
├── .gitignore         # Git 제외 파일 (최적화됨)
├── .gitattributes     # Git 파일 처리 규칙
├── CLAUDE.md          # Claude Code 전용 설정
└── README.md          # 메인 문서
```

## 🗺️ 향후 개발 계획

### Phase 2: 고급 Claude 통합 (예정)
- 고급 Claude 런처 시스템
- 세션 관리 및 로깅 시스템
- 환경변수 격리 및 자동화
- PATH 설정 자동화
- VS Code 작업 통합

### Phase 3: 멀티 AI 에이전트 지원 (예정)
- **Gemini** 통합
  - Google Gemini CLI 설치 및 설정
  - configs/gemini/ 디렉터리 구성
  - API 키 관리 시스템

- **Codex/GPT** 통합  
  - OpenAI API 연동
  - configs/codex/ 디렉터리 구성
  - 인증 토큰 관리

### Phase 4: 통합 대시보드 (예정)
- 웹 기반 관리 인터페이스
- AI 에이전트 상태 모니터링
- 사용량 통계 및 분석
- 설정 중앙화 관리

## 🔧 기술 스택

### 핵심 기술
- **플랫폼**: WSL2 Ubuntu 22.04
- **런타임**: Node.js 18+ (LTS)
- **패키지 관리**: npm
- **버전 관리**: Git

### AI 도구들
- **Claude Code**: Anthropic의 AI 코딩 어시스턴트 (현재)
- **Gemini**: Google AI (계획)
- **Codex**: OpenAI (계획)

### 개발 환경
- **편집기**: VS Code (Remote-WSL)
- **터미널**: WSL2 네이티브 bash
- **Git UI**: SourceTree, GitHub Desktop 등

## 📋 아키텍처 원칙

### 1. 환경 이식성 우선
- 모든 설정은 프로젝트 내에 포함
- 글로벌 설치에 의존하지 않음
- `git clone` + `npm install`로 완전 복원

### 2. 보안 중심 설계
- API 키, 인증 토큰은 Git에서 제외
- 세션 파일은 임시 파일로 관리
- 개인 정보와 공용 설정 분리

### 3. WSL2 네이티브 최적화
- Windows와의 파일 권한 호환성
- Git UI 도구와의 통합
- 성능 최적화된 경로 설정

## 🎯 단기 목표 (향후 2주)

1. **고급 런처 시스템 구축**
   - 환경변수 자동 관리
   - 세션 및 로깅 시스템
   - 모니터링 대시보드

2. **VS Code 통합 강화**  
   - 작업(Tasks) 설정 최적화
   - 키바인딩 및 단축키
   - 확장 추천 목록

3. **문서화 완성**
   - 설치 가이드 보완
   - 트러블슈팅 섹션
   - 개발자 가이드

## 🎯 중기 목표 (향후 1개월)

1. **Gemini 통합**
   - Google AI CLI 도구 연동
   - 통합 설정 관리
   - 에이전트 선택 인터페이스

2. **자동화 스크립트**
   - 일괄 설정 스크립트
   - 백업/복원 도구
   - 환경 검증 도구

## 🌟 장기 비전

### 완전한 AI 개발 환경
- 여러 AI 어시스턴트를 상황에 맞게 선택 사용
- 통합된 설정 및 세션 관리
- 클라우드 동기화 지원

### 팀 협업 지원
- 팀 설정 템플릿 공유
- 협업 세션 관리
- 사용량 분석 및 리포팅

### 확장성
- 새로운 AI 도구 쉽게 통합
- 플러그인 시스템
- 커스텀 워크플로우 지원

## 📚 참고 자료

원본 계획 문서들:
- `plan.md` - 기본 개념 및 방향성
- `plan_detail.md` - 상세 구현 계획 (2,600+ 줄)
- 설치 및 환경 구축 상세 가이드

현재 이 자료들은 개발 완료 후 정리될 예정입니다.
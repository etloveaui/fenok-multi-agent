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

## 🗺️ 개발 로드맵 (유동적 계획)

> **⚠️ 중요**: 이 계획은 유동적이며 각 단계 완료 후 재검토하여 수정됩니다. 확정사항은 없으며 모든 것이 유연하게 조정 가능합니다.

### Phase 2: SuperClaude Framework 통합 (✅ 완료)
**목표**: Claude Code를 전문 개발 도구로 변환
- ✅ SuperClaude Framework v4.0.8 설치 완료
- ✅ 21개 전문 명령어 (sc 네임스페이스)
- ✅ 14개 전문 에이전트 (system-architect, python-expert 등)
- ✅ 4개 MCP 서버 연동 (Context7, Sequential, Playwright, Serena)
- ✅ 프로젝트 Git 관리 (설정 파일 모두 `.claude/`에 포함)

### Phase 2.5: 한글 SuperClaude 패치 적용 (예정)
**소스**: 기존 dev-agents 프로젝트의 한글 패치 + 추가 개선
- 📋 기존 한글 패치 검토 및 적용 (디스크립션 한글화)
- 📋 한국어 명령어 및 응답 최적화
- 📋 한국어 페르소나 추가 및 상세 설명
- 📋 사용자가 이해하기 쉬운 한국어 가이드 작성
- 📋 복잡한 개념의 한국어 설명 및 예제 추가

### Phase 3: Claude Code Templates 적용 (예정) 
**소스**: https://github.com/davila7/claude-code-templates
- 📋 400+ 컴포넌트 라이브러리 활용
- 📋 전문 AI 에이전트 설정
- 📋 프레임워크별 최적화 템플릿
- 📋 자동화 훅 및 MCP 서버 연동

### Phase 4: OpenAI Codex 통합 (예정)
**소스**: https://github.com/openai/codex (최신 v0.27.0)
- 📋 Codex CLI 로컬 설치 (Rust 기반)
- 📋 Codex IDE 통합
- 📋 Codex MCP 서버 연동  
- 📋 configs/codex/ 디렉터리 구성
- 📋 로그인 방식 인증 (API 키 불필요)

### Phase 5: Google Gemini 통합 (예정)
**소스**: Google Gemini CLI + SuperGemini Framework
- 📋 Gemini CLI 설치
- 📋 SuperGemini Framework 적용 (pip install SuperGemini)
- 📋 `/sg:*` 명령어 시스템 (10+ 전문 명령어)
- 📋 Gemini IDE (VS Code 실행 가능) 로컬 관리 구성
- 📋 configs/gemini/ 디렉터리 구성
- 📋 로그인 방식 인증 (API 키 불필요)

### Phase 6: 기존 프로젝트 장점 통합 (예정)
**소스**: multi-agent-workspace, dev-agents 프로젝트
- 📋 기존 프로젝트 분석 및 좋은 점 추출
- 📋 안정성 향상 방안 적용
- 📋 시스템 최적화 기법 도입
- 📋 검증된 아키텍처 패턴 적용

### Phase 7: VS Code 통합 및 프로젝트 관리 시스템 (예정)
**핵심**: VS Code를 통한 모든 에이전트 작업
- 📋 VS Code 확장으로 모든 에이전트 통합
- 📋 에이전트별 VS Code 작업(Tasks) 설정
- 📋 프로젝트 폴더 구조 설계
  - `projects/` - 개별 프로젝트들 (독립 Git 관리)
  - `workspace/` - 업무용 작업 폴더 (문서검토, 개발 등)
- 📋 VS Code에서 에이전트 선택 인터페이스

### Phase 8: 통합 관리 시스템 (최종 목표) 
- 📋 통합 에이전트 선택 인터페이스
- 📋 크로스 플랫폼 설정 동기화  
- 📋 모니터링 및 분석 대시보드
- 📋 자동 환경 구축 시스템

## 🔧 기술 스택

### 핵심 기술
- **플랫폼**: WSL2 Ubuntu 22.04
- **런타임**: Node.js 18+ (LTS)
- **패키지 관리**: npm
- **버전 관리**: Git

### AI 도구들 (모두 로그인 방식 - API 키 불필요)
- **Claude Code**: Anthropic의 AI 코딩 어시스턴트 (✅ 현재)
  - SuperClaude Framework v4.0.8 (✅ 완료)
  - Claude Code Templates (📋 계획)
- **OpenAI Codex**: OpenAI의 로컬 코딩 에이전트 (📋 계획)
  - 최신 v0.27.0 (Rust 기반)
  - Codex CLI, IDE, MCP 통합
- **Google Gemini**: Google AI (📋 계획)
  - Gemini CLI + SuperGemini Framework

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

## 📋 Git 관리 전략 및 설정 파일 관리

### SuperClaude Framework Git 통합 (✅ 완료)
**현재 상태**: SuperClaude Framework v4.0.8의 모든 설정이 프로젝트에 통합됨

**포함 파일들**:
```
.claude/
├── CLAUDE.md                    # SuperClaude 엔트리 포인트
├── FLAGS.md                     # 동작 플래그 설정 (브레인스토밍, 분석 등)
├── PRINCIPLES.md                # 소프트웨어 엔지니어링 원칙
├── RULES.md                     # Claude Code 동작 규칙 (14KB 상세 규칙)
├── MODE_Brainstorming.md        # 협업 발견 모드
├── MODE_Introspection.md        # 메타인지 분석 모드
├── MODE_Orchestration.md        # 도구 최적화 모드
├── MODE_Task_Management.md      # 작업 관리 모드
├── MODE_Token_Efficiency.md     # 토큰 효율성 모드
├── MCP_Context7.md             # 공식 라이브러리 문서 조회
├── MCP_Playwright.md           # 브라우저 자동화 테스팅
├── MCP_Sequential.md           # 다단계 추론 엔진
├── MCP_Serena.md               # 프로젝트 메모리 관리
├── agents/                     # 14개 전문 에이전트
│   ├── system-architect.md      # 시스템 설계
│   ├── python-expert.md         # Python 전문가
│   ├── security-engineer.md     # 보안 엔지니어
│   ├── performance-engineer.md  # 성능 최적화
│   ├── quality-engineer.md      # 품질 보증
│   └── ...                     # 9개 추가 전문가
├── commands/sc/                # 21개 SuperClaude 명령어
│   ├── brainstorm.md           # 요구사항 발견
│   ├── analyze.md              # 코드 분석
│   ├── build.md                # 빌드 최적화
│   ├── implement.md            # 구현 전략
│   └── ...                     # 17개 추가 명령어
├── .superclaude-metadata.json  # 설치 정보 및 구성
└── backups/                    # 자동 백업
    └── superclaude_backup_*.tar.gz
```

### 환경 이식성 전략
1. **완전한 환경 복구**: `git clone` + `npm install`로 모든 AI 설정 복원
2. **설정 동기화**: SuperClaude 프레임워크가 프로젝트에 완전 포함됨
3. **팀 협업**: 동일한 AI 에이전트 환경을 팀원과 공유 가능
4. **백업 관리**: `.claude/backups/`에 자동 백업 보관

### MCP 서버 상태
- ✅ **Context7**: 공식 라이브러리 문서 조회 (React, Vue 등)
- ✅ **Sequential**: 다단계 분석 및 추론 엔진
- ⚠️ **Playwright**: 브라우저 자동화 (Chrome 설치 필요: `npx playwright install chrome`)
- ❓ **Serena**: 메모리 관리 (연결 상태 확인 중)

### 향후 AI 도구 Git 관리 계획
- **Codex 설정**: `configs/codex/` 폴더에 CLI 설정
- **Gemini 설정**: `configs/gemini/` 폴더에 SuperGemini 설정
- **VS Code 확장**: `.vscode/`에 AI 통합 워크스페이스 설정
- **통합 관리**: 모든 AI 도구 설정을 Git으로 버전 관리
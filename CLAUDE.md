# Claude Code 설정

이 파일은 Claude Code가 이 프로젝트를 더 효과적으로 이해하고 작업할 수 있도록 도와주는 설정입니다.

## 프로젝트 개요

**fenok-multi-agent**는 WSL2 Ubuntu 기반의 AI 에이전트 통합 개발 환경입니다.

- **목표**: 다양한 AI 코딩 어시스턴트를 하나의 환경에서 관리
- **환경**: WSL2 Ubuntu-22.04 최적화
- **특징**: 환경 이식성, 로컬 설치, Git 통합

## 프로젝트 구조

```
fenok-multi-agent/
├── .claude/           # Claude Code 로컬 설정
├── docs/              # 프로젝트 문서
├── scripts/           # 유틸리티 스크립트
├── configs/           # 각종 설정 파일
├── node_modules/      # npm 의존성
├── 참고후삭제/         # 개발 과정 참고 자료
├── package.json       # Node.js 프로젝트 설정
├── README.md          # 프로젝트 메인 문서
└── CLAUDE.md          # 이 파일
```

## 개발 지침

### 환경 이식성 우선
- 새로운 PC에서 `git clone` + `npm install`만으로 동작해야 함
- 글로벌 설치에 의존하지 않음
- 모든 설정은 프로젝트 내에 포함

### 명령어

```bash
# Claude Code 실행
npm run claude

# 버전 확인  
npm run claude -- --version

# 의존성 업데이트
npm update @anthropic-ai/claude-code
```

### Git 작업 시 주의사항
- WSL2와 Windows UI 도구 (SourceTree) 간 호환성 고려
- 파일 권한 및 줄바꿈 문자 이슈 주의

## 작업 우선순위

1. **환경 이식성** - 어떤 환경에서든 동일하게 동작
2. **문서화** - 설정과 사용법을 명확히 기록
3. **확장성** - 향후 다른 AI 도구 통합 준비

## 테스트 및 검증

프로젝트 변경 시 다음을 확인:
- [ ] 새로운 환경에서 `npm install` 후 정상 동작
- [ ] README.md의 설치 가이드 유효성
- [ ] Git 커밋/푸시 정상 동작 (UI 도구 포함)

## 향후 계획

- Gemini, Codex 등 다른 AI 도구 통합
- 멀티 에이전트 협업 시스템 구축
- 클라우드 환경 지원 확장
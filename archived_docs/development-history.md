# 개발 기록 및 학습 내용

## 🎯 프로젝트 목표 변화

### 초기 계획 (Windows PowerShell + Python venv)
- Windows PowerShell 기반 개발
- Python 가상환경 사용  
- 복잡한 환경 설정

### 최종 방향 (WSL2 Ubuntu 네이티브)
- **완전히 새로운 접근**: WSL2 Ubuntu에서 처음부터 구축
- **기존 Windows 방식 완전 폐기**
- **npm 기반 Claude Code 직접 설치**
- **환경 이식성 최우선**

## 🛠️ 핵심 기술 결정

### WSL2 선택 이유
1. **네이티브 성능**: Linux 환경에서 AI 도구 최적 성능
2. **Git 호환성**: Linux Git과 Windows UI 도구 모두 지원
3. **개발 환경 일관성**: 서버 환경과 동일한 개발 경험
4. **확장성**: 향후 Docker, 컨테이너 통합 용이

### npm 로컬 설치 전략
- **글로벌 설치 지양**: 환경 이식성 저해
- **프로젝트별 의존성 관리**: package.json으로 완전 제어
- **버전 일관성**: 팀원 간 동일한 도구 버전 보장

## 🔧 해결한 주요 이슈들

### 1. SSH 키 인증 문제
**문제**: SourceTree에서 "FATAL ERROR: No supported authentication methods available"
- WSL2의 SSH 키 ≠ Windows의 SSH 키
- Git UI 도구들은 Windows SSH 키만 인식

**해결**:
```bash
# WSL2 → Windows SSH 키 복사
cp ~/.ssh/id_ed25519* /mnt/c/Users/[username]/.ssh/
```

### 2. VS Code Git 통합 문제  
**문제**: VS Code에서 Git 커밋이 표시되지만 실제로는 실행되지 않음

**해결**:
- **Remote - WSL** 확장 사용
- WSL2에서 `code .` 실행하여 WSL 환경에서 VS Code 실행
- Git 터미널이 WSL2 환경에서 직접 실행됨

### 3. .gitignore 과도한 제외 문제
**기존 문제**: 시스템 파일들까지 과도하게 제외
- `.vscode/settings.json` 제외 → 팀 설정 공유 불가
- `package-lock.json` 제외 → 의존성 버전 불일치

**해결**: 보안상 중요한 파일만 선별적 제외
```gitignore
# 보안 파일만 제외
configs/*/api_keys
configs/*/auth_tokens  
.claude/session-*

# 세션 파일 (자동 재생성되므로 백업 불필요)
configs/*/*.session
```

### 4. 환경 이식성 이슈
**목표**: 어떤 PC에서든 `git clone` + `npm install`로 즉시 실행

**해결 전략**:
- 모든 설정 파일을 Git에 포함 (보안 파일 제외)
- 로컬 설치 기반 구조
- 자동 환경 설정 스크립트

## 📊 현재 상태 vs 원래 계획

### 원래 계획의 Phase 구분
- **Phase 0**: WSL2 환경 구축 ✅ **완료**
- **Phase 1**: Claude Code 설치 및 설정 ✅ **완료** 
- **Phase 2**: WSL 네이티브 런처 시스템 📋 **설계 완료, 구현 대기**
- **Phase 3**: VS Code + WSL 통합 ✅ **완료**

### 추가 달성한 항목 (계획에 없던 것)
- ✅ Git UI 도구 완벽 호환성 (SourceTree, GitHub Desktop 등)
- ✅ 환경 이식성 문제 해결
- ✅ 상세 문서화 (설치, 트러블슈팅 가이드)
- ✅ 크로스 플랫폼 호환성 (Windows, macOS, Linux)

## 🎓 학습한 내용들

### WSL2 고급 활용
- Windows와 Linux 파일 시스템 연동
- 권한 및 줄바꿈 문자 이슈 해결
- Git UI 도구와 WSL2 연계

### npm 프로젝트 구조 설계
- 로컬 vs 글로벌 설치 전략
- package.json scripts 활용
- 의존성 관리 모범 사례

### Git 워크플로우 최적화
- .gitignore 보안 설계
- .gitattributes 파일 타입별 설정
- 멀티 플랫폼 호환성

### 문서화 및 사용성
- 사용자 친화적 가이드 작성
- 단계별 설치 방법
- 트러블슈팅 체계화

## 🚀 다음 단계 우선순위

### 즉시 구현 가능한 항목들
1. **고급 런처 시스템** - 설계 완료, 구현만 남음
2. **세션 관리 시스템** - 로깅 및 추적
3. **모니터링 대시보드** - 시스템 상태 확인

### 중장기 계획
1. **Gemini 통합** - Google AI CLI 연동
2. **멀티 에이전트 선택 인터페이스**
3. **웹 기반 관리 도구**

## 💡 핵심 교훈

### 1. 단순함의 힘
복잡한 환경 설정보다 단순하고 명확한 구조가 유지보수성이 높음

### 2. 이식성의 중요성  
개발 환경이 쉽게 복제되어야 팀 협업과 확장이 용이함

### 3. 문제 해결 과정의 문서화
발생한 문제와 해결 과정을 문서화하면 미래의 같은 문제 예방 가능

### 4. 사용자 관점의 설계
개발자가 아닌 사용자가 쉽게 설치하고 사용할 수 있는 구조가 중요
# 로컬 설치 전략 가이드

## 🎯 로컬 설치의 중요성

### 왜 로컬 설치를 선택했는가?

1. **환경 이식성**: `git clone` + `npm install`로 어떤 PC에서든 동일한 환경
2. **버전 일관성**: 팀원 간 완전히 동일한 도구 버전 보장
3. **격리성**: 시스템 전역 설치와 독립적으로 프로젝트별 관리
4. **의존성 추적**: package.json으로 모든 도구 명시적 관리

### 글로벌 설치의 문제점
```bash
# ❌ 문제가 되는 방식들
npm install -g @anthropic-ai/claude-code  # 시스템 전역 오염
sudo apt install vscode                   # 버전 고정 불가
pip install jupyter                       # 의존성 충돌 위험
```

## 🛠️ 지원하는 도구들

### 현재 구현된 도구

#### Claude Code (완료 ✅)
```bash
# 로컬 설치
npm install @anthropic-ai/claude-code

# 실행 방법
npm run claude
# 또는
./node_modules/.bin/claude
```

### 향후 구현 예정 도구들

#### VS Code Server (계획)
```bash
# 로컬 VS Code 서버 설치 예정
npm install @vscode/server

# 프로젝트별 확장 관리
# .vscode/extensions.json에서 의존성 관리
```

#### Jupyter Lab (계획)
```bash
# 로컬 Jupyter 환경
npm install @jupyterlab/server

# Python 가상환경과 연동
# configs/jupyter/ 디렉터리에서 설정 관리
```

#### Git UI 도구 (부분 구현 ✅)
```bash
# Git 자체는 시스템 설치이지만
# 설정과 SSH 키는 프로젝트별 관리

# 현재 지원:
# - SourceTree 호환성
# - GitHub Desktop 호환성
# - VS Code Git 통합
```

## 📋 구현 전략

### 1. npm 기반 도구들
```json
{
  "devDependencies": {
    "@anthropic-ai/claude-code": "^1.0.96",
    "@vscode/server": "^1.85.0",
    "@jupyterlab/server": "^4.0.0"
  },
  "scripts": {
    "claude": "claude",
    "code": "code-server",
    "jupyter": "jupyter lab"
  }
}
```

### 2. 래퍼 스크립트 시스템
```bash
bin/
├── claude          # Claude Code 래퍼
├── code            # VS Code Server 래퍼 (예정)
├── jupyter         # Jupyter Lab 래퍼 (예정)
└── git-ui          # Git UI 설정 도구 (예정)
```

### 3. 설정 관리 구조
```bash
configs/
├── claude/         # Claude 설정 (완료)
├── vscode/         # VS Code 설정 (예정)
├── jupyter/        # Jupyter 설정 (예정)
└── shared/         # 공통 설정 (예정)
```

## 🔧 단계별 구현 계획

### Phase 1: Claude Code (완료 ✅)
- [x] npm 로컬 설치
- [x] 래퍼 스크립트 구현
- [x] 설정 파일 관리
- [x] WSL2 호환성

### Phase 2: VS Code 통합 (예정)
- [ ] VS Code Server 로컬 설치
- [ ] 확장 의존성 관리
- [ ] 프로젝트별 설정 동기화
- [ ] WSL Remote 최적화

### Phase 3: Jupyter 환경 (예정)
- [ ] JupyterLab 로컬 설치
- [ ] Python 가상환경 통합
- [ ] 커널 관리 자동화
- [ ] 확장 프로그램 관리

### Phase 4: 통합 CLI 도구 (예정)
- [ ] 통합 런처 시스템
- [ ] 도구 간 설정 공유
- [ ] 자동 업데이트 시스템
- [ ] 상태 모니터링

## 💡 구현 가이드라인

### 1. 일관된 디렉터리 구조
```bash
# 모든 도구는 이 패턴을 따름
configs/<tool-name>/
├── settings/           # 설정 파일들
│   ├── team.json      # 팀 공유 설정
│   └── local.json     # 개인 설정 (gitignore)
├── templates/         # 설정 템플릿
└── scripts/          # 도구별 스크립트
```

### 2. 래퍼 스크립트 패턴
```bash
#!/bin/bash
# bin/<tool-name> 표준 패턴

# 환경 로드
source scripts/load-environment.sh --quiet

# 도구별 설정 적용
export TOOL_CONFIG_PATH="$CONFIGS_PATH/<tool-name>"

# 로컬 설치 우선, 글로벌 fallback
if [ -f "node_modules/.bin/<tool-name>" ]; then
    exec "node_modules/.bin/<tool-name>" "$@"
elif command -v <tool-name> >/dev/null 2>&1; then
    exec <tool-name> "$@"
else
    echo "❌ <tool-name>이 설치되지 않았습니다"
    exit 1
fi
```

### 3. 설정 관리 원칙
- **팀 설정**: Git에 커밋 (team.json)
- **개인 설정**: .gitignore에 포함 (local.json)
- **보안 정보**: 별도 관리 (api_keys, tokens)
- **템플릿**: 새 환경 설정용 (*.template)

## 🚀 사용자 경험

### 설치 과정
```bash
# 1. 프로젝트 클론
git clone https://github.com/user/fenok-multi-agent
cd fenok-multi-agent

# 2. 의존성 설치 (모든 도구 자동 설치)
npm install

# 3. 도구별 설정 (대화형)
npm run setup

# 4. 바로 사용 가능
npm run claude
npm run code
npm run jupyter
```

### 일상적 사용
```bash
# 단축 명령어들
claude                # Claude 실행
code .               # VS Code 서버 실행  
jupyter              # Jupyter Lab 실행

# 설정 관리
claude-config status # Claude 설정 상태
code-config theme   # VS Code 테마 설정
```

## 📊 장점 분석

### 개발자 경험
- ✅ **일관성**: 모든 환경에서 동일한 도구 버전
- ✅ **속도**: 글로벌 설치 없이 바로 시작
- ✅ **격리**: 프로젝트별 독립적 환경

### 팀 협업
- ✅ **재현성**: 버그 재현과 해결이 용이
- ✅ **온보딩**: 새 팀원도 빠른 환경 구축
- ✅ **표준화**: 팀 전체 도구 표준화

### 유지보수성
- ✅ **추적성**: package.json에서 모든 도구 관리
- ✅ **업데이트**: 선택적이고 안전한 업데이트
- ✅ **백업**: 전체 환경을 Git으로 백업

## 🔮 미래 확장성

이 로컬 설치 전략은 다음과 같은 확장을 고려하여 설계되었습니다:

- **컨테이너화**: Docker/Podman과의 통합
- **클라우드 동기화**: 설정의 클라우드 백업
- **자동 업데이트**: 안전한 도구 업데이트 시스템
- **플러그인 생태계**: 커스텀 도구 쉽게 추가
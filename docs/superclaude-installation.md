# SuperClaude Framework 설치 가이드

## 🎯 SuperClaude Framework란?

SuperClaude Framework는 Claude Code를 전문 개발 도구로 변환하는 설정 프레임워크입니다. 19개의 전문 명령어와 9개의 인지 페르소나를 제공하여 Claude Code를 구조화된 개발 파트너로 만들어줍니다.

**중요**: SuperClaude는 **API 키를 사용하지 않습니다**. 모든 AI 에이전트(Claude, Gemini, Codex)는 로그인 방식으로 작동합니다.

## ✅ 사전 요구사항

### 1. 기본 환경 확인
```bash
# fenok-multi-agent 프로젝트 루트에서 실행
cd /home/etloveaui/workspace/fenok-multi-agent

# Claude Code 정상 동작 확인
npm run claude -- --version
```

**성공 조건**: Claude Code가 정상적으로 설치되어 있어야 함

### 2. Python 환경 확인 (SuperClaude Framework 설치용)
```bash
# Python 버전 확인 (3.8+ 필요)
python3 --version

# pip 또는 pipx 설치 확인
pipx --version || pip3 --version
```

## 🚀 SuperClaude Framework 설치 방법

### Option 1: pipx를 통한 설치 (✅ 권장)
```bash
# pipx 설치 (없는 경우)
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# SuperClaude v4.0.8 설치 (최신)
pipx install SuperClaude
pipx upgrade SuperClaude
SuperClaude install
```

### Option 2: pip를 통한 설치
```bash
# 일반 pip 설치
pip install SuperClaude
pip upgrade SuperClaude
SuperClaude install
```

### Option 3: npm을 통한 설치 (크로스 플랫폼)
```bash
# Node.js 사용자용
npm install -g @bifrost_inc/superclaude
superclaude install
```

### PEP 668 오류 해결 (시스템 패키지 충돌 시)
```bash
# Option 1: pipx 사용 (권장)
pipx install SuperClaude

# Option 2: 사용자 설치
pip install --user SuperClaude

# Option 3: 강제 설치 (주의해서 사용)
pip install --break-system-packages SuperClaude
```

## 📁 설치 후 구조

SuperClaude Framework 설치 후 `~/.claude/` 디렉터리에 다음 파일들이 생성됩니다:

```bash
~/.claude/
├── CLAUDE.md          # 메인 프레임워크 진입점
├── COMMANDS.md        # 사용 가능한 슬래시 명령어들
├── FLAGS.md           # 명령어 플래그 및 옵션
├── PERSONAS.md        # 스마트 페르소나 시스템
└── commands/          # 16개 개별 명령어 정의
    ├── implement.md
    ├── analyze.md
    ├── troubleshoot.md
    └── ... (13개 더)
```

## ⚙️ SuperClaude Framework 기능

### 🤖 19개 전문 명령어
- `/sc:implement` - 구현 계획 수립
- `/sc:analyze` - 코드 분석
- `/sc:troubleshoot` - 문제 해결
- `/sc:brainstorm` - 아이디어 브레인스토밍
- 기타 15개 전문 명령어

### 👥 9개 인지 페르소나
- AI 전문가들이 각자의 전문 분야에서 조언
- 상황에 맞는 적절한 페르소나 자동 선택
- 구조화된 개발 파트너 역할

### 🔧 MCP 서버 통합 (선택사항)
- Model Context Protocol 서버 연동 지원
- 확장된 컨텍스트 관리

## 🎯 사용 방법

### 첫 시작
```bash
# Claude Code 실행
npm run claude

# SuperClaude 첫 경험
# Claude Code 내에서:
/sc:brainstorm

# 도움말 확인
/help
```

### 주요 명령어 예시
```bash
# Claude Code 내에서 사용:

# 프로젝트 구현 계획
/sc:implement "사용자 인증 시스템 구축"

# 코드 분석
/sc:analyze "현재 코드베이스의 성능 이슈"

# 문제 해결
/sc:troubleshoot "Git 커밋이 안되는 문제"

# 아이디어 브레인스토밍  
/sc:brainstorm "React 앱 성능 최적화 방법"
```

## ✅ 설치 확인

### 1. 설치 파일 확인
```bash
# SuperClaude 설치 디렉터리 확인
ls -la ~/.claude/

# 주요 파일들이 존재하는지 확인
ls ~/.claude/CLAUDE.md ~/.claude/COMMANDS.md ~/.claude/PERSONAS.md

# 명령어 디렉터리 확인
ls ~/.claude/commands/
```

### 2. Claude Code에서 SuperClaude 기능 테스트
```bash
# Claude Code 실행
npm run claude

# Claude Code 내에서 SuperClaude 명령어 테스트:
# /help                     # 도움말 확인
# /sc:brainstorm           # 첫 SuperClaude 경험
# /sc:implement            # 구현 계획 테스트
```

## 🚨 트러블슈팅

### 문제 1: 설치 후 명령어가 안 보이는 경우
```bash
# ~/.claude/ 디렉터리 확인
ls -la ~/.claude/

# 수동으로 Claude Code 재시작
npm run claude
# Claude Code 내에서 /help 입력하여 새 명령어 확인
```

### 문제 2: Python 환경 충돌
```bash
# pipx 사용 (권장)
pipx install SuperClaude
pipx upgrade SuperClaude

# 또는 사용자 디렉터리 설치
pip install --user SuperClaude
```

### 문제 3: v3에서 v4 업그레이드 시 충돌
```bash
# v3 관련 파일 정리 (v4 설치 전)
rm -f ~/.claude/*.md ~/.claude/*.json
rm -rf ~/.claude/commands/

# v4 재설치
pipx install SuperClaude
SuperClaude install
```

## 🔗 관련 프레임워크: SuperGemini Framework

SuperClaude와 유사하게 **Gemini CLI**를 위한 SuperGemini Framework도 있습니다:

### SuperGemini Framework 설치
```bash
# Gemini CLI 먼저 설치 필요
# 그 후 SuperGemini Framework 설치
pip install SuperGemini

# 설치 확인 및 컴포넌트 설치
SuperGemini --version
SuperGemini install --quick --yes
```

### SuperGemini 주요 명령어
- `/sg:implement` - 구현 계획
- `/sg:analyze` - 코드 분석  
- `/sg:troubleshoot` - 문제 해결
- `/sg:improve` - 코드 개선
- `/sg:test` - 테스트 생성
- 기타 10+ 전문 명령어

## 🎉 성공 확인

다음 체크리스트로 설치 상태를 확인하세요:

```bash
echo "🎯 SuperClaude Framework 설치 확인"
echo "================================="

# 1. 설치 디렉터리 확인
[ -d ~/.claude ] && echo "✅ ~/.claude 디렉터리 존재" || echo "❌ 설치 디렉터리 없음"

# 2. 주요 파일 확인
[ -f ~/.claude/CLAUDE.md ] && echo "✅ 메인 설정 파일 존재" || echo "❌ 메인 설정 파일 없음"

# 3. 명령어 디렉터리 확인
[ -d ~/.claude/commands ] && echo "✅ 명령어 디렉터리 존재" || echo "❌ 명령어 디렉터리 없음"

# 4. Claude Code 연동 확인
echo "📝 Claude Code에서 다음 명령어로 테스트:"
echo "   npm run claude"
echo "   그 후: /help 또는 /sc:brainstorm 입력"

echo ""
echo "🚀 모든 ✅ 항목이 표시되면 설치 완료!"
echo "💡 Claude Code에서 /sc:brainstorm으로 첫 경험을 시작하세요!"
```

## 🔄 정기 업데이트

SuperClaude Framework는 지속적으로 업데이트됩니다:

```bash
# 정기 업데이트 확인 및 설치
pipx upgrade SuperClaude
SuperClaude install --update

# 또는 재설치로 최신 기능 적용
SuperClaude install --quick --yes
```

이제 Claude Code가 19개 전문 명령어와 9개 인지 페르소나를 가진 강력한 개발 도구로 변신했습니다! 🎉
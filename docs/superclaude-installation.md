# SuperClaude 설치 가이드

## 🎯 SuperClaude란?

SuperClaude는 기본 Claude Code를 확장한 고급 기능을 제공하는 도구입니다. 현재 fenok-multi-agent 환경에서는 Claude Code가 정상적으로 설치되고 설정되어 있어야 SuperClaude를 추가로 설치할 수 있습니다.

## ✅ 사전 요구사항

### 1. 기본 환경 확인
```bash
# fenok-multi-agent 프로젝트 루트에서 실행
cd /home/etloveaui/workspace/fenok-multi-agent

# Claude Code 정상 동작 확인
npm run claude -- --version
```

**성공 조건**: Claude Code 버전이 정상적으로 출력되어야 함

### 2. Claude Code 설정 상태 확인
```bash
# Claude 설정 상태 점검
ls -la .claude/settings.local.json

# API 키 설정 여부 확인 (실제 키 값 노출 없이)
grep -q "sk-ant-" .claude/settings.local.json && echo "✅ API 키 설정됨" || echo "❌ API 키 미설정"
```

## 🚀 SuperClaude 설치 방법

### Option 1: npm을 통한 로컬 설치 (권장)
```bash
# fenok-multi-agent 프로젝트 루트에서
npm install @anthropic-ai/superclaude

# package.json에 스크립트 추가
npm pkg set scripts.superclaude="superclaude"

# 설치 확인
npm run superclaude -- --version
```

### Option 2: 글로벌 설치 (비권장)
```bash
# WSL2에서 글로벌 설치 (환경 이식성 저해)
npm install -g @anthropic-ai/superclaude

# 설치 확인
superclaude --version
```

## ⚙️ SuperClaude 설정

### 1. 설정 디렉터리 준비
```bash
# SuperClaude 전용 설정 디렉터리 생성
mkdir -p configs/superclaude/{settings,templates,scripts}

# 기본 설정 파일 생성
touch configs/superclaude/settings/team.json
touch configs/superclaude/settings/local.json.template
```

### 2. 팀 공유 설정 파일
```bash
cat > configs/superclaude/settings/team.json << 'EOF'
{
  "version": "1.0",
  "features": {
    "advancedMode": true,
    "multiAgent": false,
    "customPrompts": true,
    "sessionManagement": true
  },
  "integrations": {
    "claudeCode": true,
    "vscode": true,
    "jupyter": false
  },
  "ui": {
    "theme": "dark",
    "compactMode": false,
    "showAdvancedOptions": true
  }
}
EOF
```

### 3. 개인 설정 템플릿
```bash
cat > configs/superclaude/settings/local.json.template << 'EOF'
{
  "apiKeys": {
    "anthropic": "your-api-key-here",
    "openai": "optional-openai-key-here"
  },
  "user": {
    "name": "Your Name",
    "preferences": {
      "defaultAgent": "claude",
      "autoSave": true,
      "notifications": true
    }
  },
  "advanced": {
    "debugMode": false,
    "experimentalFeatures": false,
    "customEndpoints": {}
  }
}
EOF
```

### 4. 개인 설정 초기화
```bash
# 템플릿을 복사하여 개인 설정 생성
cp configs/superclaude/settings/local.json.template configs/superclaude/settings/local.json

# 설정 파일 편집 (API 키 등 개인 정보 입력)
nano configs/superclaude/settings/local.json
```

## 🔧 SuperClaude 래퍼 스크립트

### 1. 실행 스크립트 생성
```bash
cat > bin/superclaude << 'EOF'
#!/bin/bash

# SuperClaude 실행 래퍼 스크립트
set -e

# 환경 로드 (기존 fenok-multi-agent 환경 활용)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# 설정 경로 설정
export SUPERCLAUDE_CONFIG_PATH="$PROJECT_ROOT/configs/superclaude"

# 설정 파일 확인
if [ ! -f "$SUPERCLAUDE_CONFIG_PATH/settings/local.json" ]; then
    echo "❌ SuperClaude 개인 설정이 없습니다."
    echo "📝 다음 명령어로 설정을 생성하세요:"
    echo "   cp configs/superclaude/settings/local.json.template configs/superclaude/settings/local.json"
    echo "   그 후 API 키를 설정하세요."
    exit 1
fi

# SuperClaude 실행 방식 결정
if [ -f "$PROJECT_ROOT/node_modules/.bin/superclaude" ]; then
    echo "🚀 Starting SuperClaude (local installation)..."
    exec "$PROJECT_ROOT/node_modules/.bin/superclaude" "$@"
elif command -v superclaude >/dev/null 2>&1; then
    echo "🚀 Starting SuperClaude (global installation)..."
    exec superclaude "$@"
else
    echo "❌ SuperClaude가 설치되지 않았습니다."
    echo "📦 다음 명령어로 설치하세요:"
    echo "   npm install @anthropic-ai/superclaude"
    exit 1
fi
EOF

chmod +x bin/superclaude
```

### 2. package.json 스크립트 추가
```bash
# package.json에 SuperClaude 스크립트 추가
npm pkg set scripts.superclaude="./bin/superclaude"

# 설정 관리 스크립트도 추가
npm pkg set scripts.superclaude-config="./bin/superclaude-config"
```

## 📋 .gitignore 업데이트

SuperClaude 관련 개인 설정을 Git에서 제외하기 위해 .gitignore 업데이트:

```bash
cat >> .gitignore << 'EOF'

# SuperClaude 개인 설정
configs/superclaude/settings/local.json
configs/superclaude/sessions/
configs/superclaude/cache/
EOF
```

## ✅ 설치 확인

### 1. 기본 동작 테스트
```bash
# SuperClaude 버전 확인
npm run superclaude -- --version

# 설정 상태 확인
npm run superclaude -- --config-status

# 간단한 질문 테스트
echo "SuperClaude 설치 테스트" | npm run superclaude
```

### 2. 기존 Claude Code와 연동 확인
```bash
# Claude Code가 정상 작동하는지 확인
npm run claude -- --version

# 두 도구가 동시에 사용 가능한지 확인
npm run claude -- "Hello from Claude Code"
npm run superclaude -- "Hello from SuperClaude"
```

## 🎯 사용 방법

### 기본 사용법
```bash
# 대화형 모드
npm run superclaude

# 한 줄 질문
npm run superclaude -- "질문 내용"

# 파일 입력
npm run superclaude -- < input.txt

# 고급 옵션
npm run superclaude -- --advanced-mode --session mysession
```

### 설정 관리
```bash
# 설정 상태 확인
npm run superclaude -- --config-status

# 설정 백업
cp configs/superclaude/settings/local.json configs/superclaude/settings/local.json.backup

# 설정 초기화
cp configs/superclaude/settings/local.json.template configs/superclaude/settings/local.json
```

## 🚨 트러블슈팅

### 문제 1: "SuperClaude not found" 오류
```bash
# 해결방법 1: 로컬 설치 확인
npm list @anthropic-ai/superclaude

# 해결방법 2: 재설치
npm install @anthropic-ai/superclaude

# 해결방법 3: 실행 권한 확인
chmod +x bin/superclaude
```

### 문제 2: 설정 파일 오류
```bash
# JSON 형식 확인
jq . configs/superclaude/settings/local.json

# 설정 파일 초기화
cp configs/superclaude/settings/local.json.template configs/superclaude/settings/local.json
```

### 문제 3: API 키 관련 오류
```bash
# API 키 설정 확인
grep "your-api-key-here" configs/superclaude/settings/local.json
# 위 명령어 결과가 있으면 아직 API 키 미설정

# API 키 설정
nano configs/superclaude/settings/local.json
```

## 🎉 성공 확인

모든 단계가 완료되면 다음과 같이 확인할 수 있습니다:

```bash
echo "🎯 SuperClaude 설치 확인 체크리스트"
echo "=================================="

# 1. SuperClaude 실행 가능
npm run superclaude -- --version && echo "✅ SuperClaude 실행 가능" || echo "❌ SuperClaude 실행 불가"

# 2. 설정 파일 존재
[ -f configs/superclaude/settings/local.json ] && echo "✅ 설정 파일 존재" || echo "❌ 설정 파일 없음"

# 3. API 키 설정 확인
grep -v "your-api-key-here" configs/superclaude/settings/local.json > /dev/null && echo "✅ API 키 설정됨" || echo "❌ API 키 미설정"

# 4. 기존 Claude Code 호환성
npm run claude -- --version > /dev/null && echo "✅ Claude Code 호환성 유지" || echo "❌ Claude Code 문제"

echo ""
echo "🚀 모든 항목이 ✅ 표시되면 설치 완료!"
```

이제 SuperClaude를 사용할 준비가 완료되었습니다!
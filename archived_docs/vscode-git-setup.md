# VS Code Git 설정 가이드

VS Code에서 WSL2 환경의 Git이 정상 작동하도록 하는 설정 가이드입니다.

## 🔍 VS Code Git 커밋 안되는 이유

VS Code는 두 가지 방식으로 Git을 사용할 수 있습니다:
1. **Windows Git** (기본) - SSH 키 인증 문제 발생 가능
2. **WSL2 Git** (권장) - 네이티브 환경에서 동작

## 🛠️ 해결 방법

### 방법 1: WSL2 확장 사용 (권장)

1. **WSL 확장 설치**
   - `Remote - WSL` 확장 설치
   
2. **WSL2에서 VS Code 실행**
   ```bash
   # WSL2 터미널에서
   cd /home/etloveaui/workspace/fenok-multi-agent
   code .
   ```

3. **VS Code 하단 확인**
   - 좌하단에 `WSL: Ubuntu-22.04` 표시되면 성공

### 방법 2: Git 경로 설정

VS Code 설정(`Ctrl + ,`)에서 다음 추가:

```json
{
    "git.path": "C:\\Windows\\System32\\wsl.exe",
    "git.useIntegratedTerminal": true,
    "terminal.integrated.defaultProfile.windows": "WSL"
}
```

### 방법 3: SSH 키 설정 확인

Windows의 SSH 키가 올바르게 설정되어 있는지 확인:

```bash
# WSL2에서 확인
ls -la /mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" | tr -d '\r')/.ssh/
```

## 🔧 VS Code 터미널 설정

### 기본 터미널을 WSL로 설정
1. **Ctrl + Shift + P** → `Terminal: Select Default Profile`
2. **WSL** 또는 **Ubuntu-22.04** 선택

### Git 터미널 확인
```bash
# VS Code 터미널에서 실행
which git
git config --list | grep user
ssh -T git@github.com
```

## ⚙️ 권장 VS Code 설정

`.vscode/settings.json`에 추가:

```json
{
    "remote.WSL.fileWatcher.polling": true,
    "git.enabled": true,
    "git.autoRepositoryDetection": true,
    "git.detectSubmodules": false,
    "terminal.integrated.defaultProfile.windows": "WSL"
}
```

## 🚨 문제 해결

### Git 커밋 시 "Permission denied" 오류
```bash
# SSH 키 권한 확인
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

### Git 사용자 정보 미설정 오류
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### VS Code에서 Git 그래프가 안 보이는 경우
1. **Extensions** → **Git Graph** 설치
2. **Source Control** 패널에서 확인

## ✅ 설정 확인 체크리스트

VS Code에서 다음 사항들이 정상 작동하는지 확인:

- [ ] 터미널이 WSL2 환경으로 열림
- [ ] `git status` 명령어 실행됨
- [ ] Source Control 패널에서 변경사항 표시됨
- [ ] 커밋 메시지 작성 가능
- [ ] 푸시 동작 성공
- [ ] 브랜치 변경 가능

## 🔗 추가 참고사항

- **Remote - WSL** 확장 사용 시 모든 Git 작업이 WSL2 환경에서 실행됩니다
- 파일 권한 문제 없이 자연스럽게 Git 작업 가능
- WSL2의 SSH 키를 그대로 사용하므로 별도 설정 불필요
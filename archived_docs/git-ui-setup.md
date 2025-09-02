# Git UI 도구 호환성 가이드

WSL2 환경에서 Windows Git UI 도구들과 호환성을 위한 설정 가이드입니다.

## 🔑 핵심 원리

**모든 Windows Git UI 도구**는 WSL2 내부의 SSH 키를 직접 사용하지 못합니다.
Windows의 `C:\Users\[사용자명]\.ssh\` 경로의 키를 사용하므로 SSH 키 동기화가 필요합니다.

## 🚀 새로운 PC 설정 시 (필수)

### 1. SSH 키 복사
```bash
# WSL2에서 실행
mkdir -p /mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" | tr -d '\r')/.ssh
cp ~/.ssh/id_ed25519* /mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" | tr -d '\r')/.ssh/
```

### 2. 권한 설정 (Windows에서)
```powershell
# PowerShell에서 실행
icacls C:\Users\%USERNAME%\.ssh\id_ed25519 /inheritance:r /grant:r %USERNAME%:R
```

## 🛠️ Git UI 도구별 설정

### SourceTree
1. **Tools → Options → SSH Client**
2. **Use System SSH** 선택
3. 또는 **SSH Key** 탭에서 키 경로 설정: `C:\Users\%USERNAME%\.ssh\id_ed25519`

### GitHub Desktop
- 보통 자동으로 시스템 SSH 키 인식
- 문제 시: **File → Options → Git → Use system Git**

### GitKraken
1. **Preferences → SSH** 
2. **Browse** → `C:\Users\%USERNAME%\.ssh\id_ed25519` 선택

### Fork
1. **Preferences → SSH**
2. **Add Key** → `C:\Users\%USERNAME%\.ssh\id_ed25519` 선택

### VS Code
VS Code는 Git 터미널을 통해 작동하므로 추가 설정이 필요할 수 있습니다.
[VS Code Git 설정 참고](./vscode-git-setup.md)

## ✅ 설정 확인 방법

### Windows PowerShell에서 테스트
```powershell
ssh -T git@github.com
```

### WSL2에서 테스트
```bash
ssh -T git@github.com
```

두 환경 모두에서 성공 메시지가 나와야 합니다:
```
Hi [username]! You've successfully authenticated, but GitHub does not provide shell access.
```

## 🔄 키 재생성이 필요한 경우

### WSL2에서 새 SSH 키 생성
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
# Enter file: ~/.ssh/id_ed25519 (기본값)
# Enter passphrase: (선택사항)
```

### GitHub에 공개 키 등록
```bash
cat ~/.ssh/id_ed25519.pub
# 출력된 내용을 GitHub → Settings → SSH Keys에 추가
```

### Windows로 키 복사
```bash
cp ~/.ssh/id_ed25519* /mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" | tr -d '\r')/.ssh/
```

## 🚨 주의사항

1. **개인 키는 절대 공개 저장소에 커밋하지 마세요**
2. **SSH 키는 각 PC마다 새로 생성하는 것을 권장**
3. **공용 PC에서는 작업 완료 후 키 삭제**

## 📋 체크리스트

새 환경 설정 시 확인:
- [ ] WSL2에 SSH 키 존재
- [ ] Windows에 SSH 키 복사 완료
- [ ] GitHub에 공개 키 등록 완료
- [ ] WSL2에서 `ssh -T git@github.com` 성공
- [ ] Windows에서 `ssh -T git@github.com` 성공
- [ ] Git UI 도구에서 커밋/푸시 테스트 성공
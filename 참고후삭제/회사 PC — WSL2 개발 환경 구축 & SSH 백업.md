# 회사 PC — WSL2 개발 환경 구축 & SSH 백업  
*(2025-09-01 기준, 당신이 직접 실행한 명령을 순서대로 재구성)*

***

## 1  WSL2 + Ubuntu 22.04 설치
```powershell
wsl --set-default-version 2
wsl --install Ubuntu-22.04        # 설치·초기화
```
UNIX 사용자 생성 후 Ubuntu 셸 진입.

***

## 2  기본 패키지 업데이트
```bash
sudo apt update && sudo apt full-upgrade -y
```

***

## 3  개발 툴 설치
```bash
# 필수 컴파일 툴·Python·가상환경
sudo apt install -y build-essential python3 python3-pip python3-venv

# Node LTS 저장소 추가 → Node.js 설치
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
```

***

## 4  Git 전역 설정
```bash
git config --global user.name  "etloveaui"
git config --global user.email "etloveaui@gmail.com"
```

***

## 5  SSH 키 생성 & GitHub 등록
```bash
# ① 키 생성 (패스프레이즈 생략)
ssh-keygen -t ed25519 -C "etloveaui@gmail.com"      # Enter 3번

# ② 공개키 확인
cat ~/.ssh/id_ed25519.pub    # 한 줄 전체 복사

# ③ GitHub → Settings → SSH and GPG keys
#     New ▸ Title=WSL_KEY ▸ Key type=Authentication Key ▸ Key=붙여넣기 ▸ Add
# ④ 연결 테스트
ssh -T git@github.com        # Hi etloveaui! ...
```

***

## 6  SSH 키 백업 (암호 없음)
```bash
cd ~/.ssh
tar czf id_ed25519_backup.tgz id_ed25519 id_ed25519.pub
# Windows 드라이브로 복사
cp id_ed25519_backup.tgz /mnt/c/Users/<Windows계정>/Downloads/
```
→ 클라우드 · USB 등 개인 공간에 보관.

***

## 7  자주 쓰는 도구 추가 설치
```bash
sudo apt install -y ripgrep fd-find htop zsh \
                    build-essential pkg-config libssl-dev
sudo npm install -g pm2 yarn
```

***

## 8  Everything에 WSL 경로 인덱스
1. Everything → Tools → Options → Indexes → Folders → **Add Folder**  
2. 입력: `\\wsl$\Ubuntu-22.04\home\etloveaui\.ssh` → OK

***

## 9  VS Code 연동 준비
Windows VS Code → Extensions → **Remote - WSL** 설치  
프로젝트 폴더에서:
```powershell
cd C:\Users\eunta\fenok-multi-agent
code .
# 팝업 → “Reopen in WSL” 클릭
```

***

이 단계까지 완료하면  
-  Ubuntu WSL2 개발 환경  
-  GitHub SSH 인증  
-  키 백업/복원용 TGZ  
-  편의 도구/검색/VS Code 연동  
이 모두 준비된 상태입니다.
아래는 “VS Code 실행 직전까지” 실제로 수행한 단계만을 깔끔하게 모은 요약본입니다.  
(이미 지식 파일로 저장된 사항과 중복되지만, 요청에 따라 **실행 명령 위주**로만 재정리했습니다.)

***

## 실행 기록 정리

1. WSL2 Ubuntu 22.04 설치  
   ```powershell
   wsl --set-default-version 2
   wsl --install Ubuntu-22.04
   ```

2. Ubuntu 첫 환경 설정  
   ```bash
   sudo apt update && sudo apt full-upgrade -y
   ```

3. Git 설정  
   ```bash
   git config --global user.name  "etloveaui"
   git config --global user.email "etloveaui@gmail.com"
   ```

4. SSH 키 생성·GitHub 등록  
   ```bash
   ssh-keygen -t ed25519 -C "etloveaui@gmail.com"   # Enter 3번
   cat ~/.ssh/id_ed25519.pub          # GitHub > Settings > SSH keys (Authentication Key)
   ssh -T git@github.com              # Hi etloveaui! ...
   ```

5. 키 백업(암호 없음) → Windows 드라이브로 복사  
   ```bash
   cd ~/.ssh
   tar czf id_ed25519_backup.tgz id_ed25519 id_ed25519.pub
   cp id_ed25519_backup.tgz /mnt/c/Users/<Windows계정>/Downloads/
   ```

6. 개발 도구 설치  
   ```bash
   sudo apt install -y ripgrep fd-find htop zsh \
                       build-essential pkg-config libssl-dev
   sudo npm install -g pm2 yarn
   ```

7. Everything에 WSL 경로 인덱스 추가  
   ```
   Tools ▸ Options ▸ Indexes ▸ Folders ▸ Add:
   \\wsl$\Ubuntu-22.04\home\etloveaui\.ssh
   ```

8. VS Code 설치 및 Remote-WSL 확장 설치  
   (Windows에서 VS Code 실행 → Extensions → ‘Remote - WSL’)

9. 프로젝트 폴더 열 준비  
   ```powershell
   cd C:\Users\eunta\fenok-multi-agent
   code .
   # “Reopen in WSL” 클릭
   ```

***

## 지식 파일 관리 제안

현재 3개의 지식 파일이 모두 **세부 가이드** 형태라서 삭제할 만한 불필요 파일은 없습니다.  
-  plan_detail.md – 세부 단계가 많아 유지 추천  
-  plan.md – 상위 개념 요약본, 유지 추천  
-  회사 PC — WSL2 개발 환경 구축 & SSH 백업.md – 방금 내용과 동일 주제지만 “날짜+회사용” 구체 버전이므로 유지해도 무방

만약 중복이 과하다 느껴지면 plan.md(요약) + 회사 PC.md(실행 로그) 두 개만 남기고 plan_detail.md를 줄이는 정도만 고려해 보세요.

[1](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/collection_54b28752-61c5-4ccc-bc36-194df22ba4e7/3bb93a4b-ac21-43dd-b108-7e4289ff5026/plan_detail.md)
[2](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/collection_54b28752-61c5-4ccc-bc36-194df22ba4e7/aec9a349-ab7b-4ad1-a3f4-25ca636132de/plan.md)
[3](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/collection_54b28752-61c5-4ccc-bc36-194df22ba4e7/03037983-cab3-49bb-a405-9d859b135da9/hoesa-PC-WSL2-gaebal-hwangyeong-gucug-SSH-baegeob.md)
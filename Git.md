# Git

구글드라이브와 비슷한 웹하드 형태의 사이트

### commit

업로드 대기상태로 만들어 놓는 것

### push

업로드 대기 상태의 파일들을 일괄 업로드 하는 것 (푸쉬하다)

### pull

push가 이미 되어있다면 에러가난다. 그럼 Git에서는 다시 다운로드를 받아서 push를 하라고 시킨다.

이 때 다운로드 받는 것 (풀받다)

업로드 순서

1. commit
2. push
3. pull
4. commit
5. push

### 버전관리 시스템 (형상관리 시스템)

Git은 파일 변경이력을 계속 추적하여 충돌을 방지해준다.

한 파일을 두사람이 수정하여 충돌이 발생했다면, Git은 알람을 주어 어떤 파일이 최종 수정 파일인지 물어본다.

또한 변경이력을 계속 저장하고 있기 때문에, 원하는 시점으로 되돌릴 수 있다.

> 풀 푸쉬는 하루에 두번씩 꼭 하고 미루지 말기!

## GitHub

Git을 웹사이트 형태로 만들어서 무료로 사용할 수 있게 해줌

### 클라이언트 프로그램

다운로드 링크 https://git-scm.com/

> cmd용 클라이언트 프로그램을 다운받는다.

설치 후 인증서 만들기

```shell
# cmd에서 인증서를 만드는 명령어
ssh-keygen

# 아래의 경로로 이동해 보면 인증서가 보관되어 있다
C:\Users\EZEN\.ssh
```



https://github.com/

Settings > SSH and GPG keys에 id_rsa.pub 파일의 내용을 붙여넣기 한다. (id_rsa.pub 파일은 메모장에서 실행)



## Github

업로드 대기 : commit 상태

대기 상태 파일을 일괄 업로드 : push

기존 push 내역을 다운로드 : pull



Git : 모든 팀원이 같은 파일을 갖도록 유지하는 역할

버전관리시스템, 형상관리시스템 : 같은 파일이라도 내용이 다르면 충돌내용을 알려주는 것



***

1. github에 있는 프로젝트를 폴더 째 다운로드
   - Code > Clone with SSH 클릭 > 내용 복사한 뒤 명령 프롬프트 창에서 git clone 명령어 뒤에 붙여넣기

```shell
git clone git@github.com:사용자아이디/프로젝트명
```

> 명령어를 수행한 위치에 프로젝트 이름의 폴더가 생성된다



2. 생성된 프로젝트 폴더 초기화 작업

   - 폴더 안에 있는 `.gitignore` 파일과 `README.md`(선택사항) 파일을 정비

   - `.gitignore` 파일을 sublime으로 실행 (파일명 때문에 윈도우에선 안되므로)
   - `gitignore.txt` 파일 내용 복붙 후 저장 (구글드라이브 공유폴더)
   - 팀 프로젝트를 위한 기본 틀 (css, javascript, img 파일 등)을 저장할 폴더 생성 (ex `/assets/css`)
   - 사이트 대문 파일 생성 `index.html`
   - 각 페이지 별 폴더, 파일을 때에 따라 생성 (ex `/account/join.html`, `/account/login.html`)
   - **팀원은 이 단계에서 자유롭게 프로젝트 진행**

3. 작업 결과를 업로드 대기열에 등록 (commit)

```shell
git add --all
```

```shell
git commit -m "코멘트 작성하기"
```

4. github에 소스코드 업로드 (push)

```shell
git push origin master
```

> origin은 내 pc의 작업물, master는 github의 저장내역



***

```shell
# 에러가 뜨는 경우, 딱 1회 적용하기
git config --global user.name "이름"
git config --global user.email "이메일주소"
```

> 초기설정 1회 후 commit 하면 된다



***

5. github으로부터 변경 내역만 다운로드 (pull)

```powershell
git pull origin master
```



<strong>3, 4, 5를 반복하는 과정에서 늘 원본은 github에 업로드되어있는 파일임을 유념</strong>





충돌시에 pull된 파일을 열어보면.. 아래와 같이 파일 변경 내역(?) 까지 볼 수 있음.

```
<<<< HEAD

내가 작업하던내용
...



다른사람이 업로드한 내용
...

>>>> 4gd4f8ej4323kl8klw3jbkwtkl74kl709kelsdl2kl124jk

초안
```



# 깃허브 되돌리기

## Push 되돌리기

```shell
# push number는 7자리의 일련번호(?) 이다.
git reset $push_id

# 명령어를 수행 후 (add --all 처럼 어떤 문구도 나오지 않음, 문구 나올때도 있음..)

# PUSH 강제 되돌리기
git push --force
```

## Commit 되돌리기

```bash
# 직전 COMMIT 강제 되돌리기
git reset --hard HEAD^^
```

- 윈도우에서 `^` 문자는 이스케이프 문자이므로 ^^ 두개를 써준다!
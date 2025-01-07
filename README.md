# TypeD-Frontend 프로젝트 셋업 가이드

## • clone & push 작업흐름

---
### 1. 프로젝트를 저장할 폴더 생성 및 이동
~~~
mkdir TypeD-Project
cd TypeD-Project
~~~

### 2. Git 레포지토리 clone
~~~
git clone https://github.com/genericTypeD/TypeD-Frontend.git
cd TypeD-Frontend
~~~

### 3. dev 브랜치로 전환 & 최신 코드 가져오기
~~~
git checkout dev
git pull origin dev
~~~

### 4. 터미널에서 .env 파일 생성 및 설정
~~~
cp .env.example .env
~~~
##### .env 파일을 열어서 필요한 실제 값들을 입력

### 5. Flutter 의존성 설치
~~~
flutter pub get
~~~
### 6. 작업할 기능의 브랜치 생성
~~~
git checkout -b feat/기능명
~~~
#### 예시: git checkout -b feat/login

### 7. 작업 완료 된 브랜치 push
~~~
git push origin feat/기능명
~~~
#### 예시: git push origin feat/login
## • merge 작업 흐름

---
### 1. 다른 팀원 PR 확인 및 merge 되는대로 최신 dev 코드 -> local dev 브랜치에 반영
~~~
git strash 
~~~
#### ※ 작업중인 branch에서 작업중인 내용이 있거나 commit 전 상태인 경우, dev branch로 이동이 안됨 => 작업코드 임시저장
~~~
git checkout dev
git pull origin dev
~~~
### 2. dev 코드 반영 후 작업중인 브랜치 돌아가서 local dev와 코드 병합
~~~
git checkout 작업브랜치 (ex. feat/login)
git merge dev
~~~
#### ※ 임시저장한 작업코드가 있다면, 작업 내용 복원해오기
~~~
git strash pop 
~~~

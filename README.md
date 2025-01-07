# TypeD-Frontend 프로젝트 셋업 가이드

## 1. 프로젝트를 저장할 폴더 생성 및 이동
~~~
mkdir TypeD-Project
cd TypeD-Project
~~~

## 2. Git 레포지토리 클론
~~~
git clone https://github.com/genericTypeD/TypeD-Frontend.git
cd TypeD-Frontend
~~~

## dev 브랜치로 전환 & 최신 코드 가져오기
~~~
git checkout dev
git pull origin dev
~~~

## 터미널에서 .env 파일 생성 및 설정 
~~~
cp .env.example .env
~~~
#### .env 파일을 열어서 필요한 실제 값들을 입력

## Flutter 의존성 설치
~~~
flutter pub get
~~~

## 작업할 기능의 브랜치 생성
~~~
git checkout -b feature/기능명
~~~
#### 예시: git checkout -b feat/login
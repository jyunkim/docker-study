# Docker Study
출처: https://www.inflearn.com/course/%EB%94%B0%EB%9D%BC%ED%95%98%EB%A9%B0-%EB%B0%B0%EC%9A%B0%EB%8A%94-%EB%8F%84%EC%BB%A4-ci/

## 1. 도커 기본
### 도커를 쓰는 이유
프로그램을 설치하는 과정에서 서버, 패키지 버전, 운영체제, 종속성 등에 따라 많은 에러가 발생함

도커를 사용하면 프로그램을 설치하는 과정을 간단하게 만들 수 있음

### 도커란?
컨테이너를 사용하여 응용프로그램을 쉽게 배포하고 실행할 수 있도록 설계된 컨테이너 기반의 오픈소스 가상화 플랫폼

다양한 프로그램, 실행환경을 컨테이너로 추상화하고 동일한 인터페이스를 제공하여 프로그램의 배포 및 관리를 단순하게 해줌

**컨테이너**   
코드와 모든 종속성을 패키지화하여 응용프로그램이 한 컴퓨팅 환경에서 다른 컴퓨팅 환경으로 빠르고 안정적으로 실행되도록 하는 소프트웨어의 표준 단위   
이미지의 인스턴스이며, 프로그램을 실행함   
소프트웨어를 환경으로부터 격리시켜 인프라에 관계없이 동일하게 작동

**이미지**   
코드, 런타임, 시스템 도구, 시스템 라이브러리 및 설정과 같은 응용프로그램을 실행하는 데 필요한 모든 것을 포함하는 독립적이며 실행 가능한 소프트웨어 패키지   
런타임에 컨테이너로 생성됨

### VM과의 차이점
![docker-vm](https://user-images.githubusercontent.com/68456385/125197068-3f9b1800-e297-11eb-912a-1cc89b7a36fa.PNG)

**하이퍼바이저**   
호스트 시스템에서 다수의 게스트 OS를 구동할 수 있게 하는 소프트웨어   
하드웨어를 가상화하면서 하드웨어와 각각의 VM을 모니터링하는 중간 관리자

컨테이너는 하이퍼바이저와 게스트 OS가 필요하지 않으므로 더 가벼움

어플리케이션을 실행할 때 컨테이너 방식에서는 호스트 OS위에 어플리케이션의 실행 패키지인 이미지를 배포하기만 하면 되지만,    
VM에서 어플리케이션을 실행하기 위해선 VM을 띄우고 자원을 할당한 다음, 게스트 OS를 부팅하여 어플리케이션을 실행해야 해서 훨씬 복잡하고 무거움

### 컨테이너 격리
리눅스에서 쓰이는 Cgroup(Control group)과 namespace 이용   
-> 컨테이너와 호스트에서 실행되는 다른 프로세스 사이에 벽을 만드는 리눅스 커널 기능

이를 위해 도커를 설치하면 리눅스 VM이 설치되고, 그 위에서 도커가 작동됨

### 컨테이너 생성
이미지 안에는 컨테이너가 시작될 때 실행되는 명령어와 파일 스냅샷(실행하는 데 필요한 파일을 카피한 것)이 존재

1. 도커 이미지 실행(컨테이너 생성 및 실행)
    ```
    docker run <이미지>
    ```
    도커 클라이언트에 명령어 입력 후 도커 서버로 보냄   
    이미지가 로컬 이미지 캐시 보관 장소에 없다면 도커 허브에서 가져옴

2. 이미지에 있는 파일 스냅샷을 컨테이너 하드 디스크에 옮김

3. 이미지에 있는 명령어를 이용해서 프로그램 실행

![화면 캡처 2021-07-12 000234](https://user-images.githubusercontent.com/68456385/125200130-82afb800-e2a4-11eb-87d5-9eafbd142543.png)


## 2. 도커 클라이언트 명령어
도커 클라이언트에 명령어를 입력하면 도커 서버로 보내짐

docker - 도커 클라이언트 언급
### 도커 이미지 내부 파일 구조 보기
```
docker run <이미지 id/이름> ls
```
이미지 이름 뒤에 추가 커맨드를 입력하면, 이미지가 가지고 있는 시작 명령어를 무시하고 뒤에 있는 커맨드 실행

** 이미지 파일 스냅샷에 실행가능한 ls 파일이 있어야 함

### 이미지 나열
```
docker images
```

### 실행 중인 컨테이너 나열
```
docker ps
```
컨테이너도 하나의 프로세스!

- COMMAND: 컨테이너 시작 시 실행될 명령어   
- STATUS: Up - 실행 중, Exited - 종료, Pause - 중지   
- PORTS: 컨테이너가 개방한 포트와 호스트에 연결한 포트   
- NAMES: 컨테이너의 고유한 이름. 컨테이너 생성 시 --name 옵션으로 설정 가능   
\+ docker rename original-name changed-name으로 재설정 가능

### 모든 컨테이너 나열
```
docker ps -a
```

### 도커 컨테이너 생명주기
![캡처](https://user-images.githubusercontent.com/68456385/126862887-f9f4a048-cf58-4029-a862-4b270d0ddb33.PNG)

### 컨테이너 중지
\* docker run alpine ping localhost로 실행시켜 놓고 테스트

1. Stop

Gracefully하게 중지   
하고 있던 작업이 모두 끝나면 중지
```
docker stop <컨테이너 id/이름>
```

2. Kill

바로 중지
```
docker kill <컨테이너 id/이름>
```

### 컨테이너 삭제
```
docker rm <컨테이너 id/이름>
```
중지된 컨테이너만 삭제 가능

### 모든 컨테이너 삭제
```
docker rm $(docker ps -a -q)
```

### 이미지 삭제
```
docker rmi <이미지 id>
```
여러개 삭제 가능

### 모든 이미지 삭제
```
docker rmi $(docker images -q)
```

### 컨테이너, 이미지, 네트워크, 빌드 캐시 삭제
```
docker system prune
```
실행 중인 컨테이너의 시스템만 삭제됨

### 실행 중인 컨테이너에 명령어 전달
```
docker exec <컨테이너 id> <명령어>
```

### Redis 실행
1. Redis 서버 실행
```
docker run redis
```
2. Redis 클라이언트 실행
```
redis-cli
```
3. Redis 명령어 입력
```
set key1 hello
```
클라이언트에서 입력한 명령어가 서버로 전달

But, redis 서버는 컨테이너 안에서 실행되고 있기 때문에 컨테이너 밖에서 클라이언트를 실행할 수 없음   
-> 클라이언트도 컨테이너 안에서 실행시켜야됨 => exec 명령어 사용
```
docker exec -it <컨테이너 id> redis-cli
```
\* -it: interactive terminal. 명령어를 실행한 후 이어서 명령어를 작성할 수 있음. -it가 없으면 명령어를 실행하고 밖으로 나와버림

### 컨테이너를 쉘 환경으로 접근
```
docker exec -it <컨테이너 id> sh
```
매번 exec 명령어를 작성하지 않아도 됨

터미널 종료는 ctrl + d

## 3. 도커 이미지 만들기
### 도커 이미지 생성 과정
![캡처](https://user-images.githubusercontent.com/68456385/127467823-1393ddaa-573d-4844-b054-9396b6616590.PNG)

### Dockerfile 작성 순서
1. 베이스 이미지 명시(파일 스냅샷)   
FROM <이미지 이름>:<태그>   
태그가 없으면 최신 버전 사용   
latest - 최신 버전
2. 추가적으로 필요한 파일을 다운 받기 위한 명령어 명시(파일 스냅샷)   
RUN <쉘 명령어>
3. 컨테이너 시작 시 실행될 명령어 명시   
CMD [<실행 파일 또는 쉘 스크립트>]   
CMD를 여러번 작성할 순 있지만, 가장 마지막에 작성된 CMD만 실행됨

![캡처](https://user-images.githubusercontent.com/68456385/127468594-6b58b43d-ad08-465d-9187-561900473c59.PNG)

### 이미지 생성
```
docker build ./
또는
docker build .
```
현재 디렉토리 내에서 Dockerfile을 찾아서 도커 클라이언트에 전달

1. 베이스 이미지 불러옴
2. 베이스 이미지를 바탕으로 임시 컨테이너 생성
3. 임시 컨테이너에 파일 스냅샷, 실행할 명령어를 추가
4. 임시 컨테이너로 새로운 이미지 생성
5. 임시 컨테이너 삭제

![캡처](https://user-images.githubusercontent.com/68456385/127471637-3be9b512-2a9b-4b49-80e0-704ddf0ddc24.PNG)

이미지에 이름 주기
```
docker build -t <도커 id>/<이름>:<태그> .
```

## 4. 도커를 이용하여 Node.js 앱 만들기
### Dockerfile
```Dockerfile
# npm이 들어있는 베이스 이미지
FROM node:10

# package.json에 있는 Node.js 모듈(dependency) 설치
RUN npm install

CMD ["node", "index.js"]
```
-> docker build   
-> npm install 에러   
=> package.json이 임시 컨테이너에 없기 때문에 발생

-> COPY 이용   
COPY <복사할 로컬 파일 경로> <컨테이너에서 파일이 복사될 경로>
```Dockerfile
# npm이 들어있는 베이스 이미지
FROM node:10

COPY package.json ./

# package.json에 있는 Node.js 모듈(dependency) 설치
RUN npm install

CMD ["node", "index.js"]
```
-> docker run   
-> node index.js 에러   
=> index.js가 컨테이너에 없기 때문에 발생

-> COPY로 디렉토리 내 모든 파일 복사
```Dockerfile
# npm이 들어있는 베이스 이미지
FROM node:10

# 디렉토리 내 모든 파일 복사
COPY ./ ./

# package.json에 있는 Node.js 모듈(dependency) 설치
RUN npm install

CMD ["node", "index.js"]
```
웹 서버가 정상적으로 실행되지만 페이지 접속이 되지 않음   
-> 포트 매핑 필요

```
docker run -p <브라우저에서 접속할 포트번호>:<컨테이너에서 연결할 포트번호> <이미지 id/이름>
```

### Working Directory 명시
docker run ~ ls 명령어를 입력해보면 root 디렉토리에 copy한 파일들이 복사된 것을 확인할 수 있음   
-> 만약 원래 이미지에 있던 파일과 이름이 같다면 기존 파일이 덮어씌워짐   
-> 어플리케이션을 위한 파일들은 work 디렉토리를 따로 만들어서 보관  

```Dockerfile
# npm이 들어있는 베이스 이미지
FROM node:10

# Work 디렉토리 생성
WORKDIR /usr/src/app

# 디렉토리 내 모든 파일 복사
COPY ./ ./

# package.json에 있는 Node.js 모듈(dependency) 설치
RUN npm install

CMD ["node", "index.js"]
```

### 애플리케이션 소스 변경
컨테이너 백그라운드로 실행
```
docker run -d <이미지 id/이름>
```

Dockerfile의 각 명령어는 파일 변경이 없다면 캐시를 이용하여 빠르게 실행됨   
만약 소스 파일이 변경되면 바뀐 소스 파일로 명령어를 실행하여 이미지를 다시 만들고 실행해야됨   

COPY ./ ./   
-> 소스 코드가 하나라도 변경되면 캐시를 사용하지 않고 명령어를 다시 실행하여 변경된 파일 복사   
-> RUN npm install 명령어도 다시 실행   
-> node_module에 있는 종속성들까지 다시 다운

```Dockerfile
# npm이 들어있는 베이스 이미지
FROM node:10

# Work 디렉토리 생성
WORKDIR /usr/src/app

COPY package.json ./

# package.json에 있는 Node.js 모듈(dependency) 설치
RUN npm install

# 디렉토리 내 모든 파일 복사
COPY ./ ./

CMD ["node", "index.js"]
```
-> package.json은 변경이 없기 때문에 첫번째 COPY와 RUN 명령어가 캐시를 이용하여 실행되고, 
그 다음 명령어만 다시 실행됨

### Docker Volume
이미지를 빌드하지 않고 변경사항을 적용할 수는 없을까?

Volume 이용
![image](https://user-images.githubusercontent.com/68456385/128387894-c25a1c06-35e1-4adf-9c97-66e67128d3ea.png)
복사가 아닌 참조를 하기 때문에 변경사항이 바로 적용된다

```
mac: docker run -d -p 5000:8080 -v /usr/src/app/node_modules -v $(pwd):/usr/src/app <이미지 id/이름>
windows(cmd에서 해야됨): docker run -d -p 5000:8080 -v /usr/src/app/node_modules -v %cd%:/usr/src/app <이미지 id/이름>
```
- 첫번째 -v: 로컬 디렉토리에는 npm install을 하지 않아 node_modules가 없어 참조하지 않도록 함   
- 두번째 -v: 현재 경로에 있는 파일들을 : 뒤에 오는 컨테이너 경로에서 참조

=> 이미지를 새로 빌드하지 않고 다시 실행만 시켜주면 변경사항이 적용됨

모든 volume 삭제
```
docker volume rm $(docker volume ls -qf dangling=true)
```

## 5. Docker Compose
### Redis(Remote Dictionary Server)
- 메모리 기반의 키-값 구조 데이터 관리 시스템   
- 데이터를 빠르게 조회할 수 있는 비관계형 데이터베이스(NoSQL)   
- 메모리에 데이터를 저장하기 때문에 데이터를 불러올 때 빠르게 처리 가능   
- 메모리에 저장하지만 서버를 재부팅해도 데이터를 영속적으로 보관 가능   

Redis 서버 이미지와 node.js 애플리케이션 이미지를 각각 실행시켜보면 에러가 발생함

![캡처](https://user-images.githubusercontent.com/68456385/129476593-43c775a8-1cdf-41bb-ae61-c9bd831ee58a.PNG)

컨테이너 간 통신 시 아무 설정 없이는 접근 불가   
-> Docker Compose 이용

### Docker Compose
다중 컨테이너 도커 애플리케이션을 정의하고 실행하기 위한 도구   
멀티 컨테이너 상황에서 네트워크를 쉽게 연결시켜줌

### Docker Compose 명령어
이미지가 존재하지 않는 경우에만 이미지를 빌드하고 컨테이너 시작
```
docker-compose up
```

항상 이미지를 새로 빌드하고 컨테이너 시작
```
docker-compose up --build
```

실행 중인 컨테이너들을 모두 중단
```
docker-compose down
```

컨테이너를 백그라운드에서 실행(detached 모드)
```
docker-compose up -d
```

이미지를 빌드만 하고 컨테이너를 시작하지는 않음
```
docker-compose build
```
## 6. 단일 컨테이너 앱 배포
### Dockerfile 분리
개발 환경 - Dockerfile.dev   
운영 환경 - Dockerfile

Dockerfile.dev로 빌드
```
docker build -f Dockerfile.dev .
```

\* 리액트 이미지를 run하려면 -it 옵션을 주어야 함

포트, 볼륨 등 설정을 하려면 명령어가 너무 김   
-> docker compose 이용

### 테스트
컨테이너에서 테스트 실행
```
docker run -it <이미지 이름> npm run test
```
-it: 결과를 더 보기 좋게 출력

### 운영 환경
웹서버를 왜 사용 하는가?

개발환경 서버는 소스코드를 변경하면 자동으로 전체 앱을 다시 빌드해주는 기능이 있기 때문에 이러한 기능이 없어 더 가벼운 Nginx와 같은 웹서버 사용

npm run build로 생성한 빌드 파일을 웹 브라우저의 요청에 따라 Nginx 서버가 응답으로 제공

1. 빌드 파일 생성(builder stage)
2. Nginx 가동(run stage)

컨테이너 실행
```
docker run -p 8080:80 <이미지 이름>
```
Nginx의 기본 포트는 80

### Travis CI
Github에서 진행되는 오픈소스 프로젝트를 위한 지속적인 통합(CI) 서비스   
프로젝트를 특정 이벤트에 따라 자동으로 테스트, 빌드, 배포해줌   
Private 레포지토리에 경우 유료

1. Github master 저장소에 소스 push
2. Travis CI가 업데이트된 소스를 가져와 테스트 코드 실행
3. 테스트가 성공하면 AWS와 같은 호스팅 사이트로 보내서 배포

https://docs.travis-ci.com/user/languages/minimal-and-generic/

### Elastic BeanStalk
웹 애플리케이션을 쉽게 배포하고 확장해주는 서비스   
EC2 인스턴스를 포함한 환경을 구성하여 소프트웨어를 업데이트 할 때마다 자동으로 환경 관리

![image](https://user-images.githubusercontent.com/68456385/131105518-fb4c73d4-32f2-418c-bfc6-a6008fc8a906.png)

트래픽이 많아지면 EC2 인스턴스가 추가되면서 로드밸런서로 관리됨   

Travis CI에서 가지고 있는 파일을 압축해서 EB안에 자동으로 생성된 S3로 보냄

소스 파일을 배포하기 위해선 secret key 필요

**IAM(Identity and Access Management)**   
AWS 리소스에 대한 액세스를 안전하게 제어할 수 있는 웹 서비스   
IAM을 사용하여 리소스를 사용하도록 인증 및 권한 부여된 대상을 제어   
Root 사용자(AWS 서비스 및 리소스에 대한 완전한 엑세스 권한 보유)가 부여한 권한만 가지고 있음   

AdministratorAccess-AWSElasticBeanstalk 부여   
AWS Secret ACCESS Key는 travis-ci 레포지토리 More options - Settings - Environment Variables에 저장

테스트 성공 후 전체 소스를 AWS에서 던져서 EB 안에서 따로 이미지를 만들고 컨테이너를 생성해서 앱을 실행함   
그때 EB는 플랫폼 설정을 docker로 해주어서 Dockerfile을 찾아서 이미지를 알아서 빌드해줌   
-> Dockerfile.dev가 아닌 Dockerfile로 배포됨

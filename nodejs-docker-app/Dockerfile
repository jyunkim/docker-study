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

# builder stage 명시
FROM node:alpine as builder

# 빌드한 파일은 /usr/src/app/build로 들어감
WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./

# CMD는 이미지를 빌드하고 컨테이너를 실행할 때 실행되기 때문에 가장 늦게 실행됨
# -> 아래 copy 명령어에서 build 디렉토리를 찾을 수 없다는 에러 발생
# CMD [ "npm", "run", "build" ]
RUN npm run build

FROM nginx

# 컨테이너에서 listen할 포트
EXPOSE 80

# 다른 stage에 있는 파일을 복사할 때 stage 이름을 명시해줘야 함
# /usr/share/nginx/html - Nginx가 제공하는 정적 파일 경로
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
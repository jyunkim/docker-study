# 베이스 이미지
# alpine - 가벼운 베이스 이미지
FROM alpine

# 추가적으로 필요한 파일 다운
# RUN ~

# 컨테이너 시작 시 실행될 명령어
CMD [ "echo", "hello" ]
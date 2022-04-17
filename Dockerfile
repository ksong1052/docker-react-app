FROM node:alpine as builder
WORKDIR /usr/src/app
COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# nginx는 80 포트를 이용합니다. 
# 실행시 문제가 생기면 build시에 받은 id를 이용해서 실행 시키자. 
# Successfully built e33f47948942 => docker run -p 8080:80 e33f47948942
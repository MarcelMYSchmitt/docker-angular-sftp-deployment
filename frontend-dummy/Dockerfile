FROM node:lts as prepare

WORKDIR /src
COPY package.json package-lock.json ./

FROM prepare as build

COPY . /src
RUN npm run build-release

FROM nginx:1.13-alpine as runtime

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /src/dist /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /run/nginx

CMD ["nginx", "-g", "daemon off;"]
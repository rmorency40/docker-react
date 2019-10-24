FROM node:alpine as builder
ENV   https_proxy=http://10.101.65.50:8080/
ENV   http_proxy=http://10.101.65.50:8080/

RUN mkdir -p '/app'
WORKDIR '/app'

COPY package.json /app/
RUN npm install

COPY . .
RUN npm run build

FROM nginx
EXPOSE 80

COPY --from=builder   /app/build /usr/share/nginx/html
CMD ["npm", "run", "start"]

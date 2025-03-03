FROM alpine:3.21

RUN apk update && apk add --no-cache nodejs npm

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 3002

CMD ["node", "app.js"]
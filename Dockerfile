FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git

RUN git clone https://github.com/tashfeenahmed/freellmapi.git .

RUN npm install

RUN cp .env.example .env && \
    node -e "console.log('ENCRYPTION_KEY=' + require('crypto').randomBytes(32).toString('hex'))" >> .env

RUN npm run build

EXPOSE 3000

CMD ["node", "server/dist/index.js"]

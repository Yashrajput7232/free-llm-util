FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git

# Clone repository
RUN git clone https://github.com/tashfeenahmed/freellmapi.git .

# Install dependencies
RUN npm install

# Generate .env and encryption key
RUN cp .env.example .env && \
    echo "ENCRYPTION_KEY=$(node -e \"console.log(require('crypto').randomBytes(32).toString('hex'))\")" >> .env

# Build application
RUN npm run build

EXPOSE 3000

CMD ["node", "server/dist/index.js"]

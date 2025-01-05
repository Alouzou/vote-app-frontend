FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build --prod

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist/vote-app /usr/share/nginx/html



RUN chmod -R 755 /usr/share/nginx/html

EXPOSE 4200

CMD ["nginx", "-g", "daemon off;"]
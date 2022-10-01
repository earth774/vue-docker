# develop stage
FROM node:16.17.1-alpine3.16 as develop-stage
WORKDIR /app
COPY package*.json ./
RUN yarn
COPY . .

# build stage
FROM develop-stage as build-stage
RUN yarn build

# production stage
FROM nginx:1.23.1-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
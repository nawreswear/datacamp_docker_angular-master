<<<<<<< HEAD
FROM node:12.7-alpine AS build

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

### STAGE 2: Run ###

FROM nginx:1.17.1-alpine

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build /usr/src/app/dist/aston-villa-app /usr/share/nginx/html
=======

>>>>>>> 4bcbf2b2ec2079475e805e7780f6ef4352449aa1

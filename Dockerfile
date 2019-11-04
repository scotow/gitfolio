## Node builder
FROM node:lts-alpine AS builder

COPY . /gitfolio
WORKDIR /gitfolio

RUN npm install
RUN node bin/gitfolio.js build scotow --sort star --order desc --theme dark --background 'https://images.unsplash.com/photo-1551895763-554bd1c491eb'

RUN mv /gitfolio/dist /html
RUN rm -rf /gitfolio

## Nginx web server
FROM nginx:alpine

COPY --from=builder /html /usr/share/nginx/html

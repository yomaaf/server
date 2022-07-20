FROM node:10.1.0-alpine

WORKDIR /app

COPY package.json /app/
COPY yarn.lock /app/

RUN yarn install --production && yarn cache clean

COPY . /app

ENV NODE_ENV production
CMD sed -i -e "s/default: '80'/default: '${PORT:-80}'/g" ./bin/server && node -r esm ./bin/server

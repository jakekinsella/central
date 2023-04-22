FROM node:16

WORKDIR /central/common/react/

ADD common/react/package.json .

RUN yarn install

ADD common/react/src/ src/
ADD common/react/tsconfig.json tsconfig.json
RUN yarn run build

WORKDIR /ui

ADD ui/package.json .
RUN yarn install

ADD ui/public/ public/
ADD ui/scripts/ scripts/
ADD ui/config/ config/
ADD ui/src/ src/
ADD ui/tsconfig.json tsconfig.json
RUN yarn run build

FROM nginx
COPY --from=0 /ui/build/ /usr/share/nginx/html/
COPY build/docker/ui/default.conf /etc/nginx/conf.d/default.conf

ENV PRODUCTION=1

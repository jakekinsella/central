FROM node:16

WORKDIR /central/common/react/

ADD common/react/package.json .

RUN yarn install

ADD common/react/src/ src/
ADD common/react/tsconfig.json tsconfig.json
RUN yarn run build

FROM node:14-alpine AS builder

ARG MAIN_DIR=graphbook
ARG SOURCE_CODE_URL=https://github.com/pSharpX/graphbook.git
ARG WORKPLACE_PATH=/opt/source

RUN apk update && \
    apk add git && \
    git clone ${SOURCE_CODE_URL} ${MAIN_DIR} && \
    mkdir ${WORKPLACE_PATH} && \ 
    mv ${MAIN_DIR} ${WORKPLACE_PATH}

WORKDIR ${WORKPLACE_PATH}/${MAIN_DIR}

RUN npm install && npm run server:build

FROM node:14-alpine

ARG MAIN_DIR=graphbook
ARG WORKPLACE_PATH=/opt/source
ARG APPLICATION_PATH=${WORKPLACE_PATH}/${MAIN_DIR}

LABEL edu.cibertec.votoelectronico.project.name="GraphBook" \
    edu.cibertec.votoelectronico.project.key="graphbook" \
    edu.cibertec.votoelectronico.project.version="1.0" \
    edu.cibertec.votoelectronico.project.description="Social Network Application" \
    edu.cibertec.votoelectronico.author.name="Christian Rivera" \
    edu.cibertec.votoelectronico.author.email="crivera2093@gmail.com" \
    edu.cibertec.votoelectronico.author.url="https://github.com/pSharpX"

RUN mkdir ${WORKPLACE_PATH} && mkdir ${APPLICATION_PATH}

COPY --from=builder ${APPLICATION_PATH}/dist/server ${APPLICATION_PATH}

WORKDIR ${APPLICATION_PATH}

CMD [ "npm", "run", "server:production" ]

FROM node:14-alpine AS builder

ARG SOURCE_CODE_URL=https://github.com/pSharpX/graphbook.git
ARG MAIN_DIR=graphbook
ARG WORKPLACE_PATH=/opt/source

WORKDIR ${WORKPLACE_PATH}

RUN apk update && \
    apk add git && \
    git clone ${SOURCE_CODE_URL} ${MAIN_DIR}

WORKDIR ${WORKPLACE_PATH}/${MAIN_DIR}

RUN npm install && npm run server:build

FROM node:14-alpine

ARG MAIN_DIR=graphbook
ARG WORKPLACE_PATH=/opt/source

LABEL edu.cibertec.votoelectronico.project.name="GraphBook" \
    edu.cibertec.votoelectronico.project.key="graphbook" \
    edu.cibertec.votoelectronico.project.version="1.0" \
    edu.cibertec.votoelectronico.project.description="Social Network Application" \
    edu.cibertec.votoelectronico.author.name="Christian Rivera" \
    edu.cibertec.votoelectronico.author.email="crivera2093@gmail.com" \
    edu.cibertec.votoelectronico.author.url="https://github.com/pSharpX"

WORKDIR ${WORKPLACE_PATH}/${MAIN_DIR}

COPY --from=builder ${WORKPLACE_PATH}/${MAIN_DIR}/package.json package.json
COPY --from=builder ${WORKPLACE_PATH}/${MAIN_DIR}/dist dist

RUN npm install --only=production

EXPOSE 8000
CMD [ "npm", "run", "server:production" ]

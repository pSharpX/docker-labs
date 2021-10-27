FROM node:14-alpine AS builder

ARG ENV=production
ARG MAIN_DIR=graphbook
ARG WORKPLACE_PATH=/opt/source

WORKDIR ${WORKPLACE_PATH}

RUN apk update && \
    apk add git && \
    git clone https://github.com/pSharpX/graphbook.git ${MAIN_DIR}

WORKDIR ${WORKPLACE_PATH}/${MAIN_DIR}

FROM node:14-alpine

ARG ENV=production
ARG MAIN_DIR=graphbook
ARG WORKPLACE_PATH=/opt/source

ENV NODE_ENV ${ENV}
ENV USERNAME YOUR_USERNAME
ENV PASSWORD YOUR_PASSWORD
ENV DATABASE YOUR_DATABASE
ENV HOST YOUR_HOST

LABEL edu.cibertec.votoelectronico.project.name="GraphBook" \
    edu.cibertec.votoelectronico.project.key="graphbook" \
    edu.cibertec.votoelectronico.project.version="1.0" \
    edu.cibertec.votoelectronico.project.description="Social Network Application" \
    edu.cibertec.votoelectronico.author.name="Christian Rivera" \
    edu.cibertec.votoelectronico.author.email="crivera2093@gmail.com" \
    edu.cibertec.votoelectronico.author.url="https://github.com/pSharpX"

WORKDIR ${WORKPLACE_PATH}/${MAIN_DIR}

COPY --from=builder ${WORKPLACE_PATH}/${MAIN_DIR}/.babelrc ./
COPY --from=builder ${WORKPLACE_PATH}/${MAIN_DIR}/package*.json ./
COPY --from=builder ${WORKPLACE_PATH}/${MAIN_DIR}/webpack.server.build.config.js ./
COPY --from=builder ${WORKPLACE_PATH}/${MAIN_DIR}/webpack.client.build.config.js ./
COPY --from=builder ${WORKPLACE_PATH}/${MAIN_DIR}/src src

RUN ["npm", "install"]
RUN ["npm", "install", "-g" ,"mysql2", "sequelize", "sequelize-cli"]

CMD [ "sequelize", "db:migrate", "--migrations-path", "src/server/migrations", "--config", "src/server/config/index.js", "--env", "$NODE_ENV" ] 

FROM node:14-alpine AS builder

ARG ENV=production
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

LABEL edu.cibertec.graphbook.project.name="GraphBook" \
    edu.cibertec.graphbook.project.key="graphbook" \
    edu.cibertec.graphbook.project.version="1.0" \
    edu.cibertec.graphbook.project.description="Social Network Application" \
    edu.cibertec.graphbook.author.name="Christian Rivera" \
    edu.cibertec.graphbook.author.email="crivera2093@gmail.com" \
    edu.cibertec.graphbook.author.url="https://github.com/pSharpX"

WORKDIR ${WORKPLACE_PATH}/${MAIN_DIR}

COPY env_secrets_expand.sh env_secrets_expand.sh
COPY entrypoint.sh entrypoint.sh
COPY --from=builder ${WORKPLACE_PATH}/${MAIN_DIR}/package.json package.json
COPY --from=builder ${WORKPLACE_PATH}/${MAIN_DIR}/dist dist

#RUN npm install --only=production
##TODO: change to --only=production when fixing application production building.
RUN chmod +x env_secrets_expand.sh entrypoint.sh
RUN npm install

EXPOSE 8000
#CMD [ "npm", "run", "server:production" ]
ENTRYPOINT [ "./entrypoint.sh" ] 

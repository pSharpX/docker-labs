FROM maven:3.8.3-jdk-8 AS builder

ARG MAIN_DIR=EmisionVotosApi
ARG SOURCE_CODE_URL=https://github.com/pSharpX/EmisionVotosApi.git
ARG WORKPLACE_PATH=/opt/source

RUN git clone ${SOURCE_CODE_URL} ${MAIN_DIR} && \
    mkdir ${WORKPLACE_PATH} && \ 
    mv ${MAIN_DIR} ${WORKPLACE_PATH}

WORKDIR ${WORKPLACE_PATH}/${MAIN_DIR}

RUN mvn clean install

FROM jboss/wildfly:latest

ARG MAIN_DIR=EmisionVotosApi
ARG WORKPLACE_PATH=/opt/source
ARG APPLICATION_PATH=${WORKPLACE_PATH}/${MAIN_DIR}/EmisionVoto_Api/target/EmisionVoto_Api-1.0-SNAPSHOT.war

LABEL edu.cibertec.votoelectronico.project.name="EmisionVotos" \
    edu.cibertec.votoelectronico.project.key="votoelectronico" \
    edu.cibertec.votoelectronico.project.version="1.0" \
    edu.cibertec.votoelectronico.project.description="EmisionVotos Application" \
    edu.cibertec.votoelectronico.author.name="Christian Rivera" \
    edu.cibertec.votoelectronico.author.email="crivera2093@gmail.com" \
    edu.cibertec.votoelectronico.author.url="https://github.com/pSharpX"

COPY --from=builder ${APPLICATION_PATH} /opt/jboss/wildfly/standalone/deployments/

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
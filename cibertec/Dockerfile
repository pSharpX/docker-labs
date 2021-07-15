############################################################
# Dockerfile to build Wildfly container images
# Based on Official JBoss Wildfly Image
############################################################

# Set the base image to Ubuntu
FROM jboss/wildfly:latest

# File Author / Maintainer
MAINTAINER Christian Rivera <crivera2093@gmail.com>

# The LABEL instruction adds metadata to an image. A LABEL is a key-value
# pair. To include spaces within a LABEL value, use quotes and blackslashes
# as you would in command-line parsing.
# LABEL <key>=<value> <key>=<value> <key>=<value> ...
LABEL edu.cibertec.votoelectronico.project.name="EmisionVotos"
LABEL edu.cibertec.votoelectronico.project.key="votoelectronico"
LABEL edu.cibertec.votoelectronico.project.version="1.0"
LABEL edu.cibertec.votoelectronico.project.description="EmisionVotos Application"
LABEL edu.cibertec.votoelectronico.author.name="Christian Rivera"
LABEL edu.cibertec.votoelectronico.author.email="crivera2093@gmail.com"
LABEL edu.cibertec.votoelectronico.author.url="https://github.com/pSharpX"

# The VOLUME instruction creates a mount point with the specified name and
# marks it as holding externally mounted volumes from native host or other
# containers. The value can be a JSON array, VOLUME ["/var/log/"], or a plain
# string with multiple arguments, such as VOLUME /var/log or VOLUME /var/log
# /var/db.
# VOLUME [ "/opt/wildfly/standalone/log" ]

# Expose the default port
# Expose ports.
#   - 27017: process
# EXPOSE 8080
# EXPOSE 9990

RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#17815 --silent

# COPY <src>... <dest>
# COPY your-awesome-app.war /opt/jboss/wildfly/standalone/deployments/
# COPY your-awesome-app.war /opt/jboss/wildfly/domain/deployments/
COPY /data/app/deploy/EmisionVoto_Api-1.0-SNAPSHOT.war /opt/jboss/wildfly/standalone/deployments/

# ADD your-awesome-app.war /opt/jboss/wildfly/standalone/deployments/

# WORKDIR <path>
# WORKDIR /path

# To boot in standalone mode with admin console available remotely
# CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
# To boot in domain mode
# CMD ["/opt/jboss/wildfly/bin/domain.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
# CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
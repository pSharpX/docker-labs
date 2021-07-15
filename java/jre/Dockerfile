############################################################
# Dockerfile to build Java container images
# Based on Official CentOS Image
############################################################

# Set the base image to Ubuntu
FROM centos:latest

# File Author / Maintainer
MAINTAINER Christian Rivera <crivera2093@gmail.com>

# The LABEL instruction adds metadata to an image. A LABEL is a key-value
# pair. To include spaces within a LABEL value, use quotes and blackslashes
# as you would in command-line parsing.
# LABEL <key>=<value> <key>=<value> <key>=<value> ...
LABEL author.name="Christian Rivera"
LABEL author.email="crivera2093@gmail.com"

# The VOLUME instruction creates a mount point with the specified name and
# marks it as holding externally mounted volumes from native host or other
# containers. The value can be a JSON array, VOLUME ["/var/log/"], or a plain
# string with multiple arguments, such as VOLUME /var/log or VOLUME /var/log
# /var/db.
VOLUME [ "/tmp" ]

# The ENV instruction sets the environment variable <key> to the value
# <value>. This value will be in the environment of all "descendent"
# Dockerfile commands and can be replaced inline in many as well.
ENV JAVA_OPTS ""

# Expose the default port
# Expose ports.
#   - 27017: process

RUN yum update -y && \
    yum install -y java-1.8.0-openjdk && \
    yum clean all

# COPY <src>... <dest>

# ADD <src>... <dest>
ADD /app/EmisionVoto_Client-1.0-SNAPSHOT.jar /EmisionVoto_Client-1.0-SNAPSHOT.jar

# WORKDIR <path>
# WORKDIR /path

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /EmisionVoto_Client-1.0-SNAPSHOT.jar" ]
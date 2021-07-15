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

ARG JAVA_VER=8
ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/root"

# The ENV instruction sets the environment variable <key> to the value
# <value>. This value will be in the environment of all "descendent"
# Dockerfile commands and can be replaced inline in many as well.
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.151-5.b12.el7_4.x86_64/bin
ENV MVN_HOME /usr/share/maven
ENV M2_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"

# Expose the default port
# Expose ports.
#   - 27017: process

RUN yum update -y && \
    yum install -y java-1.8.0-openjdk-devel && \
    yum clean all
RUN mkdir -p /usr/share/maven && mkdir /usr/src/app
RUN curl -fsSL https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# The VOLUME instruction creates a mount point with the specified name and
# marks it as holding externally mounted volumes from native host or other
# containers. The value can be a JSON array, VOLUME ["/var/log/"], or a plain
# string with multiple arguments, such as VOLUME /var/log or VOLUME /var/log
# /var/db.
VOLUME [ "/usr/src/app", "/root/.m2" ]

# COPY <src>... <dest>

# ADD <src>... <dest>

# WORKDIR <path>
# WORKDIR /path
WORKDIR /usr/src/app

ENTRYPOINT ["/usr/bin/mvn"]
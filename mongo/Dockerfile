############################################################
# Dockerfile to build MongoDB container images
# Based on Official Mongo Image
############################################################

# Set the base image to Ubuntu
FROM mongo:latest

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
VOLUME [ "/data/db" ]

# The ENV instruction sets the environment variable <key> to the value
# <value>. This value will be in the environment of all "descendent"
# Dockerfile commands and can be replaced inline in many as well.
ENV MONGO_INITDB_ROOT_USERNAME "admin"
ENV MONGO_INITDB_ROOT_PASSWORD "\$admin123.a"
ENV MONGO_INITDB_DATABASE "admin"

# Expose the default port
# Expose ports.
#   - 27017: process
EXPOSE 27017

# COPY <src>... <dest>
# COPY mysetup.sh /docker-entrypoint-initdb.d/
COPY /startup/createUser.js /docker-entrypoint-initdb.d/
COPY /startup/createusers.sh /docker-entrypoint-initdb.d/
COPY /startup/databaseSeed.sh /docker-entrypoint-initdb.d/

# WORKDIR <path>
# WORKDIR /path

# Default port to execute the entrypoint (MongoDB)
# CMD ["--port 27017"]
# CMD ["--port 27017", "--smallfiles"]
# CMD ["--bind_ip_all"]
CMD ["--auth"]
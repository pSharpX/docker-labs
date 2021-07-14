# The Base Image used to create this Image
FROM httpd:latest

LABEL author.name="Christian Rivera"
LABEL author.email="crivera2093@gmail.com"

COPY ./public-html/ /usr/local/apache2/htdocs/
COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf

# This is the Additional Directory where we are going to keep our Virtualhost configuraiton files
# You can use the image to create N number of different virtual hosts
RUN mkdir -p /usr/local/apache2/conf/sites/

# To tell docker to expose this port
EXPOSE 80
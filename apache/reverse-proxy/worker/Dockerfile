# The Base Image used to create this Image
FROM php:7.2-apache

LABEL author.name="Christian Rivera"
LABEL author.email="crivera2093@gmail.com"

COPY src/ /var/www/html/

# Execute a2enmod in order to enable rewrite URL. 
RUN a2enmod rewrite

# To tell docker to expose this port
EXPOSE 80
FROM ubuntu:20.04
# bc newer ubuntu asks for timezone info
ENV TZ=US/Pacific
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y apache2 apache2-utils curl vim
WORKDIR /etc/apache2

RUN a2enmod autoindex
RUN a2enmod alias
RUN a2enmod ssl

# create dir for each site, copy index.html in, setup vhost files
RUN mkdir /var/www/html/site1
COPY site1.html /var/www/html/site1/index.html
COPY site1.conf /etc/apache2/sites-available

# certs
COPY site1.internal.cert /etc/ssl/certs
COPY site1.internal.key /etc/ssl/private

# enable the sites
RUN a2ensite site1.conf

LABEL maintainer="monica.luong.234@my.csun.edu"
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

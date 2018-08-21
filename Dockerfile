FROM ubuntu:16.04

ENV URL=URL
ENV EMAIL=s.hols@erasmusmc.nl 

RUN apt-get update -y && apt-get upgrade -y && apt-get autoremove -y
RUN apt install gdebi-core -y
RUN apt-get install software-properties-common -y && add-apt-repository ppa:certbot/certbot -y && apt-get update 
RUN apt-get install r-base gdebi-core -y && apt-get install wget -y

RUN apt-get install apache2 -y && a2enmod rewrite && service apache2 restart
RUN apt-get install libxml2-dev -y && a2enmod proxy && a2enmod proxy_http && a2enmod proxy_wstunnel && service apache2 restart

WORKDIR /downloads

RUN wget https://download2.rstudio.org/rstudio-server-1.1.456-amd64.deb
RUN gdebi rstudio-server-1.1.456-amd64.deb

WORKDIR /home

RUN useradd -p rstudio rstudio

COPY rstudio.conf /etc/apache2/sites-available
RUN a2ensite rstudio.conf && service apache2 restart

RUN apt-get install python-certbot-apache -y

#RUN ${EMAIL} | A | N | 2 | certbot --apache

#CMD ${EMAIL} | A | N | 2 | certbot --apache && 
CMD  apachectl -D FOREGROUND
EXPOSE 80
EXPOSE 443
EXPOSE 8787

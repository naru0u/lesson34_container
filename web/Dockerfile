FROM ubuntu:22.04
RUN mkdir /command_tutorial
RUN touch /command_tutorial/firstvi.txt
RUN apt-get update
RUN apt -y install vim
RUN apt -y install language-pack-ja
RUN update-locale LANG=ja_JP.utf8
ENV LANG ja_JP.utf8
RUN DEBIAN_FRONTEND=noninteractive apt -y install tzdata
RUN echo 'Asia/Tokyo' > /etc/timezone
ENV TZ Asia/Tokyo
RUN apt -y install apache2
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2ensite default-ssl
RUN sed -i -e "s/^<\/VirtualHost>/RewriteEngine on/" /etc/apache2/sites-available/000-default.conf
RUN echo 'RewriteCond %{HTTPS} off' >> /etc/apache2/sites-available/000-default.conf
RUN echo 'RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L]' >> /etc/apache2/sites-available/000-default.conf
RUN echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf
EXPOSE 80
EXPOSE 443
RUN apt -y install wget apt-transport-https gnupg
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add -
RUN echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
RUN apt update
RUN apt -y install temurin-17-jdk=17.0.5.0.0+8
RUN mkdir /var/www/java
COPY DailyReportSystemApplication-0.0.1-SNAPSHOT.jar /var/www/java/
RUN a2enmod proxy
RUN a2enmod proxy_ajp
RUN echo "ProxyPass / ajp://localhost:8009/" >> /etc/apache2/apache2.conf
RUN apt -y install sudo
RUN useradd -s /bin/bash -G sudo -m myuser
RUN echo "myuser:mypass" | chpasswd
RUN echo "root:rootpass" | chpasswd
COPY startup.sh /startup.sh
RUN chmod 744 /startup.sh
CMD /startup.sh
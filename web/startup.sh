#!/bin/bash

# Spring Bootアプリケーションの起動
java -jar /var/www/java/DailyReportSystemApplication-0.0.1-SNAPSHOT.jar &

# Apache2の起動
rm -f /ver/run/apache2/apache2.pid
apachectl -D FOREGROUND
FROM bazaglia/nginx-php:latest

RUN apk add --update xvfb ttf-freefont fontconfig dbus \
      && apk add qt5-qtbase-dev wkhtmltopdf --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
      && mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin \
      && echo $'#!/usr/bin/env sh\n\
  Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \n\
  DISPLAY=:0.0 wkhtmltopdf-origin $@ \n\
  killall Xvfb\
  ' > /usr/bin/wkhtmltopdf && \
      chmod +x /usr/bin/wkhtmltopdf \
      && mv /usr/bin/wkhtmltoimage /usr/bin/wkhtmltoimage-origin \
      && echo $'#!/usr/bin/env sh\n\
  Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \n\
  DISPLAY=:0.0 wkhtmltoimage-origin $@ \n\
  killall Xvfb\
  ' > /usr/bin/wkhtmltoimage && \
      chmod +x /usr/bin/wkhtmltoimage \
    && rm -rf /var/cache/apk/*
    
COPY files /
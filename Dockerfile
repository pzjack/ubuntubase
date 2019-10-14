FROM ubuntu:xenial
  
ENV DISPLAY=:1 \
    VNC_PORT=5901

EXPOSE $VNC_PORT


ENV VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1024x768 \
    VNC_PW=12345678

RUN  apt-get update \
  && apt-get install -y vim wget net-tools locales bzip2 \
  && apt-get clean -y

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
RUN apt-get install -y ttf-wqy-zenhei

RUN wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.8.0.x86_64.tar.gz | tar xz --strip 1 -C /


RUN apt-get install -y supervisor xfce4 xfce4-terminal xterm \
 && apt-get purge -y pm-utils xscreensaver* \
 && apt-get clean -y

ADD start.sh /
RUN chmod a+x /start.sh

ENTRYPOINT ["/start.sh"]

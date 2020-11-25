FROM centos:7
MAINTAINER chrichen
RUN rm -rf /etc/yum.repos.d/*.repo
ADD CentOS-Base.repo /etc/yum.repos.d
RUN yum install -y git && yum clean all
RUN yum install -y wget && yum clean all

## Installing TigerVNC
RUN wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.8.0.x86_64.tar.gz | tar xz --strip 1 -C /

RUN yum install -y deltarpm
RUN yum groupinstall -y "GNOME Desktop" "Graphical Administration Tools"
RUN systemctl set-default graphical.target
RUN cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service

## Changing VNC password
RUN mkdir $HOME/.vnc
RUN echo "vncpassword" | vncpasswd -f >> $HOME/.vnc/passwd
RUN chmod 600 $HOME/.vnc/passwd

## Clean old vnc locks
RUN vncserver -kil :1 || rm -rfv /tmp/.X*-lock /tmp/.X11-unix

## Run vncserver
RUN vncserver :1 -depth 24 -geometry 1280x1024

CMD ["--wait"]

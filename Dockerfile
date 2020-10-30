FROM yeyiyi/centos7-systemd:latest
MAINTAINER chrichen
USER root
ADD init.sh /opt/
RUN chmod +x /opt/init.sh
#RUN rm -rf /etc/yum.repos.d/*.repo
#ADD CentOS-Base.repo /etc/yum.repos.d
RUN ln -sf /usr/share/zoneinfo/Hongkong /etc/localtime
RUN yum update
RUN yum install -y git && yum clean all
RUN yum install -y tigervnc-server && yum clean all
RUN yum install -y deltarpm
RUN yum groupinstall -y "GNOME Desktop" "Graphical Administration Tools"
RUN cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
RUN sed -i 's/\/home\/<USER>/\/root/g' /etc/systemd/system/vncserver@:1.service
RUN sed -i 's/<USER>/root/g' /etc/systemd/system/vncserver@:1.service
RUN sed -i 's/800x600/1920x1080/g' /usr/bin/vncserver
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/home/init.sh"]

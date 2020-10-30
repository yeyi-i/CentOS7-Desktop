FROM centos:7
MAINTAINER chrichen
USER 0
RUN ADD init.sh /opt/
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
EXPOSE 5901 5902 5903 5904 5905 5906 5907 5908 5909 5910
VOLUME [ "/sys/fs/cgroup" ]
ENTRYPOINT ["/usr/sbin/init"]
CMD ["/home/init.sh"]

FROM centos:7
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN echo "root" | passwd --stdin root

ADD rootfs/etc /etc
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN mv /etc/yum.repos.d/centos7_base.repo.aliyun /etc/yum.repos.d/CentOS-Base.repo
#RUN mv /etc/yum.repos.d/centos7_base.repo.tencent /etc/yum.repos.d/CentOS-Base.repo

#RUN yum install -y wget
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.cloud.tencent.com/repo/centos7_base.repo

RUN yum clean all && yum makecache
RUN yum install -y openssl openssh* net-tools wget git jq lrzsz zsh libevent-devel ncurses-devel

ADD rootfs/usr /usr
RUN chmod a+x /usr/local/src/install.sh && sh -c "echo Y | /usr/local/src/install.sh"
#RUN git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
#RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

RUN rpm -ivh /usr/local/src/tmux-2.5-8.2.x86_64.rpm
RUN chsh -s /usr/bin/tmux
ADD rootfs/root /root

#RUN systemctl enable sshd.service && systemctl start sshd.service && systemctl status sshd.service

EXPOSE 22 80 81 82 83 84 85 86 87 88 89

VOLUME [ "/sys/fs/cgroup" ]
ENTRYPOINT ["/usr/sbin/init"]
#CMD ["/usr/sbin/init"]

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

################### yum
#RUN mv /etc/yum.repos.d/centos7_base.repo.aliyun /etc/yum.repos.d/CentOS-Base.repo
#RUN mv /etc/yum.repos.d/centos7_base.repo.tencent /etc/yum.repos.d/CentOS-Base.repo
#RUN mv /etc/yum.repos.d/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo
#RUN mv /etc/yum.repos.d/CentOS-7-anon.repo.huawei /etc/yum.repos.d/CentOS-Base.repo
#RUN mv /etc/yum.repos.d/CentOS7-Base.repo.yunidc /etc/yum.repos.d/CentOS-Base.repo

#RUN yum install -y wget
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.cloud.tencent.com/repo/centos7_base.repo
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.huaweicloud.com/repository/conf/CentOS-7-anon.repo
ADD rootfs/etc /etc
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
	&& mv /etc/yum.repos.d/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo \
	&& yum clean all && yum makecache \
	&& yum install -y openssl openssh* net-tools wget git jq lrzsz zsh libevent-devel ncurses-devel

################### soft package
ADD rootfs/usr /usr

#### docker
#### If there is a network problem,Manually download and save to /usr/local/src/docker-19.03.13.tgz
RUN set -xe \
	&& cd /tmp \
	&& wget https://download.docker.com/linux/static/stable/x86_64/docker-19.03.13.tgz \
	&& tar --extract \
		--file /usr/local/src/docker-19.03.13.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
	&& docker --version \
#### oh-my-zsh
	&& chmod a+x /usr/local/src/install.sh \
	&& sh -c "echo Y | /usr/local/src/install.sh" \
	&& tar --extract \
		--file /usr/local/src/plugins.tar.gz \
		--directory /root/.oh-my-zsh/custom/ \
#### tmux
	&& rpm -ivh /usr/local/src/tmux-2.5-8.2.x86_64.rpm \
	&& chsh -s /usr/bin/tmux \
	&& rm -rf /tmp/*

ADD rootfs/root /root

#RUN systemctl enable sshd.service && systemctl start sshd.service && systemctl status sshd.service

EXPOSE 22 80 81 82 83 84 85 86 87 88 89

ENV DOCKER_HOST unix:///tmp/docker.sock

VOLUME [ "/sys/fs/cgroup" ]
ENTRYPOINT ["/usr/sbin/init"]
#CMD ["/usr/sbin/init"]

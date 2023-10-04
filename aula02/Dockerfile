FROM oraclelinux:7-slim

# openconnect & dependencies
COPY extra/ol7_developer_EPEL.repo /etc/yum.repos.d
RUN yum repolist
RUN yum -y install openconnect 
RUN yum -y install which net-tools iputils iproute vi nano gzip zip unzip socat
RUN yum -y install openssh-server openssh-clients

# Setup ssh
USER 0
# Configure SSHD.
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN mkdir /var/run/sshd
RUN bash -c 'install -m755 <(printf "#!/bin/sh\nexit 0") /usr/sbin/policy-rc.d'
RUN ex +'%s/^#\zeListenAddress/\1/g' -scwq /etc/ssh/sshd_config
RUN ex +'%s/^#\zeHostKey .*ssh_host_.*_key/\1/g' -scwq /etc/ssh/sshd_config
RUN systemctl enable sshd
RUN ssh-keygen -A -v

# Configure sudo.
RUN yum -y install sudo ed

# Update path
COPY extra/bashrc /root/.bashrc
COPY extra/hosts.new /etc/hosts.new
RUN useradd -d /home/mtaprod -g wheel mtaprod
RUN cat /root/.bashrc >> /home/mtaprod/.bashrc
RUN echo mtaprod:Atos@2023 | chpasswd 

USER mtaprod
WORKDIR /home/mtaprod
EXPOSE 8080 9091 9092 9093 22
RUN ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
RUN mkdir /home/mtaprod/bin
COPY extra/bin/ /home/mtaprod/bin

##CMD ["/usr/bin/sudo", "/usr/sbin/sshd", "-D", "-o", "ListenAddress=0.0.0.0"]
CMD ["/bin/bash"]
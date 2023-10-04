FROM oraclelinux:7-slim

# openconnect & dependencies
COPY extra/ol7_developer_EPEL.repo /etc/yum.repos.d
RUN yum repolist
RUN yum -y install openconnect 
RUN yum -y install which net-tools iputils iproute vi nano gzip zip unzip socat
RUN yum -y install openssh-server openssh-clients

# Update path
COPY extra/bashrc /root/.bashrc
COPY extra/hosts.new /etc/hosts.new
RUN useradd -d /home/mtaprod -g wheel mtaprod
RUN cat /root/.bashrc >> /home/mtaprod/.bashrc
RUN echo mtaprod:Atos@2023 | chpasswd 

USER mtaprod
WORKDIR /home/mtaprod
RUN ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
RUN mkdir /home/mtaprod/bin
COPY extra/bin/ /home/mtaprod/bin

USER 0
CMD ["/bin/bash"]
FROM ubuntu:latest
MAINTAINER Pierre Baillet <pierre@baillet.name>

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g;s/UsePAM.*/UsePAM no/g;s/PermitRootLogin.*/PermitRootLogin without-password/g;" /etc/ssh/sshd_config
RUN mkdir -p /root/.ssh

ADD ssh/authorized_keys /tmp/your_key
RUN cat /tmp/your_key >> /root/.ssh/authorized_keys && rm -f /tmp/your_key

ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22
CMD ["/run.sh"]

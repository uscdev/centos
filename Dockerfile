# USC CentOS base image - docker hub: uscits/centos
FROM centos:7
MAINTAINER Don Corley [dcorley@usc.edu]
LABEL name="CentOS Base Image for USC" \
    vendor="USC" \
    license="GPLv2" \
    build-date="$(date)"
ENV USC_CENTOS_VERSION 7.4.0

RUN cd /etc/yum.repos.d\
 && sed -i 's/mirrorlist/#mirrorlist/g' *\
 &&  sed -i 's/#baseurl/baseurl/g' *\
 &&  sed -i 's/mirror.centos.org/mirrors.usc.edu\/pub\/linux\/distributions/g' *\
 && cd\
 && echo "USC Centos Version: ${USC_CENTOS_VERSION} Built: $(date)" >> /usccentos.txt

RUN yum -y update\
 && yum -y upgrade\
 && yum install -y ntp\
 && ntpdate pool.ntp.org
# Volumes for systemd
# VOLUME ["/run", "/tmp"]

# Environment for systemd
# ENV container=docker

# For systemd usage this changes to /usr/sbin/init
# Keeping it as /bin/bash for compatability with previous
CMD ["/bin/bash"]

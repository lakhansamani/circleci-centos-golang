
FROM		centos:7
MAINTAINER 	JAkub Scholz "www@scholzj.com"

# Install needed software and users
USER root
RUN groupadd -r circleci && useradd -r -d /home/circleci -m -g circleci circleci
RUN yum install -y git tar curl wget gcc sudo make yum-utils device-mapper-persistent-data lvm2 && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y docker-ce && \
    yum clean all
RUN echo "%circleci        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

# Install golang
RUN curl -s https://dl.google.com/go/go1.14.linux-amd64.tar.gz | tar -xz -C /usr/local
ENV PATH /usr/local/go/bin:/home/circleci/go/bin:$PATH
ENV GOPATH /home/circleci/go

USER circleci

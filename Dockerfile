FROM jenkins/jenkins:latest

USER root
RUN apt-get update \
    && apt-get install -y apt-transport-https \
    && apt-get install -y sudo \
    && echo \
    'deb https://apt.dockerproject.org/repo debian-stretch main' \
      >> /etc/apt/sources.list.d/docker.list \
    && apt-key adv --keyserver \
      hkp://p80.pool.sks-keyservers.net:80 \
      --recv-keys F76221572C52609D \
    && apt-get update \
    && apt-get install -y docker-engine \
    && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; \
    chmod +x /usr/local/bin/docker-compose

USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN xargs /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt


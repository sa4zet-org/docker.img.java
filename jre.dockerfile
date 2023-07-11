FROM ghcr.io/sa4zet-org/docker.img.debian:latest

ARG docker_img
ENV DOCKER_TAG=$docker_img
ARG jdk_version
ENV jdk_version=$jdk_version

RUN apt-get update \
  && apt-get -y install \
    openjdk-${jdk_version}-jre \
    openjdk-${jdk_version}-jre-headless

RUN apt-get --purge -y autoremove \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/*

WORKDIR /home/user
USER user

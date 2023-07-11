FROM ghcr.io/sa4zet-org/docker.img.jre:latest

ARG docker_img
ENV DOCKER_TAG=$docker_img
ARG jdk_version
ENV jdk_version=$jdk_version
ARG gradle_version
ENV gradle_version=$gradle_version

USER 0
RUN apt-get update \
  && apt-get -y install \
    unzip \
    openjdk-${jdk_version}-jdk \
    openjdk-${jdk_version}-jdk-headless \
  && curl --progress-bar --location --output /tmp/gradle.zip "https://services.gradle.org/distributions/gradle-${gradle_version}-bin.zip" \
  && unzip -d /opt /tmp/gradle.zip \
  && ln -s /opt/gradle-${gradle_version} /opt/gradle

RUN apt-get --purge -y autoremove \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/*

ENV PATH=/opt/gradle/bin:${PATH}

WORKDIR /home/user
USER user
RUN mkdir 0 && cd 0 \
  && gradle init --type=kotlin-application --dsl=kotlin --project-name=tmp --package=tmp --incubating \
  && gradle clean \
  && cd .. && rm -rf 0

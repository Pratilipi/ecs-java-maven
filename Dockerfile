FROM 370531249777.dkr.ecr.ap-south-1.amazonaws.com/java:8

WORKDIR /usr/bin

ARG MAVEN_VERSION=3.5.2
ARG USER_HOME_DIR="/root"
ARG SHA=707b1f6e390a65bde4af4cdaf2a24d45fc19a6ded00fff02e91626e3e42ceaff
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/bin/maven /usr/bin/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/bin/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/bin/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/bin/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

WORKDIR /usr/src/app

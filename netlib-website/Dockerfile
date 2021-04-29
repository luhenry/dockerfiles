FROM jdk:latest

ENV JAVA_HOME="/opt/jdk11"
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN apt-get -y install \
        curl \
        gpg

RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
ENV PATH="/usr/local/bin/heroku:${PATH}"

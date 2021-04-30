FROM base:latest

ARG DOCKERGID=1001

RUN groupadd -g $DOCKERGID docker

RUN apt-get -y install \
        docker.io \
        make

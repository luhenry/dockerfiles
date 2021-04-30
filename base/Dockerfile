FROM ubuntu:latest

ENV USER=ludovic

# Fix installation of tzdata
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
 && echo $TZ > /etc/timezone

# define CACHEBUST in command line to bust the cache
#  --build-arg CACHEBUST=$(date +'%Y-%m-%d')
ARG CACHEBUST=1

RUN apt-get -y update \
 && apt-get -y upgrade

RUN apt-get -y install \
        apt-utils \
        cloc \
        git \
        host \
        htop \
        pciutils \
        sudo \
        vim \
        wget \
        zsh

# Add $USER user to match host
RUN useradd --create-home --shell /usr/bin/zsh --groups sudo $USER \
 && echo "\n%sudo ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN git config --system user.name "Ludovic Henry" \
 && git config --system user.email "git@ludovic.dev" \
 && git config --system core.editor "vim" \
 && git config --system oh-my-zsh.hide-dirty 1

CMD zsh

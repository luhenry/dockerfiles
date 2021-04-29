FROM jdk:latest

RUN apt-get -y install \
        libgcc-8-dev \
        libstdc++-8-dev \
        python3 \
        python3-pygments \
        python3-yaml \
        python3-six \
        python3-serial

RUN wget --progress=dot:giga -c http://sdk-releases.upmem.com/2021.1.0/ubuntu_20.04/upmem_2021.1.0_amd64.deb \
 && dpkg -i upmem_2021.1.0_amd64.deb \
 && rm upmem_2021.1.0_amd64.deb

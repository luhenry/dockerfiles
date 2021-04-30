FROM jdk:latest

RUN apt-get -y install \
        intel-oneapi-mkl \
        libarpack2-dev \
        libnvblas10 \
        libopenblas-dev

ENV LD_LIBRARY_PATH="/opt/intel/oneapi/mkl/latest/lib/intel64:/opt/intel/oneapi/compiler/latest/linux/compiler/lib/intel64_lin${LD_LIBRARY_PATH:+":${LD_LIBRARY_PATH}"}"

RUN apt-get -y install \
        build-essential \
        libffi-dev \
        libgdbm-dev \
        libncurses5-dev \
        libnss3-dev \
        libreadline-dev \
        libssl-dev \
        wget \
        zlib1g-dev

RUN mkdir -p /opt/pypy3 \
 && wget --progress=dot:giga -c https://downloads.python.org/pypy/pypy3.7-v7.3.4-linux64.tar.bz2 \
 && tar -xvjf pypy3.7-v7.3.4-linux64.tar.bz2 --strip-components 1 -C /opt/pypy3 \
 && rm -rf pypy3.7-v7.3.4-linux64.tar.bz2
ENV PATH="/opt/pypy3/bin:${PATH}"

# RUN pypy3 -m pip install numpy 'pyarrow<3.0.0' pandas scipy xmlrunner

RUN mkdir -p /opt/python3.8 \
 && wget --progress=dot:giga -c https://www.python.org/ftp/python/3.8.9/Python-3.8.9.tgz \
 && tar -xvzf Python-3.8.9.tgz \
 && cd Python-3.8.9 \
 && ./configure --prefix=/opt/python3.8 \
 && make -j \
 && make altinstall \
 && rm -rf Python-3.8.9.tgz Python-3.8.9
ENV PATH="/opt/python3.8/bin:${PATH}"

RUN python3.8 -m pip install numpy 'pyarrow<3.0.0' pandas scipy xmlrunner

RUN mkdir -p /opt/python3.6 \
 && wget --progress=dot:giga -c https://www.python.org/ftp/python/3.6.13/Python-3.6.13.tgz \
 && tar -xvzf Python-3.6.13.tgz \
 && cd Python-3.6.13 \
 && ./configure --prefix=/opt/python3.6 \
 && make -j \
 && make altinstall \
 && rm -rf Python-3.6.13.tgz Python-3.6.13
ENV PATH="/opt/python3.6/bin:${PATH}"

RUN python3.6 -m pip install numpy 'pyarrow<3.0.0' pandas scipy xmlrunner

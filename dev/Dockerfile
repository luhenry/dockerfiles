FROM base:latest

ENV LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu${LD_LIBRARY_PATH:+":${LD_LIBRARY_PATH}"}"

RUN apt-get -y install \
        build-essential \
        cmake \
        gdb \
        linux-headers-`uname -r` \
        linux-tools-`uname -r` \
        make \
        python \
        rubygems \
        unzip \
        zip

RUN wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
 && apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
 && rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
 && echo "deb https://apt.repos.intel.com/oneapi all main" > /etc/apt/sources.list.d/oneAPI.list \
 && apt-get -y update \
 && apt-get -y install \
        intel-oneapi-vtune
ENV PATH="/opt/intel/oneapi/vtune/latest/bin64:${PATH}"

RUN gem install gist

FROM jdk:latest

RUN apt-get -y install \
        intel-oneapi-mkl \
        libnvblas10

ENV LD_LIBRARY_PATH="/opt/intel/oneapi/mkl/latest/lib/intel64:/opt/intel/oneapi/compiler/latest/linux/compiler/lib/intel64_lin${LD_LIBRARY_PATH:+":${LD_LIBRARY_PATH}"}"

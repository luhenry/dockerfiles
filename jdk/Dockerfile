FROM dev:latest

RUN apt-get -y install \
        autoconf \
        libasound2-dev \
        libcups2-dev \
        libcups2-dev \
        libffi-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        libharfbuzz-dev \
        libx11-dev \
        libxext-dev \
        libxrandr-dev \
        libxrender-dev \
        libxt-dev \
        libxtst-dev

# JDK 8
RUN mkdir -p /opt/jdk8 \
 && wget --progress=dot:giga -c https://cdn.azul.com/zulu/bin/zulu8.54.0.21-ca-jdk8.0.292-linux_x64.tar.gz \
 && tar -xvzf zulu8.54.0.21-ca-jdk8.0.292-linux_x64.tar.gz --strip-components 1 -C /opt/jdk8 \
 && rm -rf zulu8.54.0.21-ca-jdk8.0.292-linux_x64.tar.gz

# JDK 11
RUN mkdir -p /opt/jdk11 \
 && wget --progress=dot:giga -c https://cdn.azul.com/zulu/bin/zulu11.48.21-ca-jdk11.0.11-linux_x64.tar.gz \
 && tar -xvzf zulu11.48.21-ca-jdk11.0.11-linux_x64.tar.gz --strip-components 1 -C /opt/jdk11 \
 && rm zulu11.48.21-ca-jdk11.0.11-linux_x64.tar.gz

# JDK 16
RUN mkdir -p /opt/jdk16 \
 && wget --progress=dot:giga -c https://cdn.azul.com/zulu/bin/zulu16.28.11-ca-jdk16.0.0-linux_x64.tar.gz \
 && tar -xvzf zulu16.28.11-ca-jdk16.0.0-linux_x64.tar.gz --strip-components 1 -C /opt/jdk16 \
 && rm zulu16.28.11-ca-jdk16.0.0-linux_x64.tar.gz
ENV JAVA_HOME="/opt/jdk16"
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# JDK 17
RUN mkdir -p /opt/jdk17 \
 && wget --progress=dot:giga -c https://cdn.azul.com/zulu/bin/zulu17.0.45-ea-jdk17.0.0-ea.18-linux_x64.tar.gz \
 && tar -xvzf zulu17.0.45-ea-jdk17.0.0-ea.18-linux_x64.tar.gz --strip-components 1 -C /opt/jdk17 \
 && rm zulu17.0.45-ea-jdk17.0.0-ea.18-linux_x64.tar.gz

RUN mkdir -p /opt/maven3.8 \
 && wget --progress=dot:giga -c https://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz \
 && tar -xvzf apache-maven-3.8.1-bin.tar.gz --strip-components 1 -C /opt/maven3.8 \
 && rm apache-maven-3.8.1-bin.tar.gz
ENV PATH="/opt/maven3.8/bin:${PATH}"

RUN git clone https://github.com/jvm-profiling-tools/perf-map-agent.git /opt/perf-map-agent \
 && cd /opt/perf-map-agent \
 && cmake . \
 && make -j
ENV PATH="/opt/perf-map-agent/bin:${PATH}"

RUN git clone https://github.com/brendangregg/FlameGraph.git /opt/FlameGraph
ENV FLAMEGRAPH_DIR="/opt/FlameGraph"

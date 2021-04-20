# base
FROM ubuntu:latest

# set the github runner version
ARG RUNNER_VERSION="2.277.1"

# Fix installation of tzdata
ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
 && echo $TZ > /etc/timezone

ENV LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu"

# update the base packages
RUN apt-get update -y \
 && apt-get upgrade -y

# install python and the packages the your code depends on along with jq so we can parse JSON
# add additional packages as necessary
RUN apt-get install -y \
        build-essential \
        curl \
        jq \
        libffi-dev \
        libssl-dev \
        python3 \
        python3-dev \
        python3-venv \
        wget

# add a non-sudo user
RUN useradd -m gh

# cd into the user directory, download and unzip the github actions runner
RUN mkdir /home/gh/actions-runner \
 && wget --progress=dot:giga -c https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
 && tar -xvzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -C /home/gh/actions-runner \
 && rm ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
 && /home/gh/actions-runner/bin/installdependencies.sh

# copy over the actions-runner-start.sh script
COPY actions-runner-start.sh actions-runner-start.sh
RUN chmod +x actions-runner-start.sh

# Fix permissions on home directory
RUN chown -R gh:gh /home/gh

# install some additional dependencies
RUN mkdir -p /usr/lib/jvm/maven-3.8.1 \
 && wget --progress=dot:giga -c https://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz \
 && tar -xvzf apache-maven-3.8.1-bin.tar.gz --strip-components 1 -C /usr/lib/jvm/maven-3.8.1 \
 && rm apache-maven-3.8.1-bin.tar.gz
ENV PATH="/usr/lib/jvm/maven-3.8.1/bin:${PATH}"

RUN apt-get install -y \
        libopenblas-dev

# since the config and run script for actions are not allowed to be run by root,
# set the user to "gh" so all subsequent commands are run as the gh user
USER gh

# set the entrypoint to the actions-runner-start.sh script
CMD ["./actions-runner-start.sh"]

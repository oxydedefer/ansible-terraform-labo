FROM alpine:3.12
RUN apk --update --no-cache add \
        ca-certificates \
        git \
        openssh-client \
        openssl \
        python3\
        py3-pip \
        rsync \
        sshpass\
        terraform
RUN apk --update add --virtual \
        .build-deps \
        python3-dev \
        libffi-dev \
        openssl-dev \
        build-base \
        curl \
        && pip3 install --upgrade \
        pip \
        cffi \
        && pip3 install ansible==2.10.4 \
        mitogen \
        && mkdir /etc/ansible \
        && mkdir /home/.ssh \
        && mkdir /terraform \
        && curl https://gist.githubusercontent.com/oxydedefer/96872191421c770079cd8722c8b3d7ad/raw/0d41258a2201e8c7e25b473348a617574e934c64/ansible.cfg -o /etc/ansible/ansible.cfg \
        && apk del \
        .build-deps \
        && rm -rf /var/cache/apk/*

WORKDIR /app
ENTRYPOINT []
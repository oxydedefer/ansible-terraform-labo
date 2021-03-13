FROM alpine:3.13.2
RUN apk --update --no-cache add \
        git \
        terraform \
        ansible\
        && apk add --virtual .build-deps \
        py3-pip \
        curl \
        && pip3  --no-cache-dir install --upgrade pip mitogen \
        && mkdir /etc/ansible \
        && mkdir /home/.ssh \
        && mkdir /terraform \
        && touch /tmp/.vault_pass \
        && curl https://gist.githubusercontent.com/oxydedefer/96872191421c770079cd8722c8b3d7ad/raw/0d41258a2201e8c7e25b473348a617574e934c64/ansible.cfg -o /etc/ansible/ansible.cfg \
        && apk del .build-deps
WORKDIR /app
ENTRYPOINT []
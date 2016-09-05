FROM alpine:latest

RUN apk update
# sudo and bash are just for convenience
# perl also might not be necessary
# man is for nix-env
# we might also need less too
# we need curl and bzip2 t install
# gcc is an actual build depedency
# honestly though we might not even need gcc
# if we're just 
RUN apk add \
    curl \
    bzip2 \
    sudo \
    perl \
    man \
    less \
    bash

RUN apk add \
    gcc \
    perl \
    pkgconfig \
    sqlite \
    make \
    libxml2-utils \
    bison \
    flex \
    musl-dev

# removed depdencies (gcc)

# adduser --home /home/nix --shell /bin/bash --uid 1000 --disabled-password nix
# busybox does not understand gnu-style options okay
RUN adduser -h /home/nix -s /bin/bash -u 1000 -D nix
# set up the root nix directory first
RUN mkdir -m 0755 /nix && chown nix /nix

ADD ./setup.sh /home/nix/setup.sh

USER nix
WORKDIR /home/nix
RUN echo '. /home/nix/.nix-profile/etc/profile.d/nix.sh' >> .bashrc

RUN sh setup.sh
RUN rm _install.sh && rm setup.sh

CMD ["bash"]

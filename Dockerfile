FROM ubuntu:14.04

RUN apt-get update \
 && apt-get install -y \
        automake \
        autopoint \
        build-essential \
        gettext \
        man \
        rsync \
        texinfo \
        texi2html \
        ;

RUN apt-get install -y \
        gist git vim

WORKDIR /indent

COPY . .

RUN \
    ./bootstrap && \
    ./configure && \
    make && \
    make install

WORKDIR /work/

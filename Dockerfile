FROM ubuntu:20.04
LABEL ubuntu.version="20.04"

MAINTAINER Omar Moreno <omoreno@slac.stanford.edu>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      g++ \
      gcc \
      git \
      cmake \
      make \
      libexpat1-dev \
      libxerces-c-dev \
      freeglut3 \
      freeglut3-dev \
      mesa-utils \
      libfontconfig1-dev \
      libfreetype6-dev \
      libx11-dev \
      libxcursor-dev \ 
      libxext-dev \
      libxfixes-dev \
      libxft-dev \
      libxi-dev \
      libxrender-dev \
      libxmu-dev \
      qt5-default \

#RUN mkdir packages

#RUN cd /packages && \
#     git clone --depth 1 --branch v10.6.3 https://github.com/Geant4/geant4.git geant4 &&\
#     mkdir -p geant4/build && cd geant4/build &&\
#     cmake \

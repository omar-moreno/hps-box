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
      qt5-default 

RUN mkdir packages

RUN cd /packages && \
      git clone --depth 1 --branch LDMX.10.2.3_v0.5 https://github.com/LDMX-Software/geant4.git geant4 &&\
      mkdir -p geant4/build && cd geant4/build &&\
      cmake -DCMAKE_INSTALL_PREFIX=../install -DGEANT4_INSTALL_DATA=ON -DGEANT4_USE_QT=ON -DGEANT4_USE_OPENGL_X11=ON .. &&\
      make -j4 install

RUN cd /packages &&\
      git clone https://github.com/JeffersonLab/hps-lcio.git lcio &&\
      mkdir -p lcio/build && cd lcio/build &&\
      cmake -DINSTALL_DOC=OFF -DBUILD_LCIO_EXAMPLES=OFF -DCMAKE_INSTALL_PREFIX=../install .. &&\
      make -j4 install

RUN cd /packages &&\
      git clone https://github.com/slaclab/heppdt.git &&\
      cd heppdt &&\
      ./configure --prefix=$PWD/install --disable-static &&\
      make -j4 install

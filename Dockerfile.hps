FROM ubuntu:20.04
LABEL ubuntu.version="20.04"

MAINTAINER Omar Moreno <omoreno@slac.stanford.edu>

SHELL ["/bin/bash", "-c"]
ENV PACKAGES=/packages

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

RUN cd ${PACKAGES} &&\
    #git clone --depth 1 --branch v10.5.1 https://github.com/Geant4/geant4.git &&\
    git clone --depth 1 --branch LDMX.10.2.3_v0.5 https://github.com/LDMX-Software/geant4.git &&\
    mkdir -p geant4/build && cd geant4/build &&\
    cmake   -DGEANT4_INSTALL_DATA=ON \
            -DGEANT4_USE_QT=ON \
            -DGEANT4_USE_OPENGL_X11=ON .. &&\
    make -j`nproc` install

ENV G4DATA=/usr/local/share/Geant4-10.2.3/data
ENV G4LEDATA=${G4DATA}/G4EMLOW6.48
ENV G4LEVELGAMMADATA=${G4DATA}/PhotonEvaporation3.2
ENV G4RADIOACTIVEDATA=${G4DATA}/RadioactiveDecay4.3.2
#ENV G4PARTICLEXSDATA=${G4DATA}/G4PARTICLEXS3.1.1
ENV G4PIIDATA=${G4DATA}/G4PII1.3
ENV G4REALSURFACEDATA=${G4DATA}/RealSurface1.0
ENV G4SAIDXSDATA=${G4DATA}/G4SAIDDATA1.1
ENV G4ABLADATA=${G4DATA}/G4ABLA3.0
#ENV G4INCLDATA=${G4DATA}/G4INCL1.0
ENV G4ENSDFSTATEDATA=${G4DATA}/G4ENSDFSTATE1.2.3

RUN cd /packages &&\
      git clone https://github.com/JeffersonLab/hps-lcio.git lcio &&\
      mkdir -p lcio/build && cd lcio/build &&\
      cmake -DINSTALL_DOC=OFF \ 
            -DBUILD_LCIO_EXAMPLES=OFF \
            -DCMAKE_INSTALL_PREFIX=/usr/local .. &&\ 
      make -j`nproc` install

RUN cd /packages &&\
      git clone https://github.com/slaclab/heppdt.git &&\
      cd heppdt &&\
      ./configure --disable-static &&\
      make -j`nproc` install

RUN cd /packages &&\
      git clone https://github.com/slaclab/gdml.git &&\
      mkdir -p gdml/build && cd gdml/build && cmake .. &&\
      make -j`nproc` install

RUN cd /packages &&\
      git clone https://github.com/slaclab/lcdd.git &&\
      mkdir -p lcdd/build && cd lcdd/build &&\
      cmake -DINSTALL_DOC=OFF .. &&\
      make -j`nproc` install

RUN cd /packages &&\
      git clone https://github.com/slaclab/slic.git && cd slic &&\
      git checkout iss98 &&\
      mkdir -p build && cd build/ &&\
      cmake -DINSTALL_DOC=OFF \
            -DCMAKE_INSTALL_PREFIX=/usr/local \
            -DQT_VIS=ON \
            -DWITH_GEANT4_UIVIS=ON .. &&\
      make -j`nproc` install

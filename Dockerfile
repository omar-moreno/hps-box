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

RUN cd ${PACKAGES} && \
      git clone --depth 1 --branch LDMX.10.2.3_v0.5 \
                 https://github.com/LDMX-Software/geant4.git geant4 &&\
      mkdir -p geant4/build && cd geant4/build &&\
      cmake -DCMAKE_INSTALL_PREFIX=../install \
            -DGEANT4_INSTALL_DATA=ON \
            -DGEANT4_USE_QT=ON \
            -DGEANT4_USE_OPENGL_X11=ON .. &&\
      make -j4 install

ENV G4DIR=${PACKAGES}/geant4/install

RUN source ${G4DIR}/bin/geant4.sh

RUN cd /packages &&\
      git clone https://github.com/JeffersonLab/hps-lcio.git lcio &&\
      mkdir -p lcio/build && cd lcio/build &&\
      cmake -DINSTALL_DOC=OFF \ 
            -DBUILD_LCIO_EXAMPLES=OFF \ 
            -DCMAKE_INSTALL_PREFIX=../install .. &&\
      make -j4 install

ENV LCIO_DIR=${PACKAGES}/lcio/install
ENV LD_LIBRARY_PATH=${LCIO_DIR}/lib:${LD_LIBRARY_PATH}
ENV PATH=${LCIO_DIR}/bin:${PATH}

RUN cd /packages &&\
      git clone https://github.com/slaclab/heppdt.git &&\
      cd heppdt &&\
      ./configure --prefix=${PWD}/install --disable-static &&\
      make -j4 install

ENV HEPPDT_DIR=${PACKAGES}/heppdt/install
ENV LD_LIBRARY_PATH=${HEPPDT_DIR}/lib:${LD_LIBRARY_PATH}

RUN cd /packages &&\
      git clone https://github.com/slaclab/gdml.git &&\
      mkdir -p gdml/build && cd gdml/build &&\
      cmake -DGeant4_DIR=${G4DIR}/lib/Geant4-10.2.3/ \
            -DCMAKE_INSTALL_PREFIX=../install .. &&\
      make -j4 install

ENV GDML_DIR=${PACKAGES}/gdml/install
ENV LD_LIBRARY_PATH=${GDML_DIR}/lib:${LD_LIBRARY_PATH}

RUN cd /packages &&\
      git clone https://github.com/slaclab/lcdd.git &&\
      mkdir -p lcdd/build && cd lcdd/build &&\
      cmake -DINSTALL_DOC=OFF \
            -DGeant4_DIR=${G4DIR}/lib/Geant4-10.2.3/ \
            -DGDML_DIR=${GDML_DIR} \
            -DCMAKE_INSTALL_PREFIX=../install .. &&\
      make -j4 install

ENV LCDD_DIR=${PACKAGES}/lcdd/install
ENV LD_LIBRARY_PATH=${LCDD_DIR}/lib:${LD_LIBRARY_PATH}


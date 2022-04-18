FROM opensuse/leap:15.3

MAINTAINER Moreno <omoreno@slac.stanford.edu>

RUN zypper refs && zypper refresh &&\
    zypper --non-interactive in \
    libxerces-c-devel \
    gcc \
    gcc7-c++ \
    gcc-c++ \
    git \
    cmake \
    expat \
    libexpat-devel 

RUN mkdir software &&\
    cd software &&\
    git clone --depth 1 --branch v10.6.3 https://github.com/Geant4/geant4.git geant4 &&\
    mkdir -p geant4/build && cd geant4/build &&\
    cmake \
      -DGEANT4_INSTALL_DATA=ON \
      -DGEANT4_USE_GDML=ON \
      -DGEANT4_INSTALL_EXAMPLES=OFF \
      -DCMAKE_INSTALL_PREFIX=../install .. &&\
    make install

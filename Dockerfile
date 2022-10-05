FROM opensuse/leap:15.4

MAINTAINER Moreno <omoreno@slac.stanford.edu>

RUN zypper --non-interactive refs &&\
    zypper --non-interactive refresh &&\
    zypper --non-interactive in \
    libxerces-c-devel \
    gcc \
    gcc7-c++ \
    gcc-c++ \
    gcc-fortran \
    git \
    cmake \
    expat \
    libexpat-devel \
    wget \ 
    tar \
    gzip \
    libz1 

RUN mkdir software
#    cd software &&\
#    export MG4=MG_ME_V4.5.2 &&\
#    wget http://madgraph.phys.ucl.ac.be/Downloads/$MG4.tar.gz &&\
#    tar -zxvf $MG4.tar.gz; rm $MG4.tar.gz &&\
#    cd $MG4/MadGraphII &&\
#    sed -i 's/g77/gfortran/g' makefile &&\
#    sed -i 's/-i4//g' makefile &&\
#    make

#RUN cd /software &&\
#    git clone https://github.com/omar-moreno/hps-mg.git 
    
RUN cd /software &&\
    git clone --depth 1 --branch v10.6.3 https://github.com/Geant4/geant4.git geant4 &&\
    mkdir -p geant4/build && cd geant4/build &&\
    cmake \
      -DGEANT4_INSTALL_DATA=ON \
      -DGEANT4_USE_GDML=ON \
      -DGEANT4_INSTALL_EXAMPLES=OFF \
      -DCMAKE_INSTALL_PREFIX=../install .. &&\
    make -j3 install &&\
    cd ../install &&\
    export G4DIR=$PWD

RUN cd /software &&\
    git clone https://github.com/JeffersonLab/hps-lcio.git lcio &&\
    mkdir -p lcio/build && cd lcio/build &&\
    cmake -DINSTALL_DOC=OFF \ 
          -DBUILD_LCIO_EXAMPLES=OFF \
          -DCMAKE_INSTALL_PREFIX=../install .. &&\
    make -j3 install &&\

COPY ./entrypoint.sh /etc/
RUN chmod 755 /etc/entrypoint.sh
ENTRYPOINT ["/etc/entrypoint.sh"]

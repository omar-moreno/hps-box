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
    zlib-devel \
    libxerces-c-devel \
    libxerces-c-3_2 

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
    make -j8 install 

RUN cd /software &&\
    git clone https://github.com/JeffersonLab/hps-lcio.git lcio &&\
    mkdir -p lcio/build && cd lcio/build &&\
    cmake -DINSTALL_DOC=OFF \ 
          -DBUILD_LCIO_EXAMPLES=OFF \
          -DCMAKE_INSTALL_PREFIX=../install .. &&\
    make -j8 install 

RUN cd /software &&\
    git clone https://github.com/slaclab/heppdt.git &&\
    cd heppdt &&\
    ./configure --prefix=$PWD/install --disable-static &&\
    make -j8 install

RUN cd /software &&\
    git clone https://github.com/slaclab/gdml.git &&\
    mkdir -p gdml/build && cd gdml/build &&\
    cmake -DGeant4_DIR=/software/geant4/install/lib64/Geant4-10.6.3 \
          -DCMAKE_INSTALL_PREFIX=../install .. &&\
    make -j8 install

RUN cd /software &&\
    git clone https://github.com/slaclab/lcdd.git &&\
    mkdir -p lcdd/build && cd lcdd/build &&\
    cmake -DINSTALL_DOC=OFF \
          -DGeant4_DIR=/software/geant4/install/lib64/Geant4-10.6.3 \
          -DGDML_DIR=/software/gdml/install \ 
          -DCMAKE_INSTALL_PREFIX=../install .. &&\
    make -j8 install

COPY ./entrypoint.sh /etc/
RUN chmod 755 /etc/entrypoint.sh
ENTRYPOINT ["/etc/entrypoint.sh"]

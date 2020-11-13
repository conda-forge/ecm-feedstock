#!/usr/bin/env bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* .

export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH

if [ "$(uname)" == "Linux" ]
then
    autoconf
fi

chmod +x configure
./configure --prefix=$PREFIX --with-gmp-include=$PREFIX/include --with-gmp-lib=$PREFIX/lib --enable-shared

make

chmod +x test.pp1
chmod +x test.pm1
chmod +x test.ecm
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
make check
fi

make install

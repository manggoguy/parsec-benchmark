#!/bin/bash

rm *.exe
rm *.ll 
rm *.bc

rm `find . |grep \.o$`
rm `find . |grep \.d$`
PARSEC_DIR=/home/mok/parsec/parsec-3.0 \
CC=wllvm \
CXX=wllvm++ \
PHYSBAM=/home/mok/parsec/parsec-3.0/pkgs/apps/facesim/src \
version=pthreads \
CXXFLAGS="-std=c++98 -w -fno-exceptions -DENABLE_PTHREADS -g -Ofast -funroll-loops -fprefetch-loop-arrays -fpermissive " \
CFLAGS="$CXXFLAGS" \
make 

cp ./Benchmarks/facesim/facesim ./facesim

extract-bc facesim

#mv facesim.bc facesim_stage1.bc

#/opt/spec/tools-root/bin/llvm-dis -o facesim_stage1.ll facesim_stage1.bc

#opt -std-compile-opts -std-link-opts -O3 facesim_stage1.bc -o facesim.bc

#:<<COMMENT
#build prof bin

#do profiling



#COMMENT
#build tx

./txbin-tx.sh facesim.bc

#build tsan


#run!
#rm -rf ./Face_Data ./Storytelling
#tar xf ../inputs/input_simlarge.tar
#time ./facesim.tsan.exe -timing -threads 4


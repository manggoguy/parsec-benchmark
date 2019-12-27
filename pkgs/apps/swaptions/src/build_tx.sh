#!/bin/bash

rm *.ll 
rm *.bc

make clean 

env version=pthreads \
CXX=wllvm++ \
CXXFLAGS="-g -Ofast -funroll-loops -fprefetch-loop-arrays -fpermissive -fno-exceptions -DPARSEC_VERSION=3.0-beta-20130728 -pthread  -DENABLE_THREADS" \
LDFLAGS="-g -Ofast" \
/usr/bin/make

extract-bc swaptions

llvm-dis -o swaptions.ll swaptions.bc

#build prof bin


#do profiling


#build tx

./txbin-lock.sh swaptions.bc
./txbin-lock-static.sh swaptions.bc
#build tsan


#run!

#time ./swaptions.tsan.exe -ns 64 -sm 40000 -nt 4


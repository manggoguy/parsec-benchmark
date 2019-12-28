#!/bin/bash

rm *.exe
rm *.ll 
rm *.bc
rm *.out 

export CC=wllvm
export CXX=wllvm++
env version=pthreads /usr/bin/make 

extract-bc canneal

#mv canneal.bc canneal_stage1.bc

opt -std-link-opts -O3 canneal_stage1.bc -o canneal.bc

llvm-dis -o canneal.ll canneal.bc
#build tx

./txbin-tx.sh canneal.bc



#run!

time ./canneal.tsan.exe  4 15000 2000 400000.nets 128


#!/bin/bash

#rm *.exe
rm *.ll 
rm *.bc
make clean 

CXX=wllvm++ \
CXXFLAGS="-Wno-deprecated -Ofast -g" \
make

extract-bc freqmine

llvm-dis -o freqmine.ll freqmine.bc

tar xf ../inputs/input_simlarge.tar





#build tx

./txbin-tx.sh freqmine.bc

#build tsan




#export OMP_NUM_THREADS=4
#time ./freqmine.tsan.exe kosarak_990k.dat 790


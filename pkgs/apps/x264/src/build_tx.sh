#!/bin/bash

rm *.ll 
rm *.bc

make clean

export CC=wllvm
export CXX=wllvm++
export RANLIB=ranlib
./configure \
	--enable-pthread \
	--extra-cflags="-Ofast -g" \
	--extra-ldflags="-Ofast -g" \
	--enable-debug --disable-asm

make -j10

extract-bc x264
llvm-dis -o x264.ll x264.bc


#build prof bin




./txbin-lock.sh x264.bc

#build tsan

./txbin-lock-static.sh x264.bc

#run!

#time ./x264.tsan.exe --quiet --qp 20 --partitions b8x8,i4x4 --ref 5 --direct auto --b-pyramid --weightb --mixed-refs --no-fast-pskip --me umh --subme 7 --analyse b8x8,i4x4 --threads 4 -o eledream.264 eledream_640x360_128.y4m


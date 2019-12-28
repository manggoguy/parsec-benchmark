#!/bin/bash

make clean 

rm *.exe
rm *.ll 
rm *.bc

CC=wllvm CXX=wllvm++ env version=pthreads /usr/bin/make


extract-bc streamcluster
#mv streamcluster.bc streamcluster_stage1.bc

#/opt/spec/tools-root/bin/llvm-dis -o streamcluster_stage1.ll streamcluster_stage1.bc

#opt -std-compile-opts -std-link-opts -O3 streamcluster_stage1.bc -o streamcluster.bc


#build prof bin


#do profiling


#build tx

./txbin-lock.sh streamcluster.bc
./txbin-lock-static.sh streamcluster.bc
#mv streamcluster.tx.bc streamcluster.tx_stage1.bc

#opt -std-compile-opts -std-link-opts -O3 streamcluster.tx_stage1.bc -o streamcluster.tx.bc

#clang++ streamcluster.tx.bc -o ./streamcluster.tx.exe $LLVM_HOME/lib/libTxHooks.a $LLVM_HOME/lib/libtsan_rtl.a $LLVM_HOME/lib/libtsan_icp.a $LLVM_HOME/lib/libtsan_san.a  -ldl -lpthread

#build tsan

./txbin-tsan.sh streamcluster.bc

#mv streamcluster.tsan.bc streamcluster.tsan_stage1.bc

#opt -std-compile-opts -std-link-opts -O3 streamcluster.tsan_stage1.bc -o streamcluster.tsan.bc 

#clang++ streamcluster.tsan.bc -o ./streamcluster.tsan.exe $LLVM_HOME/lib/libTxHooks.a $LLVM_HOME/lib/libtsan_rtl.a $LLVM_HOME/lib/libtsan_icp.a $LLVM_HOME/lib/libtsan_san.a  -ldl -lpthread

#run!

time ./streamcluster.tx.exe  10 20 128 16384 16384 1000 none output.txt 4


#!/bin/bash

TESTNAME=${TESTNAME:-container}  # container/host
TESTDIR=${TESTDIR:-test/}      # 测试指定的文件目录

# 结果存放位置
mkdir -p results

# bs=4k iodepth=1
./run-fio-test.sh $TESTNAME-4k-1 $TESTDIR fio-jobs/* --iodepth="1" --blocksize="4k" > results/fio-results-$TESTNAME-4k-1.txt
# bs=4k iodepth=128
./run-fio-test.sh $TESTNAME-4k-128 $TESTDIR fio-jobs/* --iodepth="128" --blocksize="4K" > results/fio-results-$TESTNAME-4k-128.txt
# bs=8k iodepth=1
./run-fio-test.sh $TESTNAME-8k-1 $TESTDIR fio-jobs/* --iodepth="1" --blocksize="8K" > results/fio-results-$TESTNAME-8k-1.txt
# bs=8k iodepth=128
./run-fio-test.sh $TESTNAME-8k-128 $TESTDIR fio-jobs/* --iodepth="128" --blocksize="8K" > results/fio-results-$TESTNAME-8k-128.txt
# bs=1024k iodepth=1
./run-fio-test.sh $TESTNAME-1M-1 $TESTDIR fio-jobs/* --iodepth="1" --blocksize="1M" > results/fio-results-$TESTNAME-1M-1.txt
# bs=1024k iodepth=16
./run-fio-test.sh $TESTNAME-1M-16 $TESTDIR fio-jobs/* --iodepth="16" --blocksize="1M" > results/fio-results-$TESTNAME-1M-16.txt
# bs=4096k iodepth=1
./run-fio-test.sh $TESTNAME-4M-1 $TESTDIR fio-jobs/* --iodepth="1" --blocksize="4M" > results/fio-results-$TESTNAME-4M-1.txt
# bs=4096k iodepth=16
./run-fio-test.sh $TESTNAME-4M-16 $TESTDIR fio-jobs/* --iodepth="16" --blocksize="4M" > results/fio-results-$TESTNAME-4M-16.txt
# bs=4096k iodepth=128
./run-fio-test.sh $TESTNAME-4M-128 $TESTDIR fio-jobs/* --iodepth="128" --blocksize="4M" > results/fio-results-$TESTNAME-4M-128.txt
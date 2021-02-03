#!/bin/bash

TESTNAME="container"  # container/host
TESTDIR="test/"      # 测试指定的文件目录

# 结果存放位置
mkdir -p results

# bs=4k iodepth=1
./run-fio-test.sh $TESTNAME-4k-1 $TESTDIR fio-jobs/* --size="4k" --iodepth="1" > results/fio-results-$TESTNAME-4k-1.txt
# bs=4k iodepth=128
./run-fio-test.sh $TESTNAME-4k-128 $TESTDIR fio-jobs/* --size="4k" --iodepth="128" > results/fio-results-$TESTNAME-4k-128.txt
# bs=8k iodepth=1
./run-fio-test.sh $TESTNAME-8k-1 $TESTDIR fio-jobs/* --size="8k" --iodepth="1" > results/fio-results-$TESTNAME-8k-1.txt
# bs=8k iodepth=128
./run-fio-test.sh $TESTNAME-8k-1 $TESTDIR fio-jobs/* --size="8k" --iodepth="128" > results/fio-results-$TESTNAME-8k-128.txt
# bs=1024k iodepth=1
./run-fio-test.sh $TESTNAME-1M-1 $TESTDIR fio-jobs/* --size="1024k" --iodepth="1" > results/fio-results-$TESTNAME-1M-1.txt
# bs=1024k iodepth=16
./run-fio-test.sh $TESTNAME-1M-16 $TESTDIR fio-jobs/* --size="1024k" --iodepth="16" > results/fio-results-$TESTNAME-1M-16.txt
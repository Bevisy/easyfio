#!/bin/bash

# Job Name, Workload, Bandwidth, IOPS
PRINT_FORMAT="%-24s%-24s%-16s%-16s\n"

get_total() {
  local data="$1"
  local i total

  for i in $data;do
    i=`printf "%.0f" "$i"`
    total=$(( total + i ))
  done 

  echo $total
}

get_avg() {
  local data="$1"
  local avg i total
  local nr_samples="0"

  for i in $data;do
    i=`printf "%.0f" "$i"`
    total=$(( total + i ))
    nr_samples=$((nr_samples + 1))
  done 

  avg=$((total/nr_samples))
  echo $avg
}

div_by_kib() {
  local data=$1
  local total

  if [ -x "/usr/bin/bc" ]; then
    total=`echo "scale=1; $data/1024" | bc`
  else
    total=$(($data/1024))
  fi
  echo $total
}

get_op_bw() {
  local op=$1
  local file=$2
  local write=$3
  local data

  if [ "$write" == "1" ];then
    data=`grep -e ";$op;" $file | awk -F\; '{print $48}'`
  else
    data=`grep -e ";$op;" $file | awk -F\; '{print $7}'`
  fi

  echo $data 
}

get_op_iops() {
  local op=$1
  local file=$2
  local write=$3
  local data

  if [ "$write" == "1" ];then
    data=`grep -e ";$op;" $file | awk -F\; '{print $49}'`
  else
    data=`grep -e ";$op;" $file | awk -F\; '{print $8}'`
  fi

  echo $data
}

get_op_bw_with_suffix() {
  local op=$1 file=$2 write=$3
  local unit data avg bw

  unit="kb"
  data=`get_op_bw $op $file $write`

  if [ -z "$data" ];then
    avg="Unknown"
    bw="$avg"
  else
    avg=`get_avg "$data"`
    if [ $avg -gt 10240 ]; then
      avg=`div_by_kib $avg`
      unit="mb"
    fi
      bw="$avg$unit"
  fi
  echo "$bw"
}

get_op_bw_formatted() {
  local op=$1 file=$2 write=$3 mixed=$4
  local unit data avg bw
  local rbw wbw

  if [ "$mixed" == "1" ] || [ "$write" != "1" ]; then
    rbw=`get_op_bw_with_suffix $op $file 0`
  fi

  if [ "$mixed" == "1" ] || [ "$write" == "1" ]; then
    wbw=`get_op_bw_with_suffix $op $file 1`
  fi

  if [ "$mixed" == "1" ]; then
    echo "$rbw/$wbw"
  elif [ -n "$rbw" ]; then
    echo "$rbw"
  else
    echo "$wbw"
  fi
}

get_op_iops_with_suffix() {
      local op=$1 file=$2 write=$3
      local unit data avg iops

      unit=""
      data=`get_op_iops $op $file $write`
      if [ -z "$data" ];then
        avg="Unknown"
      else
        avg=`get_avg "$data"`
        if [ $avg -gt 10240 ]; then
          avg=`div_by_kib $avg`
          unit="k"
        fi
      fi

      iops="$avg$unit"
      echo "$iops"
}

get_op_iops_formatted() {
  local op=$1 file=$2 write=$3 mixed=$4
  local unit data avg bw
  local riops wiops

  if [ "$mixed" == "1" ] || [ "$write" != "1" ]; then
    riops=`get_op_iops_with_suffix $op $file 0`
  fi

  if [ "$mixed" == "1" ] || [ "$write" == "1" ]; then
    wiops=`get_op_iops_with_suffix $op $file 1`
  fi

  if [ "$mixed" == "1" ]; then
    echo "$riops/$wiops"
  elif [ -n "$riops" ]; then
    echo "$riops"
  else
    echo "$wiops"
  fi
}

print_result_header() {
  local name="NAME"
  local op="WORKLOAD"
  local bw="Bandwidth"
  local iops="IOPS"

  printf $PRINT_FORMAT "$name" "$op" "$bw" "$iops"
}

parse_print_ops() {
  local operations=$1
  local write=$2 mixed=$3
  local bw iops found_valid_value

  for op in $operations;do
    found_valid_value="No"
    for file in $FILES;do
      TEST_NAME=`grep "^TEST_NAME=" $file | cut -d "=" -f2`
      [ -z "$TEST_NAME" ] && TEST_NAME="unknown"
      bw=`get_op_bw_formatted $op $file $write $mixed`
      iops=`get_op_iops_formatted $op $file $write $mixed`

      [ "$bw" == "Unknown" ] || [ "$bw" == "Unknown/Unknown" ] && continue

      found_valid_value="yes"
      printf "$PRINT_FORMAT" "$TEST_NAME" "$op" "$bw" "$iops"
    done
    [ "$found_valid_value" == "yes" ] && printf "\n"
  done
}

#Main script
if [ $# -lt 1 ];then
  echo "Usage: $0 FILE ..."
  exit 1
fi

FILES="$@"
READ_OPERATIONS="seqread-psync seqread-psync-multi seqread-mmap seqread-mmap-multi seqread-libaio seqread-libaio-multi randread-psync randread-psync-multi randread-mmap randread-mmap-multi randread-libaio randread-libaio-multi"

WRITE_OPERATIONS="seqwrite-psync seqwrite-psync-multi seqwrite-mmap seqwrite-mmap-multi seqwrite-libaio seqwrite-libaio-multi randwrite-psync randwrite-psync-multi randwrite-mmap randwrite-mmap-multi randwrite-libaio randwrite-libaio-multi"

RW_OPERATIONS="randrw-psync randrw-psync-multi randrw-mmap randrw-mmap-multi randrw-libaio randrw-libaio-multi"

# Parse and print numbers
print_result_header
parse_print_ops "$READ_OPERATIONS"
parse_print_ops "$WRITE_OPERATIONS" "1"
parse_print_ops "$RW_OPERATIONS" "0" "1"

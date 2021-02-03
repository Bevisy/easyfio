# virtiofs-tests
A placeholder for kata-containers tests

# Setup Environment
- Install fio
- Setup target directory where fio file will be setup and I/O will be done
  to these files

# Run Tests
- cd kata-tests
- Assumeing testdir is mounted at /test/ and config name is container 
- ./run-fio-test.sh $TESTNAME $TESTDIR fio-jobs/* --size="4k" --iodepth="1" > fio-results-$TESTNAME-4k-1.txt

# Parse Results
- ./parse-fio-results fio-results-$TESTNAME-4k-1.txt

# kata-containers-tests
A placeholder for kata-containers tests

# Setup Environment
- Install fio
```sh
sudo apt-get install fio
```
- Setup target directory where fio file will be setup and I/O will be done
  to these files

# Run Tests
- change directory to kata-tests
```sh
cd kata-tests
```

- Assumeing testdir is mounted at ./test and config name is "container" 
```sh
TESTNAME=container TESTDIR=test ./kata-tests.sh
```

# Parse Results
```sh
# RESULTS is the directory where fio results are stored
RESULTS='results';for i in $(ls $RESULTS);do ./parse-fio-results.sh $RESULTS/$i;done
```
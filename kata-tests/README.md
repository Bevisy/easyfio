# virtiofs-tests
A placeholder for kata-containers tests

# Setup Environment
- Install fio
- Setup target directory where fio file will be setup and I/O will be done
  to these files

# Run Tests
- cd kata-tests
- Assumeing testdir is mounted at ./test/ and config name is "container" 
- ./kata-tests.sh

# Parse Results
- for i in $(ls results);do ./parse-fio-results.sh results/$i;done

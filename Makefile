LIBRARY = "docker.io"
USER_NAME = "bevisy"
IMAGE_NAME = fio
IMAGE_VERSION = latest
FIO_TESTS_DIR = "virtiofs-tests"

.PHONY: \
    run \
    prepare \
    build-image \
    push

run: prepare
	# excute fio tests
	# example: ./run-fio-test.sh test01 testDir/ testConfig/* | tee fio-tests-test01.txt
	$(FIO_TEST_DIR)/run-fio-test.sh

prepare:
	echo "TODO"

build-image:
	docker build -t $(LIBRARY)/$(USER_NAME)/$(IMAGE_NAME):$(IMAGE_VERSION) -f Dockerfile .

push:
	docker push $(LIBRARY)/$(USER_NAME)/$(IMAGE_NAME):$(IMAGE_VERSION)
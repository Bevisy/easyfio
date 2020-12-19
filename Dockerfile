FROM docker.io/library/centos:7

# Build with essential tools.
RUN yum update && \
    yum install fio -y && \
    yum clean all
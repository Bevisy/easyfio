FROM docker.io/library/centos:7

# Build with essential tools.
RUN yum update && \
    yum install fio vim curl wget -y && \
    yum clean all
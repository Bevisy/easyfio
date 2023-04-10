FROM docker.io/library/ubuntu:22.04

# Build with essential tools.
RUN apt update -y && \
    apt install fio vim curl wget git -y && \
    apt clean all
ADD kata-tests /root/

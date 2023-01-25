FROM ubuntu:22.04

RUN apt update && apt install -y \
    build-essential \
    flex \
    bison \
    dwarves \
    libssl-dev \
    libelf-dev \
    libncurses-dev \
    autoconf \
    libudev-dev \
    libtool \
    bc \
    curl \ 
    unzip \
    python3 \
    kmod \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN ln -s /usr/bin/objdump /usr/bin/nobjdump && \
    ln -s /usr/bin/ld /usr/bin/nld

ADD wsl-config .
ADD build-kernel.sh .
RUN chmod u+x build-kernel.sh

ENV WSL2_KERNEL_SOURCE_URL https://github.com/microsoft/WSL2-Linux-Kernel/archive/refs/heads/linux-msft-wsl-5.15.y.zip

CMD ./build-kernel.sh
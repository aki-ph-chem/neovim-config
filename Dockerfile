FROM ubuntu:latest

WORKDIR /root

RUN apt update -y && \ 
    apt install wget tar git -y &&\
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.tar.gz && \
    tar -xf nvim-linux-x86_64.tar.gz

CMD ["/bin/bash"]

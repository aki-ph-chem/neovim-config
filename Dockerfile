FROM ubuntu:latest

WORKDIR /nvim

RUN apt update -y && \ 
    apt install wget tar git tzdata -y &&\
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz && \
    tar -xf nvim-linux-x86_64.tar.gz && \
    rm nvim-linux-x86_64.tar.gz 

ENV NVIM_EXEC_PATH=/nvim/nvim-linux-x86_64/bin/nvim

CMD ["/bin/bash"]

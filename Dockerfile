FROM ubuntu:latest

WORKDIR /root

RUN apt update -y && apt install wget tar git -y
RUN wget https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.tar.gz && \
    tar -xf nvim-linux-x86_64.tar.gz && \ 
    mkdir /root/.config

COPY nvim /root/.config/nvim

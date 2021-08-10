FROM ubuntu:20.04
WORKDIR /workdir
COPY . .
RUN apt update && apt install --yes \
    make

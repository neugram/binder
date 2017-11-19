##
## a simple Dockerfile where Go and Gophernotes are installed
##
from andrewosh/binder-base
maintainer Sebastien Binet <binet@cern.ch>

user root

env GOVERS 1.9.2

# install Go
run apt-get update -y && \
	apt-get install -y curl git pkg-config && \
	curl -O -L https://golang.org/dl/go${GOVERS}.linux-amd64.tar.gz && \
	tar -C /usr/local -zxf go${GOVERS}.linux-amd64.tar.gz && \
	/bin/rm go${GOVERS}.linux-amd64.tar.gz

user main

env GOPATH $HOME/gopath
env PATH $GOPATH/bin:/usr/local/go/bin:$PATH

run go get golang.org/x/tools/cmd/goimports && \
	go get neugram.io/ng/...

# install the Go kernel
run mkdir -p $HOME/.local/share/jupyter/kernels/neugram

copy ./kernel.json $HOME/.local/share/jupyter/kernels/neugram/.
copy ./logo-32x32.png $HOME/.local/share/jupyter/kernels/neugram/.
copy ./logo-64x64.png $HOME/.local/share/jupyter/kernels/neugram/.

run mkdir -p $HOME/notebooks

user root
run chown -R main:main /home/main/notebooks

FROM golang:1.12-alpine as builder

MAINTAINER Olaoluwa Osuntokun <lightning.engineering>

# Copy in the local repository to build from.
COPY . /go/src/github.com/lightningnetwork/lnd

# Copy in the sense directory. TODO: should really be in a separate project and pull in stable LND
COPY ../lightning-sense-py /sense

# Force Go to use the cgo based DNS resolver. This is required to ensure DNS
# queries required to connect to linked containers succeed.
ENV GODEBUG netdns=cgo

# Install dependencies and install/build lnd.
RUN apk add --no-cache --update alpine-sdk \
    make \
&&  cd /go/src/github.com/lightningnetwork/lnd \
&&  make \
&&  make install tags="signrpc walletrpc chainrpc invoicesrpc"

# Start a new, final image to reduce size.
FROM alpine as final

# Expose lnd ports (server, rpc).
EXPOSE 9735 10009

# Copy the binaries and entrypoint from the builder image.
COPY --from=builder /go/bin/lncli /bin/
COPY --from=builder /go/bin/lnd /bin/

# Add bash.
RUN apk add --no-cache \
    bash

# install grpc stuff
RUN apk add --no-cache \
    git curl python python-dev py-pip build-base 

# Should be copied into the `./sense` directory already
# RUN pip install virtualenv grpcio grpcio-tools googleapis-common-protos
# RUN git clone https://github.com/googleapis/googleapis.git
# RUN curl -o rpc.proto -s https://raw.githubusercontent.com/lightningnetwork/lnd/master/lnrpc/rpc.proto
# RUN python -m grpc_tools.protoc --proto_path=googleapis:. --python_out=. --grpc_python_out=. rpc.proto

# Copy the entrypoint script.
COPY "docker/lnd/start-lnd.sh" .
RUN chmod +x start-lnd.sh

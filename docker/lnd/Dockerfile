FROM golang:1.12-alpine as builder

MAINTAINER Olaoluwa Osuntokun <lightning.engineering>

# Copy in the local repository to build from.
COPY . /sense

# Force Go to use the cgo based DNS resolver. This is required to ensure DNS
# queries required to connect to linked containers succeed.
ENV GODEBUG netdns=cgo

# Install dependencies and install/build lnd.
RUN apk add --no-cache --update alpine-sdk \
    make \
&&  cd /sense/lnd \
&&  make \
&&  make install tags="signrpc walletrpc chainrpc invoicesrpc"

# Install dependencies and Compile proto
# install grpc stuff
RUN apk add --no-cache \
    git curl python python-dev py-pip build-base py-virtualenv \
&&  cd /sense \
&&  virtualenv lnd \
&&  source lnd/bin/activate \
&&  pip install grpcio grpcio-tools googleapis-common-protos \
&&  python -m grpc_tools.protoc --proto_path=googleapis:. --python_out=. --grpc_python_out=. rpc.proto

# Start a new, final image to reduce size.
# TOOD: comment this back in and figure out deploying webserver
# FROM alpine as final

# Expose lnd ports (server, rpc).
EXPOSE 9735 10009

# Copy the binaries and entrypoint from the builder image.
# COPY --from=builder /go/bin/lncli /bin/
# COPY --from=builder /go/bin/lnd /bin/
COPY /go/bin/lncli /bin/
COPY /go/bin/lnd /bin/

# Add bash.
RUN apk add --no-cache \
    bash

# Get entrypoint script executable ok
COPY "docker/lnd/start-lnd.sh" /
RUN chmod +x /start-lnd.sh

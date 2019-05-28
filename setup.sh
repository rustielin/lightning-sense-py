#!/bin/bash

# downloads a bunch of crap. only run once

# clone lnd and build locally from source
# TODO: find a stable release to checkout and build from
git clone https://github.com/lightningnetwork/lnd.git

# to be compiled in docker
git clone https://github.com/googleapis/googleapis.git
curl -o rpc.proto -s https://raw.githubusercontent.com/lightningnetwork/lnd/master/lnrpc/rpc.proto

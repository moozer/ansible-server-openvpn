#!/bin/bash

set -e

client=$1

if [ x$client = x ]; then
    echo "Usage: $0 clientname"
    exit 1
fi

if [ ! -e pki/private/$client.key ]; then
    echo "Generating keys..."
    ./easyrsa gen-req $client nopass
    ./easyrsa sign-req client $client
    echo "...keys generated."
fi

tarball=./pki/$client.tgz

if [ ! -e $tarball ]; then
    echo "Creating tarball..."
    tmpdir=/tmp/client-tar.$$
    mkdir $tmpdir
    cp {{ openvpn_client_conf }} $tmpdir/{{ openvpn_client_conf }}
    cp pki/ca.crt $tmpdir 
    cp pki/private/ta.key $tmpdir 
    cp pki/private/$client.key $tmpdir/client.key
    cp pki/issued/$client.crt $tmpdir/client.crt
    tar -C $tmpdir -czvf $tarball .
    rm -rf $tmpdir
    echo "...tarball created" 
else
    echo "Nothing to do, so nothing done. ($tarball already exists)" 
fi

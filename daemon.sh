#!/usr/bin/env bash

set -e
set -o pipefail
set -o verbose
#set -o xtrace

PWD=$(cd "$(dirname "$0")" && pwd)
export PATH="$PWD:$PATH"

gencerts

mkdir -p .btcd .btcwallet
cp rpc.cert rpc.key .btcwallet/
cp "$GOPATH"/src/github.com/btcsuite/btcwallet/sample-btcwallet.conf  "${HOME}"/.btcwallet/btcwallet.conf
cp "$GOPATH"/src/github.com/btcsuite/btcd/sample-btcd.conf "${HOME}"/.btcd/btcd.conf
cp rpc.cert rpc.key .btcd/

btcwallet --username=root --password=1314 --simnet --createtemp --appdata="${HOME}"/.btcwallet &

sleep 2
miningaddr=$(btcctl --rpcuser=root --rpcpass=1314 --simnet --wallet getnewaddress)

echo "mingaddress: ${miningaddr}"

btcctl --rpcuser=root --rpcpass=1314 --simnet --wallet listacounts
sleep 2

btcd --simnet --rpcuser=root --rpcpass=1314 --miningaddr="${miningaddr}" --txindex
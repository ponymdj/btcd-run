#!/usr/bin/env bash

set -e
set -o pipefail
set -o verbose
# set -o xtrace

PWD=$(cd "$(dirname "$0")" && pwd)
export PATH="$PWD:$PATH"

gencerts --host=btcd  -f

mkdir -p "${HOME}"/.btcd "${HOME}"/.btcwallet
cp rpc.cert rpc.key "${HOME}"/.btcwallet/
cp "$GOPATH"/src/github.com/btcsuite/btcwallet/sample-btcwallet.conf "${HOME}"/.btcwallet/btcwallet.conf
cp "$GOPATH"/src/github.com/btcsuite/btcd/sample-btcd.conf "${HOME}"/.btcd/btcd.conf
cp rpc.cert rpc.key "${HOME}"/.btcd/

btcwallet --username=root --password=1314 --simnet --createtemp --appdata="${HOME}"/.btcwallet &

sleep 10
miningaddr=$(btcctl --rpcuser=root --rpcpass=1314 --simnet --wallet getnewaddress)

echo "mingaddress: ${miningaddr}"

btcctl --rpcuser=root --rpcpass=1314 --simnet --wallet listaccounts
sleep 2

btcd --simnet --rpcuser=root --rpcpass=1314 --rpclisten="0.0.0.0:18556" --miningaddr="${miningaddr}" --txindex
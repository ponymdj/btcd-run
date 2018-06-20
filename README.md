# btcd-run
btcd run with docker

```

btcctl --rpcuser=root --rpcpass=1314 --simnet --wallet listaccounts

btcctl --rpcuser=root --rpcpass=1314 --simnet generate 100

btcctl --rpcuser=root --rpcpass=1314 --simnet generate 1

```
or

```
docker exec [实例id或者name] btcctl --rpcuser=root --rpcpass=1314 --simnet --wallet listaccounts

docker exec [实例id或者name] btcctl --rpcuser=root --rpcpass=1314 --simnet generate 100

docker exec [实例id或者name] btcctl --rpcuser=root --rpcpass=1314 --simnet generate 1
```
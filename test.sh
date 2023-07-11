#!/bin/bash

response=`curl -s -X POST https://bsc-dataseed1.binance.org -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}'`
blocknumber=`printf "%d\n"  $(echo $response | jq '.result' -r)`
echo "Using latest blocknumber: $blocknumber"

# Check if a command is provided as an argument
if [ $# -eq 0 ]; then
  echo "Please provide a command to run."
  exit 1
fi

# Get the command as a string
command=$@

export BSC_BLOCK_NUMBER=$blocknumber

# Execute the command
eval "forge test $command"
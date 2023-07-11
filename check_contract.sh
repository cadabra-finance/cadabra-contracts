#!/bin/bash
############################
# install forge
#
# more about slither https://github.com/crytic/slither
############################
BASEDIR=$(dirname $0)
solcVersion="0.8.19"
echo "solc version $solcVersion"
fileName="$(basename -s .sol $1)"
echo "start analyze contract $fileName.sol"
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT
tmpPathSol=$tmp/$fileName.sol
tmpPathMd=$tmp/$fileName.md
resultPath=$BASEDIR/slither/$fileName.md
forge flatten $1 > $tmpPathSol
c="solc-select install $solcVersion && solc-select use $solcVersion && slither /share/$fileName.sol --checklist > /share/$fileName.md --filter-paths \"IERC20.sol|SafeERC20.sol|Address.sol\""
docker run -it -v $tmp:/share trailofbits/eth-security-toolbox -c "$c" > /dev/null 2>&1

mv $tmpPathMd $resultPath
rm $tmpPathSol

echo "done. result: $resultPath"
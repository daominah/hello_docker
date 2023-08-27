#!/usr/bin/env bash

set -e

# option: `--progress=plain`, `--no-cache`
docker build  --tag=daominah/go121 .

docker push daominah/go121

set +e

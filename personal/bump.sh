#!/usr/bin/env bash

LAST_PWD=$(pwd)
cd ~/3pp/void-packages || exit 1

./personal/bump_zen.sh

cd "$LAST_PWD" || exit 1

#!/usr/bin/env bash

DEPENDENCIES=$(awk '$0 == "[dependencies]" {i=1;next};i && i >= 0' wally.toml)

cd test

echo "$DEPENDENCIES" >> wally.toml
wally install

cd ..

if [[ ! -d test/Packages ]]; then
    mkdir test/Packages
    mkdir test/Packages/_Index
fi

mkdir test/Packages/_Index/zxibs_signalservice

cp -R src test/Packages/_Index/zxibs_signalservice/signalservice
echo 'return require(script.Parent._Index["zxibs_signalservice"]["signalservice"])' > test/Packages/SignalService.lua

rojo build test/test.project.json -o test/signalservice-test.rbxlx

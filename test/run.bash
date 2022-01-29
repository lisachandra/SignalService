#!/usr/bin/env bash

while true; do
    run-in-roblox --place test/signalservice-test.rbxlx --script test/runner.server.lua

    if [[ "$(echo $?)" == 0]]; then
        break
    fi

    sleep 1
done

echo "Script ran successfully"

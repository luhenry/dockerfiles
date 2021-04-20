#!/bin/bash

ORGANIZATION=$ORGANIZATION
PROJECT=$PROJECT
ACCESS_TOKEN=$ACCESS_TOKEN

REG_TOKEN=$(curl -X POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${ACCESS_TOKEN}" https://api.github.com/repos/${ORGANIZATION}/${PROJECT}/actions/runners/registration-token | jq .token --raw-output)

cd ~/actions-runner

./config.sh --unattended --url https://github.com/${ORGANIZATION}/${PROJECT} --token ${REG_TOKEN}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT

./run.sh & wait $!

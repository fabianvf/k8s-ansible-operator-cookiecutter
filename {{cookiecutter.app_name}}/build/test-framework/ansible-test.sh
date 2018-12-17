#!/bin/sh

(/usr/local/bin/entrypoint)&
trap "kill $!" SIGINT SIGTERM EXIT

cd ${HOME}/project
exec molecule test -s test-cluster

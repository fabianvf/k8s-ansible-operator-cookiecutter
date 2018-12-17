#!/bin/sh

(${OPERATOR:-/usr/local/bin/ansible-operator})&
trap "kill $!" SIGINT SIGTERM EXIT

cd ${HOME}/project
exec "molecule test -s test-cluster"

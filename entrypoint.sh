#!/bin/bash

set -o errexit

set -e

bundle exec rails db:prepare

if [ -f tmp/pids/server.pid ]; then
    rm tmp/pids/server.pid
fi

exec "$@"

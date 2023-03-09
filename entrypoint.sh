#!/bin/bash

set -o errexit

set -e

bundle exec rails db:prepare
bundle exec rails db:seed

if [ -f tmp/pids/server.pid ]; then
    rm tmp/pids/server.pid
fi

exec "$@"

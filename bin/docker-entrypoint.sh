#!/bin/bash -e

# If running the rails server then create or migrate existing database
# if [ "${1}" == "./bin/rails" ] && [ "${2}" == "server" ]; then
  echo "running migrations"
  ./bin/rails db:prepare
# fi

exec "${@}"

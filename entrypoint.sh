#!/bin/sh
set -e

# Create and migrate database
rake db:create
rake db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

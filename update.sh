#!/usr/bin/env bash

APACHE_DOCKER_IMAGE="c4dt/apache:latest"
# Must match the path used when running the actual Apache service
SHOWCASE_MOUNTPOINT="/var/www/showcase"

# For docker
PATH=${PATH}:/snap/bin

cd ~/showcase

# Clean local changes (if any)
git checkout .

git pull

# Recreate virtual env
docker run \
    --rm \
    --mount type=bind,src=/home/showcase/showcase,dst=${SHOWCASE_MOUNTPOINT} \
    --user `id -u`:`id -g` \
    ${APACHE_DOCKER_IMAGE} \
    make -C ${SHOWCASE_MOUNTPOINT} clean env

# Touching the main WSGI app file triggers a reload
touch app.wsgi

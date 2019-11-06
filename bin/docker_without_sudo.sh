#!/bin/sh
set -e

if [ ! $(getent group docker) ]; then
  sudo groupadd docker
fi

sudo usermod -aG docker $USER

newgrp docker

echo "You can run command `docker run hello-world` without sudo"

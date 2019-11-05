#!/bin/sh
set -e

sudo groupadd docker

sudo usermod -aG docker $USER

newgrp docker

echo "You can run command `docker run hello-world` without sudo"

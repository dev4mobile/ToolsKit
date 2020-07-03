#! /bin/bash

set -e

project_name=$1

if [ ! -d "${project_name}" ]; then
  echo "${project_name} not exist."
  mkdir "$project_name"
fi

cd "${project_name}"

mkdir -p src/main/java src/main/resources src/test/java src/test/resources

curl https://gist.githubusercontent.com/dev4mobile/1a919dd2690951705bafb684f1e2a00d/raw/90e0c53e61181d107f2d6d9d6e4c16c9309e7e50/pom_template.txt -o pom.xml

curl https://gist.githubusercontent.com/dev4mobile/8e109a7eb2355daad0fb01b912a177ab/raw/1dd69f151221f3d8d63a40f12c239aa00f37211a/.gitignore_template -o .gitignore

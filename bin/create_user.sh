#!/bin/sh
set -e

if [ `whoami` != 'root' ]; then
  echo "[Error] current `whoami` is not root user"
  exit 1;
fi

echo -e "Please input user name:\c"

read user_name;

if [[ -z $user_name ]]; then
  echo "User name can't be empty"
  exit;
fi

echo "Create user:$user_name"

adduser ${user_name}

#generate default password

password=`cat /proc/sys/kernel/random/uuid`

echo $password

echo $password | passwd $user_name --stdin

#added to wheel group
usermod -aG wheel $user_name;

read -p "Paste $user_name's ssh key: "

ssh_key=$REPLY

su - $user_name <<EOF
cd ~
mkdir .ssh
cd .ssh
echo $ssh_key > authorized_keys
chmod 600 authorized_keys
chmod 700 ~/.ssh
EOF

echo -n "Added sudo permissions to $user_name?(y/n)?:"

read need;

if [ $need='y' ]; then
  echo "${user_name} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${user_name}
  chmod 440 /etc/sudoers.d/${user_name}
  echo "Sudo Added success."
elif [ $need='n' ]; then
  echo "No need sudo permissions"
else
  exit 0
fi

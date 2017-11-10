#!/bin/sh -xe

# Preconditions
[ -S /var/run/docker.sock ]
java -version

# Add user to docker group
gid="`stat -c '%g' /var/run/docker.sock`"
[ "$gid" -gt 0 ]
delgroup docker || true
addgroup -g "$gid" docker
addgroup jenkins docker
id jenkins

# Generate random password if not given
[ -z "$ssh_passwd" ] && ssh_passwd="`tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 16`"

# Set password of jenkins user
echo "jenkins:${ssh_passwd}" | chpasswd
echo "Connect via SSH as jenkins user with password: ${ssh_passwd}"
unset ssh_passwd

# Run SSHD
exec /usr/sbin/sshd -D -e

#!/bin/bash

rm /etc/apt/sources.list
echo 'deb https://mirrors.ustc.edu.cn/ubuntu focal main restricted universe multiverse'>>/etc/apt/sources.list
echo 'deb https://mirrors.ustc.edu.cn/ubuntu focal-backports main restricted universe multiverse'>>/etc/apt/sources.list
echo 'deb https://mirrors.ustc.edu.cn/ubuntu focal-proposed main restricted universe multiverse'>>/etc/apt/sources.list
echo 'deb https://mirrors.ustc.edu.cn/ubuntu focal-security main restricted universe multiverse'>>/etc/apt/sources.list
echo 'deb https://mirrors.ustc.edu.cn/ubuntu focal-updates main restricted universe multiverse'>>/etc/apt/sources.list
echo 'deb-src https://mirrors.ustc.edu.cn/ubuntu focal main restricted universe multiverse'>>/etc/apt/sources.list
echo 'deb-src https://mirrors.ustc.edu.cn/ubuntu focal-backports main restricted universe multiverse'>>/etc/apt/sources.list
echo 'deb-src https://mirrors.ustc.edu.cn/ubuntu focal-proposed main restricted universe multiverse'>>/etc/apt/sources.list
echo 'deb-src https://mirrors.ustc.edu.cn/ubuntu focal-security main restricted universe multiverse'>>/etc/apt/sources.list
echo 'deb-src https://mirrors.ustc.edu.cn/ubuntu focal-updates main restricted universe multiverse'>>/etc/apt/sources.list

if [ "${KEY}" != "**None**" ]; then
    echo "=> Found authorized keys"
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    touch /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    IFS=$'\n'
    arr=$(echo ${KEY} | tr "," "\n")
    for x in $arr
    do
        x=$(echo $x |sed -e 's/^ *//' -e 's/ *$//')
        cat /root/.ssh/authorized_keys | grep "$x" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "=> Adding public key to /root/.ssh/authorized_keys: $x"
            echo "$x" >> /root/.ssh/authorized_keys
        fi
    done
    else echo "=> Please add authorized keys"
fi

exec /usr/sbin/sshd -D

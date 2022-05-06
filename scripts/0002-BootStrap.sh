#!/bin/bash  -xue

script_dir=$(dirname $0)
chef_dir=${script_dir}/../chef-repo

function  show_help_message () {
    echo  "Usage: $0 (IP) (KEY) [USER]" 1>&2
}

if [[ $# -lt 2 ]] ; then
    show_help_message
    exit  2
fi

target_vps=$1
ssh_private_key=$2
shift  2

ssh_user_name=ubuntu
if [[ $# -ge 1 ]] ; then
    ssh_user_name=$1
    shift  1
fi

pushd  ${chef_dir}
bundle  exec                \
knife  zero  bootstrap      \
    -x ${ssh_user_name}     \
    -i ${ssh_private_key}   \
    --sudo  -N server1      \
    --verbose               \
    ${target_vps}           \
    ;
popd

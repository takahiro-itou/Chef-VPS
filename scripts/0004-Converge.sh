#!/bin/bash  -xue

script_dir=$(dirname $0)
chef_dir=${script_dir}/../chef-repo

function  show_help_message () {
    echo  "Usage: $0 (KEY) [USER]" 1>&2
}

if [[ $# -lt 1 ]] ; then
    show_help_message
    exit  2
fi

ssh_private_key=$1
shift  1

ssh_user_name=ubuntu
if [[ $# -ge 1 ]] ; then
    ssh_user_name=$1
    shift  1
fi

pushd  ${chef_dir}
bundle  exec                        \
    knife  zero                     \
    -c conf.rb                      \
    converge  'name:server1'        \
    -a knife_zero.host              \
    -x ${ssh_user_name}             \
    -i ${ssh_private_key}           \
    --sudo  --verbose               \
    ;
popd

#!/bin/bash  -ue

script_dir=$(dirname $0)
chef_dir=${script_dir}/../chef-repo

function  show_help_message () {
    echo  "Usage: $0 (RECIPE)"              1>&2
    echo  "Example: $0  'recipe[nginx]'"    1>&2
}

if [[ $# -lt 1 ]] ; then
    set  +x
    show_help_message
    exit  2
fi

set  -x
pushd ${chef_dir}
knife  node  \
    -c conf.rb      \
    run_list        \
    add  server1    \
    -z              \
    "$@"            \
    ;
popd


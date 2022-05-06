#!/bin/bash  -xue

script_dir=$(dirname  $0)
bundle_dir="${script_dir}/../submodules/knifezero"
chef_dir="${script_dir}/../chef-repo"

pushd  ${bundle_dir}
./Install.sh
popd

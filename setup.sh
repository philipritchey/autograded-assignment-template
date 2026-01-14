#!/usr/bin/env bash

# update and upgrade
apt-get update
apt-get -y upgrade

# install dependencies
apt-get -y install apt-utils valgrind num-utils

cd /autograder/source
mkdir -p /root/.ssh
cp ssh_config /root/.ssh/config

mv deploy_key /root/.ssh/deploy_key
chmod 600 /root/.ssh/deploy_key

# you should fork https://github.com/philipritchey/autograder-core and follow the above instructions (roughly)
# to make your own autograder-core deploy key(s)
mv autograder_core_deploy_key /root/.ssh/autograder_core_deploy_key
chmod 600 /root/.ssh/autograder_core_deploy_key

# To prevent host key verification errors at runtime
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Clone autograder files
#
# TODO(you)
#
# set your username and repository for the assignment-specific content (i.e. tests)
username=your_username
repository=repository_for_assignment
git clone git@assignment:$username/$repository.git /autograder/autograder-code
git clone git@core:$username/autograder-core.git /autograder/autograder-core


#!/usr/bin/env bash

#
# TODO(you)
#
# set your username and repository for the assignment-specific content (i.e. tests)
username=your_username
repository=repository_for_assignment

################################################################################
##
## DON'T MESS WITH THIS STUFF DOWN HERE, please.
##
################################################################################

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

mv autograder_core_deploy_key /root/.ssh/autograder_core_deploy_key
chmod 600 /root/.ssh/autograder_core_deploy_key

# To prevent host key verification errors at runtime
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Clone autograder files
git clone git@assignment:$username/$repository.git /autograder/autograder-code
git clone git@core:philipritchey/autograder-core.git /autograder/autograder-core

# add unprivileged student user
adduser student --no-create-home --disabled-password --gecos ""
# remove student access to autograder code and core
chmod o= /autograder/autograder-code
chmod o= /autograder/autograder-core

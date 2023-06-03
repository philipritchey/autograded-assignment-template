# autograded-assignment-template
a template repo for an autograded assignment

## Gradescope Setup

### make a deploy key
`ssh-keygen -t ed25519 -C "gradescope"`

save it as `./deploy_key` with no passphrase

`mv ./deploy_key ./secrets/deploy_key` to move the secret key to the `secrets/` directory

on GitHub, add contents of `./deploy_key.pub` to your assignment-specific repo as a new deploy key

### add autograder-core deploy key

`cp /path/to/autograder_core_deploy_key ./secrets/autograder_deploy_key`

if you don't have one, [get one](https://github.com/philipritchey/autograder-core)!

### prepare upload to gradescope
`make`

creates the file `autograder.zip`

### upload to gradescope
Upload `autograder.zip` to Gradescope.

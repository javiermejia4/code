#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace

name=testapp1
env=stageenv

# Lets use AWS CLI # needs further testing...
aws elasticbeanstalk create-application-version --application-name $name 
aws elasticbeanstalk update-environment --environment-name $env 

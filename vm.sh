#!/bin/bash

# Control my Virtualbox machine
VBoxManage controlvm Ubuntu poweroff
VBoxManage snapshot Ubuntu restorecurrent
VBoxManage startvm --type headless Ubuntu 

# Connect through ssh
ssh rprod

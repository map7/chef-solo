#!/bin/bash
# Reset and restart my server as a headless server.
#
# Control my Virtualbox machine
VBoxManage controlvm Ubuntu poweroff
VBoxManage snapshot Ubuntu restorecurrent
VBoxManage startvm --type headless Ubuntu 


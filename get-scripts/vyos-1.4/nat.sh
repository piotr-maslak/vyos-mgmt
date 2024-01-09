#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
run show nat destination rules
echo
run show nat source rules
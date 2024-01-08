#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
backup1(){
    run show nat destination rules
    echo
    run show nat source rules
}
backup1
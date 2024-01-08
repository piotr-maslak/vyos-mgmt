#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
backup1(){
    run show firewall group
    echo
    run show firewall
}
backup1
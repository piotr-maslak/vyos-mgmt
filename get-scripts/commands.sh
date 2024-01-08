#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
backup1(){
    run show configuration commands
}
backup1
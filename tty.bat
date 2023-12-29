@echo off
call config.cmd

IF "%pw%" == "" (SET /p pw=enter password or press enter to use pagent:)
IF NOT "%pw%" == "" (SET pw=-pw %pw%)
IF "%pw%" == "" (SET pw=-agent)
putty.exe -ssh -P %port% %pw% %user%@%host%
pause
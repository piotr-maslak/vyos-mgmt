@echo off
if exist config.cmd (
    call config.cmd
) else (
    call ..\config.cmd
)

putty.exe -ssh -P %port% %pw% %user%@%host%
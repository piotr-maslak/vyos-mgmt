@echo off
if exist config.cmd (
    call config.cmd
) else (
    call ..\config.cmd
)

bvssh.exe -start=login -port=%port% -host=%host% -user=%user% %pw%
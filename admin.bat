@echo off

call default.config.cmd
if exist config.cmd (
    call config.cmd
)


IF NOT "%1" == "" (
    if exist admin\%1.config.cmd (
        call admin\%1.config.cmd
    )
)

IF "%pw%" == "" ( SET /p pw="press enter to use agent or enter password for user %user%:" )
IF NOT "%pw%" == "" (
    SET pw=-pw %pw%
) else (
    SET pw=-agent
)

IF NOT "%1" == "" (
    call admin\%1.bat
) else (
    call admin\index.cmd
)
@echo off
if exist config.cmd (
    call config.cmd
) else (
    call ..\config.cmd
)


IF "%pw%" == "" ( SET /p pw="enter password or press enter to use agent:" )
IF NOT "%pw%" == "" (	SET pw=-pw=%pw%	)
IF "%pw%" == "" (SET pw="-pk=a")

bvssh.exe -start=login -port=%port% -host=%host% -user=%user% %pw%
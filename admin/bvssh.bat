@echo off
IF NOT "%pw%" == "" (
    SET pw="-password=%pw%"
)
echo bvssh.exe -start=login -port=%port% -host=%host% -user=%user% %pw%
bvssh.exe -start=login -port=%port% -host=%host% -user=%user% %pw%
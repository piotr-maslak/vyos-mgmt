@echo off
echo bvssh.exe -start=login -port=%port% -host=%host% -user=%user% %pw%
bvssh.exe -start=login -port=%port% -host=%host% -user=%user% %pw%
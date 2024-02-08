@echo off
IF NOT "%pw%" == "" (
    SET pw=-pw %pw%
) else (
    SET pw=-agent
)
echo putty.exe -ssh -P %port% %pw% %user%@%host% 
putty.exe -ssh -P %port% %pw% %user%@%host%
@echo off
if exist config.cmd (   
    call config.cmd
) else (
    call ..\config.cmd
)
if exist include (
    call include\include.cmd
) else (
    call ..\include\config.cmd
)

IF NOT "%pw%" == "" (	SET pw=-pw %pw%	)
IF "%pw%" == "" (SET pw=-agent)

echo connecting %host%

echo get configuration
plink -batch -P %port% %pw% %user%@%host% -m %scrpath%\configuration.sh > configuration-%date%.cfg
ping localhost -n %timeout% >NUL

echo get configuration-commands
plink -batch -P %port% %pw% %user%@%host% -m %scrpath%\commands.sh > commands-%date%.cfg
ping localhost -n %timeout% >NUL

echo get firewall-rules
plink -batch -P %port% %pw% %user%@%host% -m %scrpath%\firewall.sh > firewall-%date%.txt
ping localhost -n %timeout% >NUL

echo get nat-rules
plink -batch -P %port% %pw% %user%@%host% -m %scrpath%\nat.sh > nat-%date%.txt
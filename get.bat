@echo off
if exist config.cmd (   
    call config.cmd
) else (
    call ..\config.cmd
)

echo connecting %host%

echo get configuration
plink -batch -P %port% %pw% %user%@%host% -m get-scripts\%version%\configuration.sh > configuration-%date%.cfg
ping localhost -n %timeout% >NUL

echo get configuration-commands
plink -batch -P %port% %pw% %user%@%host% -m get-scripts\%version%\commands.sh > commands-%date%.cfg
ping localhost -n %timeout% >NUL

echo get firewall-rules
plink -batch -P %port% %pw% %user%@%host% -m get-scripts\%version%\firewall.sh > firewall-%date%.txt
ping localhost -n %timeout% >NUL

echo get nat-rules
plink -batch -P %port% %pw% %user%@%host% -m get-scripts\%version%\nat.sh > nat-%date%.txt
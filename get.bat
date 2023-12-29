@echo off
call config.cmd
IF "%pw%" == "" (SET /p pw=enter password or press enter to use pagent:)
IF NOT "%pw%" == "" (SET pw=-pw %pw%)
IF "%pw%" == "" (SET pw=-agent)
echo get from %host%
echo get configuration          (plink -batch -P %port% %pw% %user%@%host% -m get-scripts\configuration.sh)
plink -batch -P %port% %pw% %user%@%host% -m get-scripts\configuration.sh > configuration.cfg
echo get completed, wait %timeout%s
ping localhost -n %timeout% >NUL
echo get configuration-commands (plink -batch -P %port% %pw% %user%@%host% -m get-scripts\commands.sh)
plink -batch -P %port% %pw% %user%@%host% -m get-scripts\commands.sh > commands.cfg
echo get completed, wait %timeout%s
ping localhost -n %timeout% >NUL
echo get firewall-rules         (plink -batch -P %port% %pw% %user%@%host% -m get-scripts\firewall.sh)
plink -batch -P %port% %pw% %user%@%host% -m get-scripts\firewall.sh > firewall.txt
echo get completed, wait %timeout%s
ping localhost -n %timeout% >NUL
echo get nat-rules              (plink -batch -P %port% %pw% %user%@%host% -m get-scripts\nat.sh)
plink -batch -P %port% %pw% %user%@%host% -m get-scripts\nat.sh > nat.txt
echo get completed
if exist .git (
	git add "*.txt"
	git add "*.cfg"
	git add "*.md"
	git commit -m "commited"
) else (
    git init
	git add "*.txt"
	git add "*.cfg"
	git add "*.md"
	git commit -m "commited"
)
pause
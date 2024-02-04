@echo off
echo putty.exe -ssh -P %port% %pw% %user%@%host% 
putty.exe -ssh -P %port% %pw% %user%@%host%
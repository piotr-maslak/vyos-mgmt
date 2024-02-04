@echo off

@REM usage: ssh [-46AaCfGgKkMNnqsTtVvXxYy] [-B bind_interface]
@REM            [-b bind_address] [-c cipher_spec] [-D [bind_address:]port]
@REM            [-E log_file] [-e escape_char] [-F configfile] [-I pkcs11]
@REM            [-i identity_file] [-J [user@]host[:port]] [-L address]
@REM            [-l login_name] [-m mac_spec] [-O ctl_cmd] [-o option] [-p port]
@REM            [-Q query_option] [-R address] [-S ctl_path] [-W host:port]
@REM            [-w local_tun[:remote_tun]] destination [command]

echo ssh.exe -l %user% -p %port% %host%
ssh.exe -l %user% -p %port% %host%
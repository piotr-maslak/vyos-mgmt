### Description
Management scripts for VyOS  
This scipts is requiring :
- Putty | https://www.chiark.greenend.org.uk/~sgtatham/putty/
- Bitvise SSH Client | https://www.bitvise.com/ssh-client-download 

The key authentication method need you to provide a key within an agent
``` pageant .\path\to\key.ppk ```

The **config.cmd** file should contain variables that enables your scripts to connect to the server remotely using the ssh protocol. The variables are:
```
host=localhost (host fqdn)
port=22 (port number)
user=vyos (username string)
pw=yvos (password string)
timeout=3 (in seconds)
version=vyos-1.2 || vyos-1.3 || vyos-1.4
```
There is a ***default*** folder which contains example of config.cmd and some other default settings for your router.

### Initial VyOS configuration
```
set interfaces ethernet eth0 address '192.168.X.X/24'
set system gateway-address '192.168.X.X'
set service ssh port '2222'
set system login user vyos authentication plaintext-password 'p@s$w0rD'
```

### Hardware
| RAM | DISK | CPU |
|-----|------|-----|
|     |      |     |

### Management
|methods|                         |
|-------|-------------------------|
|ssh    | user@example.com:2222   |
|webui  | https://kvm.example.com |
|serial | 9600.8.1                |
### Description
Management scripts for VyOS and EdgeOS.

This scipts require following software:
- Putty | https://www.chiark.greenend.org.uk/~sgtatham/putty/
- Bitvise SSH Client | https://www.bitvise.com/ssh-client-download 

The key authentication method needs you to provide a key within an agent<br/>
``` pageant .\path\to\key.ppk ```

The **config.cmd** file should contain variables that enables your scripts to connect to the server remotely using the ssh protocol. The variables are:
```
host=localhost (host fqdn)
port=22 (port number)
user=vyos (username string)
pw=yvos (password string)
timeout=3 (in seconds)
version=vyos-1.2 || vyos-1.3 || vyos-1.4 || edgeos
```
There is a ***default*** folder which contains example of config.cmd and some other defaults for your router.

### Example initial VyOS configuration
```
set interfaces ethernet eth0 address 'IP_ADDRESS/24'
set system gateway-address 'IP_ADDRESS'
set service ssh port 'PORT'
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
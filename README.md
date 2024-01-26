### Description
vyos-mgmt is a CLI utility for Windows to store VyOS ( and other vyatta based routers like EdgeOS ) configuration in a folder and through it, an easier way to back to the device and reconfigure it.

This scipts require following software (and properly configured PATH):
- Putty | https://www.chiark.greenend.org.uk/~sgtatham/putty/
- Bitvise SSH Client | https://www.bitvise.com/ssh-client-download 
- Nmap for Windows | https://nmap.org/download.html#windows

The **key authentication** method requires the agent to provide the key<br/>
example : ``` pageant .\path\to\the\key.ppk ```

The **config.cmd** file should contain variables that enables your scripts to connect to the server remotely using the ssh protocol. The file should be placed in a root of this folder. You can copy this file from a *default* folder.
The variables included are:
```
host=localhost (host fqdn)
port=22 (port number)
user=vyos (username string)
pw=yvos (password string)
timeout=3 (in seconds)
version=vyos-1.2 || vyos-1.3 || vyos-1.4 || edgeos
```

### Initial router configuration
To connect to the router with this scripts you should done a basic router configuration.
```
set interfaces ethernet eth0 address 'IP_ADDRESS/24'
set system gateway-address 'IP_ADDRESS'
set service ssh port 'PORT'
set system login user vyos authentication plaintext-password 'p@s$w0rD'
```
The more extensive configuration example is placed in a default folder.

### Hardware
| RAM | DISK | CPU |
|-----|------|-----|
|     |      |     |

### Management methods
|method |                         |
|-------|-------------------------|
|ssh    | user@example.com:2222   |
|webui  | https://kvm.example.com |
|serial | 9600.8.1                |
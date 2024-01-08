### Description
Management scripts for VyOS 
This piece of scipts requires 
- Putty | https://www.chiark.greenend.org.uk/~sgtatham/putty/
- Bitvise SSH Client | https://www.bitvise.com/ssh-client-download 

Password or key method are used as an authentication methods so you need to provide a key with and agent help
pageant .\path\to\key.ppk

The file config.cmd contains basic variables that enables you to connect to the server remotely using the protocols. There is a default-config.cmd file which desribes the varibles. The variables are:
host=localhost (host fqdn)
port=22 (port number)
user=vyos (username string)
pw=yvos (password string)
timeout=3 (in seconds)
version=vyos-1.2 | vyos-1.3 | vyos-1.4

### Initial configuration
set interfaces ethernet eth0 address '192.168.1.1/24'
set system gateway-address '192.168.1.254'
set service ssh port '2222'
set system login user vyos authentication plaintext-password 'Abcd!234'

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
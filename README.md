### Description
This is a practical, real-world example to help me to learn the PowerShell scripting language.
vyos-mgmt is a powershell script to manage vyatta based routers ( VyOS, EdgeOS ) configuration & backup.

This scipts require following software (and properly configured PATH):
- Putty | https://www.chiark.greenend.org.uk/~sgtatham/putty/

It can use serial connection (serial.json) or a remote based connection (credentials.json)
The **key authentication** method requires the agent to provide the key<br/>
example : ``` pageant .\path\to\the\key.ppk ```

The settings files should contain variables that provide the information required for your scripts to connect to the device. 
The files should be placed in the `settings` folder. If any are missing, the scripts will prompt for them the first time.

The variables are:
- system.json
```
{
  "Port": "22",
  "Hostname": "fqdn.example.com",
  "System": "vyos-1.3" or "System": "vyos-1.4" or "System": "edgeos"
}

```

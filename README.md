### Description
vyos-mgmt is a powershell script to manage vyatta based routers ( VyOS, EdgeOS ) configuration & backup in a folder.
It helps to came back to the device configuration, reconfigure it and again, store the changes. This scipts are writen in powershell and vbash

This scipts require following software (and properly configured PATH):
- Putty | https://www.chiark.greenend.org.uk/~sgtatham/putty/

The **key authentication** method requires the agent to provide the key<br/>
example : ``` pageant .\path\to\the\key.ppk ```

The settings files should contain variables that provides required info your scripts to connect to the host remotely using the ssh protocol. 
The file should be placed in settings folder. If some are missing the scripts asks for it for a first time.
The variables are:
system.json
```
{
  "Port": "22",
  "Hostname": "fqdn.example.com",
  "System": "vyos-1.3" or "System": "vyos-1.4" or "System": "edgeos"
}

```
there are also serial.json and credentials.json
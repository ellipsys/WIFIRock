# WIFIRock

Container centered in all the common tools for pentesting wifi networks.

This Docker container has the next tools:

- Macchanger
- Wireshark
- Nmap
- Pyrit
- Aircrack-ng
- Wps-pixie
- Hcxdump
- Hcxtools
- Bully
- Hashcat
- Reaver
- Cowpatty
- Wifite
- Fluxion
- All the WPS-Scripts

Running command

```
sudo docker run -it --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro --privileged --network=host --name wifirock andresmontoyain/wifirock bash
```

## More tools!

Do you want to add more tools in this project? Write me or do a pull request!

In the case of [Bettercap](https://github.com/bettercap/bettercap), this tool has its own Dockerfile config and is optimized nicely!

## Contact

- [Twitter](https://twitter.com/@AndresMontoyaIN)
- andresmontoyafcb@gmail.com

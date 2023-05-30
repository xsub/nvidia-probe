**🚧 Work in Progress**


# 📝 NVIDIA Probe

[![License](https://img.shields.io/badge/License-GPL%203.0-blue.svg)](https://github.com/xsub/nvidia-probe/blob/main/LICENSE)

This script generates a compatibility matrix report for NVIDIA drivers on AlmaLinux.

## Usage

```bash
./nvidia_probe.sh
```
    The script will retrieve various information related to the NVIDIA drivers and display it in the console.

ℹ️ Information Retrieved

The script retrieves the following information:

    Timestamp
    Kernel version
    Kernel modules
    Nouveau blacklisting
    Installed packages
    Display-class hardware list (lshw)
    NVIDIA devices list (lspci)
    Xorg log details


[EXAMPLE OUTPUT](./EXAMPLE.txt)

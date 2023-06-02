# AlmaLinux NVIDIA Driver Assistant

The "NVidia Helper (or Assistant)" project aims to streamline the process of installing NVIDIA binary graphics drivers on AlmaLinux OS systems. It consists of three interactive Command Line Interface (CLI) utilities designed to enhance user experience and simplify troubleshooting and support activities.

## NVIDIA-PROBE
`nvidia-probe.sh`: This utility scans the system for existing NVIDIA graphics hardware and any installed drivers. It collects important system information needed for driver installation, compatibility, and troubleshooting. The output of this tool can be used for support purposes and for preparing the system for new driver installation.

## NVIDIA-REPORTER
`nvidia-reporter.sh`: This utility generates reports based on the information collected by the NVIDIA PROBE. It provides detailed insights about the system's graphics capabilities, driver versions, and compatibility. The reports can be stored in a local SQLite database for further reference or troubleshooting.

## NVIDIA-INSTALLER
`nvidia-installer`: This utility automates the installation process of the NVIDIA binary graphics driver. Using the data generated by NVIDIA PROBE and NVIDIA REPORTER, it identifies the correct driver for the system, downloads it, and initiates the installation process.


The outputs of these tools are formatted for three specific targets:

## Almalinux Local DB
Outputs are stored as SQLite database entries for easy access, querying, and long-term storage (distributed with the package)

## Almalinux NVIDIA Wiki - NVIDIA Compatibility Matrix
Outputs are formatted to be directly usable in the wiki, aiding in the maintenance of a compatibility matrix for different NVIDIA hardware and driver combinations.

## Almalinux Chat Post Format
For troubleshooting purposes, outputs are also formatted to be copy-pasted directly into chat.almalinux.org. This encourages community engagement and simplifies the process of sharing system details for troubleshooting.
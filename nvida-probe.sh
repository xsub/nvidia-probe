#!/bin/bash
# The AlmaLinux NVIDIA compatiblity matrix report generator (script).

separator() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" | tr ' ' $1
}

sep_print() {
    separator -
    echo $*
    separator =
}

sep_print "TIMESTAMP"
date +%Y-%m-%d-%H-%M-%S

# Find kernel settings
sep_print "KERNEL VERSION"
uname -a

sep_print "KERNEL MODULES"
lsmod | grep -Ei '(nouv|nvidia)'

sep_print "NOUVEAU BLACKLIST CHECK"
grep 'blacklist nouveau' /etc/modprobe.d/nouveau-blacklist.conf
grep GRUB_CMDLINE_LINUX /etc/default/grub

# Find installed packges
sep_print "PACKAGES"
sudo dnf list installed '*nvidia*'

# Find Display-class devicess
sep_print "DISPLAY CLASSH HW LIST (lshw)"
sudo lshw -class display

# List NVIDIA devices
sep_print "NVIDIA DEVICES LIST (lspci)"
lspci -kvd 10de:

# Find interesting data in /dev/log/Xorg.0.log
sep_print "XORG LOG DETAILS (parse for selected)"
[ -f /var/log/Xorg.0.log ] &&
grep -E 'X.Org X |loading driver|Kernel command|Operating|NVIDIA GLX Module' /var/log/Xorg.0.log | \
cut -d']' -f2- | sed 's/^ //' | tr -d "\t"

# Find GLX renderer info 
if w $USER | grep -q ":0"; then
  sep_print "GLXGEARS INFO"
  timeout 5 glxgears -info
fi


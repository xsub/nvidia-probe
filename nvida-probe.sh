#!/bin/bash
# The AlmaLinux NVIDIA compatiblity matrix report generator (script).

separator() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '-'
}

sep_print() {
    separator
    echo $*
    separator 
}

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

# Find interesting data in /dev/log/Xorg.0.log
sep_print "XORG LOG DETAILS"
[ -f /var/log/Xorg.0.log ] && 
grep -E 'X.Org X |loading driver|Kernel command|Operating|NVIDIA GLX Module' /var/log/Xorg.0.log | \
cut -d']' -f2- | sed 's/^ //' | tr -d "\t" 

# Find GLX renderer info 


if w $USER | grep -q ":0"; then 
  sep_print "GLXGEARS INFO"
  timeout 3 glxgears -info }
fi

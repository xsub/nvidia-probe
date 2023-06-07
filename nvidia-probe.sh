#!/bin/bash
# The AlmaLinux NVIDIA compatiblity matrix report generator (script).

separator() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" | tr ' ' $1
}


log_it() {
    cat - | tee -a $CMRF
}

sep_print() {
    {
    separator -
    echo $*
    separator =
    } | log_it
}

print_run() {
  cmd="$@"
  output=$(eval "$cmd")
  echo "$output" | log_it
}

print_run_grep() {
  pattern=$1
  shift
  cmd="$@"
  print_run "$cmd" | grep "$pattern"
}

print_grep() {
  pattern=$1
  shift
  line="$@"
  echo "$line" | grep "$pattern" | log_tit
}

# Timestamp
sep_print "TIMESTAMP"
ts=`date +%Y-%m-%d-%H-%M-%S`
echo $ts | log_it

# Compatiblity Matrix Report File
CMRF="AlmaLinux-NVIDIA_Compatiblity_Matrix_Report_$ts.txt"
echo "AlmaLinux - NVIDIA Compatiblity Matrix Report" | log_it

# Find kernel settings
sep_print "KERNEL VERSION"
#uname -a without -n (node name) and + -pi
uname -srvmpio | log_it

sep_print "KERNEL MODULES"
lsmod | grep -Ei '(nouv|nvidia)' | log_it

sep_print "NOUVEAU BLACKLIST CHECK"
grep 'blacklist nouveau' /etc/modprobe.d/nouveau-blacklist.conf
grep GRUB_CMDLINE_LINUX /etc/default/grub | log_it

# Find installed packges
sep_print "PACKAGES"
sudo dnf list installed '*nvidia*' | log_it

# Find Display-class devicess
sep_print "DISPLAY CLASSH HW LIST (lshw)"
sudo lshw -class display | log_it

# List NVIDIA devices
sep_print "NVIDIA DEVICES LIST (lspci)"
lspci -kvd 10de: | log_it

# Find interesting data in /dev/log/Xorg.0.log
sep_print "XORG LOG DETAILS (parse for selected)"
[ -f /var/log/Xorg.0.log ] && \
grep -E 'X.Org X |loading driver|Kernel command|Operating|NVIDIA GLX Module' /var/log/Xorg.0.log \
| cut -d']' -f2- | sed 's/^ //' | tr -d "\t" | \
log_it

# Find GLX renderer info 
if w $USER | grep -q ":0"; then
  sep_print "GLXGEARS INFO"
  timeout 5 glxgears -info | log_it
fi


#!/bin/bash

if [[ "$EUID" -ne 0 ]];then
    echo "This script requires root privileges. Re running with sudo."
    sudo "$0" "$@"
    exit $?
fi

disk=""
final_pass=""
random_passes=1
args=("$@")
argc=${#args[@]}

for ((i=0;i<argc;i++)); do
    arg="${args[i]}"
    if [[ "$arg" == "-z" || "$arg" == "--zero-disk" ]];then
        final_pass="z"
    elif [[ "$arg" == "-r" || "$arg" == "--randomize-disk" ]];then
        final_pass="r"
    elif [[ "$arg" = "-p" || "$arg" == "--passes" ]];then
        if (($i + 1 < $argc)) && [[ "${args[i+1]}" =~ ^[0-9]+$ ]];then
            random_passes="${args[i+1]}"
        else
            echo "Error: --passes must be followed by number of passes."
            exit 2
        fi
    elif [[ -b "$arg" ]];then
        disk="$arg"
    fi
done
disk=$1

if [ -z $disk ];then
    echo "Usage: $0 /dev/sdX [-z | -r | --zero-disk | --randomize-disk ]"
    echo "Replace /dev/sdX with the target device you wish to erase e.g. /dev/sdb"
    echo "  -r --randomize-disk: Perform a final pass of random data to the disk in a final pass"
    echo "                       to prepare the disk for encryption and ensure data boundaries will be harder to detect etc."
    echo "  -z --zero-disk:      Perform a final pass of zeroes to the disk, equivalent of low-level fomatting it."
    echo "  -p --passes <number>: Number of random passes for extra security (default is 1)."
    exit 1;
fi;

read -p "This will erase all data on $disk. Are you sure you want to continue? (y/N) " confirm
if [[ "$confirm" != "y" ]];then
    echo "Aborted"
    exit 3;
fi

device_size=$(blockdev --getsize64 "$disk")
if [[ $? -ne 0 ]];then
    echo "Failed to get size of $disk"
    exit 4;
fi

echo "Pass 1: writing 0x00 to the entire disk."
pv -tpreb -s "$device_size" /dev/zero | dd of="$disk" bs=1M oflag=direct status=none

echo "Pass 2: writing random data to the disk."
pv -tpreb -s "$device_size" /dev/urandom | dd of="$disk" bs=1M oflag=direct status=none

pass=3
for ((i=1; i<= random_passes;i++));do
    echo "Pass $pass: writing random data to the disk."
    pv -tpreb -s "$device_size" /dev/urandom | dd of="$disk" bs=1M oflag=direct status=none
    ((pass++))
done

if [[ "$final_pass" == "z" ]];then
    echo "Pass $pass: writing 0x00 to the entire disk."
    pv -tpreb -s "$device_size" /dev/zero | dd of="$disk" bs=1M oflag=direct status=none
fi

if [[ "$final_pass" == "r" ]];then
    echo "Pass $pass: writing random data to the entire disk."
    pv -tpreb -s "$device_size" /dev/urandom | dd of="$disk" bs=1M oflag=direct status=none
fi

echo "Erase $disk is now complete. "

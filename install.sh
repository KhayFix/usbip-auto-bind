#!/bin/bash

#TODO сделать проверку whereis usbipd и изменить путь в service usbipd, если это требуется
# cat <<EOF >/etc/
# EOF

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

ABSOLUTE_FILENAME=`readlink -e "$0"`
DIRECTORY=`dirname "$ABSOLUTE_FILENAME"`

echo ABSOLUTE_FILENAME=$ABSOLUTE_FILENAME
echo DIRECTORY=$DIRECTORY

array_file_sh=(usbip_auto_bind.sh usbip_auto_unbind.sh)
array_file_service=(usbipd.service usbip_auto_bind.service)


function copy_file {
    cp -f $1 $2
}

function loop_array_and_copy {
    local dirname="$1"
    shift
    local array=("$@")

    for file in "${array[@]}"; do
        copy_file $DIRECTORY/$file $dirname
    done
}

loop_array_and_copy "/etc/systemd/system/" "${array_file_service[@]}" 

mkdir -p /etc/usbip/
loop_array_and_copy "/etc/usbip/" "${array_file_sh[@]}" 

systemctl daemon-reload
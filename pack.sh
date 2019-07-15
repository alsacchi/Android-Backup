#!/bin/zsh
CMD=(dialog --clear --title "Package List" --menu "Select one:" 76 80 40)
LIST=()
ls -d */ | sort | \
while read i
do
	LIST+=($i)
	LIST+=($i)
done
CHOICE=$("${CMD[@]}" "${LIST[@]}" 2>&1 >/dev/tty)
clear
echo "$CHOICE"
if [ "$CHOICE" = "" ]
	then
	echo "No package selected"
	exit
fi
cd "$CHOICE"
cat androidData.list | pax -wd > androidDataOut.tar
dd if=androidData.ab bs=24 count=1 of=androidDataOut.ab ; openssl zlib -in androidDataOut.tar >> androidDataOut.ab
adb restore androidDataOut.ab

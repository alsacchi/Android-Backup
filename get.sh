#!/bin/zsh
CMD=(dialog --clear --title "Package List" --menu "Select one:" 76 80 40)
LIST=()
adb shell 'pm list packages -f' | sed -e 's/.*=//' | sort | \
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
mkdir "$CHOICE"
cd "$CHOICE"
adb backup -f androidData.ab "$CHOICE" 
dd if=androidData.ab bs=24 skip=1 | openssl zlib -d > androidData.tar
tar -xvf androidData.tar
tar -tf androidData.tar | grep "/sp/\|manifest" > androidData.list



#!/system/bin/sh

UKM=/data/UKM;
BB=$UKM/busybox;
DEVICE=`getprop ro.product.device`;

if [ $DEVICE == "mako" ]; then
	CONFIG="mako"; #Nexus 4
elif [ $DEVICE == "hammerhead" ]; then
	CONFIG="hammerhead"; #Nexus 5
elif [ $DEVICE == "deb" -o $DEVICE == "flo" ]; then
	CONFIG="deb"; #Nexus 7
fi;

PATH=$UKM/device/$CONFIG.sh;

$BB echo $PATH;

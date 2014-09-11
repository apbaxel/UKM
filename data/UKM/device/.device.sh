#!/system/bin/sh

UKM=/data/UKM;
BB=$UKM/busybox;
DEVICE=`getprop ro.product.device`;

#Official
if [ $DEVICE == "mako" ]; then
	CONFIG="mako"; #Nexus 4
elif [ $DEVICE == "hammerhead" ]; then
	CONFIG="hammerhead"; #Nexus 5
elif [ $DEVICE == "deb" -o $DEVICE == "flo" ]; then
	CONFIG="deb"; #Nexus 7 2013
elif [ $DEVICE == "bacon" -o $DEVICE == "A0001" ]; then
	CONFIG="bacon"; #OnePlus One
#Unnofficial
elif [[ $DEVICE = "gee"* ]] || [ $DEVICE == "v500" ]; then
	CONFIG="mako"; #gee* = LG Optimus G, v500= LG G Pad 8.3
elif [[ $DEVICE = "m7"* ]]; then
	CONFIG="mako"; #m7* = HTC One M7
elif [ $DEVICE == "odin" -o $DEVICE == "yuga" ] || [[ $DEVICE = "C650"? ]] || [[ $DEVICE = "C660"? ]]; then
	CONFIG="mako"; #odin|C650x = Sony Xperia ZL, yuga|C660x = Sony Xperia Z
elif [ $DEVICE == "grouper" -o $DEVICE == "tilapia" ]; then
	CONFIG="deb"; #Nexus 7 2012
elif [ $DEVICE == "g2" -o $DEVICE == "galbi" -o $DEVICE == "ls980" -o $DEVICE == "vs980" ] || [[ $DEVICE = "d80"? ]]; then
	CONFIG="bacon"; #g2|galbi|ls980|vs980|d80x = LG G2
else
	CONFIG=""; #Not defined
fi;

if [ -n "$CONFIG" ]; then
	PATH=$UKM/device/$CONFIG.sh;
else
	PATH="";
fi;

$BB echo "$PATH";

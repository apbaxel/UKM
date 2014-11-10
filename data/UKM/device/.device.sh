#!/system/bin/sh

UKM=/data/UKM;
BB=$UKM/busybox;
DEVICE=`getprop ro.product.device`;

#Official
case $DEVICE in
	mako)
		CONFIG="mako";; #Nexus 4
	hammerhead)
		CONFIG="hammerhead";; #Nexus 5
	deb|flo)
		CONFIG="deb";; #Nexus 7 2013
	bacon|A0001)
		CONFIG="bacon";; #OnePlus One
	maguro|toro|toroplus)
		CONFIG="maguro";; #Galaxy Nexus
	g2|galbi|ls980|vs980|d80?|g3)
		CONFIG="g2";; #g2|galbi|ls980|vs980|d80x = LG G2, g3 = LG G3
#Unofficial
	gee*|v500|*m7*|odin|yuga|C650?|C660?)
		CONFIG="mako";; #gee* = LG Optimus G, v500 = LG G Pad 8.3, *m7* = HTC One M7, odin|C650x = Sony Xperia ZL, yuga|C660x = Sony Xperia Z
	*m8*)
		CONFIG="hammerhead";; #*m8* = HTC One M8
	grouper|tilapia)
		CONFIG="deb";; #Nexus 7 2012
	honami|C6943|C690?|falcon*|peregrine*)
		CONFIG="bacon";; #honami|C6943|C690x = Sony Xperia Z1, falcon* = Moto G 2013, #peregrine* = Moto G 4G 2013
	*)
		CONFIG="";; #Not defined
esac;

if [ -n "$CONFIG" ]; then
	PATH=$UKM/device/$CONFIG.sh;
else
	PATH="";
fi;

$BB echo "$PATH";
